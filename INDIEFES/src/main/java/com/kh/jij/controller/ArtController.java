package com.kh.jij.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jij.domain.ArtInfoVo;
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
		ArtInfoVo artVo = artService.art_read(user_id);
		List<MusicInfoVo> musicList = artService.music_read(1);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
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
