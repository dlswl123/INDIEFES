package com.kh.ts.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.imgscalr.Scalr.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.service.IBoardService;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {

	@Inject
	IBoardService boardService;
	
	// 글목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void boardList(Model model) throws Exception {
		// 게시판 글 목록불러오기
		List<BoardVo> list = boardService.selectAll();
		System.out.println("boardList");
		model.addAttribute("list", list);
	}
	
	// 글조회
	@RequestMapping(value="/read", method = RequestMethod.GET)
	public void read(@RequestParam("board_number")int board_number, Model model, HttpSession session)throws Exception {
		System.out.println("BoardController, read, board_number:" + board_number);
		BoardVo boardVo = boardService.select(board_number);
		// 해당글 작성 아이디
		String user_id = boardVo.getUser_id();
		// 로그인 아이디
		String login_id = "xotjd";
		System.out.println("user_id:" + user_id);
		System.out.println("login_id:" + login_id);
		if (! user_id.equals(login_id)) {
			System.out.println("update 실행");
			boardService.updateViewcnt(board_number);
		}
		model.addAttribute("boardVo", boardVo);
	}
	
	// 글쓰기 폼 - /indiefes/board/regist(GET 요청)
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void registGet() throws Exception {
		System.out.println("registGet()실행됨");
		// 반환타입인경우 요청경로.jsp로 포워딩한다
		// /WEB-INF/indifes/board/regist.jsp
	}
	
	// 글쓰기처리 - /indiefes/board/regist(Post 요청)
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String registPost(BoardVo boardVo, RedirectAttributes rttr, HttpSession session)throws Exception {
		System.out.println("boardVo:" + boardVo);
		System.out.println("BoardController, registPost, boardVo:" + boardVo);
		boardService.insert(boardVo);
		rttr.addAttribute("message","success_insert");
//		-> 리다이렉트시 한번 쓰이고 버려질 속성
		return "redirect:/board/list";
	}
	
	// 글수정 폼 - /indiefes/board/update(GET 요청)
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public void updateGet(@RequestParam("board_number")int board_number, Model model)throws Exception {
		BoardVo boardVo = boardService.select(board_number);
		model.addAttribute("boardVo", boardVo);
	}
	
	// 글수정처리 - /indiefes/board/update(Post 요청)
	@RequestMapping(value="/update", method= RequestMethod.POST)
	public String updatePost(BoardVo boardVo, RedirectAttributes rttr)throws Exception {
		boardService.update(boardVo);
		rttr.addAttribute("message", "success_update");
		
		return "redirect:/board/read?board_number=" + boardVo.getBoard_number();
	}
	// 글삭제 폼 - /indiefes/board/update(GET 요청)
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public void deleteGet(int board_number, Model model)throws Exception {
		
	}
	// 글삭제처리 - /indiefes/board/delete(Post 요청)
	@RequestMapping(value="/delete-run", method=RequestMethod.POST)
	public String deletePost(@RequestParam("board_number")int board_number,
			RedirectAttributes rttr)throws Exception {
		try {
			boardService.delete(board_number);
			rttr.addAttribute("mesage", "success_delete");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/list?board_number=" + board_number;
	}
}
