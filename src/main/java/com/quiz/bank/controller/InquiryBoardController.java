package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.service.InquiryBoardService;

@Controller
public class InquiryBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InquiryBoardService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	
	// 1. 문의글쓰기 페이지 요청
	@GetMapping(value="/inquiryWriteForm")
	public String inquiryWriteForm(Model model, HttpSession session) {
		logger.info("문의글쓰기 페이지 요청");
		String page = "/redirect:/inquiryBoardList";
		
		if (session.getAttribute("loginId") != null) {
			page = "inquiryWriteForm";
		}
		return page;
	}
	
	
	//2.문의글쓰기 요청
	@PostMapping(value = "/inquiryWrite")
	 public String inqwrite(Model model,
			 @RequestParam HashMap<String, String> params) { 
		 logger.info("문의글쓰기 요청 : {}", params);

		 return service.inquiryWrite(params);
	}
	
	
	

	
	
	
}
