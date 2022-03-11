package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.quiz.bank.dto.StudyBoardDTO;


public interface AdminDAO {

	ArrayList<StudyBoardDTO> ManagPostStudy();

	List<StudyBoardDTO> StudySearchList(StudyBoardDTO sBdto);

	int allCount();

	ArrayList <StudyBoardDTO> studylist (int pagePerCnt, int offset);

	


}
