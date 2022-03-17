package com.quiz.bank.dto;

import java.sql.Date;

//@Alias(value ="FreeBoard")
public class FreeBoardDTO {
	
	//검색 필터
	private String SearchType;
	private String FBSearchType;
	private String Keyword;
	
	//자유 게시판
	private int board_no;
	private String title;
	private int board_cate_no;
	private String user_id;
	private Date reg_date;
	private int bHit;
	private boolean del_falg;
	private String content;
	
	private String board_cate;
	
	//댓글
	private int reply_no;
	private int ori_reply;
	private String reply_content;
	
	
	
	
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	public String getFBSearchType() {
		return FBSearchType;
	}
	public void setFBSearchType(String fBSearchType) {
		FBSearchType = fBSearchType;
	}
	public String getKeyword() {
		return Keyword;
	}
	public void setKeyword(String keyword) {
		Keyword = keyword;
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
	public boolean isDel_falg() {
		return del_falg;
	}
	public void setDel_falg(boolean del_falg) {
		this.del_falg = del_falg;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBoard_cate() {
		return board_cate;
	}
	public void setBoard_cate(String board_cate) {
		this.board_cate = board_cate;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getOri_reply() {
		return ori_reply;
	}
	public void setOri_reply(int ori_reply) {
		this.ori_reply = ori_reply;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	
	
	
	

}
