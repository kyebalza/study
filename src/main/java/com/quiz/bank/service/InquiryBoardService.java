package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.InquiryBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.InquiryBoardDTO;

@Service
public class InquiryBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InquiryBoardDAO dao;



	// 2. 문의글쓰기
	public String inquiryWrite(HashMap<String, String> params) {
		
		String page = "redirect:/inquiryBoardList";
		
		InquiryBoardDTO dto = new InquiryBoardDTO();
		dto.setTitle(params.get("title"));
		dto.setContent(params.get("content"));
		dto.setUser_id(params.get("user_id"));
		dao.inquiryWrite(dto);
		
		int board_no = dto.getBoard_no();
		logger.info("board_no : "+board_no);
		
		if (board_no > 0) {
			page = "redirect:/inquiryBoardDetail?board_no="+board_no;
		}
		
		return page;
	}

	


	

}
