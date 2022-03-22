package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface MyPageDAO {

	
	
	ArrayList<HashMap<String, String>> reply_call(String board_no);

	void reply_write(HashMap<String, String> reply);

	void answecomplete(HashMap<String, String> reply);

	ArrayList<HashMap<String, String>> noticeListCall(String loginId);

	ArrayList<HashMap<String, String>> myPageStudyBoardListCall(String loginId, int pagePerCnt, int offset);

	ArrayList<HashMap<String, String>> myPagefreeBoardListCall(String loginId, int pagePerCnt, int offset);

	ArrayList<HashMap<String, String>> myPageinquiryBoardListCall(String loginId, int pagePerCnt, int offset);

	int allCount(String string, String loginId);

	ArrayList<HashMap<String, String>> myPageStudyReplyListCall(String loginId, int pagePerCnt, int offset);

	ArrayList<HashMap<String, String>> myPagefreeReplyListCall(String loginId, int pagePerCnt, int offset);


}
