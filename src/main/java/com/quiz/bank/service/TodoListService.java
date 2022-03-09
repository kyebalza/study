package com.quiz.bank.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.TodoListDAO;

@Service
public class TodoListService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired TodoListDAO dao;

	

}
