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
	
	
	// 3. 문의게시판 수정페이지 요청
	@GetMapping(value = "/inquiryUpdateForm")
	public String inquiryUpdateForm(Model model, @RequestParam String board_no) {
		logger.info("inquiryUpdateForm : {}",board_no);
		return service.inquiryUpdateForm(model, board_no);
	}
	
	// 3-1. 문의게시판 수정하기
	@PostMapping(value = "/inquiryUpdate")
	public String update(Model model, @RequestParam HashMap<String, String> params
			,MultipartFile uploadFile,HttpSession session) {
		logger.info("문의게시판 수정 요청 : {}", params);
		logger.info("업로드할 파일 : {}", uploadFile);
		return service.inquiryUpdate(params,uploadFile);
		
	}
	

	// 4. 문의게시판 상세보기
	@GetMapping(value = "/inquiryBoardDetail")
	public String inquiryBoardDetail(Model model, @RequestParam String board_no, HttpSession session) {
		logger.info("문의게시판 상세보기 요청 : {}", board_no);

		InquiryBoardDTO dto = service.inquirydetail(board_no);
		logger.info("dto : {}",dto.getContent());
		model.addAttribute("info", dto);

		return "inquiryBoard/inquiryBoardDetail";
	}

	
	
	
	//6. 문의게시판 삭제
	@GetMapping(value = "/inquirydelete")
	public String inquirydelete(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 삭제 요청 : {}", board_no);
		service.inquirydelete(board_no);
		return "inquiryBoard/inquiryBoardList";
	}
	
	
	
	
	// 관리자 댓글기능 관련
	
	@RequestMapping(value="/reply_call" , method = RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> reply_call(HttpSession session, @RequestParam String board_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();

			logger.info("{} reply 리스트 불러오기",board_no);
			ArrayList<HashMap<String, String>> list= service.reply_call(board_no);
			
			for (HashMap<String, String> list_date : list) {
				logger.info("list date {}",String.valueOf(list_date.get("reply_date")));
				

				String dateYear = (String.valueOf(list_date.get("reply_date"))).substring(0, 4);
				logger.info("dateYear {}",dateYear);

				String dateMonth = (String.valueOf(list_date.get("reply_date"))).substring(5,7);
				logger.info("dateMonth {}",dateMonth);

				String dateDate = (String.valueOf(list_date.get("reply_date"))).substring(8,10);
				logger.info("dateDate {}",dateDate);

				String newDate = dateYear+"년 "+dateMonth+"월"+dateDate+"일";
				list_date.put("reply_date", newDate);

			}
			
			logger.info("list  {}",list);
			map.put("list", list);
			map.put("count", list.size());
		return map;
	}
	
	@RequestMapping(value="/reply_write" , method = RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> reply_write(HttpSession session, @RequestParam HashMap<String, String> reply) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId") != null) {
			
			logger.info("{} 문의게시판 reply 등록하기",reply);
			service.reply_write(reply);
			map.put("msg", "success");
			map.put("list",service.reply_call(reply.get("board_no")));
		} else {
			map.put("msg", "fail");
		}
		
		return map;
	}	
	
	
	
	 

	
	

	
	
	
}
