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
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.service.StudyBoardService;

@Controller
public class StudyBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired StudyBoardService service;

	/*
	//0. 로그인 페이지 이동
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("로그인페이지 이동");

		return "login";
	}
	*/
	
	/*공부게시판 리스트 - 도연
	@RequestMapping(value = "/studyBoard/list", method = RequestMethod.GET)
	public String home(Model model,HttpSession session) {
		logger.info("게시판 리스트 요청");
		//자격증종류 카테고리
		ArrayList<HashMap<String, String>> quiz_name = service.test_name();
		model.addAttribute("quiz_name",quiz_name);
		
		ArrayList<StudyBoardDTO> list = service.list();
		logger.info("글의 수 : {}",list.size());
		model.addAttribute("size",list.size());
		model.addAttribute("list", list);
		return "studyBoard/list";
	}*/
	
	/*공부게시판 리스트*/
	@RequestMapping(value = "/studyBoard/list", method = RequestMethod.GET)
	public String list(Model model) {
		logger.info("게시판 리스트 요청");
		return "studyBoard/list";
	}
	
	/*공부게시판 리스트 페이징*/
	@ResponseBody
	@RequestMapping(value = "/studyBoard/listCall", method = RequestMethod.GET)
	public  HashMap<String, Object> listCall(
			@RequestParam String page, @RequestParam String cnt) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("리스트 요청 : {}페이지,{}개씩",page,cnt);
		
		ArrayList<StudyBoardDTO> list = service.listCall();
		map.put("list", list);
		map.put("count", list.size());
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return service.list(currPage,pagePerCnt);
	}
	
	/*공부게시판 글쓰기 페이지 이동 -도연*/
	@RequestMapping(value="/studyBoard/writeForm", method = RequestMethod.GET)
	public String writeForm(Model model,HttpSession session) {
		logger.info("글쓰기 페이지 이동");
		//게시판 세부 카테고리
		ArrayList<HashMap<String, String>> study_cate = service.studyboard_cate();
		model.addAttribute("study_cate",study_cate);
		//자격증종류 카테고리
		ArrayList<HashMap<String, String>> quiz_name = service.test_name();
		model.addAttribute("quiz_name",quiz_name);
		//시행년도 카테고리
		ArrayList<HashMap<String, String>> year_count = service.test_year();
		model.addAttribute("year_count",year_count);
		//문제 번호 가져오기
		ArrayList<HashMap<String, String>> quiz_no = service.test_no();
		model.addAttribute("quiz_no",quiz_no);
		
		//로그인 여부 확인
		String page = "redirect:/loginPage";
		if(session.getAttribute("loginId") != null) {
			page="studyBoard/writeForm";
		}
		return page;
	}
	
	/*공부 게시판 글쓰기 - 도연*/
	@RequestMapping(value = "/studyBoard/write", method = RequestMethod.POST)
	public String write(Model model, @RequestParam HashMap<String, String>params,MultipartFile uploadFile,HttpSession session) {
		logger.info("upload 파일요청 : {}", uploadFile);
		//로그인 확인
		String page = "redirect:/loginPage";
		if(session.getAttribute("loginId") != null) {
			page="studyBoard/writeForm";
		}
		//세션에서 로그인한 아이디 가져와서 params에 넣어줌
		params.put("user_id", (String) session.getAttribute("loginId"));
		logger.info("write 요청 : {}", params);
		return service.write(params,uploadFile);
		
	}
	
	/*공부 게시판 상세보기- 도연*/
	@RequestMapping(value = "/studyBoard/detail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam String board_no) {
		logger.info("detail 요청 : {}", board_no);
		
		StudyBoardDTO dto = service.detail(board_no, "detail");
		logger.info("dto : {}", dto.getContent());
		model.addAttribute("info", dto);
		//사진 가져오기
		StudyBoardDTO photo = service.photo(board_no);
		logger.info("사진 : {}",photo);
		model.addAttribute("photo",photo);
		
		return "studyBoard/detail";
	}
	
	/*공부 게시글 수정 페이지*/
	@RequestMapping(value = "/studyBoard/updateForm", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam String board_no) {
		logger.info("updateForm : {}",board_no);
		//페이지 이동은 꼭 Controller에서만 하는 건 아니다.
		return service.updateForm(model, board_no);
	}
	
	/*공부 게시글 수정*/
	@RequestMapping(value = "/studyBoard/update", method = RequestMethod.POST)
	public String update(Model model, @RequestParam HashMap<String, String>params
			,MultipartFile uploadFile,HttpSession session) {
		logger.info("update 요청 : {}", params);
		logger.info("업로드할 파일 : {}", uploadFile);
		return service.update(params,uploadFile);
		
	}
	
	
	/*공부 게시글 삭제- 도연*/
	@RequestMapping(value = "/studyBoard/delete", method = RequestMethod.GET)
	public String delete(Model model, @RequestParam String board_no) {
		logger.info("삭제 요청 : {}", board_no);
		service.delete(board_no);
		
		return "redirect:/studyBoard/list";
	}
	
	/*공부게시판 리스트 검색*/
	@ResponseBody
	@RequestMapping(value = "/studyBoard/studySearch", method = RequestMethod.GET)
	public  List<StudyBoardDTO> studySearch(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword) {
		logger.info("공부게시판 리스트 검색 요청");
		logger.info(SearchType + " : "+Keyword);
		StudyBoardDTO SBdto = new StudyBoardDTO();
		SBdto.setKeyword(Keyword);
		SBdto.setSearchType(SearchType);
		
		return service.studySearch(SBdto);
	}
	
	/*좋아요*/
	
}
