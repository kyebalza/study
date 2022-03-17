package com.quiz.bank.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dao.FreeBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.FreeBoardDTO;

@Service
public class FreeBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired FreeBoardDAO fbdao;

	// 자유 게시판 페이징
	public HashMap<String, Object> FBlistCall(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = fbdao.FballCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", fbdao.FBlistCall(pagePerCnt, offset));
		
		return map;
	}

	//자유 게시판 카테고리
	public ArrayList<HashMap<String, String>> freeboard_cate() {
		logger.info("자유 게시판 세부 카테고리");
		return fbdao.freeboard_cate();
	}

	//자유게시판 작성
	public String freeWrite(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("자유게시판 작성 서비스");
		
		String page = "/freeBoard/freeBoardList";
		FreeBoardDTO fdto = new FreeBoardDTO();
		
		fdto.setTitle(params.get("title"));
		fdto.setUser_id(params.get("user_id"));
		fdto.setContent(params.get("content"));
		fdto.setBoard_cate_no(Integer.parseInt(params.get("board_cate_no")));
		fbdao.freeWrite(fdto);
		
		int board_no = fdto.getBoard_no();
		logger.info("board_no : "+board_no);
		
		if (board_no > 0) {
			page = "redirect:/freeBoardDetail?board_no="+board_no;
			saveFile(board_no,uploadFile);
		}
		return page;
	}
	
	//자유 게시판 파일 업로드
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
				fbdao.freefileWrite(board_no,oriFileName,newFileName);
			}
			
			
		}catch (Exception e) {
			logger.info("오류 발생 : {}",e);
		}
		
	}
	
	//자유 게시판 상세보기
	public FreeBoardDTO freeBoardDetail(String board_no) {
		logger.info("자유게시판 상세보기 서비스");
		
		fbdao.freeBoardupHit(board_no);
		
		return fbdao.freeBoardDetail(board_no);
	}

	//자유 게시글 삭제
	public void freedelete(String board_no) {
		logger.info("자유 게시글 삭제 서비스 : "+board_no);
		int success = fbdao.freedelete(board_no);
		logger.info("자유 게시글 삭제 여부 : "+success);
		
	}

	//자유 게시판 리스트 검색
	public List<FreeBoardDTO> FreeSearch(FreeBoardDTO fbdto) {
		logger.info("자유 게시판 리스트 검색");
		return fbdao.FreeSeasrch(fbdto);
	}

}
