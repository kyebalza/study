package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.quiz.bank.dto.ReplyDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.dto.UserDTO;

public interface StudyBoardDAO {


ArrayList<StudyBoardDTO> list();

//int write(HashMap<String, String> params, HttpSession session);

void upHit(String board_no);

 StudyBoardDTO detail(String board_no);

 int delete(String board_no);

UserDTO userid(String attribute);

void write(StudyBoardDTO dto);

ArrayList<HashMap<String, String>> studyboard_cate();

ArrayList<HashMap<String, String>> test_name();

ArrayList<HashMap<String, String>> test_year();

void fileWrite(int board_no, String oriFileName, String newFileName);

StudyBoardDTO photo(String board_no);

int update(HashMap<String, String> params);

void fileUpdate(int board_no, String oriFileName, String newFileName);

ArrayList<StudyBoardDTO> listCall(int pagePerCnt, int offset);

int allCount();

List<StudyBoardDTO> studySearch(StudyBoardDTO sBdto);

ArrayList<HashMap<String, String>> test_no();

int like2(String loginId, String board_no);

int like_del(String loginId, String board_no, String board_name);

int uplike(String loginId, String board_no, String board_name);

ArrayList<StudyBoardDTO> like(String board_no, String loginId);

int countlike(String board_no);

HashMap<String, Object> quizselect(String params);

int studyReport(HashMap<String, String> params);

StudyBoardDTO studyQuiz(String board_no);

void sbcoment(StudyBoardDTO sbdto);

ArrayList<HashMap<String, String>> studycoment(String board_no);

void sbcomdel(String reply_no);

String relike2(String loginId, String board_no, String reply_no);

int relike_del(String loginId, String board_no, String reply_no);

int reuplike(String loginId, String board_no, String reply_no);

int doIHaveReLike(String board_no, String loginId, String reply_no);

int sbcomreport(HashMap<String, String> params);

int sbCallCount(String board_no);

ArrayList<HashMap<String, String>> SBClistCall(int pagePerCnt, int offset, String board_no);

int SearchallCount(StudyBoardDTO sBdto);

void fileUpdate(int photo_no, int board_no, String oriFileName, String newFileName);

ArrayList<HashMap<String, String>> test_year_ajax(String test_cate_no);

ArrayList<HashMap<String, String>> test_times_ajax(String test_cate_no, String test_year);

ArrayList<HashMap<String, String>> quiz_no_ajax(String test_cate_no, String test_year, String test_count);

HashMap<String, String> quizinfo(String quiz_no);

int filedelete(String board_no, String photo_no);





}
