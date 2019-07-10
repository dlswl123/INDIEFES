package com.kh.ks.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jij.service.IArtInfoService;
import com.kh.ks.domain.UserInfoVo;

import com.kh.ks.service.IUserInfoService;
import com.kh.ts.domain.PaginationDto;
import com.kh.ts.domain.PagingDto;

@Controller
@RequestMapping("/user/*")
public class LoginController {
	
	@Inject
	private IUserInfoService userInfoService;
	
	@Inject
	IArtInfoService artService;
	
	
	//로그인 폼
	@RequestMapping(value="/login")
	public void LoginForm() {
		System.out.println("loginForm() 실행됨");
	}
	
	//로그인 동작
	@RequestMapping(value="/login-run", method=RequestMethod.POST)
	public String loginRun(String user_id, String user_pw, HttpSession session, RedirectAttributes rttr)throws Exception{
		System.out.println("LoginController, loginRun, user_id/user_pw:" + user_id + "/" + user_pw); // 1.로그인폼에서 넘어온 데이터 -> service로 넘겨줌
//		String user_id = userInfoVo.getUser_id();
//		String user_pw = userInfoVo.getUser_pw();
		UserInfoVo userInfoVo = userInfoService.readWithPw(user_id, user_pw);
		System.out.println("userInfoVo : " + userInfoVo);
		String deleted = userInfoVo.getDeleted();
//		UserInfoVo userInfoVo1 = userInfoService.readWith(user_id);
//		System.out.println("LoginController, loginRun, userInfoVo1:" + userInfoVo1); // 6.service에서 다시 넘어온 데이터
//		System.out.println("LoginController, loginRun, userInfoVo:" + userInfoVo); // 6.service에서 다시 넘어온 데이터
		// 팀가입 여부
		try {
			if(userInfoVo != null) {
				session.setAttribute("userInfoVo", userInfoVo);
				int indieNum = -1;
				indieNum = artService.getIndieNumber(userInfoVo.getUser_id()); 
				if (indieNum > -1) {
					session.setAttribute("indieNum", indieNum);
				}
				if(deleted.equals("O")) {
					rttr.addFlashAttribute("message", "login_fail");
					return "redirect:/user/login";
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 팀가입 끝
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
	
	// 회원가입 처리
	@RequestMapping(value="/account-create-run", method=RequestMethod.GET)
	public String accountCreateRun(UserInfoVo userInfoVo, String birthYear, String birthMonth, String birthDay, 
			RedirectAttributes rttr, HttpServletResponse response)throws Exception{
		
//		System.out.println("account create birthYear : " + birthYear);
//		System.out.println("account create birthMonth : " + birthMonth);
//		System.out.println("account create birthDay : " + birthDay);
		String birth = "";
		birth = birthYear + "-" + birthMonth + "-" + birthDay;
//		System.out.println(birth);
		
		
		userInfoVo.setUser_birth(birth);
		
//		System.out.println("account create userInfoVo : " + userInfoVo);
		
		boolean accountResult = userInfoService.createAccount(userInfoVo);
		System.out.println(accountResult);
		String returnURI = "";
//		PrintWriter out=response.getWriter();
//		response.setContentType("text/html; charset=UTF-8");
		if(accountResult == true) {
			
			rttr.addFlashAttribute("message", "create_accout_success");




			
			returnURI = "redirect:/user/login";
		}
		
		
		return returnURI;
	}
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="/id-check", method=RequestMethod.POST)
	public int idCheck(HttpServletRequest request) throws Exception{
	
		int result = 0;
		
		String user_id = request.getParameter("user_id");
		System.out.println("아이디 중복 체크 Controller : " + user_id);
		UserInfoVo idCheck = userInfoService.idCheck(user_id);
		System.out.println("아이디 중복 체크 Controller(service에서 넘어온 데이터) : " + idCheck);
		
		if(idCheck != null) {
			  result = 1;
		} 
		
		return result;
	}
	
	// 닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value="/nick-check", method= {RequestMethod.POST, RequestMethod.GET})
	public int nickCheck(HttpServletRequest request) throws Exception{
	
		int result = 0;
		
		String user_nick = request.getParameter("user_nick");
		System.out.println("닉네임 중복 체크 Controller : " + user_nick);
		UserInfoVo nickCheck = userInfoService.nickCheck(user_nick);
		
		System.out.println("닉네임 중복 체크 Controller(service에서 넘어온 데이터) : " + nickCheck);
		
		
		if(nickCheck != null) {
			  result = 1;
		} 
		
		
		return result;
	}
	
	// 회원정보
	@RequestMapping(value="/user-info", method=RequestMethod.GET)
	public String userInfo()throws Exception{
		return "/user/user_info";

	}
	
	// 회원정보 비밀번호확인
	@RequestMapping(value="/user-info-pwinput", method= {RequestMethod.POST, RequestMethod.GET})
	public String userInfoPwinput(HttpSession session)throws Exception{
		System.out.println("LoginController, userInfoPwinput(), sesssion:" + session);
		UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
		if (userInfoVo == null) {
			return "redirect:/user/login";
		}
		return "/user/user_info_pwinput";
		
	}
	
	// 회원정보 비밀번호확인 동작
	@RequestMapping(value="/user-info-pwinput-run", method= {RequestMethod.POST, RequestMethod.GET})
	public String userInfoPwinputRun(HttpSession session, String user_pw, RedirectAttributes rttr)throws Exception{
		String URI = "";
		if (session == null) {
			URI = "redirect:/user/login";
		}
		
		UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
		String sessionUserid = userInfoVo.getUser_id();
		String sessionUserpw = userInfoVo.getUser_pw();
		
		System.out.println("회원정보재확인 Controller id : " + sessionUserid);
		System.out.println("회원정보재확인 Controller pw세션 : " + sessionUserpw);
		System.out.println("회원정보재확인 Controller pw입력 : " + user_pw);
		if(sessionUserpw.equals(user_pw)) {
			
			rttr.addFlashAttribute("message", "success");
			URI = "redirect:/user/user-info";
		}
		else {
			
			rttr.addFlashAttribute("message", "fail");
			URI = "redirect:/user/user-info-pwinput";
		}
		
		return URI;
			
	}
	
	// 인디팀 가입신청시 비밀번호 확인폼
	@RequestMapping(value="/indie-team-subscription", method= {RequestMethod.POST, RequestMethod.GET})
	public String indieTeamSubscription(HttpSession session) throws Exception{
		UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
		if (userInfoVo == null) {
			return "redirect:/user/login";
		}
		
		
		return "/user/indie_team_subscription";
	}
	
	// 인디팀 가입신청시 비밀번호확인 동작
	@RequestMapping(value="/indie-team-subscription-run", method= {RequestMethod.POST, RequestMethod.GET})
	public String indieTeamSubscriptionRun(HttpSession session, String user_pw, RedirectAttributes rttr)throws Exception{
		String URI = "";
		if (session == null) {
			URI = "redirect:/user/login";
		}
		
		UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
		String sessionUserid = userInfoVo.getUser_id();
		String sessionUserpw = userInfoVo.getUser_pw();
		
		if(sessionUserpw.equals(user_pw)) {
			URI = "redirect:/art/indie_team_input";
			rttr.addFlashAttribute("message", "success");
		}
		else {
			URI = "redirect:/user/indie-team-subscription";
			rttr.addFlashAttribute("message", "fail");
		}
		
		return URI;
	}
	// 회원정보 수정
	@RequestMapping(value="/user-info-adjust", method= {RequestMethod.POST, RequestMethod.GET})
	public String userInfoAdjust(UserInfoVo userInfoVo, String birthYear, String birthMonth, String birthDay, 
			RedirectAttributes rttr, HttpServletRequest request)throws Exception{
		
		System.out.println("user-info-adjust birthYear : " + birthYear);
		System.out.println("user-info-adjust birthMonth : " + birthMonth);
		System.out.println("user-info-adjust birthDay : " + birthDay);
		String birth = "";
		birth = birthYear + "-" + birthMonth + "-" + birthDay;
		System.out.println(birth);
		
		
		userInfoVo.setUser_birth(birth);
		System.out.println("user-info-adjust : " + userInfoVo);
		userInfoService.userInfoAdjust(userInfoVo);
		
		rttr.addFlashAttribute("message", "success");
		HttpSession session= request.getSession();
		session.invalidate();
//		System.out.println("user-info-adjust : " + userInfoVo);
		return "redirect:/";
		
	}
	
	// 회원탈퇴
	@RequestMapping(value="/user-delete", method= {RequestMethod.POST, RequestMethod.GET})
	public String userDelete(HttpSession session, RedirectAttributes rttr)throws Exception{
		
		UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userInfoVo.getUser_id();
		System.out.println(user_id);
		userInfoService.userDelete(user_id);
		rttr.addFlashAttribute("message", "delete-success");
		session.invalidate();
		return "redirect:/";
	}
	
	
	// 회원관리페이지
	@RequestMapping(value="/user-management", method= {RequestMethod.POST, RequestMethod.GET})
	public String userManagement(PagingDto pagingDto, Model model)throws Exception{
		
		System.out.println("회원관리폼 실행됨");
		List<UserInfoVo> list = userInfoService.userInfo(pagingDto);
		System.out.println("회원관리폼 결과값 : " + list);
		model.addAttribute("list", list);
		
		PaginationDto paginationDto = new PaginationDto();
		
		paginationDto.setPagingDto(pagingDto);
		int count = userInfoService.userCount(pagingDto);
		System.out.println("LoginController userCount : " + count);
		paginationDto.setTotalCount(count);
		model.addAttribute("paginationDto", paginationDto);
		
		
		
		return "/user/user_management";
	}
	
	
	
	
	
	
}
