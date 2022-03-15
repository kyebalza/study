package com.quiz.bank.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.quiz.bank.dao.InquiryBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.InquiryBoardDTO;

@Service
public class InquiryBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InquiryBoardDAO dao;

	private Object board_cate_no;



	// 2. 문의글쓰기
	public String inquiryWrite(HashMap<String, String> params) {
		
		String page = "redirect:/inquiryBoardList";
		
		InquiryBoardDTO dto = new InquiryBoardDTO();
		dto.setTitle(params.get("title"));
		dto.setContent(params.get("content"));
		dto.setUser_id(params.get("user_id"));
		dao.inquiryWrite(dto);
		
		int board_no = dto.getBoard_no();
		logger.info("board_no : "+board_no);
		
		if (board_no > 0) {
			page = "redirect:/inquiryBoardDetail?board_no="+board_no;
		}
		return page;
	}
	

	
	
	/*

	// 3. 문의게시판 리스트 호출 (페이징)
	public ArrayList<HashMap<String, String>> InquiryBoardList() {
		return dao.InquiryBoardList();
	}



	public int list_rangecall(int currPage, int pagePerCnt) {
		
		int totalCount = dao.list_allCount(); // 일단 테이블 글이 몇개인지?
		logger.info("totalCount : {}",totalCount);
		int range = totalCount%pagePerCnt > 0 ? (totalCount/pagePerCnt) + 1 : (totalCount/pagePerCnt); // 만들 수 있는 페이지의 갯수
		logger.info("range : {}",range);
		return range;
	}



	public ArrayList<HashMap<String, String>> list_listCall(int currPage, int pagePerCnt) {
		int offset = (currPage -1) * pagePerCnt -1; // DB에 요청할 인덱스 번호임, 1:0-9, 2:10-19 이런식으로 해야 함
		//1페이지면 limit 10에, offset 0부터 조회
		//2페이지면 limit 10에, offset 10부터 조회
		//3페이지면 limit 10에, offset 20부터 조회
		
		if (offset < 0) {
			offset = 0;
		}
		
		logger.info("offset : {}",offset);
		ArrayList<HashMap<String, String>> listCall = dao.list_listCall(pagePerCnt,offset);
		
		return listCall;
	}
	
	*/




	// 3. 문의게시판 리스트 호출(페이징)
	public HashMap<String, Object> inquirylist(int currPage, int pagePerCnt) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 어디서 부터 보여줄 것인가.
		int offset = ((currPage -1) * pagePerCnt -1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : " +offset);
		
		int totalCount = dao.allCount(); // 테이블 모든 글의 총 갯수
		// 만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ?
				(totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		
		logger.info("총 갯수 : {}",totalCount);
		logger.info("만들 수 있는 총 페이지 : {}",range);
		
		map.put("pages", range);
		map.put("list", dao.inquirylist(pagePerCnt,offset));
	
		return map;
	}





	
	

	// 문의게시판 상세보기
	public InquiryBoardDTO inquirydetail(String board_no) {
		logger.info("문의게시판 상세보기 서비스 요청");
		
		dao.inquiryupHit(board_no);
		
		return dao.inquirydetail(board_no);
	}




	public void exposure(String board_no) {
		logger.info("문의게시글 삭제(비노출) 처리 요청");
		
		dao.exposure(board_no);
		
	}





	

	
	



	



	


	

}
