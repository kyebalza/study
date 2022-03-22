package com.quiz.bank.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value ="TestResult")
public class TestResultDTO {
	
	private int test_result_no;
	private String user_id;
	private int test_no;
	private String elapse_time;
	private int score;
	private Date test_execute_date;
	
	public int getTest_result_no() {
		return test_result_no;
	}
	public void setTest_result_no(int test_result_no) {
		this.test_result_no = test_result_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public String getElapse_time() {
		return elapse_time;
	}
	public void setElapse_time(String elapse_time) {
		this.elapse_time = elapse_time;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Date getTest_execute_date() {
		return test_execute_date;
	}
	public void setTest_execute_date(Date test_execute_date) {
		this.test_execute_date = test_execute_date;
	}
	

	
	
	
}
