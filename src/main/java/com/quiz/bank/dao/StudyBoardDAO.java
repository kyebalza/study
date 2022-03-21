package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

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

ArrayList<StudyBoardDTO> listCall(int pagePerCnt, int offset);

int allCount();

List<StudyBoardDTO> studySearch(StudyBoardDTO sBdto);

ArrayList<HashMap<String, String>> test_no();

String like2(String loginId, String board_no, String board_name);

int like_del(String loginId, String board_no, String board_name);

int uplike(String loginId, String board_no, String board_name);

StudyBoardDTO like(String board_no, String loginId);

int countlike(String board_no);

HashMap<String, Object> quizselect(HashMap<String, String> params);

int studyReport(HashMap<String, String> params);






}
