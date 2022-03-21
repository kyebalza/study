package com.quiz.bank.dao;

import java.util.HashMap;

import com.quiz.bank.dto.UserDTO;

public interface UserDAO {
	
	//1. 회원가입
	int join(UserDTO dto);
	
	//1-1. 아이디 중복확인
	String overlay(String id);

	//2. 로그인
	HashMap<String, String> login(String user_id, String user_pw);

	//2-1. 암호화된 비밀번호 비교
	String loginPw(String user_id);

	int emailOverLay(String email);

	//4. 아이디 찾기
	String findid(String user_name, String user_phone, String user_email);

	int confirmIdAndEmail(String user_id, String user_email);

	void rePassword(String user_id, String encPw);
	
	
}
