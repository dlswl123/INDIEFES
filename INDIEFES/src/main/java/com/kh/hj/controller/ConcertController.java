package com.kh.hj.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hj.domain.ConcertInfoVo;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "concert/*")
public class ConcertController {
	
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
		System.out.println("vo : " + vo.toString());
		
		// move to /concert/info.jsp
		return "redirect:/concert/info";
	}
	
}
