package com.kh.jij.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("art/*")
public class ArtController {

	
	@RequestMapping(value="/art_info", method=RequestMethod.GET)
	public void ArtInfo() {
		
	}
	@RequestMapping(value="/art_info_input", method=RequestMethod.GET)
	public void ArtInfoInput() {
		System.out.println("ArtInfoInput()");
	}
	@RequestMapping(value="/indie_team_input", method=RequestMethod.GET)
	public void TeamInput() {
		System.out.println("TeamInput()");
	}
	
	
}
