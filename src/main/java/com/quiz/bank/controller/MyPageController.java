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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.service.MyPageService;

@Controller
public class MyPageController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MyPageService service;

	@RequestMapping(value="myNotice")
	public String myNotice(Model model) {
		return "mypage/myNotice";
	}
	@RequestMapping(value="myBoard")
	public String myBoard(Model model) {
		return "mypage/myBoard";
	}
	@RequestMapping(value="myReply")
	public String myReply(Model model) {
		return "mypage/myReply";
	}
	@RequestMapping(value="myTest")
	public String myTest(Model model) {
		return "mypage/myTest";
	}
	@RequestMapping(value="myInfo")
	public String myInfo(Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		HashMap<String, String> map = service.CallUserInfo(loginId);
		model.addAttribute("userInfo",map);
		
		return "mypage/myInfo";
	}
	
	@RequestMapping(value="updateUser")
	public ModelAndView updateUser(@RequestParam HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView("redirect:/myInfo");
		int success = service.updateUser(params);
		
		return mav;
	}

		
	@RequestMapping(value="myPageBoardListCall")
	@ResponseBody
	public HashMap<String, Object> myPageBoardListCall(HttpSession session,@RequestParam String page,@RequestParam String cnt,@RequestParam String board_name){
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		String loginId = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(board_name.equals("studyBoardBtn")) {
			map = service.myPageStudyBoardListCall(currPage,pagePerCnt,loginId);
		}
		if(board_name.equals("freeBoardBtn")) {
			map = service.myPagefreeBoardListCall(currPage,pagePerCnt,loginId);	
				}
		if(board_name.equals("inquiryBoardBtn")) {
			map = service.myPageinquiryBoardListCall(currPage,pagePerCnt,loginId);
		}
		logger.info("map : {}",map);
		return map;
	}	
	@RequestMapping(value="myPageReplyListCall")
	@ResponseBody
	public HashMap<String, Object> myPageReplyListCall(HttpSession session,@RequestParam String page,@RequestParam String cnt,@RequestParam String board_name){
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		String loginId = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(board_name.equals("studyReplyBtn")) {
			map = service.myPageStudyReplyListCall(currPage,pagePerCnt,loginId);
		}
		if(board_name.equals("freeReplyBtn")) {
			map = service.myPagefreeReplyListCall(currPage,pagePerCnt,loginId);	
				}

		logger.info("map : {}",map);
		return map;
	}	
	
	
	@RequestMapping(value="myTestListCall")
	@ResponseBody
	public HashMap<String, Object> myTestListCall(HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String loginId = (String) session.getAttribute("loginId");
		map = service.myTestListCall(loginId);
		
		return map;
	}
	
		
	
}
