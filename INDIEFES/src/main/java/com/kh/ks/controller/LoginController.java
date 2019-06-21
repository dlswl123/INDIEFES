package com.kh.ks.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ks.service.IUserInfoService;

@Controller
@RequestMapping("/user/*")
public class LoginController {
	
	@Inject
	private IUserInfoService userInfoService;
	
	
	@RequestMapping(value="/login")
	public void LoginForm() {
		System.out.println("loginForm() 실행됨");
	}
	
	@RequestMapping(value="/login-run", method=RequestMethod.POST)
	public String loginRun(String user_id, String user_pw, HttpSession session)throws Exception{
		System.out.println("LoginController, loginRun, user_id/user_pw:" + user_id + "/" + user_pw); // 1.로그인폼에서 넘어온 데이터 -> service로 넘겨줌
//		String user_id = userInfoVo.getUser_id();
//		String user_pw = userInfoVo.getUser_pw();
		UserInfoVo userInfoVo = userInfoService.readWithPw(user_id, user_pw);
		System.out.println("LoginController, loginRun, userInfoVo:" + userInfoVo); // 6.service에서 다시 넘어온 데이터
		if(userInfoVo != null) {
			session.setAttribute("userInfoVo", userInfoVo);
		}
		return "redirect:/";
	}
}
