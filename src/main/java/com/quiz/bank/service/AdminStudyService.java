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
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dao.AdminStudyDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.QuizDTO;
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
				}
			} catch (Exception e) {
				System.out.println(e.toString());
				e.printStackTrace();
			}
		}
		return newphotonames;
	}

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
}
