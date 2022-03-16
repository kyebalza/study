package com.quiz.bank.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.InquiryBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.InquiryBoardDTO;

@Service
public class InquiryBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InquiryBoardDAO dao;

	
	// 문의게시판 세부 카테고리 추가
	public ArrayList<HashMap<String, String>> inquiryboard_cate() {
		logger.info("문의게시판 세부 카테고리");
		return dao.inquiryboard_cate();
	}


	// 문의게시판 작성하기
	public String inquiryWrite(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("문의게시판 작성하기 서비스 도착");
		String page = "/inquiryBoard/inquiryBoardList";
		InquiryBoardDTO dto = new InquiryBoardDTO();
		dto.setTitle(params.get("title"));
		dto.setUser_id(params.get("user_id"));
		dto.setContent(params.get("content"));
		dto.setBoard_cate_no(Integer.parseInt(params.get("board_cate_no")));
		dao.inquiryWrite(dto);
		
		int board_no = dto.getBoard_no();
		logger.info("board_no : {}",board_no);
		
		if (board_no > 0) {
			page = "redirect:/inquiryBoardDetail?board_no="+board_no;
			saveFile(board_no,uploadFile);
		}
		return page;
	}
	
	// 문의게시판 파일 업로드
	private void saveFile(int board_no, MultipartFile uploadFile) {
		
		try {
			String oriFileName = uploadFile.getOriginalFilename();
			int index = oriFileName.lastIndexOf(".");
			logger.info("index : {}",index);
			
			if (index>0) {
				String ext = oriFileName.substring(index);
				String newFileName = System.currentTimeMillis()+ext;
				logger.info(oriFileName+"->"+newFileName);
				
				byte[] bytes = uploadFile.getBytes();
				Path path = Paths.get("C:/upload/"+newFileName);
				Files.write(path,bytes);
				logger.info(oriFileName+"문의Save완료!");
				dao.inquiryfileWrite(board_no,oriFileName,newFileName);
			}
			
			
		}catch (Exception e) {
			logger.info("오류 발생 : {}",e);
		}
		
	}
	

	
	
	/*

	// 3. 문의게시판 리스트 호출 (페이징)
	public ArrayList<HashMap<String, String>> InquiryBoardList() {
		return dao.InquiryBoardList();
	}



	public int list_rangecall(int currPage, int pagePerCnt) {
		
		int totalCount = dao.list_allCount(); // 일단 테이블 글이 몇개인지?
		logger.info("totalCount : {}",totalCount);
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) + 1 : (totalCount/pagePerCnt); // 만들 수 있는 페이지의 갯수
		logger.info("range : {}",range);
		return range;
	}



	public ArrayList<HashMap<String, String>> list_listCall(int currPage, int pagePerCnt) {
		int offset = (currPage -1) * pagePerCnt -1; // DB에 요청할 인덱스 번호임, 1:0-9, 2:10-19 이런식으로 해야 함
		//1페이지면 limit 10에, offset 0부터 조회
		//2페이지면 limit 10에, offset 10부터 조회
		//3페이지면 limit 10에, offset 20부터 조회
		
		if (offset < 0) {
			offset = 0;
		}
		
		logger.info("offset : {}",offset);
		ArrayList<HashMap<String, String>> listCall = dao.list_listCall(pagePerCnt,offset);
		
		return listCall;
	}
	
	*/



	// 3. 문의게시판 리스트 호출(페이징)
	public HashMap<String, Object> inquirylist(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 어디서 부터 보여줄 것인가.
		int offset = ((currPage -1) * pagePerCnt -1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : " +offset);
		
		int totalCount = dao.allCount(); // 테이블 모든 글의 총 갯수
		// 만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ?
				(totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		
		logger.info("총 갯수 : {}",totalCount);
		logger.info("만들 수 있는 총 페이지 : {}",range);
		
		map.put("totalCount", totalCount);
		map.put("pages", range);
		map.put("list", dao.inquirylist(pagePerCnt,offset));
	
		return map;
	}
	
	
	// 문의게시글 리스트 검색
	public List<InquiryBoardDTO> InquirySearchBoardList(InquiryBoardDTO dto) {
		logger.info("문의게시판 리스트 검색 요청 도착");
		return dao.InquirySearchBoardList(dto);
	}
	

	// 문의게시판 상세보기
	public InquiryBoardDTO inquirydetail(String board_no) {
		logger.info("문의게시판 상세보기 서비스 요청");
		
		dao.inquiryupHit(board_no);
		
		return dao.inquirydetail(board_no);
	}
	
	

	/*
	
	// 문의게시글 수정페이지 요청
	public String inquiryUpdateForm(Model model, String board_no) {
		logger.info("문의게시글 수정페이지 요청");
		InquiryBoardDTO dto = dao.inquirydetail(board_no);
		ArrayList<InquiryBoardDTO> list = dao.
		
		logger.info("content : "+dto.getContent());
		logger.info("photos : {}", list);
		
		model.addAttribute("dto", dto);
		model.addAttribute("photos", list);
		
		return "inquiryUpdateForm";
	}
	
	// 문의게시글 수정 요청
	public String inquiryUpdate(HashMap<String, String> params) {
		
		int board_no = Integer.parseInt(params.get("board_no"));
		String page = "/inquiryBoard/inquiryBoardDetail?board_no="+board_no;
		
		if (dao.inquiryUpdate(params)>0) {
			page = "/inquiryBoard/inquiryBoardDetail?board_no="+board_no;
		}
		
		return page;
	}
	
	*/
	
	

	
	// 문의게시글 삭제
	public void inquirydelete(String board_no) {
		logger.info("문의게시글 삭제 서비스 : {}", board_no);
		int success = dao.inquirydelete(board_no);
		logger.info("문의게시글 삭제완료 여부 : "+success);
		
	}

























	

	
	



	



	


	

}
