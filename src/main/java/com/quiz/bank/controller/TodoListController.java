package com.quiz.bank.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.quiz.bank.service.TodoListService;

@Controller
public class TodoListController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired TodoListService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
}
