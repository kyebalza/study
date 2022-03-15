package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;

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


}
