package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public ModelAndView testForm(@RequestParam String test_no, HttpSession session) {
		logger.info("시험페이지 요청 : {}",test_no);
		String loginId = (String)session.getAttribute("loginId");
		
		return service.testFroml(test_no, loginId);
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
	
	//5. 북마크 추가/ 삭제
	@RequestMapping(value = "/bookMarkChange", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> bookMarkChange(@RequestParam String loginId, @RequestParam String quiz_no) {
		
		logger.info("로그인아이디: {}",loginId);
		logger.info("게시글 번호 : {}",quiz_no);
		
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//5-1. 현재 id 북마크 여부 확인
		 String wishlist2 = service.bookMark2(loginId,quiz_no);
		
		 logger.info(wishlist2);
		 
		 if(wishlist2 != null) { //5-2. 북마크 삭제
			 int row2 = service.bookmark_delete(quiz_no,loginId);
			 map.put("row2", row2);
			 
		 }else {
			 //5-3. 북마크 추가
			 int row = service.bookmark_Insert(loginId,quiz_no);
			 map.put("success",row);
		 }
		 

		return map;
	}
	
	////////////////////////////////////
	//6. 체점하기(시험)
	@RequestMapping(value="testResult")
	@ResponseBody
	public HashMap<String, Integer> testResult(@RequestParam(value="params[]") ArrayList <String> params, String test_prac_flag, String loginId, String elapse_time, String test_no){
		//HashMap<String, Object> map = new HashMap<String, Object>();
		//HashMap<String, Object> success = service.testResult(params, test_prac_flag, loginId, elapse_time, test_no);
		logger.info("{}",params);
		logger.info("{}",test_prac_flag);
		logger.info("{}",loginId);
		logger.info("{}",test_no);
		logger.info("{}",elapse_time);
		//map.put("msg", success);
		return service.testResult(params, test_prac_flag, loginId, elapse_time, test_no);
	}
	
	//7.시험보기 페이지 및 시험문제 가져오기
	@GetMapping(value="/practiceForm")
	public ModelAndView practiceForm(@RequestParam String test_no, HttpSession session) {
		logger.info("시험페이지 요청 : {}",test_no);
		String loginId = (String)session.getAttribute("loginId");
		
		return service.practiceForm(test_no, loginId);
	}
	
	//8. 체점하기(시험)
	@RequestMapping(value="practiceResult")
	@ResponseBody
	public HashMap<String, Object> practiceResult(@RequestParam(value="params[]") ArrayList <String> params, String test_prac_flag, String loginId, String elapse_time, String test_no){
		//HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> success = service.practiceResult(params, test_prac_flag, loginId, elapse_time, test_no);
		logger.info("{}",params);
		logger.info("{}",test_prac_flag);
		logger.info("{}",loginId);
		logger.info("{}",test_no);
		logger.info("{}",elapse_time);
		//map.put("msg", success);
		return success;
	}
	//9. 결과페이지 이동하기
	//3.시험보기 페이지 및 시험문제 가져오기
	@GetMapping(value="/resultFrom")
	public ModelAndView resultFrom(@RequestParam int test_result_no, HttpSession session) {
		logger.info("시험페이지 요청 : {}",test_result_no);
		String loginId = (String)session.getAttribute("loginId");
		
		return service.resultFrom(test_result_no, loginId);
	}
}
