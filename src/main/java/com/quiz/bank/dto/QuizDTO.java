package com.quiz.bank.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value ="Quiz")
public class QuizDTO {
	
	private int quiz_no;
	private int test_no;
	private int test_cate_no;
	private int subject_cate_no;
	private int detailed_subject_cate_no;
	private int quiz_index;
	private String quiz_content;
	private String quiz_explation;
	private String quiz_type;
	private int quiz_point;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private String option5;
	private String quiz_answer;
	private boolean del_flag;
	
	
	//북마크
	private String bookmark_quiz_no; 
	private String user_id; 
	private Date bookmark_date; 
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getBookmark_date() {
		return bookmark_date;
	}
	public String getBookmark_quiz_no() {
		return bookmark_quiz_no;
	}
	public void setBookmark_quiz_no(String bookmark_quiz_no) {
		this.bookmark_quiz_no = bookmark_quiz_no;
	}
	public void setBookmark_date(Date bookmark_date) {
		this.bookmark_date = bookmark_date;
	}
	public int getQuiz_no() {
		return quiz_no;
	}
	public void setQuiz_no(int quiz_no) {
		this.quiz_no = quiz_no;
	}
	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public int getTest_cate_no() {
		return test_cate_no;
	}
	public void setTest_cate_no(int test_cate_no) {
		this.test_cate_no = test_cate_no;
	}
	public int getSubject_cate_no() {
		return subject_cate_no;
	}
	public void setSubject_cate_no(int subject_cate_no) {
		this.subject_cate_no = subject_cate_no;
	}
	public int getDetailed_subject_cate_no() {
		return detailed_subject_cate_no;
	}
	public void setDetailed_subject_cate_no(int detailed_subject_cate_no) {
		this.detailed_subject_cate_no = detailed_subject_cate_no;
	}
	public int getQuiz_index() {
		return quiz_index;
	}
	public void setQuiz_index(int quiz_index) {
		this.quiz_index = quiz_index;
	}
	public String getQuiz_content() {
		return quiz_content;
	}
	public void setQuiz_content(String quiz_content) {
		this.quiz_content = quiz_content;
	}
	public String getQuiz_explation() {
		return quiz_explation;
	}
	public void setQuiz_explation(String quiz_explation) {
		this.quiz_explation = quiz_explation;
	}
	public String getQuiz_type() {
		return quiz_type;
	}
	public void setQuiz_type(String quiz_type) {
		this.quiz_type = quiz_type;
	}
	public int getQuiz_point() {
		return quiz_point;
	}
	public void setQuiz_point(int quiz_point) {
		this.quiz_point = quiz_point;
	}
	public String getOption1() {
		return option1;
	}
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	public String getOption3() {
		return option3;
	}
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	public String getOption5() {
		return option5;
	}
	public void setOption5(String option5) {
		this.option5 = option5;
	}
	public String getQuiz_answer() {
		return quiz_answer;
	}
	public void setQuiz_answer(String quiz_answer) {
		this.quiz_answer = quiz_answer;
	}
	public boolean isDel_flag() {
		return del_flag;
	}
	public void setDel_flag(boolean del_flag) {
		this.del_flag = del_flag;
	}
	
	
	
	
	
}
