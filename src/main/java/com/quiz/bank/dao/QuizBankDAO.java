package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.QuizSolveDTO;
import com.quiz.bank.dto.TestCategoryDTO;
import com.quiz.bank.dto.TestResultDTO;

public interface QuizBankDAO {

	//1. 시험 리스트 불러오기
	ArrayList<TestCategoryDTO> list();

	//2. 시험 상세보기 리스트 불러오기
	ArrayList<TestCategoryDTO> detail(String test_cate_no);

	//2-(1). 시험명 가져오기
	TestCategoryDTO test_name(String test_cate_no);

	
	//3.시험보기 페이지 및 시험문제 가져오기
	ArrayList<HashMap<String, String>> testFrom(String test_no);
	
	//3-1. 통계 테스트
	
	ArrayList<HashMap<String, String>> quizRightCnt();// 정답
	
	ArrayList<HashMap<String, String>> quizAllCnt();// 전체

	//3-2. 사진 가져오기
	ArrayList<HashMap<String, String>> quiz_Photo();
	
	//3-3. 북마크 값 가져오기
	ArrayList<HashMap<String, String>> quiz_bookmark(String loginId);

	//4. 시험 검색기능 
	ArrayList<TestCategoryDTO> search(HashMap<String, String> params);

	//5-1. 북마크 여부 확인
	String bookMark2(String quiz_no, String loginId);
	
	//5-2. 북마크 삭제
	int bookMark_delete(String quiz_no, String loginId);
	
	//5-3. 북마크 추가
	int bookMark_Insert(String loginId, String quiz_no);

	
//	//6-1. 시험 결과 테이블
//	int test_result(TestResultDTO testResultDTO);
	
	//6-1. 시험 결과 테이블(test_result_no) 받아오기
	void test_result(TestResultDTO testResultDTO);

	//6-2. 개별 문제풀이 결과테이블
	int quiz_solve(QuizSolveDTO quizSolveDTO);

	//6-3. 시험 결과테이블에서 score 업데이트
	int test_result_scoreUpdate(int score, int test_result_no);

	//9. 결과페이지 이동
	ArrayList<HashMap<String, String>> resultFrom(int test_result_no);
	
	//9-1. 시험결과 가져오기
	HashMap<String, String> getTestResult(int test_result_no);
	
	//9-2. 시험 기본 정보들 가져오기
	HashMap<String, String> test_info(int test_cate_no, int test_no);

	



}
