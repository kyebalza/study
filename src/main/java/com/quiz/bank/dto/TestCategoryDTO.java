package com.quiz.bank.dto;

import org.apache.ibatis.type.Alias;

@Alias(value ="TestCategory")
public class TestCategoryDTO {
	
	private int test_cate_no;
	private String test_cate; 
	private boolean del_flag;
	private int pass_criterion;
	
	public int getTest_cate_no() {
		return test_cate_no;
	}
	public void setTest_cate_no(int test_cate_no) {
		this.test_cate_no = test_cate_no;
	}
	public String getTest_cate() {
		return test_cate;
	}
	public void setTest_cate(String test_cate) {
		this.test_cate = test_cate;
	}
	public boolean isDel_flag() {
		return del_flag;
	}
	public void setDel_flag(boolean del_flag) {
		this.del_flag = del_flag;
	}
	public int getPass_criterion() {
		return pass_criterion;
	}
	public void setPass_criterion(int pass_criterion) {
		this.pass_criterion = pass_criterion;
	}
	
	
	

}
