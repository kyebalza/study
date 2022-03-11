package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringJoiner;

import org.json.JSONArray;
import org.json.JSONObject;
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
	
	

	@RequestMapping(value="adminTestCategoryCall")
	@ResponseBody
	public HashMap<String, Object> adminTestCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.testCategoryCall();
		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="adminSubjectCategoryCall")
	@ResponseBody
	public HashMap<String, Object> adminSubjectCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.subjectCategoryCall(obj);

		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="adminDetailSubjectCategoryCall")
	@ResponseBody
	public HashMap<String, Object> adminDetailSubjectCategoryCall(@RequestParam HashMap<String,String>obj){
		logger.info("{}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> Category = new ArrayList<HashMap<String,String>>();
		Category = service.detailSubjectCategoryCall(obj);

		map.put("Category", Category);
		return map;
	}
	
	@RequestMapping(value="adminRegistCategory")
	@ResponseBody
	public HashMap<String, Object> adminRegistCategory(@RequestParam HashMap<String, String>obj){
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



	@RequestMapping(value="adminDeleteTestCategory")
	@ResponseBody
	public HashMap<String, Object> adminDeleteTestCategory(@RequestParam HashMap<String,String>obj){
		logger.info("obj : {}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = service.deleteTestCategory(obj);
		map.put("msg",success);
		logger.info("map : {}",map);
		logger.info("success : {}",success);
		return map;
	}	
	@RequestMapping(value="adminDeleteSubjectCategory")
	@ResponseBody
	public HashMap<String, Object> adminDeleteSubjectCategory(@RequestParam HashMap<String,String>obj){
		logger.info("obj : {}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = service.deleteSubjectCategory(obj);
		map.put("msg",success);
		logger.info("map : {}",map);
		logger.info("success : {}",success);
		return map;
	}		
	@RequestMapping(value="adminDeleteDetailedSubjectCategory")
	@ResponseBody
	public HashMap<String, Object> adminDeleteDetailedSubjectCategory(@RequestParam HashMap<String,String>obj){
		logger.info("obj : {}",obj);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = service.adminDeleteDetailedSubjectCategory(obj);
		map.put("msg",success);
		logger.info("map : {}",map);
		logger.info("success : {}",success);
		return map;
	}		
	///문제등록 페이지 관련한것

	@RequestMapping(value="adminRegistQuizForm")
	public ModelAndView adminRegistQuizForm(@RequestParam HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		String testCategory = service.getTestCategoryName(params);
		params.put("test_category_name", testCategory);
		ArrayList<HashMap<String, String>> subjectCategory = service.getSubjectCategoryList(params);
		
		StringJson ja = new StringJson();
		JSONArray jsonArray = ja.HashArrayToJsonArray(subjectCategory);
		logger.info("{}",jsonArray);
		
		mav.addObject("test_info",params);
		mav.addObject("subjectCategory", jsonArray);
		mav.setViewName("admin_study/adminRegistQuiz");
		return mav;
	}
	
	@RequestMapping(value="adminPhotoChildOpen")
	public String adminPhotoChildOpen() {
		
		return "admin_study/adminPhotoChildOpen";
	}



	
	
	
	
	
	
	
	
	//
	public class StringJson {
		
		public JSONArray ArrayToJsonArray (ArrayList<String> params) {
			JSONArray jsonArray = new JSONArray();
			for (String jsonStr : params) {
				JSONObject jsonStr2 = new JSONObject(jsonStr);
				jsonArray.put(jsonStr2);
			}
			return jsonArray;
		}
		
		
		public JSONArray HashArrayToJsonArray (ArrayList<HashMap<String, String>> params) {
			JSONArray jsonArray = new JSONArray();
			for (HashMap<String, String> jsonStr : params) {
				JSONObject jsonStr2 = new JSONObject(jsonStr);
				jsonArray.put(jsonStr2);
			}
			return jsonArray;
			}
		}
	
	
	
}

