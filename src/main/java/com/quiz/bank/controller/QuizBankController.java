package com.quiz.bank.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.service.QuizBankService;

@Controller
public class QuizBankController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired QuizBankService service;

	//1. 문제은행 리스트 가져오기
	@GetMapping(value="/quizBankList")
	public ModelAndView list() {
		logger.info("문제은행 리스트 가져오기");
		return service.list();
	}
	
	//2. 회차별 시험리스트 상세보기
	@GetMapping(value="/testDetail")
	public ModelAndView testDetail(@RequestParam String test_cate_no) {
		logger.info("상세보기 요청 : {}",test_cate_no);
		return service.testdetail(test_cate_no);
	}

	
	//3.시험보기 페이지 및 시험문제 가져오기
	@GetMapping(value="/testForm")
	public ModelAndView testForm(@RequestParam String test_no) {
		logger.info("시험페이지 요청 : {}",test_no);
		return service.testFroml(test_no);
	}
	
	//4.검색기능
	//Model은 데이터를 view에 전달하는 역활 수행
	//컨트롤러에서만 생성이 가능(파라메터 형태로)
	@RequestMapping(value = "/search")
	public ModelAndView search(@RequestParam HashMap<String, String> params) {
		logger.info("시험이름으로 검색 요청");
		logger.info("params : {}", params);
		return service.search(params);
	}
}
