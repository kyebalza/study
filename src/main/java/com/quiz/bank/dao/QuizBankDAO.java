package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.TestCategoryDTO;

public interface QuizBankDAO {

	//1. 시험 리스트 불러오기
	ArrayList<TestCategoryDTO> list();

	//2. 시험 상세보기 리스트 불러오기
	ArrayList<TestCategoryDTO> detail(String test_cate_no);

	//2-(1). 시험명 가져오기
	TestCategoryDTO test_name(String test_cate_no);

	
	//3.시험보기 페이지 및 시험문제 가져오기
	ArrayList<QuizDTO> testFrom(String test_no);
	
	//4. 시험 검색기능 
	ArrayList<TestCategoryDTO> search(HashMap<String, String> params);

	
	//////////////////////////////////////////////////////////////////////////////
	ArrayList<TestCategoryDTO> test();

	ArrayList<TestCategoryDTO> test2();


}
