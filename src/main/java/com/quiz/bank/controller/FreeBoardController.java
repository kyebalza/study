package com.quiz.bank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
		logger.info("자유 게시판 페이징 요청");
		logger.info("자유 게시판 페이징 요청 : {} 페이지, {} 개 씩",page, cnt);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		return fbservice.FBlistCall(currPage,pagePerCnt);
	}
	
	//댓글 페이징
	@ResponseBody
	@RequestMapping(value = "/FBClistCall", method = RequestMethod.GET)
	public HashMap<String, Object> FBClistCall(@RequestParam String page, @RequestParam String cnt, @RequestParam String board_no, HttpSession session) {
		logger.info("댓글 페이징 요청");
		logger.info("댓글 페이징 요청 : {} 페이지, {} 개 씩",page, cnt);
		logger.info("로딩 중인 게시글 번호 : "+board_no);
		
		int currPage = Integer.parseInt(page);
		int pagePerCnt = Integer.parseInt(cnt);
		
		String user_id = (String) session.getAttribute("loginId");
		
		
		return fbservice.FBClistCall(currPage,pagePerCnt,board_no,user_id);
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
	public String freeBoardDetail(Model model, @RequestParam String board_no, HttpSession session) {
		logger.info("자유게시판 상세보기 요청 : {}", board_no);

		String user_id = (String) session.getAttribute("loginId");
		
		
		//내용
		FreeBoardDTO fbdto = fbservice.freeBoardDetail(board_no);
		logger.info("dto : {}", fbdto.getBoard_no());
		model.addAttribute("info", fbdto);
		
		//사진
		ArrayList<PhotoDTO> fbphoto = fbservice.fbphoto(board_no);
		logger.info("사진 : "+fbphoto);
		model.addAttribute("fbphoto", fbphoto);

		//좋아요
		int CountLike = fbservice.CountLike(board_no);
		logger.info("좋아요 갯수 : "+CountLike);
		model.addAttribute("like", CountLike);
		
		
		
		//좋아요 조회
		int like2 = fbservice.likecheck(user_id,board_no);
		logger.info("좋아요 여부확인 : {}", like2);
		model.addAttribute("likecheck", like2);
		
		//댓글
//		ArrayList<HashMap<String, String>> fbcom = fbservice.freecoment(board_no,user_id);
//		logger.info("댓글 : "+board_no);
//		model.addAttribute("frcomList", fbcom);
//		logger.info("댓글 목록 요청 : "+fbcom);
		
		model.addAttribute("loginId", session.getAttribute("loginId"));
		
		
		return "freeBoard/freeBoardDetail";
	}	
	
	//댓글
	/*
	 * @RequestMapping(value = "/freeboardcoment", method = RequestMethod.POST)
	 * public String freeboardcoment(Model model, HttpSession session, @RequestParam
	 * String board_no) {
	 * 
	 * logger.info("마이크 테스트"); model.addAttribute("loginId",
	 * session.getAttribute("loginId")); ArrayList<FreeBoardDTO> fbdto =
	 * fbservice.freeboardcoment(board_no); logger.info("댓글 목록 요청 : "+fbdto);
	 * model.addAttribute("fbcomList",fbdto);
	 * 
	 * 
	 * return "freeBoard/fbComent"; }
	 */
	
	
	
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
		String user_id = loginId;
		/*현재 id 좋아요 여부 확인*/
		int like2 = fbservice.likecheck(user_id,board_no);
		logger.info("좋아요 여부확인 : {}",like2);
		
		if(like2 != 0) {//좋아요 취소
			int row2 = fbservice.fbDownlike(loginId,board_no,board_name);
			map.put("row2", row2);
		}else {
			int row = fbservice.fbUplike(loginId,board_no,board_name);
			map.put("success", row);
		}
		
		
		return map;
	}	
	
	
	//자유 게시판 신고 팝업창 출력
	/*
	 * @RequestMapping(value = "freeboardReport") public String freeboardReport
	 * (HttpServletRequest request, HttpServletResponse response, Model model)
	 * throws Exception{
	 * 
	 * return "freeBoard/freeboardReport"; }
	 */
	
	//댓글 작성
	@RequestMapping(value="fbcoment", method = RequestMethod.POST)
	public String fbcoment(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("댓글 등록 요청" + session +" / "+ params);
		fbservice.fbcoment(session, params);
		String user_id = params.get("user_id");
		
		return "redirect:/freeBoardDetail?board_no="+params.get("board_no");
				
	}
	
	//댓글 삭제
	@RequestMapping(value="fbcomdel", method = RequestMethod.GET)
	public String fbcomdel(Model model, @RequestParam String reply_no, @RequestParam String board_no, @RequestParam String user_id ) {
		logger.info("댓글 삭제 요청 : "+reply_no);
		fbservice.fbcomdel(reply_no);
		
		return "redirect:/freeBoardDetail?board_no="+board_no;
				
	}
	
	//게시글 신고
	@RequestMapping(value="fbReport", method = RequestMethod.POST)
	public String fbReport(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
		String user_id = (String) session.getAttribute("loginId");
		params.put("report_user", user_id);
		logger.info("게시글 신고 요청 : "+params);
		
		return fbservice.fbReport(params);
				
	}
	
	//댓글 신고
	@ResponseBody
	@RequestMapping(value = "/fbcomReport", method = RequestMethod.POST)
	public HashMap<String, Object> fbcomReport(@RequestParam HashMap<String, String> params, HttpSession session ) {
		logger.info("공부게시판 신고하기 요청 : {}",params);
		String user_id = (String) session.getAttribute("loginId");
		params.put("report_user", user_id);
		return fbservice.fbcomReport(params);
	}
	
	
	//댓글 좋아요
	@ResponseBody
	@RequestMapping(value = "fbcrelike", method = RequestMethod.POST)
	public  HashMap<String, Object> fbcrelike(@RequestParam String loginId
			, @RequestParam String board_no,@RequestParam String reply_no) {
		
		logger.info(reply_no,"댓글 좋아요 요청");
		logger.info("로그인아이디/게시글번호 : {},{}",loginId,board_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		/*현재 id 좋아요 여부 확인*/
		String relike2 = fbservice.fbcrelike2(loginId,board_no,reply_no);
		logger.info("좋아요 여부확인 : {}",relike2);
		
		if(relike2 != null) {//좋아요 취소
			int row2 = fbservice.fbcrelike_del(loginId,board_no,reply_no);
			map.put("row2", row2);
		}else {
			int row = fbservice.fbcreuplike(loginId,board_no,reply_no);
			map.put("success", row);
		}
		
		return map;
	}	
	
	
	
}
