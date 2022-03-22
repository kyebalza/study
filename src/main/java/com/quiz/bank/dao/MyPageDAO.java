package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface MyPageDAO {

	
	
	ArrayList<HashMap<String, String>> reply_call(String board_no);

	void reply_write(HashMap<String, String> reply);

	void answecomplete(HashMap<String, String> reply);


}
