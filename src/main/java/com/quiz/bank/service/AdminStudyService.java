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

	public int deleteTestCategory(HashMap<String, String> obj) {
		int del_success_test_cate = dao.deleteTestCategory(obj);
		logger.info("대분류 삭제한거 : {}",del_success_test_cate);

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



}
