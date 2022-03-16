package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.QuizBankDAO;
import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.QuizSolveDTO;
import com.quiz.bank.dto.TestCategoryDTO;

@Service
public class QuizBankService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired QuizBankDAO dao;

		//1. 시험보기 리스트 불러오기
	public ModelAndView list() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("quizBankList");
		ArrayList<TestCategoryDTO> list = dao.list();
		logger.info("리스트 갯수 : {}",list.size());
		mav.addObject("list", list);
		
		return mav;
	}

	//2. 회차별 시험 리스트
	public ModelAndView testdetail(String test_cate_no) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("testDetail");
		ArrayList<TestCategoryDTO> dto =dao.detail(test_cate_no);//상세보기
		logger.info("시험 상세보기 리스트 갯수 : {}",dto.size());
		mav.addObject("test", dto);
		
		//2-(1). 시험명 가져오기
		TestCategoryDTO test_name = dao.test_name(test_cate_no);
		mav.addObject("test_name", test_name);

		return mav;
	}

	//3.시험보기 페이지 및 시험문제 가져오기
	public ModelAndView testFroml(String test_no, String loginId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("testForm");
		ArrayList<QuizDTO> dto = dao.testFrom(test_no);
		logger.info("회차별 시험문제 리스트 갯수 : {}", dto.size());
		mav.addObject("test", dto);
		
		//로그인 아이디 확인
		logger.info("로그인 아이디 : "+loginId);
		mav.addObject("loginId", loginId);
		

		
		
		
		
		/////////////////////////////////////////////////////////////
		//test
		ArrayList<TestCategoryDTO> all = dao.test();
		ArrayList<TestCategoryDTO> part = dao.test2();
		float all2 = all.size();
		float part2 = part.size();
		
		float per2 = (all2/part2)*100;
		int per = (int) ((all2/part2)*100);
		logger.info("모든 사이즈" +all2+"일부 사이즈"+ part2);
		logger.info("나누기 결과값"+per);
		logger.info("나누기 결과값2"+per2);
		
		////////////////////////////////////////////////////////////
		//시험 문제별 정답률 통계
		//ArrayList<QuizSolveDTO> 
		return mav;
	}

	//4. 검색기능
	//ModelAndView : Model + view -> 이 안에 전달할 데이터와 페이지명을 넣는 객체
	//ModelAndView 는 컨트롤러에서만 생성 가능한 model 과 다르게 *어디에서나 생성이 가능
	public ModelAndView search(HashMap<String, String> params) {
		logger.info("시험명 검색기능 서비스 도착");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<TestCategoryDTO> list = dao.search(params);
		mav.addObject("list", list);
		
		mav.setViewName("quizBankList");//가고 싶은 jsp 파일명
		
		
		return mav;
	}

	//5-1. 북마크 여부 확인
	public String bookMark2(String loginId, String quiz_no) {
		String wishlist2 = dao.bookMark2(quiz_no,loginId);
		return wishlist2;
	}

	//5-2. 북마크 삭제
	public int bookmark_delete(String quiz_no, String loginId) {
		return dao.bookMark_delete(quiz_no,loginId);
	}

	//5-3. 북마크 추가
	public int bookmark_Insert(String loginId, String quiz_no) {
		int row = dao.bookMark_Insert(loginId,quiz_no);
		logger.info(" 입력된 건수 : {}",row);
		return row;
	}

	

}
