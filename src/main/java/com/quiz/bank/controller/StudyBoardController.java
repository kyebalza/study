package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.service.StudyBoardService;

@Controller
public class StudyBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired StudyBoardService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	
	/*공부게시판 리스트 - 도연*/
	@RequestMapping(value = "/studyBoard/list", method = RequestMethod.GET)
	public String home(Model model,HttpSession session) {
		logger.info("게시판 리스트 요청");
		ArrayList<StudyBoardDTO> list = service.list();
		logger.info("글의 수 : {}",list.size());
		model.addAttribute("size",list.size());
		model.addAttribute("list", list);
		return "studyBoard/list";
	}
	
	
	/*공부게시판 글쓰기 페이지 이동 -도연*/
	@RequestMapping(value="/studyBoard/writeForm", method = RequestMethod.GET)
	public String writeForm(Model model,HttpSession session) {
		logger.info("글쓰기 페이지 이동");
		//게시판 세부 카테고리
		ArrayList<HashMap<String, String>> study_cate = service.studyboard_cate();
		model.addAttribute("study_cate",study_cate);
		//자격증종류 카테고리
		ArrayList<HashMap<String, String>> quiz_name = service.test_name();
		model.addAttribute("quiz_name",quiz_name);
		//시행년도 카테고리
		ArrayList<HashMap<String, String>> year_count = service.test_year();
		model.addAttribute("year_count",year_count);
		
		//문제 번호 가져오기(ajax?)
		
		//로그인 여부 확인
		String page = "redirect:/loginPage";
		if(session.getAttribute("loginId") != null) {
			page="studyBoard/writeForm";
		}
		return page;
	}
	
	/*공부 게시판 글쓰기 - 도연*/
	@RequestMapping(value = "/studyBoard/write", method = RequestMethod.POST)
	public String write(Model model, @RequestParam HashMap<String, String>params,MultipartFile uploadFile,HttpSession session) {
		logger.info("upload 파일요청 : {}", uploadFile);
		//세션에서 로그인한 아이디 가져와서 params에 넣어줌
		params.put("user_id", (String) session.getAttribute("loginId"));
		logger.info("write 요청 : {}", params);
		return service.write(params,uploadFile);
		
	}
	
	/*공부 게시판 상세보기- 도연*/
	@RequestMapping(value = "/studyBoard/detail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam String board_no) {
		logger.info("detail 요청 : {}", board_no);		
		
		StudyBoardDTO dto = service.detail(board_no, "detail");
		logger.info("dto : {}", dto.getContent());
		model.addAttribute("info", dto);		
		
		return "studyBoard/detail";
	}
	
	/*공부 게시글 삭제- 도연*/
	@RequestMapping(value = "/studyBoard/delete", method = RequestMethod.GET)
	public String delete(Model model, @RequestParam String board_no) {
		logger.info("삭제 요청 : {}", board_no);
		service.delete(board_no);
		
		return "redirect:/studyBoard/list";
	}
	
	
}
