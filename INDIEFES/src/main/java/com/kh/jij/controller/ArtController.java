package com.kh.jij.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.service.IArtInfoService;
import com.kh.jij.util.FileUploadUtil;

@Controller
@RequestMapping("art/*")
public class ArtController {

	@Inject
	IArtInfoService artService;
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")
	
	// 앨범정보조회 폼
	@RequestMapping(value="/art_info", method=RequestMethod.GET)
	public void ArtInfo(HttpSession session, Model model) throws Exception {
//		UserVo userVo = session.getAttribute("userVo");
		
		String user_id = "indie1";
		String team_name = "인디1";
		ArtInfoVo artVo = artService.artRead(user_id, 1);
		List<MusicInfoVo> musicList = artService.musicRead(1);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
		model.addAttribute("team_name", team_name);
//		System.out.println("ArtController, artVo : " + artVo);
//		System.out.println("ArtController, musicList : " + musicList);
	}
	
	// 앨범정보 수정 폼
	@RequestMapping(value="/art_modify", method=RequestMethod.GET)
	public void ArtModify(HttpSession session, Model model) throws Exception {
		String user_id = "indie1";
		String team_name = "인디1";
		ArtInfoVo artVo = artService.artRead(user_id, 1);
		List<MusicInfoVo> musicList = artService.musicRead(1);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
		model.addAttribute("team_name", team_name);
		
	}
	
	// 앨범리스트 폼
	@RequestMapping(value="/art_list", method=RequestMethod.GET)
	public void ArtList(HttpSession session, Model model) throws Exception {
		List<ArtInfoVo> artList = artService.allArtList();
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		model.addAttribute("artList", artList);
		model.addAttribute("teamList", teamList);
//		System.out.println("ArtController, ArtList 실행됨");
//		System.out.println("ArtController, ArtList, teamList" + teamList);
		
	}
	
	// 앨범정보 입력폼
	@RequestMapping(value="/art_info_input", method=RequestMethod.GET)
	public void ArtInfoInput() {
//		System.out.println("ArtInfoInput()");
	}
	// 앨범정보 처리
	@RequestMapping(value="/art_info_input", method=RequestMethod.POST)
	public String registPost(ArtInfoVo artVo,@RequestParam("file")MultipartFile file ,HttpSession session) throws Exception {
		artVo.setUser_id("indie1");
		artVo.setTeam_number(1);
		artService.insert(artVo);
		String originalName = file.getOriginalFilename();
		try {
			FileUploadUtil.uploadFile(uploadPath, originalName,artVo, file.getBytes());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:/art/art_info_input";
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
