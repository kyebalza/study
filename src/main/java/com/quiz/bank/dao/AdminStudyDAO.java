package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminStudyDAO {

	ArrayList<HashMap<String, String>> testCategoryCall();

	ArrayList<HashMap<String, String>> subjectCategoryCall(HashMap<String, String> obj);

	ArrayList<HashMap<String, String>> detailSubjectCategoryCall(HashMap<String, String> obj);

	int registTestCategory(HashMap<String, String> obj);

	int registSubjectCategory(HashMap<String, String> obj);

	int registDetailSubject(HashMap<String, String> obj);

	int overlayTestCate(HashMap<String, String> obj);

	int overlaySubjectCate(HashMap<String, String> obj);

	int overlayDetailSubjectCate(HashMap<String, String> obj);

	int deleteTestCategory(HashMap<String, String> obj);

	int deleteTestCategory_subject(HashMap<String, String> obj);

	ArrayList<String> deleteTestCategory_subjectList(HashMap<String, String> obj);

	int deleteTestCategory_detailed_subject(String subject);

	int deleteSubjectCategory(HashMap<String, String> obj);

	int adminDeleteDetailedSubjectCategory(HashMap<String, String> obj);

	String getTestCategoryName(HashMap<String, String> params);

	ArrayList<HashMap<String, String>> getSubjectCategoryList(HashMap<String, String> params);


}
