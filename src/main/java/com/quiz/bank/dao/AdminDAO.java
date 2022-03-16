package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.ReprotDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.dto.UserDTO;


public interface AdminDAO {

	ArrayList<StudyBoardDTO> ManagPostStudy();

	List<StudyBoardDTO> StudySearchList(StudyBoardDTO sBdto);

	int SallCount();

	ArrayList <StudyBoardDTO> studylist (int pagePerCnt, int offset);

	int studydel(String board_no);

	int studydel_check(String board_no);

	int studycall(String board_no);

	ArrayList <InquiryBoardDTO> Inquirylist(int pagePerCnt, int offset);

	int IallCount();

	ArrayList <FreeBoardDTO> Freelist(int pagePerCnt, int offset);

	int FallCount();

	List<InquiryBoardDTO> InquirySearchList(InquiryBoardDTO IBdto);

	List<FreeBoardDTO> FreeSearchList(FreeBoardDTO fBdto);

	int Inquirydel_check(String board_no);

	int Inquirydel(String board_no);

	int Inquirycall(String board_no);

	int Freedel_check(String board_no);

	int Freedel(String board_no);

	int Freecall(String board_no);

	int MallCount();

	List <UserDTO> Memlist(int pagePerCnt, int offset);

	List<UserDTO> MemSearchList(UserDTO uBdto);

	UserDTO ADdetail(String user_id);

	void adminUserUpdate(HashMap<String, String> params);

	ArrayList <ReprotDTO> ManagDelist(int pagePerCnt, int offset);

	int MDallCount();

	List<ReprotDTO> ManageDePostSearchList(ReprotDTO rdto);

	int MCallCount();

	ArrayList <ReprotDTO> ManagDeComentlist(int pagePerCnt, int offset);

	void ManagDeUpdate(String board_no, String inputOut);

	List<ReprotDTO> ManagDeComentSearch(ReprotDTO rdto);

	void ManagDeComUpdate(String board_no, String inputOut);

	


}
