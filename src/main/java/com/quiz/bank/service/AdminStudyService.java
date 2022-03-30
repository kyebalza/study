package com.quiz.bank.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.AdminStudyDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.PhotoDTO;
import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.TestCategoryDTO;
import com.quiz.bank.dto.TestListDTO;

@Service
public class AdminStudyService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	AdminStudyDAO dao;

	public ArrayList<HashMap<String, String>> testCategoryCall() {
		return dao.testCategoryCall();
	}

	public ArrayList<HashMap<String, String>> subjectCategoryCall(HashMap<String, String> obj) {
		return dao.subjectCategoryCall(obj);
	}

	public ArrayList<HashMap<String, String>> detailSubjectCategoryCall(HashMap<String, String> obj) {
		return dao.detailSubjectCategoryCall(obj);
	}

	public int registTestCategory(HashMap<String, String> obj) {
		int overlay = overlayTestCate(obj);
		int success = 0;
		if (overlay == 0) {
			success = dao.registTestCategory(obj);
		}
		return success;
	}

	public int registSubjectCategory(HashMap<String, String> obj) {
		int overlay = overlaySubjectCate(obj);
		int success = 0;
		if (overlay == 0) {
			success = dao.registSubjectCategory(obj);
		}
		return success;
	}

	public int registDetailSubject(HashMap<String, String> obj) {
		int overlay = overlayDetailSubjectCate(obj);
		int success = 0;
		if (overlay == 0) {
			success = dao.registDetailSubject(obj);
		}
		return success;
	}

	public int overlayTestCate(HashMap<String, String> obj) {
		return dao.overlayTestCate(obj);
	}

	public int overlaySubjectCate(HashMap<String, String> obj) {
		return dao.overlaySubjectCate(obj);
	}

	public int overlayDetailSubjectCate(HashMap<String, String> obj) {
		return dao.overlayDetailSubjectCate(obj);
	}

	public int deleteTestCategory(HashMap<String, String> obj) {
		int del_success_test_cate = dao.deleteTestCategory(obj);
		logger.info("대분류 삭제한거 : {}", del_success_test_cate);

		return del_success_test_cate;
	}

	public int deleteSubjectCategory(HashMap<String, String> obj) {
		return dao.deleteSubjectCategory(obj);
	}

	public int adminDeleteDetailedSubjectCategory(HashMap<String, String> obj) {
		return dao.adminDeleteDetailedSubjectCategory(obj);
	}

	public String getTestCategoryName(HashMap<String, String> params) {
		return dao.getTestCategoryName(params);
	}

	public ArrayList<HashMap<String, String>> getSubjectCategoryList(HashMap<String, String> params) {
		return dao.getSubjectCategoryList(params);
	}

	public ArrayList<HashMap<String, String>> getDetailedSubjectCategoryList(HashMap<String, String> params) {
		return dao.getDetailedSubjectCategoryList(params);
	}

	public HashMap<String, String> adminPhotoUpload(MultipartFile[] photos) {
		return saveFile(photos);
	}

	private HashMap<String, String> saveFile(MultipartFile[] photos) {
		HashMap<String, String> newphotonames = new HashMap<String, String>();
		int i = 1;
		for (MultipartFile photo : photos) {
			try {
				String oriFileName = photo.getOriginalFilename();
				int index = oriFileName.lastIndexOf(".");
				logger.info("index : {}", index);
				// 방어코드 : 예외 발생이 예상되는 지점을 피해가도록 처리
				if (index > 0) {
					String ext = oriFileName.substring(index); // 확장자(보여주기 시작할 인덱스)
					String newFileName = System.currentTimeMillis() + ext;// 새로운 파일명 생성
					Thread.sleep(1);// 파일 중복 피하기위함
					logger.info(oriFileName + " => " + newFileName);
					// 파일 저장(photo 로부터 byte 를 뽑아내 경로를 지정하여 넣는다.)
					byte[] bytes = photo.getBytes();

					Path path = Paths.get("C:/upload/" + newFileName); // 경로설정
					Files.write(path, bytes);
					logger.info(oriFileName + " 컴퓨터에 SAVE");
					newphotonames.put(Integer.toString(i), newFileName);
					newphotonames.put(Integer.toString(i+1), oriFileName);
					i++;
				} else {
					newphotonames.put("index", Integer.toString(index));
				}
			} catch (Exception e) {
				System.out.println(e.toString());
				e.printStackTrace();
			}
		}
		return newphotonames;
	}

	@Transactional
	public int registTestAndQuiz(ArrayList<String> params) {
		TestListDTO testListDTO = new TestListDTO();
		int success = 0;

		logger.info("{}", params);// 스트링 배열로 도착

		for (int i = 0; i < params.size(); i++) {
			JSONObject jObject = new JSONObject(params.get(i));
			if (i == 0) {
				logger.info("{}", jObject);
				testListDTO.setTest_cate_no(Integer.parseInt(jObject.getString("test_category")));
				testListDTO.setTest_year(Integer.parseInt(jObject.getString("test_year")));
				testListDTO.setTest_month(Integer.parseInt(jObject.getString("test_month")));
				testListDTO.setTest_count(Integer.parseInt(jObject.getString("test_count")));
				testListDTO.setTest_passrate(Integer.parseInt(jObject.getString("test_pass_rate")));
				testListDTO.setTest_time(Integer.parseInt(jObject.getString("test_time")));
				testListDTO.setTest_fullscore(Integer.parseInt(jObject.getString("test_fullscore")));
				testListDTO.setPass_criterion(Integer.parseInt(jObject.getString("test_pass_criterion")));
				logger.info("{}", testListDTO.getTest_cate_no());
				logger.info("{}", testListDTO.getTest_year());
				logger.info("{}", testListDTO.getTest_month());
				logger.info("{}", testListDTO.getTest_count());
				logger.info("{}", testListDTO.getTest_passrate());
				logger.info("{}", testListDTO.getTest_time());
				logger.info("{}", testListDTO.getTest_fullscore());

				dao.registTest(testListDTO);
				logger.info("받아온 번호 : {}", testListDTO.getTest_no());

			} else {
				QuizDTO dto = new QuizDTO();
				dto.setTest_no(testListDTO.getTest_no()); // 위에서 회차번호 받아와서 해야 함
				dto.setQuiz_index(Integer.parseInt(jObject.getString("quiz_index")));
				dto.setTest_cate_no(testListDTO.getTest_cate_no());
				dto.setSubject_cate_no(Integer.parseInt(jObject.getString("quiz_subject")));
				dto.setDetailed_subject_cate_no(Integer.parseInt(jObject.getString("quiz_detailed_subject")));
				dto.setQuiz_content(jObject.getString("quiz_content"));
				dto.setQuiz_explation(jObject.getString("quiz_explation"));
				dto.setQuiz_type(jObject.getString("quiz_type"));
				dto.setQuiz_point(Integer.parseInt(jObject.getString("quiz_point")));
				dto.setOption1(jObject.getString("option1"));
				dto.setOption2(jObject.getString("option2"));
				dto.setOption3(jObject.getString("option3"));
				dto.setOption4(jObject.getString("option4"));
				dto.setOption5(jObject.getString("option5"));
				dto.setQuiz_answer(jObject.getString("answer"));

				success += dao.registQuiz(dto);
				
				if(jObject.has("newPhotoName")) {
					logger.info("사진 존재, 사진입력 시작 : {}",jObject);
					PhotoDTO photoDTO= new PhotoDTO();
					photoDTO.setBoard_name("quiz");
					photoDTO.setBoard_no(dto.getQuiz_no());
					photoDTO.setOri_filename(jObject.getString("oriPhotoName"));
					photoDTO.setNew_filename(jObject.getString("newPhotoName"));
					dao.registPhoto(photoDTO);
					
				}
				
			}
		}

		return success;
	}

	public HashMap<String, Object> adminQuizListQuizCountList() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<String> test_count_list = dao.adminQuizListQuizCountList();
		map.put("test_count_list", test_count_list);

		return map;
	}

	public HashMap<String, Object> adminSearchQuiz(HashMap<String, String> search_info) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		//v페이징 관련부분
		int currPage = Integer.parseInt(search_info.get("page"));
		int pagePerCnt = Integer.parseInt(search_info.get("cnt"));
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		int totalCount = dao.allCount(search_info); // bbs테이블의 모든 글의 갯수
		logger.info("totalCount : {}",totalCount);
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;
		map.put("pages",range);
		search_info.put("pagePerCnt", Integer.toString(pagePerCnt));
		search_info.put("offset", Integer.toString(offset));
		
		
		
		logger.info("{}", search_info);
		logger.info("검색할 값들 : {}", search_info);
		ArrayList<HashMap<String, String>> quiz_search_list = dao.adminSearchQuiz(search_info);
		logger.info("검색 결과 : {}", quiz_search_list);

		map.put("quiz_search_list", quiz_search_list);
		return map;

	}

	public HashMap<String, String> adminUpdateQuizForm(String quiz_no) {
		return dao.adminUpdateQuizForm(quiz_no);
	}

	public int updateQuiz(HashMap<String, String> params) {
		dao.updateQuiz(params);
		
		
		
		
		
		//사진 수정부분
		PhotoDTO photoDTO = new PhotoDTO();
		photoDTO.setBoard_name("quiz");
		photoDTO.setBoard_no(Integer.parseInt(params.get("quiz_no")));
		photoDTO.setNew_filename(params.get("new_filename"));
		photoDTO.setOri_filename(params.get("ori_filename"));
		int success = 0;
		//1.없던 사진을 추가하는 경우
		if(params.get("before_new_filename").equals("") && params.get("new_filename") !=null)
		{
			logger.info("{}","1.없던 사진을 추가하는 경우 INSERT");
			success = dao.registPhoto(photoDTO);
			}
		//2.사진을 삭제하는 경우
		else if (!params.get("before_new_filename").equals("") && params.get("new_filename") ==null)
		{
			logger.info("{}","2.사진을 삭제하는 경우 DELETE");
			success = dao.deletePhoto(params.get("before_new_filename"));
			}
		//3.사진을 바꾸는 경우
		else if(!params.get("before_new_filename").equals("") && params.get("new_filename") !=null && !params.get("before_new_filename").equals(params.get("new_filename")))
		{
			logger.info("{}","3.사진을 바꾸는 경우 UPDATE");
			success = dao.updatePhoto(params);
			}
		//4.사진이 있는데 그대로인 경우
		else if(!params.get("before_new_filename").equals("") && params.get("new_filename") !=null && params.get("before_new_filename").equals(params.get("new_filename")))
		{
			logger.info("{}","4.사진이 있는데 그대로인 경우 PASS");
			}
		//5.원래 없는데 없는 경우
		else if(params.get("before_new_filename").equals("") && params.get("new_filename") ==null) 
		{
			logger.info("{}","5.원래 없는데 없는 경우 PASS");
			}
		
		return success;
	}

	public HashMap<String, Object> adminQuizReportCall(HashMap<String, String> search_info) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int currPage = Integer.parseInt(search_info.get("page"));
		int pagePerCnt = Integer.parseInt(search_info.get("cnt"));
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		int totalCount = dao.quizReportAllCount(search_info); // bbs테이블의 모든 글의 갯수
		logger.info("totalCount : {}",totalCount);
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;
		//map.put("pages",range);
		search_info.put("pagePerCnt", Integer.toString(pagePerCnt));
		search_info.put("offset", Integer.toString(offset));
		
		
		
		logger.info("{}", search_info);
		logger.info("검색할 값들 : {}", search_info);
		ArrayList<HashMap<String, String>> quiz_report_list = dao.adminSearchQuizReport(search_info);
		logger.info("검색 결과 : {}", quiz_report_list);
		
		map.put("quiz_report_list", quiz_report_list);		
		map.put("pages",range);
		logger.info("pages : {}",map);
		return map;
	}

	public void quizReportComplete(String quiz_no) {
		dao.quizReportComplete(quiz_no);
	}

	public ModelAndView quizBankTestDetail(String test_cate_no) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("quiz_bank2/quizBankTestDetail");
		HashMap<String, String> test_category = dao.test_category(test_cate_no);
		mav.addObject("test_category", test_category);
		return mav;
	}

	public HashMap<String, Object> testCountListCall(String test_cate_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> testCountList  = dao.testCountListCall(test_cate_no);
		map.put("testCountList", testCountList);
		
		return map;
	}

	public HashMap<String, Object> subjectListCall(String test_cate_no, String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> subjectList = dao.subjectList(test_cate_no);
		ArrayList<HashMap<String, String>> subjectStaticList = dao.subjectStatistics(test_cate_no);
		logger.info("subjectList : {}",subjectList);
		logger.info("subjectStaticList : {}",subjectStaticList);
		for (HashMap<String, String> subject : subjectList) {
			for (HashMap<String, String> subjectStatic : subjectStaticList) {
				if(subject.get("subject_cate_no") == subjectStatic.get("subject_cate_no")) {
					logger.info("valueof 전 : {}",subjectStatic.get("correct_cnt"));
					logger.info("valueof 후 : {}",String.valueOf(subjectStatic.get("correct_cnt")));
				
					subject.put("rightCnt", String.valueOf(subjectStatic.get("correct_cnt")));
					subject.put("AllCnt", String.valueOf(subjectStatic.get("all_cnt")));

				}
			}
		}
		logger.info("subjectList : {}",subjectList);
		
		/*
		for (HashMap<String, String> subject : subjectList) {
			for (HashMap<String, String> subjectStatic :  subjectStaticList) {
				if(subject.get("subject_cate_no").equals(subjectStatic.get("subject_cate_no"))) {		
				}
			}
		}
		*/
		/*
		for (HashMap<String, String> subjectUnitMap : subjectList) {
			//String subject_cate_no = subjectUnitMap.get("subject_cate_no");
			subjectUnitMap.put("loginId", loginId);
			int rightCnt = dao.subjectRightCnt(subjectUnitMap);
			int AllCnt = dao.subjectAllCnt(subjectUnitMap);
			subjectUnitMap.put("rightCnt", Integer.toString(rightCnt));
			subjectUnitMap.put("AllCnt",Integer.toString(AllCnt));
		}
		*/
		
		ArrayList<HashMap<String, String>> detailedSubjectList = dao.detailedSubjectList(test_cate_no);
		ArrayList<HashMap<String, String>> detailedsubjectStaticList = dao.detailedsubjectStatistics(test_cate_no);
		logger.info("detailedSubjectList : {}",detailedSubjectList);
		logger.info("detailedsubjectStaticList : {}",detailedsubjectStaticList);
		for (HashMap<String, String> detailedSubject : detailedSubjectList) {
			for (HashMap<String, String> detailedsubjectStatic : detailedsubjectStaticList) {
				if(detailedSubject.get("detailed_subject_cate_no") == detailedsubjectStatic.get("detailed_subject_cate_no")) {
					logger.info("valueof 전 : {}",detailedsubjectStatic.get("correct_cnt"));
					logger.info("valueof 후 : {}",String.valueOf(detailedsubjectStatic.get("correct_cnt")));
				
					detailedSubject.put("rightCnt", String.valueOf(detailedsubjectStatic.get("correct_cnt")));
					detailedSubject.put("AllCnt", String.valueOf(detailedsubjectStatic.get("all_cnt")));

				}
			}
		}
		
		logger.info("detailedSubjectList : {}",detailedSubjectList);
		
		
		/*
		for (HashMap<String, String> detailedSubjectUnitMap : detailedSubjectList) {
			detailedSubjectUnitMap.put("loginId", loginId);
			int rightCnt = dao.detailedSubjectRightCnt(detailedSubjectUnitMap);
			int AllCnt = dao.detailedSubjectAllCnt(detailedSubjectUnitMap);
			detailedSubjectUnitMap.put("rightCnt", Integer.toString(rightCnt));
			detailedSubjectUnitMap.put("AllCnt",Integer.toString(AllCnt));			
		}
		*/
		
		map.put("subjectList", subjectList);
		map.put("detailedSubjectList", detailedSubjectList);
		
		return map;
	}

	public HashMap<String, Object> bookmarkListCall(String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> bookMarkList = dao.bookmarkListCall(loginId);
		map.put("bookMarkList", bookMarkList);
		
		return map;
	}

	public ArrayList<Integer> quizOneByOneList(String table_type, String no, String loginId) {
		ArrayList<Integer> quizList = null;
		if(table_type.equals("subject")) {
			quizList = dao.quizSubjectList(no);
		}
		if(table_type.equals("detailedSubject")) {
			quizList = dao.quizDetailedSubjectList(no);			
		}
		if(table_type.equals("bookmark")) {
			quizList = dao.quizBookmarkList(no,loginId);
		}
		if(table_type.equals("quiz")) {
			quizList = dao.quizOneList(no);
		}
		return quizList;
	}

	public HashMap<String, Object> quiz_call(String quiz_no, String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		HashMap<String, String> quiz = dao.quiz_call(quiz_no);
		map.put("quiz", quiz);
		int success = dao.bookmark_call(loginId,quiz_no);
		map.put("book", success);
		
		HashMap<String, String> qos = dao.quiz_one_statistic(quiz_no);
		map.put("qos", qos);
		String photoname = "noPhoto";
		photoname = dao.quiz_photo(quiz_no);
		if(photoname != null) {
		}
		map.put("photo", photoname);			
		
		return map;
	}

	public HashMap<String, Object> quizErrorReport(HashMap<String, String> params) {
		HashMap<String, Object> mav = new HashMap<String, Object>();
		int msg = dao.quizErrorReport(params);
		mav.put("msg", msg);
		return mav;
	}

	public HashMap<String, Object> quizSolve(HashMap<String, String> params) {
		HashMap<String, Object>map = new HashMap<String, Object>();
		String answer = dao.quizAnswer(params);
		boolean correct_worng = answer.equals(params.get("answer"));
		if(correct_worng) {
			params.put("correct_worng", "1");		
			map.put("result", 1);
		} else {
			params.put("correct_worng", "0");
			map.put("result", 0);
		}
		params.put("test_prac_flag", "prac");
		logger.info("loginId : {}",params.get("loginId"));
		if(!params.get("loginId").equals("")) {
			int success = dao.quizSolve(params);			
			
		}
		
		
		return map;
	}

	public HashMap<String, Object> updateQuizState(String quiz_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = dao.updateQuizState(quiz_no);
		map.put("msg", success);
		return map;
	}

	public HashMap<String, Object> mainStatics() {
		
		//1.많이 푼 사람
		ArrayList<HashMap<String, String>> manyQuiz= dao.manyQuiz();
		
		//2.많이 맞춘 사람
		ArrayList<HashMap<String, String>> manyCorrect= dao.manyCorrect();
		
		//3.정답률 높은 사람
		ArrayList<HashMap<String, String>> manyCorrectPer = dao.manyCorrectPer();

		
		//4.공부 좋아요 많은 게시글
		ArrayList<HashMap<String, String>> studyBoardLike = dao.studyBoardLike();
		//5.자유 좋아요 많은 게시글
		ArrayList<HashMap<String, String>> freeBoardLike = dao.freeBoardLike();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("manyQuiz", manyQuiz);
		map.put("manyCorrect", manyCorrect);
		map.put("manyCorrectPer", manyCorrectPer);
		map.put("studyBoardLike", studyBoardLike);
		map.put("freeBoardLike", freeBoardLike);
		
		return map;
		
		
	}




}
