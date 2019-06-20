package com.kh.hj.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "concert/*")
public class ConcertController {
	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public void concertInfo(Model model) {
		// move to /concert/info.jsp
		
	}
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void concertInfoWrite(Model model) {
		// move to /concert/info.jsp
		
	}
	
}
