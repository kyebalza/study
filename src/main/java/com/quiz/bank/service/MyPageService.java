package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.MyPageDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;

@Service
public class MyPageService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MyPageDAO dao;

	
	
	// 댓글 기능
	public ArrayList<HashMap<String, String>> reply_call(String board_no) {
		logger.info("reply_call : DAO 호출");
		
		return dao.reply_call(board_no);
	}




	public void reply_write(HashMap<String, String> reply) {
		dao.reply_write(reply);
		if (reply.get("board_name").equals("문의게시판")) {
			dao.answecomplete(reply);
		}
		
	}




	public HashMap<String, Object> noticeListCall(String loginId) {
		ArrayList<HashMap<String, String>> noticeList = dao.noticeListCall(loginId);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		
		
		return map;
	}




	public HashMap<String, Object> myPageStudyBoardListCall(int currPage,int pagePerCnt, String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		
		int totalCount = dao.allCount("study_board",loginId); // bbs테이블의 모든 글의 갯수
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;

		
		
		ArrayList<HashMap<String, String>> boardList = dao.myPageStudyBoardListCall(loginId,pagePerCnt,offset);
		for (HashMap<String, String> board : boardList) {
			if(!board.containsKey("like_cnt")) {
				board.put("like_cnt", "0");
			}
			if(!board.containsKey("reply_cnt")) {
				board.put("reply_cnt", "0");
			}
		}

		map.put("pages", range);
		map.put("boardList", boardList);

		return map;
	}




	public HashMap<String, Object> myPagefreeBoardListCall(int currPage,int pagePerCnt, String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		
		int totalCount = dao.allCount("free_board",loginId); // bbs테이블의 모든 글의 갯수
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;

		
		
		ArrayList<HashMap<String, String>> boardList = dao.myPagefreeBoardListCall(loginId,pagePerCnt,offset);
		for (HashMap<String, String> board : boardList) {
			if(!board.containsKey("like_cnt")) {
				board.put("like_cnt", "0");
			}
			if(!board.containsKey("reply_cnt")) {
				board.put("reply_cnt", "0");
			}
		}
		map.put("pages", range);
		map.put("boardList", boardList);

		return map;
	}




	public HashMap<String, Object> myPageinquiryBoardListCall(int currPage,int pagePerCnt, String loginId) {
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		
		int totalCount = dao.allCount("inquiry_board",loginId); // bbs테이블의 모든 글의 갯수
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;

		ArrayList<HashMap<String, String>> boardList = dao.myPageinquiryBoardListCall(loginId,pagePerCnt,offset);
		HashMap<String, Object> map = new HashMap<String, Object>();
		for (HashMap<String, String> board : boardList) {
			if(!board.containsKey("like_cnt")) {
				board.put("like_cnt", "0");
			}
			if(!board.containsKey("reply_cnt")) {
				board.put("reply_cnt", "0");
			}
		}
		map.put("pages", range);
		map.put("boardList", boardList);

		return map;
	}




	public HashMap<String, Object> myPageStudyReplyListCall(int currPage, int pagePerCnt, String loginId) {
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		
		int totalCount = dao.allCount("study_board_reply",loginId); // bbs테이블의 모든 글의 갯수
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;

		ArrayList<HashMap<String, String>> replyList = dao.myPageStudyReplyListCall(loginId,pagePerCnt,offset);
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("pages", range);
		map.put("replyList", replyList);
		return map;
	}




	public HashMap<String, Object> myPagefreeReplyListCall(int currPage, int pagePerCnt, String loginId) {
		int offset= ((currPage-1) * pagePerCnt-1)>=0 ? ((currPage-1) * pagePerCnt-1) :0;
		//0-9,10-19,20-29,30-39
		logger.info("offset : {}",offset);
		
		int totalCount = dao.allCount("free_board_reply",loginId); // bbs테이블의 모든 글의 갯수
		//만들수 있는 총 페이지의 수(전체 갯수/보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) +1 : (totalCount/pagePerCnt) ;

		ArrayList<HashMap<String, String>> replyList = dao.myPagefreeReplyListCall(loginId,pagePerCnt,offset);
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("pages", range);
		map.put("replyList", replyList);
		return map;
	}




	public HashMap<String, Object> myTestListCall(String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> myTestList = dao.myTestListCall(loginId);
		map.put("myTestList", myTestList);
		
		return map;
	}




	public HashMap<String, String> CallUserInfo(String loginId) {
		return dao.CallUserInfo(loginId);
	}




	public int updateUser(HashMap<String, String> params) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		int success= 0;
		if(params.get("user_pw").equals("")) {
			success = dao.updateUser_nullPw(params);
		} else {
			String pw = params.get("user_pw");
			logger.info("plain pw : "+ pw);
			String encPw = encoder.encode(pw);
			params.put("user_pw", encPw);
			success = dao.updateUser(params);
		}
		return success;
	}


	

}
