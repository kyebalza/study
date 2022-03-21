package com.quiz.bank.service;

import java.util.HashMap;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.UserDTO;

@Service
public class UserService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserDAO dao;

	
	
	//1. 회원가입
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
	
	//1-1. 아이디 중복확인
	public boolean overlay(String id) {
		
		boolean overlay = true;
		String chkId = dao.overlay(id);
		logger.info("중복 아이디 : "+chkId);
		if(chkId == null) {
			overlay = false;
		}
		
		return overlay;
	}

	//2.로그인
	public HashMap<String, String> login(String user_id, String user_pw) {
		HashMap<String, String> success = null;
		//2-1. 암호화된 비밀번호 비교
		String enc_pw = dao.loginPw(user_id);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		if(encoder.matches(user_pw, enc_pw)) {
			success = dao.login(user_id, user_pw);
			logger.info("비밀번호의 일치가 확인되었습니다.");
		}else {
			logger.info("일치하지 않는 비밀번호입니다.");
		}
		
		return success;
	}

	//4. 아이디 찾기
	public String findid(String user_name, String user_phone, String user_email) {
		return dao.findid(user_name, user_phone, user_email);
	}

	public int emailOverLay(String email) {
		return dao.emailOverLay(email);
	}	
	
	
	public int confirmIdAndEmail(String user_id, String user_email) {
		return dao.confirmIdAndEmail(user_id,user_email);
	}

	public String rePassword(String user_id, String user_email) {
		
		Random rnd =new Random();
		String tempPw = "";
		for(int i=0;i<10;i++){
		    // rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.
		    if(rnd.nextBoolean()){
		    	tempPw += ((char)((int)(rnd.nextInt(26))+97));
		    }else{
		    	tempPw+=((rnd.nextInt(10)));
		    }
		}
		logger.info("새로 발급 된 비번 : {}",tempPw);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encPw = encoder.encode(tempPw);
		logger.info("enc pw :"+encPw);		
		dao.rePassword(user_id,encPw);
		
		return tempPw;
	}


}
