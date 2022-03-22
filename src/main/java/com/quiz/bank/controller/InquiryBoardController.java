	package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.service.InquiryBoardService;

@Controller
public class InquiryBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InquiryBoardService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	
	// 1. 문의게시판 리스트 페이지 호출
	
	@GetMapping(value = "/inquiryBoardList")
	public String inquiryBoardList(Model model) { 
		logger.info("문의게시판 리스트 이동");
		
		return "inquiryBoard/inquiryBoardList";
	}
	
	// 1-1. 문의게시판 리스트 출력
	@ResponseBody
	@GetMapping(value = "/inquirylist")
	public HashMap<String, Object> inquirylist(@RequestParam  String page, @RequestParam String cnt) {
		
		logger.info("문의게시판 게시물 리스트 요청");
		logger.info("문의게시판 리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return service.inquirylist(currPage,pagePerCnt);
	}
	
	// 1-2 문의 게시글 리스트 검색 요청
	  @ResponseBody  
	  @GetMapping(value = "/InquirySearchBoardList")
	  public List<InquiryBoardDTO> InquirySearchBoardList(@RequestParam("SearchType")String SearchType, @RequestParam("Keyword") String Keyword) {
		  logger.info("문의 게시판 리스트 검색 요청");
		  logger.info(SearchType +" : "+Keyword);
		  InquiryBoardDTO dto = new InquiryBoardDTO();
		  dto.setKeyword(Keyword);
		  dto.setSearchType(SearchType);
		  
		  return service.InquirySearchBoardList(dto); 
	  
	  }
	
	
	// 2. 문의게시판 작성하기 페이지 요청
	@GetMapping(value="/inquiryWriteForm")
	public String inquiryWriteForm(Model model, HttpSession session) {
		logger.info("문의게시판 작성하기 페이지 요청");
		//문의게시판 세부 카테고리
		ArrayList<HashMap<String, String>> inquiry_cate = service.inquiryboard_cate();
		model.addAttribute("inquiry_cate", inquiry_cate);
		
		// 로그인 여부 확인
		String page = "redirect:/loginPage";
		if (session.getAttribute("loginId") != null) {
			page = "inquiryBoard/inquiryWriteForm";
		}
		return page;
	}

	//2-1.문의게시판 작성하기 요청
	@PostMapping(value = "/inquiryWrite")
	 public String inquiryWrite(Model model, @RequestParam HashMap<String, String> params, MultipartFile uploadFile, HttpSession session) { 
		logger.info("문의게시판 파일업로드 요청 : {}", uploadFile);
		// 세션에서 로그인 한 아이디를 가져와서 params 에 넣어줌
		params.put("user_id", (String) session.getAttribute("loginId"));
		logger.info("문의게시판 작성하기 요청 : {}", params);
		return service.inquiryWrite(params,uploadFile);
	}
	
	
	
	// 3. 문의게시판 상세보기
	@GetMapping(value = "/inquiryBoardDetail")
	public String inquiryBoardDetail(Model model, @RequestParam String board_no, HttpSession session) {
		logger.info("문의게시판 상세보기 요청 : {}", board_no);
		
		InquiryBoardDTO dto = service.inquirydetail(board_no);
		logger.info("dto : {}",dto.getContent());
		model.addAttribute("info", dto);
		
		// 사진 가져오기
		InquiryBoardDTO photo = service.photo(board_no);
		logger.info("사진 : {}",photo);
		model.addAttribute("photo",photo);
		
		
		return "inquiryBoard/inquiryBoardDetail";
	}
	
	// 4. 문의게시판 수정페이지 요청
	@GetMapping(value = "/inquiryUpdateForm")
	public String inquiryUpdateForm(Model model, @RequestParam String board_no) {
		logger.info("inquiryUpdateForm : {}",board_no);
		
		ArrayList<HashMap<String, String>> inquiry_cate = service.inquiryboard_cate();
		model.addAttribute("inquiry_cate", inquiry_cate);
		
		return service.inquiryUpdateForm(model, board_no);
	}
	
	// 4-1. 문의게시판 수정하기
	@PostMapping(value = "/inquiryUpdate")
	public String update(Model model, @RequestParam HashMap<String, String> params
			,MultipartFile uploadFile,HttpSession session) {
		logger.info("문의게시판 수정 요청 : {}", params);
		logger.info("업로드할 파일 : {}", uploadFile);
		return service.inquiryUpdate(params,uploadFile);
		
	}
	

	
	//5. 문의게시판 삭제
	@GetMapping(value = "/inquirydelete")
	public String inquirydelete(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 삭제 요청 : {}", board_no);
		service.inquirydelete(board_no);
		return "inquiryBoard/inquiryBoardList";
	}
	
	
	
	
	// 6. 댓글 작성(관리자 한정)
	@PostMapping(value="ibcoment")
	public String ibcoment(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("문의게시판 댓글 등록 요청" + session + "/"+params);
		service.ibcoment(session, params);
		String user_id = params.get("user_id");
		
		return "redirect:/inquiryBoardDetail?board_no="+params.get("board_no");
		
		
	}
	
	
	
	
	
	
	 

	
	

	
	
	
}
