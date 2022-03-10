package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.service.AdminStudyService;

@Controller
public class AdminStudyController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminStudyService service;

	@RequestMapping(value="adminRegistTest")
	public String adminRegistTest() {
		return "admin_study/adminRegistTest";
	}
	
	
	@RequestMapping(value="adminRegistCategory")
	public ModelAndView adminRegistCategory() {
		ModelAndView mav = new ModelAndView("adminRegistCategory");
		return mav;
	}
	
	@RequestMapping(value="testCategoryCall")
	@ResponseBody
	public HashMap<String, Object> testCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.testCategoryCall();
		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="subjectCategoryCall")
	@ResponseBody
	public HashMap<String, Object> subjectCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.subjectCategoryCall(obj);

		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="detailSubjectCategoryCall")
	@ResponseBody
	public HashMap<String, Object> detailSubjectCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.detailSubjectCategoryCall(obj);

		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="registCategory")
	@ResponseBody
	public HashMap<String, Object> registCategory(@RequestParam HashMap<String, String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = 0;
		
		if(obj.get("nowCate").equals("test")) {
			success = service.registTestCategory(obj);
		}
		if(obj.get("nowCate").equals("subject")) {
			success = service.registSubjectCategory(obj);
		}
		if(obj.get("nowCate").equals("detailSubject")) {
			success = service.registDetailSubject(obj);
		}
		if(success > 0 ) {
			map.put("msg", "등록이 완료 되었습니다.");
		} else {
			map.put("msg", "이미 존재하는 카테고리 입니다.");
		}
		
		return map;
	}


	@RequestMapping(value="deleteTestCategory")
	@ResponseBody
	public HashMap<String, Object> deleteTestCategory(@RequestParam HashMap<String, String>obj){
		logger.info("obj : {}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String success = service.deleteTestCategory(obj);
		map.put("msg",success);
		logger.info("map : {}",map);
		logger.info("success : {}",success);
		return map;
	}
	
	
	
	///문제등록 페이지 관련한것

	@RequestMapping(value="toRegistQuizForm")
	public ModelAndView toRegistQuizForm(@RequestParam HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		

		mav.addObject("test_info",params);
		mav.setViewName("admin_study/adminRegistQuiz");
		return mav;
	}



}

