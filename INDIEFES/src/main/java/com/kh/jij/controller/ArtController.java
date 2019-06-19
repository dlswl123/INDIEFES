package com.kh.jij.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.service.IArtInfoService;

@Controller
@RequestMapping("art/*")
public class ArtController {

	@Inject
	IArtInfoService artService;
	
	// 앨범정보 폼
	@RequestMapping(value="/art_info", method=RequestMethod.GET)
	public void ArtInfo() {
		
	}
	
	@RequestMapping(value="/art_info_input", method=RequestMethod.GET)
	public void ArtInfoInput() {
		System.out.println("ArtInfoInput()");
	}
	
	@RequestMapping(value="/art_info_input", method=RequestMethod.POST)
	public String registPost(ArtInfoVo artVo,HttpSession session) throws Exception {
		artVo.setUser_id("indie1");
		artVo.setTeam_number(1);
		artService.insert(artVo);
		return "redirect:/art/indie_team_input";
	}
	
	@RequestMapping(value="/indie_team_input", method=RequestMethod.GET)
	public void TeamInput() {
		System.out.println("TeamInput()");
	}
	
	
}
