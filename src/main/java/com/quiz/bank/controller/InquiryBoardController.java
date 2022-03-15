	package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.StudyBoardDTO;
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
	
	// 1. 문의게시판 작성하기 페이지 요청
	@GetMapping(value="/inquiryWriteForm")
	public String inquiryWriteForm(Model model, HttpSession session) {
		logger.info("문의게시판 작성하기 페이지 요청");
		String page = "/redirect:/inquiryBoardList";
		
		if (session.getAttribute("loginId") != null) {
			page = "inquiryBoard/inquiryWriteForm";
		}
		return page;
	}

	//2.문의게시판 작성하기 요청
	@PostMapping(value = "/inquiryWrite")
	 public String inquiryWrite(Model model,
			 @RequestParam HashMap<String, String> params) { 
		 logger.info("문의게시판 작성하기 요청 : {}", params);

		 return service.inquiryWrite(params);
	}
	
	// 2-1. 문의게시판 작성하기 (문의게시판 카테고리 추가하기)
	
	
	// 2-2. 문의게시판 파일 업로드
	
	
	

	// 3. 문의게시판 리스트 페이지 호출
	
	@GetMapping(value = "/inquiryBoardList")
	 public String inquiryBoardList(Model model) { 
		 logger.info("문의게시판 리스트 이동");
		 
		 return "inquiryBoard/inquiryBoardList";
	}
	
	// 3-1. 문의게시판 리스트 출력
	@ResponseBody
	@GetMapping(value = "/inquirylist")
	public HashMap<String, Object> studylist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("문의게시판 리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return service.inquirylist(currPage,pagePerCnt);
	}

	

	// 4. 문의게시판 상세보기
	@GetMapping(value = "/inquiryBoardDetail")
	public String inquiryBoardDetail(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 상세보기 요청 : {}", board_no);

		InquiryBoardDTO dto = service.inquirydetail(board_no);
		logger.info("dto : {}",dto.getContent());
		model.addAttribute("info", dto);

		return "inquiryBoard/inquiryBoardDetail";
	}

	
	
	
	//5. 문의게시판 수정페이지 요청
	@GetMapping(value = "/inquiryUpdateForm")
	public String inquiryUpdateForm(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 수정페이지 요청 : {}", board_no);
		
		
		return "inquiryBoard/inquiryBoardList";
	}
	
	
	
	//6. 문의게시판 삭제(비노출/블라인드)
	@GetMapping(value = "/inquiryBoardExposure")
	public String inquiryBoardExposure(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 삭제(블라인드) 요청 : {}", board_no);
		service.exposure(board_no);
		return "inquiryBoard/inquiryBoardList";
	}
	
	 

	
	

	
	
	
}
