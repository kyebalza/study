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

	//공부 게시판 리스트 호출 서비스
	public ArrayList<StudyBoardDTO> ManagPostStudy() {
		logger.info("공부 게시판 리스트 호출 서비스 도착");
		ArrayList<StudyBoardDTO> list = null;
		list = addao.ManagPostStudy();
		logger.info("size : "+list.size());
		
		return list;
	}

	//공부 게시판 리스트 검색 서비스
	public List<StudyBoardDTO> StudySearchList(StudyBoardDTO SBdto) {
		logger.info("공부 게시판 리스트 검색 서비스 도착");
		return addao.StudyBoardDTO(SBdto);
	}



	

}
