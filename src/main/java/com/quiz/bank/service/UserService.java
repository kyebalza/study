package com.quiz.bank.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.UserDAO;

@Service
public class UserService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserDAO dao;

	//1.로그인
	public HashMap<String, String> login(String user_id, String user_pw) {
		return dao.login(user_id, user_pw);
	}
/*
	//2. 회원가입
	public int join(UserDTO dto) {
		//pw 암호화
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String pw = dto.getUser_pw();
		logger.info("plain pw : "+ pw);
		String encPw = encoder.encode(pw);
		logger.info("enc pw :"+encPw);
		dto.setUser_pw(encPw);
		
		return dao.join(dto);
	}
*/
	

}
