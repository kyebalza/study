package com.quiz.bank.dto;

import java.sql.Date;

//@Alias(value ="InquiryBoard")
public class InquiryBoardDTO {
	
	private int board_no;
	private String user_id;
	private int board_cate_no;
	private String title;
	private String content;
	private Date reg_date;
	private boolean del_flag;
	private int bHit;
	private boolean answer;
	
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getBoard_cate_no() {
		return board_cate_no;
	}
	public void setBoard_cate_no(int board_cate_no) {
		this.board_cate_no = board_cate_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public boolean isDel_flag() {
		return del_flag;
	}
	public void setDel_flag(boolean del_flag) {
		this.del_flag = del_flag;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public boolean isAnswer() {
		return answer;
	}
	public void setAnswer(boolean answer) {
		this.answer = answer;
	}
	
	
	

}


