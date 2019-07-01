package com.kh.hj.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hj.domain.ConcertInfoVo;
import com.kh.hj.service.IConcertService;
import com.kh.ks.domain.UserInfoVo;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "concert/*")
public class ConcertController {
	
	@Inject
	private IConcertService service;
	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public void concertInfo(Model model) throws Exception {
		// move to /concert/info.jsp
		
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void concertInfoWrite(Model model) throws Exception {
		// move to /concert/write.jsp
		
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String concertInfoWriteRun(ConcertInfoVo vo, RedirectAttributes rttr, HttpSession session) throws Exception {

		// get user_id by session
		UserInfoVo userInfoVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userInfoVo.getUser_id();
		vo.setUser_id(user_id);
		
		// Read ConcertInfoVo
		System.out.println("vo : " + vo.toString());
		
		// insert into DBtable ConcertInfoVo information
		service.insertConcertInfo(vo);
		
		rttr.addFlashAttribute("resultMessage", "insert_success");
		
		// move to /concert/info.jsp
		return "redirect:/concert/info";
	}
	
}
