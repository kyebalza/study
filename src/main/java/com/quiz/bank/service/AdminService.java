package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.AdminDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.StudyBoardDTO;

@Service
public class AdminService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminDAO addao;


	//공부 게시판 리스트 검색 서비스
	public List<StudyBoardDTO> StudySearchList(StudyBoardDTO SBdto) {
		logger.info("공부 게시판 리스트 검색 서비스 도착");
		return addao.StudySearchList(SBdto);
	}

	
	
	//공부 게시판 리스트 호출 (페이징)
	public HashMap<String, Object> studylist(int currPage, int pagePerCnt) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = addao.allCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("pages", range);
		 map.put("list", addao.studylist(pagePerCnt, offset));
		
		return map;
	}



	

}
