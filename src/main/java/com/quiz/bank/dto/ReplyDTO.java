package com.quiz.bank.dto;

public class ReplyDTO {
	
	private int reply_no;
	private String board_name;
	private int board_no;
	private String user_id;
	private int ori_reply;
	private Integer del_flag;
	private String reply_content;
	private Integer answer_select;
	
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getOri_reply() {
		return ori_reply;
	}
	public void setOri_reply(int ori_reply) {
		this.ori_reply = ori_reply;
	}
	public Integer getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(Integer del_flag) {
		this.del_flag = del_flag;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Integer getAnswer_select() {
		return answer_select;
	}
	public void setAnswer_select(Integer answer_select) {
		this.answer_select = answer_select;
	} 
	
	
	
	
	
	

}
