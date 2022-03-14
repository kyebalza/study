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
	
	// 1. 문의글쓰기 페이지 요청
	@GetMapping(value="/inquiryWriteForm")
	public String inquiryWriteForm(Model model, HttpSession session) {
		logger.info("문의게시판 작성하기 페이지 요청");
		String page = "/redirect:/inquiryBoardList";
		
		if (session.getAttribute("loginId") != null) {
			page = "inquiryBoard/inquiryWriteForm";
		}
		return page;
	}
	
	
	//2.문의글쓰기 요청
	@ResponseBody
	@PostMapping(value = "/inquiryWrite")
	 public String inquiryWrite(Model model,
			 @RequestParam HashMap<String, String> params) { 
		 logger.info("문의게시판 작성하기 요청 : {}", params);

		 return service.inquiryWrite(params);
	}
	
	

	

/*
	// 3. 문의게시판 리스트 호출
	@ResponseBody
	@GetMapping(value = "/inquiryBoardList")
	 public String inquiryBoardList(Model model, @RequestParam String currpage) {
		logger.info("문의게시판 리스트 요청");
	
		
		
//        ArrayList<HashMap<String, String>> InquiryBoardList = service.InquiryBoardList();
//        logger.info("글의 수 : {}",InquiryBoardList.size());
//        model.addAttribute("size", InquiryBoardList.size());
//        model.addAttribute("InquiryBoardList", InquiryBoardList);      
//        return "inquiryBoardList";
        
        
        
        //String page = "/";
        
        int currPage = Integer.parseInt(currpage); // 호출을 요청할 페이지
        logger.info("currpage : {}",currpage);
        int pagePerCnt = 10; // 한 페이지당 몇개씩? 10개씩
        logger.info("pagePerCnt : {}",pagePerCnt);
        // 1. 총 페이지 갯수인 range 가 필요함
        
        int range = service.list_rangecall(currPage,pagePerCnt);
        logger.info("range : {}",range);
        // 2. 리스트가 필요함 (10개 밖에 안들어있음)
        ArrayList<HashMap<String, String>> listCall = service.list_listCall(currPage,pagePerCnt);
        model.addAttribute("pages", range);
        model.addAttribute("InquiryBoadrList", listCall);
        model.addAttribute("nowpage", currpage);
        
		return "inquiryBoard/inquiryBoardList";
		
      
		
	}
*/

	// 3. 문의게시판 리스트 페이지 호출
	@ResponseBody
	@GetMapping(value = "/inquiryBoardList")
	 public String inquiryBoardList(Model model) { 
		 logger.info("문의게시판 리스트 이동");
		 
		 return "inquiryBoard/inquiryBoardList";
	}
	
	// 3-1. 문의게시판 리스트 출력
	@ResponseBody
	@GetMapping(value = "/inquirylist")
	public HashMap<String, Object> studylist(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("문의게시판 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return service.inquirylist(currPage,pagePerCnt);
	}

	

	// 3. 문의게시판 상세보기
	@ResponseBody
	@GetMapping(value = "/inquiryBoardDetail")
	public String inquiryBoardDetail(Model model, @RequestParam String board_no) {
		logger.info("문의게시판 상세보기 요청 : {}", board_no);

		InquiryBoardDTO dto = service.inquirydetail(board_no);
		logger.info("dto : {}",dto.getContent());
		model.addAttribute("info", dto);

		return "inquiryBoard/inquiryBoardDetail";
	}

	
	
	
	//4. 문의게시판 수정
	
	
	 

	
	

	
	
	
}
