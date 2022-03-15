package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quiz.bank.dao.AdminDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.dto.UserDTO;

@Service
public class AdminService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminDAO addao;


	//관리자 공부 게시판 리스트 검색 서비스
	public List<StudyBoardDTO> StudySearchList(StudyBoardDTO SBdto) {
		logger.info("공부 게시판 리스트 검색 서비스 도착");
		return addao.StudySearchList(SBdto);
	}

	
	
	//관리자 공부 게시판 리스트 호출 (페이징)
	public HashMap<String, Object> studylist(int currPage, int pagePerCnt) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = addao.SallCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", addao.studylist(pagePerCnt, offset));
		
		return map;
	}


	//관리자 공부 게시글 삭제 유무 확인
	public int studydel_check(String board_no) {
		logger.info("삭제 게시글 번호 : "+board_no);
		return addao.studydel_check(board_no);
	}
	
	//관리자 공부 게시글 삭제 요청
	public int studydel(String board_no) {
		logger.info("관리자 공부 게시글 삭제 요청 : "+board_no);
		return addao.studydel(board_no);
	}

	//관리자 공부 게시글 복구 요청
	public int studycall(String board_no) {
		logger.info("복구 게시글 번호 : "+board_no);
		return addao.studycall(board_no);
		
	}


	//관리자 문의 게시판 리스트 호출 (페이징)
	public HashMap<String, Object> Inquirylist(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = addao.IallCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", addao.Inquirylist(pagePerCnt, offset));
		
		return map;
	}

	
	
	
	//관리자 자유 게시판 리스트 호출 (페이징)
	public HashMap<String, Object> Freelist(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = addao.FallCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", addao.Freelist(pagePerCnt, offset));
		
		return map;
	}



	
	//관리자 문의 게시판 검색 
	public List<InquiryBoardDTO> InquirySearchList(InquiryBoardDTO IBdto) {
		logger.info("문의 게시판 리스트 검색 서비스 도착");
		return addao.InquirySearchList(IBdto);
	}


	//관리자 자유 게시판 검색
	public List<FreeBoardDTO> FreeSearchList(FreeBoardDTO FBdto) {
		logger.info("자유 게시판 리스트 검색 서비스 도착");
		return addao.FreeSearchList(FBdto);
	}


	//문의 게시판 삭제 유무 확인
	public int Inquirydel_check(String board_no) {
		logger.info("삭제 게시글 번호 : "+board_no);
		return addao.Inquirydel_check(board_no);
	}


	//문의 게시판 삭제 요청
	public int Inquirydel(String board_no) {
		logger.info("관리자 문의 게시글 삭제 요청 : "+board_no);
		return addao.Inquirydel(board_no);
		
	}

	//문의 게시판 복구 요청
	public int Inquirycall(String board_no) {
		logger.info("관리자 문의 게시글 복구 요청 : "+board_no);
		return addao.Inquirycall(board_no);
		
	}


	//자유 게시판 삭제 확인
	public int Freedel_check(String board_no) {
		logger.info("삭제 게시글 번호 : "+board_no);
		return addao.Freedel_check(board_no);
	}


	//자유 게시판 삭제
	public int Freedel(String board_no) {
		logger.info("관리자 자유 게시글 삭제 요청 : "+board_no);
		return addao.Freedel(board_no);
		
	}


	//자유 게시판 복구
	public int Freecall(String board_no) {
		logger.info("관리자 자유 게시글 복구 요청 : "+board_no);
		return addao.Freecall(board_no);
		
	}


	//회원 리스트 생성
	public HashMap<String, Object> Memlist(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = addao.MallCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", addao.Memlist(pagePerCnt, offset));
		
		return map;
	}


	//관리자 회원 검색
	public List<UserDTO> MemSearchList(UserDTO uBdto) {
		logger.info("회원 검색 서비스 도착");
		return addao.MemSearchList(uBdto);
	}


	//관리자 회원 상세보기 페이지
	public UserDTO ADdetail(String user_id, String method) {
		logger.info("관리자 회원 상세보기 페이지 서비스 : "+user_id);
		
		return addao.ADdetail(user_id);
	}


	//관리자 회원 업데이트 요청
	public void adminUserUpdate(HashMap<String, String> params) {
		logger.info("회원 수정 요청 서비스 : "+params);
		addao.adminUserUpdate(params);
		
	}

	

}
