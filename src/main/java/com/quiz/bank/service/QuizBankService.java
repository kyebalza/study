package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.tools.ant.util.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.QuizBankDAO;
import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.QuizSolveDTO;
import com.quiz.bank.dto.TestCategoryDTO;
import com.quiz.bank.dto.TestResultDTO;

@Service
public class QuizBankService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired QuizBankDAO dao;

		//1. 시험보기 리스트 불러오기
	public ModelAndView list() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("quizBank/quizBankList");
		ArrayList<TestCategoryDTO> list = dao.list();
		logger.info("리스트 갯수 : {}",list.size());
		mav.addObject("list", list);
		
		return mav;
	}

	//2. 회차별 시험 리스트
	public ModelAndView testdetail(String test_cate_no) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("quizBank/testDetail");
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
		mav.setViewName("quizBank/testForm");
		//ArrayList<QuizDTO> dto = dao.testFrom(test_no);
		ArrayList<HashMap<String, String>> testList = dao.testFrom(test_no);//문제 리스트 담기
		
		//문제 통계내기 -> 계속 계산하는 과정에서 오류가 생김
		ArrayList<HashMap<String, String>> quizRightCnt = dao.quizRightCnt();//문제당 정답 횟수
		ArrayList<HashMap<String, String>> quizAllCnt = dao.quizAllCnt();//문제당 전체 풀이 횟수 
		logger.info("정답 사이즈 : "+ quizRightCnt);
		logger.info("전체사이즈 : "+quizAllCnt);
		ArrayList<HashMap<String, String>> per = new ArrayList<HashMap<String,String>>();
		if(quizRightCnt.size()==quizAllCnt.size()) {
			for (int i = 0; i <quizRightCnt.size(); ++i) {
				
				
				logger.info("정답값 {}",quizRightCnt.get(i).get("right"));
				logger.info("전체값 {}",quizAllCnt.get(i).get("all"));
				///////////////////////
				String right = String.valueOf(quizRightCnt.get(i).get("right"));
				String all = String.valueOf(quizAllCnt.get(i).get("all"));
				logger.info("{},{}",right,all);
				int intRight = Integer.parseInt(right); 
				int intAll = Integer.parseInt(all);
				logger.info("intR : {}, intA : {}",intRight,intAll);
				logger.info("intR / intA : {}",100*intRight/intAll);
				int percent2 = 100*intRight/intAll;
				logger.info("나누기 캐스팅 : {}", percent2);
				String percent = Integer.toString(percent2);
//				long percente = intRight / intAll;
//				logger.info("long percente : {}",percente);
//				int ex = intRight % intAll;
//				logger.info("int ex : {}",ex);
				
				

//				int percent2 = (int)(Integer.parseInt(quizRightCnt.get(i).get("count(quiz_no)")) / Integer.parseInt(quizAllCnt.get(i).get("count(quiz_no)"))*100);
//				logger.info("캐스트 값 {}", percent2);
//				String percent = Integer.toString(percent2);
				String quiz_no = String.valueOf(quizRightCnt.get(i).get("quiz_no"));
				HashMap<String, String> asd =new HashMap<String, String>();
				asd.put("quiz_no", quiz_no);
				asd.put("percent", percent);
				
				per.add(asd);
				//logger.info("퀴즈넘버"+per);
				
				
			}
		}
		//방법1 : 
		for(int i = 0; i <testList.size(); ++i) {
			String comp_no = String.valueOf(testList.get(i).get("quiz_no"));
			logger.info(comp_no);
			for(int i2 = 0; i2 <per.size(); ++i2) {
				String comp_no2 = String.valueOf(per.get(i2).get("quiz_no"));
				//logger.info("컴프넘버2"+comp_no2);
				if(comp_no.equals(comp_no2)) {
					//logger.info("값 담김");
					testList.get(i).put("percent",String.valueOf(per.get(i2).get("percent")));
				}
			}
		}
		
		
		
		
		
//		방법2: 향상된 for 문		
//		for(HashMap<String, String> testUnitMap : testList) {
//			String comp_no = testUnitMap.get("quiz_no");
//			for(int i2 = 0; i2 <per.size(); ++i2) {
//				String comp_no2 = per.get(i2).get("quiz_no");
//				if(comp_no.equals(comp_no2)) {
//					testUnitMap.put("test",per.get(i2).get("percent"));
//				}
//			}
//		}
		
		
		
		logger.info("회차별 시험문제 리스트 갯수 : {}", testList.size());
		mav.addObject("test", testList);
		
		//로그인 아이디 확인
		logger.info("로그인 아이디 : "+loginId);
		mav.addObject("loginId", loginId);
		

		
		
		
		
		/////////////////////////////////////////////////////////////
		//test
//		ArrayList<TestCategoryDTO> all = dao.test();
//		ArrayList<TestCategoryDTO> part = dao.test2();
//		float all2 = all.size();
//		float part2 = part.size();
//		
//		float per2 = (all2/part2)*100;
//		int per = (int) ((all2/part2)*100);
//		logger.info("모든 사이즈" +all2+"일부 사이즈"+ part2);
//		logger.info("나누기 결과값"+per);
//		logger.info("나누기 결과값2"+per2);
//		
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
		
		mav.setViewName("quizBank/quizBankList");//가고 싶은 jsp 파일명
		
		
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

	//6. 체점하기
	public HashMap<String, Object> testResult(ArrayList<String> params, String test_prac_flag, String loginId, String elapse_time, String test_no) {
		QuizSolveDTO quizSolveDTO = new QuizSolveDTO();//타입변환
		TestResultDTO testResultDTO = new TestResultDTO();//타입변환
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = 0;
		int success2 = 0;
		int score = 0;
		
		//개별문제풀이 테이블
		for (int i = 0; i < params.size(); i++) {
			JSONObject jObject = new JSONObject(params.get(i));//JSON Object로 받아오기
			quizSolveDTO.setUser_id(loginId);//아이디
			quizSolveDTO.setQuiz_no(Integer.parseInt(jObject.getString("quiz_no")));//문제식별번호
			//정답여부
			int quiz_answer  = Integer.parseInt(jObject.getString("quiz_answer"));
			int my_answer  = Integer.parseInt(jObject.getString("my_answer"));
			if(my_answer == quiz_answer) {
				quizSolveDTO.setcorrect_wrong(true);
				int first_quiz_point = Integer.parseInt(jObject.getString("quiz_point"));
				logger.info("저음 점수 {}",first_quiz_point);
				score += first_quiz_point;
				logger.info("합쳐진 점수 {}",score);
				map.put("result", 1);
			}else {
				quizSolveDTO.setcorrect_wrong(false);
				map.put("result", 0);
			}
			quizSolveDTO.setTest_prac_flag(test_prac_flag);//시험/연습
			//6-1. 개별 문제풀이 결과테이블
			success = dao.quiz_solve(quizSolveDTO);
			logger.info("개별문제풀이 업로드 성공여부 {}", success);
		}
		//6-2. 시험 결과 테이블
		testResultDTO.setUser_id(loginId);
		testResultDTO.setTest_no(Integer.parseInt(test_no));
		testResultDTO.setElapse_time(elapse_time);
		testResultDTO.setScore(score);
		success2 = dao.test_result(testResultDTO);
		logger.info("시험 결과 업로드 성공여부 {}", success2);
		
		
		return map;
	}

	

}
