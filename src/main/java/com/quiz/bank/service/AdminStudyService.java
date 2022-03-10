package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.AdminStudyDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;

@Service
public class AdminStudyService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminStudyDAO dao;

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
		if(overlay == 0 ) {
			success = dao.registTestCategory(obj);			
		}
		return success;
	}

	public int registSubjectCategory(HashMap<String, String> obj) {
		int overlay = overlaySubjectCate(obj);
		int success = 0;
		if(overlay == 0 ) {
			success = dao.registSubjectCategory(obj);			
		}
		return success;
	}


	public int registDetailSubject(HashMap<String, String> obj) {
		int overlay = overlayDetailSubjectCate(obj);
		int success = 0;
		if(overlay == 0 ) {
			success = dao.registDetailSubject(obj);			
		}
		return success;	}


	public int overlayTestCate(HashMap<String, String> obj) {
		return dao.overlayTestCate(obj);
	}
	public int overlaySubjectCate(HashMap<String, String> obj) {
		return dao.overlaySubjectCate(obj);
	}
	
	public int overlayDetailSubjectCate(HashMap<String, String> obj) {
		return dao.overlayDetailSubjectCate(obj);
	}

	public String deleteTestCategory(HashMap<String, String> obj) {
		int del_success_test_cate = dao.deleteTestCategory(obj);
		logger.info("대분류 삭제한거 : {}",del_success_test_cate);
		
		int del_success_subject_cate = dao.deleteTestCategory_subject(obj);
		logger.info("중분류 삭제한거 : {}",del_success_subject_cate);
		
		/*
		int del_success_detailed_subject_cate = 0;
		ArrayList<String> del_subject_list = dao.deleteTestCategory_subjectList(obj);
		logger.info("가져온 중분류 {}",del_subject_list);
		if(del_subject_list.get(0) != null) {
			for (String subject : del_subject_list) {
				logger.info("{}",subject);
				del_success_detailed_subject_cate += dao.deleteTestCategory_detailed_subject(subject);
			}
		}
		*/
		String msg = "관련된 카테고리들의 삭제가 완료되었습니다.";
		logger.info("보내기 전에 검수 : {}",msg);
		return msg;
	}

}
