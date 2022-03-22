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
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dao.StudyBoardDAO;
import com.quiz.bank.dto.StudyBoardDTO;

@Service
public class StudyBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired StudyBoardDAO dao;

	public ArrayList<StudyBoardDTO> list() {
		logger.info("게시글 리스트 service 도착");
		return dao.list();
	}
	
	public StudyBoardDTO detail(String board_no, String method) {
		logger.info("상세보기 페이지 서비스 : {}",board_no);
		if(method.equals("detail")) {
			dao.upHit(board_no);
		} 
		return dao.detail(board_no);
	}

	public void delete(String board_no) {
		logger.info("글 삭제 서비스 : {}", board_no);
		int success = dao.delete(board_no);
		logger.info("삭제완료 여부 : "+success);
		
	}

	public ArrayList<HashMap<String, String>> studyboard_cate() {
		logger.info("게시판 세부 카테고리");
		
		return dao.studyboard_cate();
	}

	public ArrayList<HashMap<String, String>> test_name() {
		logger.info("시험카테고리");
		
		return dao.test_name();
	}

	public ArrayList<HashMap<String, String>> test_year() {
		logger.info("시험년년도 카테고리");
		return dao.test_year();
	}


	public String write(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("글쓰기 서비스 도착");
		String page = "redirect:/studyBoard/list";
		StudyBoardDTO dto = new StudyBoardDTO();
		dto.setTitle(params.get("title"));
		dto.setUser_id(params.get("user_id"));
		dto.setContent(params.get("content"));
		dto.setBoard_cate_no(Integer.parseInt(params.get("board_cate_no")));
		dto.setQuiz_no(Integer.parseInt(params.get("quiz_no")));
		dao.write(dto);
		
		int board_no = dto.getBoard_no();
		logger.info("board_no : {}",board_no);
		
		if(board_no>0) {
			page = "redirect:/studyBoard/detail?board_no="+board_no;
			saveFile(board_no,uploadFile);
		}
		
		return page;
		
	}

	private void saveFile(int board_no, MultipartFile uploadFile) {
		
		try {
			String oriFileName = uploadFile.getOriginalFilename();
			int index = oriFileName.lastIndexOf(".");
			logger.info("index : {}",index);
			
			if(index>0) {
				String ext = oriFileName.substring(index);
				String newFileName = System.currentTimeMillis()+ext;
				logger.info(oriFileName+"->"+newFileName);
				
				byte[] bytes = uploadFile.getBytes();
				Path path = Paths.get("C:/upload/"+newFileName);
				Files.write(path,bytes);
				logger.info(oriFileName+"Save완료!");
				dao.fileWrite(board_no,oriFileName,newFileName);
			}
			
		}catch(Exception e){
			logger.info("오류 발생 : {}",e);
		}
		
	}
	
	public StudyBoardDTO photo(String board_no) {
		// TODO Auto-generated method stub
		return dao.photo(board_no);
	}

	public String updateForm(Model model, String board_no) {
		
		StudyBoardDTO dto = dao.detail(board_no);
		StudyBoardDTO photo = dao.photo(board_no);
		
		logger.info("title : "+dto.getTitle());
		logger.info("photo : {}",photo);
		
		model.addAttribute("dto",dto);
		model.addAttribute("photo",photo);
		
		return "/studyBoard/updateForm";
	}

	public String update(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("update 서비스 도착 : {}",params);
		int board_no = Integer.parseInt(params.get("board_no"));
		String page = "redirect:/studyBoard/detail?board_no="+board_no;
		
		if(dao.update(params)>0) {
			page = "redirect:/studyBoard/detail?board_no="+board_no;
			saveFile(board_no, uploadFile);//파일저장 처리			
		}
		return page;
	}

	public ArrayList<StudyBoardDTO> listCall() {
		logger.info("listCall service : DAO 호출");
		return dao.listCall(0,0);
	}

	public HashMap<String, Object> list(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서부터 보여줘야 하는거?
		int offset = ((currPage-1) * pagePerCnt-1) >= 0 ? ((currPage-1)* pagePerCnt-1) : 0;
		logger.info("offset : {}", offset);
		
		int totalCount = dao.allCount();//studyBoard테이블의 모든 글의 갯수를 가져온다.
		//만들 수 있는 총 페이지의 수(전체갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount%pagePerCnt)+1 : (totalCount/pagePerCnt);
		logger.info("총 갯수 : {}", totalCount);
		logger.info("만들 수 있는 총 페이지 : {}",range);
		
		map.put("totalCount", totalCount);
		map.put("pages", range);
		map.put("list", dao.listCall(pagePerCnt, offset));
		return map;
	}

	public List<StudyBoardDTO> studySearch(StudyBoardDTO SBdto) {
		logger.info("공부게시판 검색 서비스 도착");
		return dao.studySearch(SBdto);
	}

	public ArrayList<HashMap<String, String>> test_no() {
		logger.info("문제번호 카테고리");
		return dao.test_no();
	}
	
	//게시글 좋아요 여부 확인
	public String like2(String loginId, String board_no, String board_name) {
		String like2 = dao.like2(loginId,board_no,board_name);
		return like2;
	}
	
	//게시글 좋아요 삭제
	public int like_del(String loginId, String board_no, String board_name) {
		logger.info("좋아요 취소 서비스");
		return dao.like_del(loginId,board_no,board_name);
	}
	
	//북마크 추가
	public int uplike(String loginId, String board_no, String board_name) {
		int row = dao.uplike(loginId,board_no,board_name);
		logger.info("좋아요 등록 서비스 : {}",row);
		return row;
	}

	public StudyBoardDTO like(String board_no, String loginId) {
		logger.info("좋아요 가져오기");
		return dao.like(board_no,loginId);
	}

	public int countlike(String board_no) {
		
		return dao.countlike(board_no);
	}

	public HashMap<String, Object> quizselect(HashMap<String, String> params) {
		logger.info("문제가져오기 서비스");
		return dao.quizselect(params);
	}

	public HashMap<String, Object> studyReport(HashMap<String, String> params) {
		logger.info("공부게시판 신고 서비스 : {}",params);
		int success = dao.studyReport(params);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", success);
		return map;
	}

	public StudyBoardDTO studyQuiz(String board_no) {
		logger.info("상세보기 문제 가져오기 : {}", board_no);
		return dao.studyQuiz(board_no);
	}

	//댓글등록 기능
	public void sbcoment(HttpSession session, HashMap<String, String> params) {
		
		StudyBoardDTO sbdto = new StudyBoardDTO();
		String user_id = (String) session.getAttribute("loginId");
		
		sbdto.setUser_id(user_id);
		sbdto.setBoard_no(Integer.parseInt(params.get("board_no")));
		sbdto.setReply_content(params.get("reply_content"));
		
		//댓글등록
		dao.sbcoment(sbdto);
		logger.info("댓글등록 서비스 확인");
		
	}
	
	//댓글불러오기
	public ArrayList<StudyBoardDTO> studycoment(String board_no) {
		logger.info("댓글 불러오기 서비스");
		ArrayList<StudyBoardDTO> coment = dao.studycoment(board_no);
		return coment;
	}


	








	

}
