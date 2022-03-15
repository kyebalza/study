package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dao.StudyBoardDAO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.dto.UserDTO;

@Service
public class StudyBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired StudyBoardDAO dao;

	public ArrayList<StudyBoardDTO> list() {
		logger.info("게시글 리스트 service 도착");
		return dao.list();
	}

//	public void write(HashMap<String, String> params, HttpSession session) {	
//		
//		StudyBoardDTO dto = new StudyBoardDTO();
//		UserDTO udto = dao.userid((String)session.getAttribute("userId"));
//		logger.info("가져온 아이디 : {}", udto);
//		int row = dao.write(params,session);
//		logger.info("입력된 건수 : {}", row);
//		
//	}
	
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
		
//		if(board_no>0) {
//			page = "redirect:/detail?board_no="+board_no;
//			saveFile(board_no,uploadFile);
//		}
		
		return page;
		
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

//	private void saveFile(int board_no, MultipartFile uploadFile) {
//		
//		try {
//			String oriFileName = uploadFile.getOriginalFilename();
//			int index = oriFileName.lastIndexOf(".");
//			logger.info("index : {}",index);
//			
//		}catch(Exception e){
//			
//		}
//		
//	}

//	public void upload(MultipartFile uploadFile) {
//		//1. 파일명 추출
//		String oriFileName = uploadFile.getOriginalFilename();//업로드파일의 오리지날 파일이름을 가져와서 오리파일네임 변수에 넣어준다.
//		//2. 새 파일명 작성(업로드한 시간을 밀리세컨드로 환산한 값을파일명으로)
//		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
//		String newFileName = System.currentTimeMillis()+ext;
//		logger.info(oriFileName+"=>"+newFileName);
//	}



	

}
