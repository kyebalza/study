package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.quiz.bank.dto.FreeBoardDTO;

public interface FreeBoardDAO {

	int FballCount();

	ArrayList<FreeBoardDTO> FBlistCall(int pagePerCnt, int offset);

	ArrayList<HashMap<String, String>> freeboard_cate();

	void freeWrite(FreeBoardDTO fdto);

	void freefileWrite(int board_no, String oriFileName, String newFileName);

	void freeBoardupHit(String board_no);

	FreeBoardDTO freeBoardDetail(String board_no);

	int freedelete(String board_no);

	List<FreeBoardDTO> FreeSeasrch(FreeBoardDTO fbdto);

	


}
