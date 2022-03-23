package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.PhotoDTO;
import com.quiz.bank.dto.ReplyDTO;

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

	ArrayList<PhotoDTO> fbphoto(String board_no);

	int freeUpdate(HashMap<String, String> params);

	int likecheck(String user_id, String board_no);

	int fbDownlike(String loginId, String board_no, String board_name);

	int fbUplike(String loginId, String board_no, String board_name);

	int CountLike(String board_no);

	void fbcoment(FreeBoardDTO fbdto);

	ArrayList<FreeBoardDTO> freeboardcoment(String board_no);

	void fbcomdel(String reply_no);

	void fbReport(HashMap<String, String> params);

	int FbCallCount(String board_no);

	ArrayList<ReplyDTO> FBClistCall(int pagePerCnt, int offset, String board_no);

	int fbcomReport(HashMap<String, String> params);

	String fbcrelike2(String loginId, String board_no, String reply_no);

	int fbcrelike_del(String loginId, String board_no, String reply_no);

	int fbcreuplike(String loginId, String board_no, String reply_no);




	


}
