package com.kh.jij.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("player/*")
public class PlayerController {
	
	@RequestMapping(value="/player", method=RequestMethod.GET)
	public void Player() {
		System.out.println("Player()");
	}
	
	
	
}
