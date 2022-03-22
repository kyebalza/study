package com.quiz.bank.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value ="QuizSlove")
public class QuizSolveDTO {
	
	private int solve_no;
	private String user_id;
	private int quiz_no;
	private int detailed_subject_cate_no;
	private int subject_cate_no;
	private int test_cate_no;
	private Date solve_date;
	private boolean correct_wrong;
	private String test_prac_flag;
	public int getSolve_no() {
		return solve_no;
	}
	public void setSolve_no(int solve_no) {
		this.solve_no = solve_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getQuiz_no() {
		return quiz_no;
	}
	public void setQuiz_no(int quiz_no) {
		this.quiz_no = quiz_no;
	}
	public int getDetailed_subject_cate_no() {
		return detailed_subject_cate_no;
	}
	public void setDetailed_subject_cate_no(int detailed_subject_cate_no) {
		this.detailed_subject_cate_no = detailed_subject_cate_no;
	}
	public int getSubject_cate_no() {
		return subject_cate_no;
	}
	public void setSubject_cate_no(int subject_cate_no) {
		this.subject_cate_no = subject_cate_no;
	}
	public int getTest_cate_no() {
		return test_cate_no;
	}
	public void setTest_cate_no(int test_cate_no) {
		this.test_cate_no = test_cate_no;
	}
	public Date getSolve_date() {
		return solve_date;
	}
	public void setSolve_date(Date solve_date) {
		this.solve_date = solve_date;
	}
	public boolean iscorrect_wrong() {
		return correct_wrong;
	}
	public void setcorrect_wrong(boolean correct_wrong) {
		this.correct_wrong = correct_wrong;
	}
	public String getTest_prac_flag() {
		return test_prac_flag;
	}
	public void setTest_prac_flag(String test_prac_flag) {
		this.test_prac_flag = test_prac_flag;
	}
	
	
	
}
