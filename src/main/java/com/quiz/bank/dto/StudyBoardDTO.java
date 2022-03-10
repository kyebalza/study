package com.quiz.bank.dto;

import java.sql.Date;

//@Alias(value ="StudyBoard")
public class StudyBoardDTO {
	
	//게시글 필터
	private int board_no;
	private String title;
	private int board_cate_no;
	private String user_id;
	private Date reg_date;
	private int bHit;
	private int del_flag;
	private String board_cate;
	
	//검색 필터
	private String SearchType;
	private String Keyword;
	
	
	
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	public String getKeyword() {
		return Keyword;
	}
	public void setKeyword(String keyword) {
		Keyword = keyword;
	}
	public String getBoard_cate() {
		return board_cate;
	}
	public void setBoard_cate(String board_cate) {
		this.board_cate = board_cate;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getBoard_cate_no() {
		return board_cate_no;
	}
	public void setBoard_cate_no(int board_cate_no) {
		this.board_cate_no = board_cate_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public int getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(int del_flag) {
		this.del_flag = del_flag;
	}

	
	
}
