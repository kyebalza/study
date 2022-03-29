package com.quiz.bank.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.PhotoDTO;
import com.quiz.bank.dto.ReplyDTO;

public interface InquiryBoardDAO {


	

	ArrayList<InquiryBoardDTO> inquirylist(int pagePerCnt, int offset);
	
	int allCount(InquiryBoardDTO dto);
	
	List<InquiryBoardDTO> InquirySearchBoardList(InquiryBoardDTO dto); // 문의게시판 검색 리스트
	
	void inquiryWrite(InquiryBoardDTO dto); // 문의게시판 글쓰기
	
	void inquiryfileWrite(int board_no, String oriFileName, String newFileName); // 문의게시판 파일 업로드
	
	ArrayList<HashMap<String, String>> inquiryboard_cate(); // 문의게시판 세부 카테고리 추가
	
	InquiryBoardDTO inquirydetail(String board_no); // 문의게시판 상세보기
	
	void inquiryupHit(String board_no); // 문의게시판 조회 수 올리기

	int inquirydelete(String board_no); // 문의게시글 삭제

	int inquiryUpdate(HashMap<String, String> params); // 문의게시글 수정

	HashMap<String, String> inquiryBoarddetail(String board_no); //

	ArrayList<PhotoDTO> photo(String board_no);

	void ibcoment(ReplyDTO dto); // 댓글 등록

	ArrayList<ReplyDTO> inquiryboardcoment(String board_no); // 댓글 불러오기

	void inquiryBoardAnswer(int board_no);
	

	








}
