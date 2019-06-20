package com.kh.jij.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.service.IArtInfoService;

@Controller
@RequestMapping("art/*")
public class ArtController {

	@Inject
	IArtInfoService artService;
	
	// 앨범정보 폼
	@RequestMapping(value="/art_info", method=RequestMethod.GET)
	public void ArtInfo(HttpSession session, Model model) throws Exception {
//		UserVo userVo = session.getAttribute("userVo");
		
		String user_id = "indie1";
		String team_name = "인디1";
		ArtInfoVo artVo = artService.art_read(user_id, 1);
		List<MusicInfoVo> musicList = artService.music_read(4);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
		model.addAttribute("team_name", team_name);
//		System.out.println("ArtController, artVo : " + artVo);
//		System.out.println("ArtController, musicList : " + musicList);
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