package com.quiz.bank.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.quiz.bank.dao.FreeBoardDAO;
import com.quiz.bank.dao.TodoListDAO;
import com.quiz.bank.dao.UserDAO;
import com.quiz.bank.dto.FreeBoardDTO;
import com.quiz.bank.dto.PhotoDTO;

@Service
public class FreeBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired FreeBoardDAO fbdao;

	// 자유 게시판 페이징
	public HashMap<String, Object> FBlistCall(int currPage, int pagePerCnt) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//어디서 부터 보여줄 것인가.
		int offset = ((currPage-1)*pagePerCnt-1) >=0 ?
				((currPage-1)*pagePerCnt-1) : 0;
		logger.info("offset : "+offset);
		
		int totalCount = fbdao.FballCount(); //테이블 모든 글의 총 갯수
		//만들 수 있는 페이지의 수 (전체 갯수 / 보여줄 수)
		int range = totalCount%pagePerCnt > 0 ? 
				 (totalCount/pagePerCnt)+1 : (totalCount/pagePerCnt);
		 logger.info("총 갯수 : {}",totalCount);
		 logger.info("만들 수 있는 총 페이지 : {}",range);
		 
		 map.put("totalCount", totalCount);
		 map.put("pages", range);
		 map.put("list", fbdao.FBlistCall(pagePerCnt, offset));
		
		return map;
	}

	//자유 게시판 카테고리
	public ArrayList<HashMap<String, String>> freeboard_cate() {
		logger.info("자유 게시판 세부 카테고리");
		return fbdao.freeboard_cate();
	}

	//자유게시판 작성
	public String freeWrite(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("자유게시판 작성 서비스");
		
		String page = "/freeBoard/freeBoardList";
		FreeBoardDTO fdto = new FreeBoardDTO();
		
		fdto.setTitle(params.get("title"));
		fdto.setUser_id(params.get("user_id"));
		fdto.setContent(params.get("content"));
		fdto.setBoard_cate_no(Integer.parseInt(params.get("board_cate_no")));
		fbdao.freeWrite(fdto);
		
		int board_no = fdto.getBoard_no();
		logger.info("board_no : "+board_no);
		
		if (board_no > 0) {
			page = "redirect:/freeBoardDetail?board_no="+board_no;
			saveFile(board_no,uploadFile);
		}
		return page;
	}
	
	//자유 게시판 파일 업로드
	private void saveFile(int board_no, MultipartFile uploadFile) {
		
		try {
			String oriFileName = uploadFile.getOriginalFilename();
			int index = oriFileName.lastIndexOf(".");
			logger.info("index : {}",index);
			
			if (index>0) {
				String ext = oriFileName.substring(index);
				String newFileName = System.currentTimeMillis()+ext;
				logger.info(oriFileName+"->"+newFileName);
				
				byte[] bytes = uploadFile.getBytes();
				Path path = Paths.get("C:/upload/"+newFileName);
				Files.write(path,bytes);
				logger.info(oriFileName+"문의Save완료!");
				fbdao.freefileWrite(board_no,oriFileName,newFileName);
			}
			
			
		}catch (Exception e) {
			logger.info("오류 발생 : {}",e);
		}
		
	}
	
	//자유 게시판 상세보기
	public FreeBoardDTO freeBoardDetail(String board_no) {
		logger.info("자유게시판 상세보기 서비스");
		
		fbdao.freeBoardupHit(board_no);
		
		return fbdao.freeBoardDetail(board_no);
	}

	//자유 게시글 삭제
	public void freedelete(String board_no) {
		logger.info("자유 게시글 삭제 서비스 : "+board_no);
		int success = fbdao.freedelete(board_no);
		logger.info("자유 게시글 삭제 여부 : "+success);
		
	}

	//자유 게시판 리스트 검색
	public List<FreeBoardDTO> FreeSearch(FreeBoardDTO fbdto) {
		logger.info("자유 게시판 리스트 검색");
		return fbdao.FreeSeasrch(fbdto);
	}

	//자유 게시판 상세보기 이동
	public String freeUpdateForm(Model model, String board_no) {
		
		FreeBoardDTO fbdto = fbdao.freeBoardDetail(board_no);
		ArrayList<PhotoDTO> fbphoto = fbdao.fbphoto(board_no);
		
		logger.info("title : "+fbdto.getTitle());
		logger.info("photo : "+fbphoto);
		
		model.addAttribute("fbdto",fbdto);
		model.addAttribute("fbphoto", fbphoto);
		
		
		return "freeBoard/freeUpdateForm";
	}

	//자유게시판 상세보기 사진 불러오기
	public ArrayList<PhotoDTO> fbphoto(String board_no) {
		
		return fbdao.fbphoto(board_no);
	}

	//자유게시판 수정
	public String freeUpdate(HashMap<String, String> params, MultipartFile uploadFile) {
		logger.info("free update 서비스 : "+params);
		int board_no = Integer.parseInt(params.get("board_no"));
		String page = "redirect:/freeBoardDetail?board_no="+board_no;
		
		if (fbdao.freeUpdate(params)>0) {
			page = "redirect:/freeBoardDetail?board_no="+board_no;
			saveFile(board_no, uploadFile);
		}

		return page;
	}

	//자유 게시글 좋아요 여부 확인
	public int likecheck(String user_id, String board_no) {
		logger.info("좋아요 유무 확인 서비스");
		int likecheck = fbdao.likecheck(user_id,board_no);
		return likecheck;
	}

	//자유 게시글 좋아요 삭제
	public int fbDownlike(String loginId, String board_no, String board_name) {
		logger.info("좋아요 취소 서비스");
		return fbdao.fbDownlike(loginId,board_no,board_name);
	}

	//자유 게시글 좋아요 추가
	public int fbUplike(String loginId, String board_no, String board_name) {
		logger.info("좋아요 등록 서비스");
		int row = fbdao.fbUplike(loginId,board_no,board_name);
		
		return row;
	}

	//좋아요 수 카운트
	public int CountLike(String board_no) {
		logger.info("좋아요 수 카운트 서비스");
		return fbdao.CountLike(board_no);
	}
	
	

	//댓글 등록 기능
	public void fbcoment(HttpSession session, HashMap<String, String> params) {
		
		FreeBoardDTO fbdto = new FreeBoardDTO();
		String user_id = (String)session.getAttribute("loginId");
		
		fbdto.setUser_id(user_id);
		fbdto.setBoard_no(Integer.parseInt(params.get("board_no")));
		fbdto.setReply_content(params.get("reply_content"));
		
		//댓글 등록
		fbdao.fbcoment(fbdto);
//		int reply_no = fbdto.getReply_no();
		logger.info("댓글 등록 서비스 확인");
		
	}

	//댓글 불러오기
	public ArrayList<FreeBoardDTO> freeboardcoment(String board_no) {
		ArrayList<FreeBoardDTO> coment = fbdao.freeboardcoment(board_no);
		return coment;
	}

	//댓글 삭제
	public void fbcomdel(String reply_no) {
		logger.info("댓글 삭제 서비스");
		fbdao.fbcomdel(reply_no);
		
	}

	//게시글 신고
	public String freeBaordSingo(HashMap<String, String> params) {
		logger.info("게시글 신고 서비스 : "+params);
		fbdao.freeBoardSingo(params);
		
		String board_no = params.get("board_no");
		
		return "redirect:/freeBoardDetail?board_no="+board_no;
	}





}
