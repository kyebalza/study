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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.service.AdminService;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminService adservice;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	//관리자 페이지 이동
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("관리자페이지 이동");

		return "admin/adminPage";
	}
	
	//게시물 관리 페이지 이동
	@RequestMapping(value = "/ManagPostStudy", method = RequestMethod.GET)
	public String ManagPostStudy(Model model) {
		logger.info("게시물 관리 페이지 이동");
		
		return "admin/ManagPostStudy";
	}
	
	//공부 질문 게시물 리스트 출력
	@ResponseBody
	@RequestMapping(value = "/studylist", method = RequestMethod.GET)
	public HashMap<String, Object> studylist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("공부 질문 게시물 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.studylist(currPage,pagePerCnt);
	}
	
	
	//공부 게시글 리스트 검색 요청
	@ResponseBody
	@RequestMapping(value = "/StudySearchList", method = RequestMethod.GET)
	public List<StudyBoardDTO> StudySearchList(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword) {
		logger.info("공부 게시판 리스트 검색 요청");
		logger.info(SearchType +" : "+Keyword);
		StudyBoardDTO SBdto = new StudyBoardDTO();
		SBdto.setKeyword(Keyword);
		SBdto.setSearchType(SearchType);
		
		return adservice.StudySearchList(SBdto);
	}
	
}
