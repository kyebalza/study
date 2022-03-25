package com.quiz.bank;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.service.AdminStudyService;

@Controller
public class HomeController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired AdminStudyService service;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("임시 메인페이지 이동");

		return "home";
	}
	
	
	
	@RequestMapping(value = "/righter", method = RequestMethod.GET)
	public String righter(Model model) {
		logger.info("righter 이동");

		return "righter";
	}
	
	@RequestMapping(value="/header")
	public String header() {
		return "header";
	}
	
	@RequestMapping(value="mainStatics")
	@ResponseBody
	public HashMap<String, Object> mainStatics(){
		HashMap<String, Object> map = service.mainStatics();
		
		
		
		return map;
	}
	
	
}
