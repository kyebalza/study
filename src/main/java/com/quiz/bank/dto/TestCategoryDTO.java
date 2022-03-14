package com.quiz.bank.dto;

import org.apache.ibatis.type.Alias;

@Alias(value ="TestCategory")
public class TestCategoryDTO {
	
	private String test_cate_no;
	private String test_cate; 
	private String del_flag;
	private String pass_criterion;
	
	public String getTest_cate_no() {
		return test_cate_no;
	}
	public void setTest_cate_no(String test_cate_no) {
		this.test_cate_no = test_cate_no;
	}
	public String getTest_cate() {
		return test_cate;
	}
	public void setTest_cate(String test_cate) {
		this.test_cate = test_cate;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	public String getpass_criterion() {
		return pass_criterion;
	}
	public void setpass_criterion(String pass_criterion) {
		this.pass_criterion = pass_criterion;
	}
	

}
