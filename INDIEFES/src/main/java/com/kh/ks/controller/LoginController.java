package com.kh.ks.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("user/*")
public class LoginController {
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void LoginForm() {
		System.out.println("loginForm() 실행됨");
	}
}
