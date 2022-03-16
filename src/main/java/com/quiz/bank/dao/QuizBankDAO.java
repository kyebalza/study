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

	//5-1. 북마크 여부 확인
	String bookMark2(String quiz_no, String loginId);

	//5-2. 북마크 삭제
	int bookMark_delete(String quiz_no, String loginId);

	//5-3. 북마크 추가
	int bookMark_Insert(String loginId, String quiz_no);


}
