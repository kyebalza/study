package com.quiz.bank.dto;

import java.sql.Date;

//@Alias(value ="Reprot")
public class ReprotDTO {


	
	//게시글, 댓글 신고
	private int report_no;
	private String board_name;
	private int board_no;
	private int reply_no;
	private String report_user;
	private String reported_user ;
	private String report_reason;
	private Date report_date;
	private int report_state;
	private int board_cate_no;
	private String report_processing;
	
	private String title;
	private String SearchType;
	
	
	
	
	public String getReported_user() {
		return reported_user;
	}
	public void setReported_user(String reported_user) {
		this.reported_user = reported_user;
	}
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getReport_no() {
		return report_no;
	}
	public void setReport_no(int report_no) {
		this.report_no = report_no;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public String getReport_user() {
		return report_user;
	}
	public void setReport_user(String report_user) {
		this.report_user = report_user;
	}
	public String getReport_reason() {
		return report_reason;
	}
	public void setReport_reason(String report_reason) {
		this.report_reason = report_reason;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public int getReport_state() {
		return report_state;
	}
	public void setReport_state(int report_state) {
		this.report_state = report_state;
	}
	public int getBoard_cate_no() {
		return board_cate_no;
	}
	public void setBoard_cate_no(int board_cate_no) {
		this.board_cate_no = board_cate_no;
	}
	public String getReport_processing() {
		return report_processing;
	}
	public void setReport_processing(String report_processing) {
		this.report_processing = report_processing;
	}
	
	
	
	
	
}
