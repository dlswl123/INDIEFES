package com.kh.jij.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.service.IArtInfoService;

@Controller
@RequestMapping("music/*")
public class MusicController {

	@Inject
	IArtInfoService artService;
	
	@RequestMapping(value="/list/{art_number}")
	public ResponseEntity<List<MusicInfoVo>> MusicTrackList(@PathVariable("art_number") int art_number) throws Exception  {
		ResponseEntity<List<MusicInfoVo>> entity = null;
		try {
			List<MusicInfoVo> list = artService.musicRead(art_number);
			entity = new ResponseEntity<List<MusicInfoVo>>(list, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<MusicInfoVo>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
}
