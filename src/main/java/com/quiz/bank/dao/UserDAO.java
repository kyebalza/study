package com.quiz.bank.dao;

import java.util.HashMap;

import com.quiz.bank.dto.UserDTO;

public interface UserDAO {

	//1. 로그인
	HashMap<String, String> login(String user_id, String user_pw);

	//2. 회원가입
	int join(UserDTO dto);

}
