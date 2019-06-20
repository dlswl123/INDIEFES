package com.kh.jij.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
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
	// 앨범정보 입력폼
	@RequestMapping(value="/art_info_input", method=RequestMethod.GET)
	public void ArtInfoInput() {
		System.out.println("ArtInfoInput()");
	}
	// 앨범정보 처리
	@RequestMapping(value="/art_info_input", method=RequestMethod.POST)
	public String registPost(ArtInfoVo artVo,HttpSession session) throws Exception {
		artVo.setUser_id("indie1");
		artVo.setTeam_number(1);
		artService.insert(artVo);
		return "redirect:/art/indie_team_input";
	}
	// 팀생성 및 가입 폼
	@RequestMapping(value="/indie_team_input", method=RequestMethod.GET)
	public void TeamInfo() {
		System.out.println("TeamInput()");
	}
	// 팀생성처리
	@RequestMapping(value="/indie_team_input", method=RequestMethod.POST)
	public String TeamInfoInput(IndieTeamVo teamVo,HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("teamVo", teamVo);
		map.put("user_id", "indie1");
		artService.teamInsert(map);
		return "redirect:/art/indie_team_input";
	}
	// 팀가입 처리
	@RequestMapping(value="/team_member_input", method=RequestMethod.GET)
	public String memberInfoInput(TeamMemberVo memberVo,HttpSession session) throws Exception {
		memberVo.setUser_id("indie2");
		artService.teamInput(memberVo);
		return "redirect:/art/indie_team_input";
	}
	
	
}
