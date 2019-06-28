package com.kh.jij.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.persistence.IMusicInfoDao;
import com.kh.jij.service.IArtInfoService;

@Controller
@RequestMapping("music/*")
public class MusicController {

	@Inject
	IMusicInfoDao musicService;
	
	@Inject
	IArtInfoService artService;
	
	
	// 음악목록 가져오기
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public ResponseEntity<List<MusicInfoVo>> MusicTrackList(@RequestParam("art_number") int art_number, @RequestParam("team_number") int team_number,Model model) throws Exception  {
		ResponseEntity<List<MusicInfoVo>> entity = null;
		try {
			String teamName = artService.getTeamName(team_number);
			List<MusicInfoVo> list = musicService.musicRead(art_number);
			model.addAttribute("teamName", teamName);
			entity = new ResponseEntity<List<MusicInfoVo>>(list, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<MusicInfoVo>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 음악 추가하기
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> insert(@RequestBody MusicInfoVo musicInfoVo) throws Exception {
		System.out.println("MusicController, insert, musicInfoVo:" + musicInfoVo);
		ResponseEntity<String> entity = null;
		try {
			musicService.musicInsert(musicInfoVo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}