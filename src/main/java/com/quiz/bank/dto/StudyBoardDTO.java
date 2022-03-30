package com.quiz.bank.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias(value ="StudyBoard")
public class StudyBoardDTO {
	
	//공부게시판 (study_board)
	private int board_no;
	private String title;
	private int board_cate_no;
	private String user_id;
	private Date reg_date;
	private int bHit;
	private int del_flag;
	private String content;
	private boolean answer;
	private String board_name;
	
	//문제(quiz)
	private int quiz_no;
	private int test_no;
	private int test_cate_no;
	private int subject_cate_no;
	private int detailed_subject_cate_no;
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
	private int quiz_index;
	
	//게시판 세부 카테고리(board_category)
	private String board_cate;
	
	//시험종류 카테(test_category)
	private String test_cate;
	
	//시험 년도, 회차 카테고리
	private int test_year;
	private int test_count;
	
	//댓글(reply)
	private int reply_no;
	private int ori_reply;
	private String reply_content;
	private boolean answer_select;
	
	//검색 필터
	private String SearchType;
	private String Keyword;
	
	//파일업로드
	private int photo_no;
	private String ori_filename;
	private String new_filename;
	//페이징
	private int page;
	private int cnt;
	private int offset;	

	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getTest_year() {
		return test_year;
	}
	public void setTest_year(int test_year) {
		this.test_year = test_year;
	}
	public int getTest_count() {
		return test_count;
	}
	public void setTest_count(int test_count) {
		this.test_count = test_count;
	}
	
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public String getOri_filename() {
		return ori_filename;
	}
	public void setOri_filename(String ori_filename) {
		this.ori_filename = ori_filename;
	}
	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public String getTest_cate() {
		return test_cate;
	}
	public void setTest_cate(String test_cate) {
		this.test_cate = test_cate;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isAnswer() {
		return answer;
	}
	public void setAnswer(boolean answer) {
		this.answer = answer;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
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
	public int getQuiz_index() {
		return quiz_index;
	}
	public void setQuiz_index(int quiz_index) {
		this.quiz_index = quiz_index;
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
	public boolean isAnswer_select() {
		return answer_select;
	}
	public void setAnswer_select(boolean answer_select) {
		this.answer_select = answer_select;
	}
	
	
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
