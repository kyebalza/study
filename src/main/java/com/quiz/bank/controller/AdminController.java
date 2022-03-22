package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.ReprotDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.dto.UserDTO;
import com.quiz.bank.service.AdminService;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AdminService adservice;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	//admin lefter
	@RequestMapping(value="/adminLefter")
	public String adminLefter(Model model) {
		
		return "admin/adminLefter";
	}
	
	
	//관리자 페이지 이동
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("관리자페이지 이동");

		return "admin/adminPage";
	}
	
	//공부 게시판 관리 페이지 이동
	@RequestMapping(value = "/ManagPostStudy", method = RequestMethod.GET)
	public String ManagPostStudy(Model model) {
		logger.info("공부 게시판 관리 페이지 이동");
		
		return "admin/ManagPostStudy";
	}
	
	//문의 게시판 관리 페이지 이동
	@RequestMapping(value = "/ManagPostInquriy", method = RequestMethod.GET)
	public String ManagPostInquriy(Model model) {
		logger.info("문의 게시판 관리 페이지 이동");
		
		return "admin/ManagPostInquriy";
	}
	
	//자유 게시판 관리 페이지 이동
	@RequestMapping(value = "/ManagPostFree", method = RequestMethod.GET)
	public String ManagPostFree(Model model) {
		logger.info("자유 게시판 관리 페이지 이동");
		
		return "admin/ManagPostFree";
	}
	
	//회원 관리 페이지 이동
	@RequestMapping(value = "/ManagUser", method = RequestMethod.GET)
	public String ManagUser(Model model) {
		logger.info("회원 관리 페이지 이동");
		
		return "admin/ManagUser";
	}

	//신고 게시글 페이지 이동
	@RequestMapping(value = "/ManagDe", method = RequestMethod.GET)
	public String ManagDe(Model model) {
		logger.info("신고 게시글 페이지 이동");
		
		return "admin/ManagDe";
	}
	
	//신고 댓글 페이지 이동
	@RequestMapping(value = "/ManagDeComent", method = RequestMethod.GET)
	public String ManagDeComent(Model model) {
		logger.info("신고 댓글 페이지 이동");
		
		return "admin/ManagDeComent";
	}
	

	
	//공부 질문 게시물 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/studylist", method = RequestMethod.GET)
	public HashMap<String, Object> studylist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("공부 질문 게시물 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.studylist(currPage,pagePerCnt);
	}
	
	//문의 게시물 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/Inquirylist", method = RequestMethod.GET)
	public HashMap<String, Object> Inquirylist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("문의 게시물 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.Inquirylist(currPage,pagePerCnt);
	}
	
	//자유 게시물 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/Freelist", method = RequestMethod.GET)
	public HashMap<String, Object> Freelist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("문의 게시물 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.Freelist(currPage,pagePerCnt);
	}
	
	//회원 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/Memlist", method = RequestMethod.GET)
	public HashMap<String, Object> Memlist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("회원 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.Memlist(currPage,pagePerCnt);
	}
	
	//게시판 신고 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/ManagDelist", method = RequestMethod.GET)
	public HashMap<String, Object> ManagDelist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("게시판 신고 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.ManagDelist(currPage,pagePerCnt);
	}
	
	//댓글 신고 리스트 출력 (페이징)
	@ResponseBody
	@RequestMapping(value = "/ManagDeComentlist", method = RequestMethod.GET)
	public HashMap<String, Object> ManagDeComentlist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("게시판 신고 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return adservice.ManagDeComentlist(currPage,pagePerCnt);
	}
	
	
	//공부 게시글 리스트 검색 요청
	@ResponseBody
	@RequestMapping(value = "/StudySearchList", method = RequestMethod.GET)
	public List<StudyBoardDTO> StudySearchList(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword) {
		logger.info("공부 게시판 리스트 검색 요청");
		logger.info(SearchType +" : "+Keyword);
		StudyBoardDTO SBdto = new StudyBoardDTO();
		SBdto.setKeyword(Keyword);
		SBdto.setSearchType(SearchType);
		
		return adservice.StudySearchList(SBdto);
	}
	

//	  //문의 게시글 리스트 검색 요청
//	  @ResponseBody  
//	  @RequestMapping(value = "/InquirySearchList", method = RequestMethod.GET)
//	  public List<InquiryBoardDTO> InquirySearchList(@RequestParam("SearchType")String SearchType, @RequestParam("Keyword") String Keyword) {
//		  logger.info("문의 게시판 리스트 검색 요청");
//		  logger.info(SearchType +" : "+Keyword);
//		  InquiryBoardDTO IBdto = new InquiryBoardDTO();
//		  IBdto.setKeyword(Keyword);
//		  IBdto.setSearchType(SearchType);
//		  
//		  return adservice.InquirySearchList(IBdto); 
//	  
//	  }
//	  
//	  
//	  //자유 게시글 리스트 검색 요청 (자유게시판 dto에... 아무것도 없다...)
//	  @ResponseBody 
//	  @RequestMapping(value = "/FreeSearchList", method = RequestMethod.GET)
//	  public List<FreeBoardDTO> FreeSearchList(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword) {
//		  logger.info("자유 게시판 리스트 검색 요청"); 
//		  logger.info(SearchType +" : "+Keyword);
//		  FreeBoardDTO FBdto = new FreeBoardDTO();
//		  FBdto.setKeyword(Keyword);
//		  FBdto.setSearchType(SearchType);
//		  
//		  return adservice.FreeSearchList(FBdto); 
//	  
//	  }
//	  
//	  
//	  //회원 리스트 검색 요청 (유저 dto에 검색 추가 필요) 
//	  @ResponseBody 
//	  @RequestMapping(value = "/MemSearchList", method = RequestMethod.GET)
//	  public List<UserDTO> MemSearchList(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword) {
//		  logger.info("자유 게시판 리스트 검색 요청"); 
//		  logger.info(SearchType +" : "+Keyword);
//		  UserDTO UBdto = new UserDTO();
//		  UBdto.setKeyword(Keyword);
//		  UBdto.setSearchType(SearchType);
//		  
//		  return adservice.MemSearchList(UBdto); 
//	  
//	  }
	  
	 
	//신고 게시글 리스트 검색 요청
	@ResponseBody
	@RequestMapping(value = "/ManageDePostSearchList", method = RequestMethod.GET)
	public List<ReprotDTO> ManageDePostSearchList(@RequestParam("SearchType") String SearchType) {
		logger.info("신고 게시글 리스트 검색 요청");
		logger.info(SearchType);
		ReprotDTO Rdto = new ReprotDTO();
		Rdto.setSearchType(SearchType);
		
		return adservice.ManageDePostSearchList(Rdto);
	}
	
	//신고 댓글 리스트 검색 요청
	@ResponseBody
	@RequestMapping(value = "/ManagDeComentSearch", method = RequestMethod.GET)
	public List<ReprotDTO> ManagDeComentSearch(@RequestParam("SearchType") String SearchType) {
		logger.info("신고 댓글 리스트 검색 요청");
		logger.info(SearchType);
		ReprotDTO Rdto = new ReprotDTO();
		Rdto.setSearchType(SearchType);
		
		return adservice.ManagDeComentSearch(Rdto);
	}	

	//공부 게시글 관리자 페이지 삭제/복구 요청
	@ResponseBody
	@RequestMapping(value = "/studydel", method = RequestMethod.POST)
	public int studydel(Model model, @RequestParam String board_no) {
		logger.info("공부 게시글 관리자 페이지 삭제/복구 요청");
		logger.info("삭제/복구 공부 게시판 번호 : "+board_no);
		
		int studydel_check = adservice.studydel_check(board_no);
		logger.info("del_check : "+studydel_check);
		
		if (studydel_check == 0) {
			logger.info("삭제 : "+board_no);
			adservice.studydel(board_no);
		}else {
			logger.info("복구 : "+board_no);
			adservice.studycall(board_no);
		}
		
		return studydel_check;
	}
	
	
	//문의 게시글 관리자 페이지 삭제/복구 요청
	@ResponseBody
	@RequestMapping(value = "/Inquirydel", method = RequestMethod.POST)
	public int Inquirydel(Model model, @RequestParam String board_no) {
		logger.info("문의 게시글 관리자 페이지 삭제/복구 요청");
		logger.info("삭제/복구 문의 게시판 번호 : "+board_no);
		
		int Inquirydel_check = adservice.Inquirydel_check(board_no);
		logger.info("del_check : "+Inquirydel_check);
		
		if (Inquirydel_check == 0) {
			logger.info("삭제 : "+board_no);
			adservice.Inquirydel(board_no);
		}else {
			logger.info("복구 : "+board_no);
			adservice.Inquirycall(board_no);
		}
		
		return Inquirydel_check;
	}
	
	
	//자유 게시글 관리자 페이지 삭제/복구 요청
	@ResponseBody
	@RequestMapping(value = "/Freedel", method = RequestMethod.POST)
	public int Freedel(Model model, @RequestParam String board_no) {
		logger.info("자유 게시글 관리자 페이지 삭제/복구 요청");
		logger.info("삭제/복구 자유 게시판 번호 : "+board_no);
		
		int Freedel_check = adservice.Freedel_check(board_no);
		logger.info("del_check : "+Freedel_check);
		
		if (Freedel_check == 0) {
			logger.info("삭제 : "+board_no);
			adservice.Freedel(board_no);
		}else {
			logger.info("복구 : "+board_no);
			adservice.Freecall(board_no);
		}
		
		return Freedel_check;
	}
	
	
	//회원 상세보기 요청
	//회원 관리 페이지 이동
	@RequestMapping(value = "/ADdetail", method = RequestMethod.GET)
	public String ADdetail(Model model, @RequestParam String user_id) {
		logger.info("회원 상세보기 페이지 이동 : "+user_id);
		UserDTO udto = adservice.ADdetail(user_id, "detail");
		model.addAttribute("info", udto);
		
		return "admin/ADdetail";
	}
	
	//회원 수정 요청
	@RequestMapping(value = "/adminUserUpdate", method = RequestMethod.POST)
	public String adminUserUpdate(Model model, @RequestParam HashMap<String, String> params) {
		logger.info("수정 요청 중 : "+params);
		adservice.adminUserUpdate(params);
		String user_id = params.get("user_id");
		logger.info(user_id);
		
		return "redirect:/ADdetail?user_id="+user_id;
	}	
	
	//게시글 신고 처리사항 업데이트
	@RequestMapping(value = "/ManagDeUpdate", method = RequestMethod.GET)
	public String ManagDeUpdate(Model model, @RequestParam String board_no, @RequestParam String inputOut) {
		logger.info("받은 번호 : "+board_no+", 받은 내용 : "+inputOut);
		
		adservice.ManagDeUpdate(board_no, inputOut);
		
		return "redirect:/ManagDe";
	}
	
	
	//댓글 신고 처리사항 업데이트
	@RequestMapping(value = "/ManagDeComUpdate", method = RequestMethod.GET)
	public String ManagDeComUpdate(Model model, @RequestParam String board_no, @RequestParam String inputOut) {
		logger.info("받은 번호 : "+board_no+", 받은 내용 : "+inputOut);
		
		adservice.ManagDeComUpdate(board_no, inputOut);
		
		return "redirect:/ManagDeComent";
	}
	
}


