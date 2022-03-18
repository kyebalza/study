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

import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.InquiryBoardDTO;
import com.quiz.bank.dto.PhotoDTO;
import com.quiz.bank.dto.StudyBoardDTO;
import com.quiz.bank.service.FreeBoardService;

@Controller
public class FreeBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired FreeBoardService fbservice;

	
	//자유 게시판 이동
	@RequestMapping(value = "/freeBoardList", method = RequestMethod.GET)
	public String loginPage(Model model) {
		logger.info("자유 게시판 이동");

		return "freeBoard/freeBoardList";
	}
	
	//자유 게시판 페이징
	@ResponseBody
	@RequestMapping(value = "/FBlistCall", method = RequestMethod.GET)
	public HashMap<String, Object> FBlistCall(@RequestParam  String page, @RequestParam String cnt) {
		logger.info("공부 질문 게시물 리스트 요청");
		logger.info("리스트 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return fbservice.FBlistCall(currPage,pagePerCnt);
	}
	
	//문의게시판 작성하기 페이지 요청
	@RequestMapping(value="/freewriteForm", method = RequestMethod.GET) 
	public String freewriteForm(Model model) {
		logger.info("자유게시판 작성하기 페이지 요청");
		//문의게시판 세부 카테고리
		ArrayList<HashMap<String, String>> free_cate = fbservice.freeboard_cate();
		model.addAttribute("free_cate", free_cate);

		String page = "freeBoard/freewriteForm";		
		return page;
	}
	
	//자유게시판 작성하기 요청
	@RequestMapping(value = "/freeWrite", method = RequestMethod.POST)
	 public String freeWrite(Model model, @RequestParam HashMap<String, String> params, MultipartFile uploadFile, HttpSession session) { 
		logger.info("자유 게시판 파일업로드 요청 : {}", uploadFile);
		// 세션에서 로그인 한 아이디를 가져와서 params 에 넣어줌
		params.put("user_id", (String) session.getAttribute("loginId"));
		logger.info("자유 게시판 작성하기 요청 : {}", params);
		return fbservice.freeWrite(params,uploadFile);
	}
	
	//자유게시판 상세보기
	@RequestMapping(value = "/freeBoardDetail", method = RequestMethod.GET)
	public String freeBoardDetail(Model model, @RequestParam String board_no) {
		logger.info("자유게시판 상세보기 요청 : {}", board_no);

		FreeBoardDTO fbdto = fbservice.freeBoardDetail(board_no);
		logger.info("dto : {}", fbdto.getBoard_no());

		model.addAttribute("info", fbdto);
		
		ArrayList<PhotoDTO> fbphoto = fbservice.fbphoto(board_no);
		logger.info("사진 : "+fbphoto);
		model.addAttribute("fbphoto", fbphoto);

		int CountLike = fbservice.CountLike(board_no);
		logger.info("좋아요 갯수 : "+CountLike);
		model.addAttribute("like", CountLike);
		
		return "freeBoard/freeBoardDetail";
	}	
	
	//자유게시판 삭제
	@RequestMapping(value = "/freedelete", method = RequestMethod.GET)
	public String freedelete(Model model, @RequestParam String board_no) {
		logger.info("자유게시판 삭제 요청 : {}", board_no);
		fbservice.freedelete(board_no);
		return "redirect:/freeBoardList";
	}
	

	//자유 게시글 리스트 검색 요청
	@ResponseBody
	@RequestMapping(value = "/FreeSearch", method = RequestMethod.GET)
	public List<FreeBoardDTO> FreeSearch(@RequestParam("SearchType") String SearchType, @RequestParam("Keyword") String Keyword, @RequestParam("FBSearchType") String FBSearchType) {
		logger.info("자유 게시판 리스트 검색 요청");
		logger.info(SearchType +" : "+FBSearchType+" : "+Keyword);
		FreeBoardDTO fbdto = new FreeBoardDTO();
		fbdto.setKeyword(Keyword);
		fbdto.setSearchType(SearchType);
		fbdto.setFBSearchType(FBSearchType);
		
		return fbservice.FreeSearch(fbdto);
	}	
	
	
	//자유게시판 수정폼 이동
	@RequestMapping(value = "/freeUpdateForm", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam String board_no) {
		logger.info("updateForm : {}",board_no);
		
		ArrayList<HashMap<String, String>> free_cate = fbservice.freeboard_cate();
		model.addAttribute("free_cate", free_cate);
		
		return fbservice.freeUpdateForm(model, board_no);
	}	
	
	//자유게시판 수정
	@RequestMapping(value = "freeUpdate", method = RequestMethod.POST)
	public String freeUpdate(Model model, @RequestParam HashMap<String, String>params, MultipartFile uploadFile, HttpSession session) {
		
		logger.info("freeUpdate 요청 : {}", params);
		logger.info("업로드할 파일 : {}", uploadFile);
		return fbservice.freeUpdate(params,uploadFile);
		
	}
	
	
	//자유 게시판 좋아요
	@ResponseBody
	@RequestMapping(value = "fbUplike", method = RequestMethod.POST)
	public  HashMap<String, Object> uplike(@RequestParam String loginId, @RequestParam String board_no,@RequestParam String board_name) {
		
		logger.info("게시판 좋아요 요청");
		logger.info("로그인아이디/게시글번호 : {},{}",loginId,board_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		/*현재 id 좋아요 여부 확인*/
		String like2 = fbservice.likecheck(loginId,board_no,board_name);
		logger.info("좋아요 여부확인 : {}",like2);
		
		if(like2 != null) {//좋아요 취소
			int row2 = fbservice.fbDownlike(loginId,board_no,board_name);
			map.put("row2", row2);
		}else {
			int row = fbservice.fbUplike(loginId,board_no,board_name);
			map.put("success", row);
		}
		
		
		return map;
	}	
	
	
	
	
}
