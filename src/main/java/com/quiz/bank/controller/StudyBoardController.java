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
		logger.info("quiz_name : {}", quiz_name);
		model.addAttribute("quiz_name",quiz_name);
		//시행년도 카테고리
		ArrayList<HashMap<String, String>> year_count = service.test_year();
		logger.info("year_count : {}", year_count);
		model.addAttribute("year_count",year_count);
		//문제 가져오기
		ArrayList<HashMap<String, String>> quiz_no = service.test_no();
		logger.info("quiz_no : {}", quiz_no);
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
	public String detail(Model model, @RequestParam String board_no, HttpSession session) {
		logger.info("detail 요청 : {}", board_no);
		String loginId = (String)session.getAttribute("loginId");
		//게시글
		StudyBoardDTO dto = service.detail(board_no, "detail");
		logger.info("dto : {},{}", dto.getBoard_name(), dto.getBoard_no());
		model.addAttribute("info", dto);
		//문제가져오기
		StudyBoardDTO qdto = service.studyQuiz(board_no);
		model.addAttribute("Qinfo", qdto);
		//사진 가져오기
		StudyBoardDTO photo = service.photo(board_no);
		logger.info("사진 : {}",photo);
		model.addAttribute("photo",photo);
		//좋아요 가져오기
		StudyBoardDTO like = service.like(board_no,loginId);
		model.addAttribute("like",like);
		logger.info("가져온 좋아요 : {}",like);
		//좋아요 수
		int countlike = service.countlike(board_no);
		model.addAttribute("countlike", countlike);
		
		//댓글
//		ArrayList<HashMap<String, String>> sbcom = service.studycoment(board_no,loginId);
//		logger.info("댓글 : "+board_no);
//		model.addAttribute("sbcomList",sbcom);
//		logger.info("댓글목록 요청 : "+sbcom);
		
		
		return "studyBoard/detail";
		
	}
	
	/*공부 게시글 수정 페이지*/
	@RequestMapping(value = "/studyBoard/updateForm", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam String board_no) {
		logger.info("updateForm : {}",board_no);
		//문제가져오기
		StudyBoardDTO qdto = service.studyQuiz(board_no);
		model.addAttribute("Qinfo", qdto);
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
	public  List<StudyBoardDTO> studySearch(@RequestParam("SearchType") String SearchType
			, @RequestParam("Keyword") String Keyword) {
		logger.info("공부게시판 리스트 검색 요청");
		logger.info(SearchType + " : "+Keyword);
		StudyBoardDTO SBdto = new StudyBoardDTO();
		SBdto.setKeyword(Keyword);
		SBdto.setSearchType(SearchType);
		
		return service.studySearch(SBdto);
	}
	
	/*좋아요*/
	@ResponseBody
	@RequestMapping(value = "/studyBoard/uplike", method = RequestMethod.POST)
	public  HashMap<String, Object> uplike(@RequestParam String loginId
			, @RequestParam String board_no,@RequestParam String board_name) {
		
		logger.info(board_name,"게시판 좋아요 요청");
		logger.info("로그인아이디/게시글번호 : {},{}",loginId,board_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		/*현재 id 좋아요 여부 확인*/
		String like2 = service.like2(loginId,board_no,board_name);
		logger.info("좋아요 여부확인 : {}",like2);
		
		if(like2 != null) {//좋아요 취소
			int row2 = service.like_del(loginId,board_no,board_name);
			map.put("row2", row2);
		}else {
			int row = service.uplike(loginId,board_no,board_name);
			map.put("success", row);
		}
		
		
		return map;
	}
	
	/*글쓰기 문제불러오기*/
	@ResponseBody
	@RequestMapping(value = "/studyBoard/selectquiz", method = RequestMethod.POST)
	public HashMap<String, Object> selectquiz(@RequestParam HashMap<String, String> params) {
		logger.info("공부게시판 문제불러오기 요청 : {}",params);
		return service.quizselect(params);
	}
	
	/*글 신고하기*/
	@ResponseBody
	@RequestMapping(value = "/studyBoard/studyReport", method = RequestMethod.POST)
	public HashMap<String, Object> studyReport(@RequestParam HashMap<String, String> params, HttpSession session ) {
		logger.info("공부게시판 신고하기 요청 : {}",params);
		String user_id = (String) session.getAttribute("loginId");
		params.put("report_user", user_id);
		return service.studyReport(params);
	}
	
	//댓글 작성
		@RequestMapping(value="/studyBoard/sbcoment", method = RequestMethod.POST)
		public String sbcoment(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
			logger.info("댓글 등록 요청" + session +" / "+ params);
			service.sbcoment(session, params);
			String user_id = params.get("user_id");
			
			return "redirect:/studyBoard/detail?board_no="+params.get("board_no");
					
		}
		
		/*댓글삭제*/
		@RequestMapping(value = "/studyBoard/sbcomdel", method = RequestMethod.GET)
		public String sbcomdel(Model model, @RequestParam String reply_no, @RequestParam String board_no, @RequestParam String user_id ) {
			
			logger.info("댓글삭제 요청 : {},{}", reply_no,board_no);
			service.sbcomdel(reply_no);
			
			return "redirect:/studyBoard/detail?board_no="+board_no;
		}
	
		/*댓글신고*/
		@RequestMapping(value = "/studyBoard/sbcomreport", method = RequestMethod.POST)
		public HashMap<String, Object> sbcomreport(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
			logger.info("댓글 신고하기 요청 : {}",params);
			String user_id = (String) session.getAttribute("loginId");
			params.put("report_user", user_id);
			return service.sbcomreport(params);
			
			//return "redirect:/studyBoard/detail?board_no="+board_no;
		}
	
		/*댓글좋아요*/
		@ResponseBody
		@RequestMapping(value = "/studyBoard/relike", method = RequestMethod.POST)
		public  HashMap<String, Object> relike(@RequestParam String loginId
				, @RequestParam String board_no,@RequestParam String reply_no) {
			
			logger.info(reply_no,"댓글 좋아요 요청");
			logger.info("로그인아이디/게시글번호 : {},{}",loginId,board_no);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			/*현재 id 좋아요 여부 확인*/
			String relike2 = service.relike2(loginId,board_no,reply_no);
			logger.info("좋아요 여부확인 : {}",relike2);
			
			if(relike2 != null) {//좋아요 취소
				int row2 = service.relike_del(loginId,board_no,reply_no);
				map.put("row2", row2);
			}else {
				int row = service.reuplike(loginId,board_no,reply_no);
				map.put("success", row);
			}
			
			return map;
		}
		
		//댓글 페이징
		@ResponseBody
		@RequestMapping(value = "/studyBoard/SBClistCall", method = RequestMethod.GET)
		public HashMap<String, Object> SBClistCall(@RequestParam String page, @RequestParam String cnt, @RequestParam String board_no
				,HttpSession session) {
			logger.info("댓글 페이징 요청");
			logger.info("댓글 페이징 요청 : {} 페이지, {} 개 씩",page, cnt);
			logger.info("로딩 중인 게시글 번호 : "+board_no);
			String loginId = (String) session.getAttribute("loginId");
			int currPage = Integer.parseInt(page);
			int pagePerCnt = Integer.parseInt(cnt);
			
			return service.SBClistCall(currPage,pagePerCnt,board_no,loginId);
		}
	
	
}
