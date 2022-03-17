package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringJoiner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParser;
import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.TestListDTO;
import com.quiz.bank.service.AdminStudyService;
import com.quiz.bank.service.QuizBankService;


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
		ArrayList<HashMap<String, String>> detailedSubjectCategory = service.getDetailedSubjectCategoryList(params);
		
		StringJson ja = new StringJson();
		JSONArray jsonArray = ja.HashArrayToJsonArray(subjectCategory);
		logger.info("{}",jsonArray);
		String stringJson = jsonArray.toString();
		mav.addObject("subjectCategory", stringJson);
		
		jsonArray = ja.HashArrayToJsonArray(detailedSubjectCategory);
		String detailedStringJson = jsonArray.toString();
		mav.addObject("detailedSubjectCategory",detailedStringJson);
		
		mav.addObject("test_info",params);
		mav.setViewName("admin_study/adminRegistQuiz");
		return mav;
	}
	
	@RequestMapping(value="adminPhotoChildOpen")
	public String adminPhotoChildOpen(Model model, @RequestParam String quizCnt) {
		model.addAttribute("quizCnt", quizCnt);
		return "admin_study/adminPhotoChildOpen";
	}



	
	//문제 사진업로드 : 실제로는 하나만 받을 거지만, 여러개를 받아야 하는 기능이 있을 수 있어서, parameter는 []로 구현함
	@RequestMapping(value="adminQuizPhotoUpload", method=RequestMethod.POST)
	public ModelAndView adminQuizPhotoUpload(@RequestParam String quizCnt, MultipartFile[] photos) {
		HashMap<String, String> photo_new_name = service.adminPhotoUpload(photos);
		ModelAndView mav = new ModelAndView("admin_study/adminPhotoChildOpen");
		
		mav.addObject("quizCnt", quizCnt);
		mav.addObject("newPhotoName",photo_new_name.get("1"));
		mav.addObject("oriPhotoName",photo_new_name.get("2"));
		mav.addObject("index", photo_new_name.get("index"));
		return mav;
	}
	
	
	
	@RequestMapping(value="adminRegistTestAndQuiz")
	@ResponseBody
	public HashMap<String, Object> adminRegistTestAndQuiz(@RequestParam(value="params[]") ArrayList <String> params){
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = service.registTestAndQuiz(params);
		logger.info("{}",params);
		map.put("msg", success);
		return map;
	}
	
	
	@RequestMapping(value="adminQuizList")
	public ModelAndView adminQuizList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin_study/adminQuizList");
		session.setAttribute("prevPage", "adminQuizList");
		
		return mav;
	}
	@RequestMapping(value="adminQuizListQuizCountList")
	@ResponseBody
	public HashMap<String, Object> adminQuizListQuizCountList(){		
		return service.adminQuizListQuizCountList();
	}
	
	@RequestMapping(value="adminSearchQuiz")
	@ResponseBody
	public HashMap<String, Object> adminSearchQuiz(@RequestParam HashMap<String, String> search_info){
		
		logger.info("도착한 파라미터 : {}",search_info);
		return service.adminSearchQuiz(search_info);
	}
	
	
	@RequestMapping(value="adminUpdateQuizForm")
	public ModelAndView adminUpdateQuizForm (@RequestParam String quiz_no) {
		ModelAndView mav = new ModelAndView("admin_study/adminUpdateQuiz");
		HashMap<String, String> map = service.adminUpdateQuizForm(quiz_no);
		mav.addObject("quiz_info", map);
		return mav;
	}
	
	
	@RequestMapping(value="adminUpdateQuiz")
	@ResponseBody
	public HashMap<String, Object> adminUpdateQuiz (@RequestParam HashMap<String, String> params){
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("{}",params);
		logger.info("{}",params.getOrDefault("ori_filename", "없습니다"));
		logger.info("{}",params.get("ori_filename"));
		
		service.updateQuiz(params);
		
		map.put("msg", service.updateQuiz(params));
		return map;
	}
	
	@RequestMapping(value="adminQuizReport")
	public String adminQuizReport(HttpSession session) {
		session.setAttribute("prevPage", "adminQuizReport");
		
		
		return "admin_study/adminQuizReport";
	}
	
	@RequestMapping(value="adminQuizReportCall")
	@ResponseBody
	public HashMap<String, Object> adminQuizReportCall(@RequestParam HashMap<String, String> search_info){
		HashMap<String, Object> map = service.adminQuizReportCall(search_info);
		

		return map;
	}
	
	@RequestMapping(value="adminQuizReportComplete")
	@ResponseBody
	public HashMap<String, Object>adminQuizReportComplete(@RequestParam HashMap<String, String> params){
		logger.info("quiz_no : {}",params.get("quiz_report_no"));
		service.quizReportComplete(params.get("quiz_report_no"));
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		return map;
	}
	
	
	
	@RequestMapping(value="testCountListCall")
	@ResponseBody
	public HashMap<String, Object> testCountListCall (@RequestParam HashMap<String, String> params){
		return service.testCountListCall(params.get("test_cate_no"));	
	}
	@RequestMapping(value="subjectListCall")
	@ResponseBody
	public HashMap<String, Object> subjectListCall (@RequestParam HashMap<String, String> params){
		return service.subjectListCall(params.get("test_cate_no"));
	}
	@RequestMapping(value="bookmarkListCall")
	@ResponseBody
	public HashMap<String, Object> bookmarkListCall (HttpSession session){
		return service.bookmarkListCall((String) session.getAttribute("loginId"));
	}
	
	
	@GetMapping
	public ModelAndView quizBankTestDetail(@RequestParam String test_cate_no) {
		ModelAndView mav = new ModelAndView();
		return service.quizBankTestDetail(test_cate_no);
		
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

