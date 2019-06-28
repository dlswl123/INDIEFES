package com.kh.jij.controller;


import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.service.IArtInfoService;
import com.kh.jij.util.FileUploadUtil;
import com.kh.ks.domain.UserInfoVo;

@Controller
@RequestMapping("player/*")
public class PlayerController {
	
	@Inject
	IArtInfoService artService;
	@Resource(name = "uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")
	
	@RequestMapping(value="/player", method=RequestMethod.GET)
	public void Player(HttpSession session,Model model) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		List<MusicInfoVo> playList = artService.playList(userVo.getUser_id());
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		for(MusicInfoVo vo1:playList) {
			for(IndieTeamVo vo2:teamList) {
				if(vo1.getTeam_number()==vo2.getTeam_number()) {
					vo1.setTeam_name(vo2.getArt_team());
//					String filePath = uploadPath+File.separator+"album"+File.separator+vo1.getTeam_number()+File.separator+vo1.getArt_number()+File.separator+vo1.getFile_path();
//					vo1.setFile_path(filePath);
				}
			}
		}
		model.addAttribute("playList", playList);
		model.addAttribute("uploadPath", uploadPath);
//		System.out.println("playList:"+playList);
	}

	@RequestMapping(value = "/Song", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getCover(@RequestParam("file_path") String filePath, @RequestParam("team_number") int team_number,@RequestParam("art_number") int art_number) throws Exception {
		String album = "album";
		String realPath = uploadPath + File.separator + album + File.separator + team_number + File.separator + art_number + File.separator + filePath;
		String formatName = FileUploadUtil.getFormatName(filePath).toUpperCase();
		MediaType mediaType = null;
		if (formatName.equals("MP3")) {
			mediaType = new MediaType("audio", "mp3");
		} 

		ResponseEntity<byte[]> entity = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mediaType); // mime type 설정 : audio/mp3
			realPath = uploadPath + File.separator + album + File.separator + team_number + File.separator + art_number + File.separator + filePath;
			FileInputStream is = new FileInputStream(realPath);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
//		System.out.println("realPath:"+realPath);
		return entity;
	}
	@RequestMapping(value="/playList", method=RequestMethod.GET)
	public void listUp() {
		
	}
	
}
