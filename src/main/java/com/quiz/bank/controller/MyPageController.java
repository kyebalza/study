package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.service.MyPageService;

@Controller
public class MyPageController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MyPageService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	
	
	
	/*
	
	// 댓글 불러오기
	@ResponseBody
	@GetMapping(value="/reply_call")
	public HashMap<String, Object> reply_call(HttpSession session, @RequestParam String board_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		logger.info("{} reply 리스트 불러오기",board_no);
		ArrayList<HashMap<String, String>> list = service.reply_call(board_no);
		
		for (HashMap<String, String> list_date : list) {
			logger.info("list date {}",String.valueOf(list_date.get("reply_date")));
			

			String dateYear = (String.valueOf(list_date.get("reply_date"))).substring(0, 4);
			logger.info("dateYear {}",dateYear);

			String dateMonth = (String.valueOf(list_date.get("reply_date"))).substring(5,7);
			logger.info("dateMonth {}",dateMonth);

			String dateDate = (String.valueOf(list_date.get("reply_date"))).substring(8,10);
			logger.info("dateDate {}",dateDate);

			String newDate = dateYear+"년 "+dateMonth+"월"+dateDate+"일";
			list_date.put("reply_date", newDate);

		}
		
		logger.info("list  {}",list);
		map.put("list", list);
		map.put("count", list.size());
		
		
	return map;
	}
	
	
	
	// 댓글 작성하기
	@ResponseBody
	@GetMapping(value="/reply_write")
	public HashMap<String, Object> reply_write(HttpSession session, @RequestParam HashMap<String, String> reply){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("loginId") !=null ) {
			
			logger.info("{} reply 등록하기",reply);
			service.reply_write(reply);
			map.put("msg", "success");
			map.put("list", service.reply_call(reply.get("board_no")));
		} else {
			map.put("msg", "fall");
		}
		
		return map;
		
		
	}
	
	*/

	
	
	
	
}
