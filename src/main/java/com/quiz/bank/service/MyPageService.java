package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.MyPageDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;

@Service
public class MyPageService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MyPageDAO dao;

	
	
	// 댓글 기능
	public ArrayList<HashMap<String, String>> reply_call(String board_no) {
		logger.info("reply_call : DAO 호출");
		
		return dao.reply_call(board_no);
	}




	public void reply_write(HashMap<String, String> reply) {
		dao.reply_write(reply);
		if (reply.get("board_name").equals("문의게시판")) {
			dao.answecomplete(reply);
		}
		
	}


	

}
