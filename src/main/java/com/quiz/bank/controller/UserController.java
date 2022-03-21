package com.quiz.bank.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.dto.UserDTO;
import com.quiz.bank.service.UserService;
import com.quiz.bank.utils.MailSend;

@Controller
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserService service;
	
	//0. 회원가입 페이지 이동
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm(Model model) {
		logger.info("회원가입 페이지로 이동"); 
		return "joinForm";
	}
	
	//1-1. 아이디 중복확인(ajax)
	@GetMapping(value = "/overlay")//get으로만 받고 싶을 때
	@ResponseBody
	public HashMap<String, Object> overlay(@RequestParam String user_id) {
		logger.info("중복체크 : {}",user_id);
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean overlay = service.overlay(user_id);
		map.put("overlay", overlay);
		return map;
	}
	
	//1. 회원가입
	//DTO로 파라메터 받기
	//조건1. @ModelAttribute 로 파라메터 받을 것
	//조건2. parameter 명이 DTO 필드와 같을 것
	//조건3. POST 로 전송할 것
	@PostMapping(value = "/join")//post로만 받고 싶을 때
	public String join(@ModelAttribute UserDTO dto) {
		String page = "joinForm";
		logger.info("id : {}",dto.getUser_id());
		int success = service.join(dto);
		
		if (success > 0) {
			page = "login";
		}
		
		return page;
	}
	
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}

	//2. 로그인 
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
	
	//3. 로그아웃 
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpSession session) {
		logger.info("로그아웃 요청"); 
		session.removeAttribute("loginId");
		session.removeAttribute("admin");
		return "redirect:/";
	}
	
	//0. 아이디 찾기 페이지 이동 
	@RequestMapping(value = "/idfind")
	public String idfind(Model model) {
		logger.info("idfind page 이동");
		return "idfind";
		
	}
	
	//4. 아이디 찾기
	@RequestMapping(value = "/findid")
    @ResponseBody 
    public HashMap<String, Object> findid(@RequestParam String user_name,
    		@RequestParam String user_phone, @RequestParam String user_email) {
        String success = service.findid(user_name, user_phone, user_email);
        //logger.info("아이디 찾기 여부 성공:{}", success);
        HashMap<String, Object> map = new HashMap<String, Object>();
        
        if (success != null) {
        	map.put("success", success);    
        } else {
        	map.put("success", "아이디없음");
        }
        return map;
    }

	@RequestMapping(value="mailTest")
	public String mailTest() {
		
		return "mailTest";
	}
	
	
	@RequestMapping(value="overlayemail")
	@ResponseBody
	public HashMap<String, Object>overlayemail(@RequestParam String email){
		HashMap<String, Object> map = new HashMap<String, Object>();
		int overLay = service.emailOverLay(email);
		if(overLay > 0) {
			map.put("overLay", overLay);
		} else {
			map.put("overLay",overLay);
			String title = "EvaStudy 인증번호 입니다.";
			double dValue = Math.random();
			int iValue = (int)(dValue*100000);
			String content  = "인증번호 : "+iValue;
			
			MailSend ms = new MailSend();
			ms.MailSend(title,content,email);
			map.put("certifiNum", iValue);			
		}
		
		
		return map;
	}	
	
	
	
	
	
	//0. 아이디 찾기 페이지 이동 
	@RequestMapping(value = "/pwfind")
	public String pwfind(Model model) {
		logger.info("idfind page 이동");
		return "pwfind";
		
	}	
	
	@RequestMapping(value="/submitTempPw")
	@ResponseBody
	public HashMap<String, Object> submitTempPw(@RequestParam String user_id, @RequestParam String user_email){
		logger.info("userid {},  useremail {}",user_id,user_email);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int count = service.confirmIdAndEmail(user_id,user_email);
		if(count == 0) {
			map.put("msg", count);
		} else {
			//1.비번 재발급해서 암호화 , 저장
			String rePassword = service.rePassword(user_id,user_email);
			MailSend ms = new MailSend();
			String title = "[EvaStudy] 임시 비밀번호입니다.";
			String content = "임시 비밀번호 : "+rePassword;
			ms.MailSend(title,content,user_email);
			map.put("msg", count);	
		}
		
		
		return map;
	}
	
	
	
}
