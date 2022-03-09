package com.quiz.bank.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.service.UserService;

@Controller
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserService service;

	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}

	//1. 로그인 
	@RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody 
    public HashMap<String, Object> login(@RequestParam String user_id, @RequestParam String user_pw, HttpSession session) {
        logger.info("로그인 체크:{} / {}", user_id, user_pw);
        HashMap<String, String> success = service.login(user_id,user_pw);     
        logger.info("로그인 성공 여부:{}", success);
        HashMap<String, Object> map = new HashMap<String, Object>();    

        if (success != null) {
        	map.put("success", success); 
        	map.put("loginId",success.get("user_id"));
        	map.put("admin", success.get("user_admin"));     
        	session.setAttribute("loginId", success.get("user_id"));
        	session.setAttribute("admin", success.get("user_admin"));
        logger.info("로그인 아이디 : {} / 관리자여부 : {}",success.get("user_id"),success.get("user_admin"));
        }
        
        return map;
	}

	
	//2. 회원가입 페이지 이동
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm(Model model) {
		logger.info("회원가입 페이지로 이동"); 
		return "joinForm";
	}
	
/*	
	//2. 회원가입
	//DTO로 파라메터 받기
	//조건1. @ModelAttribute 로 파라메터 받을 것
	//조건2. parameter 명이 DTO 필드와 같을 것
	//조건3. POST 로 전송할 것
	@PostMapping(value = "/join")//post로만 받고 싶을 때
	//public String join(@RequestParam HashMap<String, String> params) {
	public String join(@ModelAttribute UserDTO dto) {
		String page = "joinForm";
		logger.info("id : {}",dto.getUser_id());
		int success = service.join(dto);
		
		if (success > 0) {
			page = "login";
		}
		
		return page;
	}
*/	
	
	
}
