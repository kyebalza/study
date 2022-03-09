package com.quiz.bank.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.StudyBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;

@Service
public class StudyBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired StudyBoardDAO dao;

	

}
