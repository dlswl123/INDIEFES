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
	
	// �۸��
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void boardList(Model model) throws Exception {
		// �Խ��� �� ��Ϻҷ�����
		List<BoardVo> list = boardService.selectAll();
		System.out.println("boardList");
		model.addAttribute("list", list);
	}
	
	// ����ȸ
	@RequestMapping(value="/read", method = RequestMethod.GET)
	public void read(@RequestParam("board_number")int board_number, Model model, HttpSession session)throws Exception {
		System.out.println("BoardController, read, board_number:" + board_number);
		BoardVo boardVo = boardService.select(board_number);
		// �ش�� �ۼ� ���̵�
		String user_id = boardVo.getUser_id();
		// �α��� ���̵�
		String login_id = "xotjd";
		System.out.println("user_id:" + user_id);
		System.out.println("login_id:" + login_id);
		if (! user_id.equals(login_id)) {
			System.out.println("update ����");
			boardService.updateViewcnt(board_number);
		}
		model.addAttribute("boardVo", boardVo);
	}
	
	// �۾��� �� - /indiefes/board/regist(GET ��û)
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public void registGet() throws Exception {
		System.out.println("registGet()�����");
		// ��ȯŸ���ΰ�� ��û���.jsp�� �������Ѵ�
		// /WEB-INF/indifes/board/regist.jsp
	}
	
	// �۾���ó�� - /indiefes/board/regist(Post ��û)
	@RequestMapping(value="/regist", method=RequestMethod.POST)
	public String registPost(BoardVo boardVo, RedirectAttributes rttr, HttpSession session)throws Exception {
		System.out.println("boardVo:" + boardVo);
		System.out.println("BoardController, registPost, boardVo:" + boardVo);
		boardService.insert(boardVo);
		rttr.addAttribute("message","success_insert");
//		-> �����̷�Ʈ�� �ѹ� ���̰� ������ �Ӽ�
		return "redirect:/board/list";
	}
	
	// �ۼ��� �� - /indiefes/board/update(GET ��û)
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public void updateGet(@RequestParam("board_number")int board_number, Model model)throws Exception {
		BoardVo boardVo = boardService.select(board_number);
		model.addAttribute("boardVo", boardVo);
	}
	
	// �ۼ���ó�� - /indiefes/board/update(Post ��û)
	@RequestMapping(value="/update", method= RequestMethod.POST)
	public String updatePost(BoardVo boardVo, RedirectAttributes rttr)throws Exception {
		boardService.update(boardVo);
		rttr.addAttribute("message", "success_update");
		
		return "redirect:/board/read?board_number=" + boardVo.getBoard_number();
	}
	// �ۻ��� �� - /indiefes/board/update(GET ��û)
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public void deleteGet(int board_number, Model model)throws Exception {
		
	}
	// �ۻ���ó�� - /indiefes/board/delete(Post ��û)
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
