package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dto.InquiryBoardDTO;

public interface InquiryBoardDAO {

	





	






	void inquiryWrite(InquiryBoardDTO dto); // 문의게시판 글쓰기
	
	
	
	
	int allCount();

	ArrayList<InquiryBoardDTO> inquirylist(int pagePerCnt, int offset);



	InquiryBoardDTO inquirydetail(String board_no);


	// void upHit(String board_no); // 문의게시판 조회 수 올리기





}
