package com.quiz.bank.dto;

public class QuizReportDTO {

	private int quiz_report_no;
	private int quiz_no;
	private String report_content;
	private boolean compl_flag;
	private String user_id;
	public int getQuiz_report_no() {
		return quiz_report_no;
	}
	public void setQuiz_report_no(int quiz_report_no) {
		this.quiz_report_no = quiz_report_no;
	}
	public int getQuiz_no() {
		return quiz_no;
	}
	public void setQuiz_no(int quiz_no) {
		this.quiz_no = quiz_no;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public boolean isCompl_flag() {
		return compl_flag;
	}
	public void setCompl_flag(boolean compl_flag) {
		this.compl_flag = compl_flag;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
}
