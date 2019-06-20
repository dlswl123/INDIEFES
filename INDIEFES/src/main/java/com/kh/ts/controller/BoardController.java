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
	
	// 게시판list.jsp로
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void boardList(Model model) throws Exception {
		// 게시판 글 목록불러오기
		List<BoardVo> list = boardService.selectAll();
		System.out.println("boardList");
		model.addAttribute("list", list);
	}
	// 글조회
	@RequestMapping(value="/read", method = RequestMethod.GET)
	public void read(@RequestParam("board_number")int board_number, Model model) throws Exception {
		System.out.println("BoardController, read, board_number:" + board_number);
		boardService.updateViewcnt(board_number);
		BoardVo boardVo = boardService.select(board_number);
		model.addAttribute("boardVo", boardVo);
	}
	
	// 글쓰기 폼 - /board/regist(GET 요청)
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void registGet() throws Exception {
		System.out.println("registGet()실행됨");
		// 반환타입인경우 요청경로.jsp로 포워딩한다
		// /WEB-INF/indifes/board/regist.jsp
	}
	// 글쓰기처리 - /board/regist(Post 요청)
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String registPost(BoardVo boardVo, RedirectAttributes rttr, HttpSession session) throws Exception {
		System.out.println("boardVo:" +boardVo);
		System.out.println("BoardController, registPost, boardVo:" + boardVo);
		boardService.insert(boardVo);
		rttr.addAttribute("message","success_insert");
//		-> 리다이렉트시 한번 쓰이고 버려질 속성
		return "redirect:/board/list";
	}
}
