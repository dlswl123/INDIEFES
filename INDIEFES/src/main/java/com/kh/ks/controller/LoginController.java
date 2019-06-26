package com.kh.ks.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;


import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ks.service.IUserInfoService;

@Controller
@RequestMapping("/user/*")
public class LoginController {
	
	@Inject
	private IUserInfoService userInfoService;
	
	
	//로그인 폼
	@RequestMapping(value="/login")
	public void LoginForm() {
		System.out.println("loginForm() 실행됨");
	}
	
	//로그인 성공
	@RequestMapping(value="/login-run", method=RequestMethod.POST)
	public String loginRun(String user_id, String user_pw, HttpSession session)throws Exception{
		System.out.println("LoginController, loginRun, user_id/user_pw:" + user_id + "/" + user_pw); // 1.로그인폼에서 넘어온 데이터 -> service로 넘겨줌
//		String user_id = userInfoVo.getUser_id();
//		String user_pw = userInfoVo.getUser_pw();
		UserInfoVo userInfoVo = userInfoService.readWithPw(user_id, user_pw);
//		UserInfoVo userInfoVo1 = userInfoService.readWith(user_id);
//		System.out.println("LoginController, loginRun, userInfoVo1:" + userInfoVo1); // 6.service에서 다시 넘어온 데이터
		System.out.println("LoginController, loginRun, userInfoVo:" + userInfoVo); // 6.service에서 다시 넘어온 데이터
		if(userInfoVo != null) {
			session.setAttribute("userInfoVo", userInfoVo);
		}
		return "redirect:/";
	}
	
	//회원가입
	@RequestMapping(value="/account-create", method=RequestMethod.GET)
	public String accountCreate()throws Exception{
		return "/user/account_create";

	}
	
	//로그아웃
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		HttpSession session= request.getSession();
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/account-create-run", method=RequestMethod.GET)
	public String accountCreateRun(UserInfoVo userInfoVo, String birthYear, String birthMonth, String birthDay, 
			RedirectAttributes rttr, HttpServletResponse response)throws Exception{
		
		System.out.println("account create birthYear : " + birthYear);
		System.out.println("account create birthMonth : " + birthMonth);
		System.out.println("account create birthDay : " + birthDay);
		String birth = "";
		birth = birthYear + "-" + birthMonth + "-" + birthDay;
		System.out.println(birth);
		
		
		userInfoVo.setUser_birth(birth);
		
		System.out.println("account create userInfoVo : " + userInfoVo);
		
		boolean accountResult = userInfoService.createAccount(userInfoVo);
		System.out.println(accountResult);
		String returnURI = "";
		PrintWriter out=response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		if(accountResult == true) {
			
			rttr.addFlashAttribute("message", "create_accout_success");




			
			returnURI = "redirect:/";
		}
		
		
		return returnURI;
	}
	
	
}
