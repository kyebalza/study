package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.quiz.bank.dto.PhotoDTO;
import com.quiz.bank.dto.QuizDTO;
import com.quiz.bank.dto.TestCategoryDTO;
import com.quiz.bank.dto.TestListDTO;

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

	ArrayList<HashMap<String, String>> getDetailedSubjectCategoryList(HashMap<String, String> params);

	void registTest(TestListDTO testListDTO);

	int registQuiz(QuizDTO dto);

	ArrayList<String> adminQuizListQuizCountList();

	ArrayList<HashMap<String, String>> adminSearchQuiz(HashMap<String, String> search_info);

	int allCount(HashMap<String, String> search_info);

	HashMap<String, String> adminUpdateQuizForm(String quiz_no);

	int registPhoto(PhotoDTO photoDTO);

	int updateQuiz(HashMap<String, String> params);

	int deletePhoto(String string);

	int updatePhoto(HashMap<String, String> params);

	int quizReportAllCount(HashMap<String, String> search_info);

	ArrayList<HashMap<String, String>> adminSearchQuizReport(HashMap<String, String> search_info);

	int quizReportComplete(String quiz_no);

	ArrayList<TestCategoryDTO> quizBankTestDetail(String test_cate_no);

	HashMap<String, String> test_category(String test_cate_no);

	ArrayList<HashMap<String, String>> testCountListCall(String test_cate_no);

	ArrayList<HashMap<String, String>> subjectList(String test_cate_no);

	ArrayList<HashMap<String, String>> detailedSubjectList(String test_cate_no);

	int subjectRightCnt(HashMap<String, String>  string);

	int subjectAllCnt(HashMap<String, String>  string);

	int detailedSubjectRightCnt(HashMap<String, String> detailedSubjectUnitMap);

	int detailedSubjectAllCnt(HashMap<String, String> detailedSubjectUnitMap);

	ArrayList<HashMap<String, String>> bookmarkListCall(String loginId);

	ArrayList<Integer> quizSubjectList(String no);

	ArrayList<Integer> quizDetailedSubjectList(String no);

	ArrayList<Integer> quizBookmarkList(String no, String loginId);

	ArrayList<Integer> quizOneList(String no);

	HashMap<String, String> quiz_call(String quiz_no);

	String quiz_photo(String quiz_no);

	int quizErrorReport(HashMap<String, String> params);

	String quizAnswer(HashMap<String, String> params);

	int quizSolve(HashMap<String, String> params);

	ArrayList<HashMap<String, String>> subjectStatistics(String test_cate_no);

	ArrayList<HashMap<String, String>> detailedsubjectStatistics(String test_cate_no);

	int bookmark_call(String loginId, String quiz_no);

	HashMap<String, String> quiz_one_statistic(String quiz_no);

	int updateQuizState(String quiz_no);

	ArrayList<HashMap<String, String>> mainQuizStatics();

	ArrayList<HashMap<String, String>> studyBoardLike();

	ArrayList<HashMap<String, String>> freeBoardLike();

	ArrayList<HashMap<String, String>> manyQuiz();

	ArrayList<HashMap<String, String>> manyCorrect();

	ArrayList<HashMap<String, String>> manyCorrectPer();

	ArrayList<HashMap<String, String>> adminTestListCall(String test_cate_no);

	void adminQuizDel(String test_no);

	void adminDelTest(String test_no);

	ArrayList<HashMap<String, String>> adminTestListCallAll();



}
