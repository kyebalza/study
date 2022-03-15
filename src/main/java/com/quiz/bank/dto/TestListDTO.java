package com.quiz.bank.dto;

import org.apache.ibatis.type.Alias;

@Alias(value ="TestList")
public class TestListDTO {
	
	private int test_no;
	private int test_cate_no;
	private int test_year;
	private int test_month;
	private int test_count;
	private int test_passrate;
	private int test_time;
	private int test_fullscore;
	private int pass_criterion;

	public int getPass_criterion() {
		return pass_criterion;
	}
	public void setPass_criterion(int pass_criterion) {
		this.pass_criterion = pass_criterion;
	}
	private boolean del_flag;
	
	
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
	public int getTest_year() {
		return test_year;
	}
	public void setTest_year(int test_year) {
		this.test_year = test_year;
	}
	public int getTest_month() {
		return test_month;
	}
	public void setTest_month(int test_month) {
		this.test_month = test_month;
	}
	public int getTest_count() {
		return test_count;
	}
	public void setTest_count(int test_count) {
		this.test_count = test_count;
	}
	public int getTest_passrate() {
		return test_passrate;
	}
	public void setTest_passrate(int test_passrate) {
		this.test_passrate = test_passrate;
	}
	public int getTest_time() {
		return test_time;
	}
	public void setTest_time(int test_time) {
		this.test_time = test_time;
	}
	public int getTest_fullscore() {
		return test_fullscore;
	}
	public void setTest_fullscore(int test_fullscore) {
		this.test_fullscore = test_fullscore;
	}
	public boolean isDel_flag() {
		return del_flag;
	}
	public void setDel_flag(boolean del_flag) {
		this.del_flag = del_flag;
	}
	
	
}
