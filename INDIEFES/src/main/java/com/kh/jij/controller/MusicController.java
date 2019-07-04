package com.kh.jij.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.MusicLyricsVo;
import com.kh.jij.persistence.IMusicInfoDao;
import com.kh.jij.service.IArtInfoService;
import com.kh.jij.util.FileUploadUtil;
import com.kh.ks.domain.UserInfoVo;

@Controller
@RequestMapping("music/*")
public class MusicController {

	@Inject
	IMusicInfoDao musicService;

	@Inject
	IArtInfoService artService;

	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// 음악목록 가져오기
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<List<MusicInfoVo>> MusicTrackList(@RequestParam("art_number") int art_number,
			@RequestParam("team_number") int team_number) throws Exception {
		ResponseEntity<List<MusicInfoVo>> entity = null;
		try {
			List<MusicInfoVo> list = musicService.musicRead(art_number);
			
			entity = new ResponseEntity<List<MusicInfoVo>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<MusicInfoVo>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 음악 추가하기
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ResponseEntity<String> insert(MusicInfoVo musicInfoVo, @RequestParam("file_path") MultipartFile file) throws Exception {
		System.out.println("MusicController, insert, musicInfoVo:" + musicInfoVo);
		ResponseEntity<String> entity = null;
		try {
			musicService.musicInsert(musicInfoVo);
			String originalName = file.getOriginalFilename();
			try {
				FileUploadUtil.uploadFile(uploadPath, originalName, musicInfoVo, file.getBytes());
			} catch (Exception e) {
				e.printStackTrace();
			}
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 음악 수정하기
	@RequestMapping(value = "/update/{music_number}", method = RequestMethod.PUT)
	public ResponseEntity<String> update(@PathVariable("music_number") int music_number, @RequestBody MusicInfoVo musicInfoVo, HttpSession session) throws Exception {
		musicInfoVo.setMusic_number(music_number);
		ResponseEntity<String> entity = null;
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		int team_number = artService.getIndieNumber(user_id);
		musicInfoVo.setTeam_number(team_number);
//		System.out.println(musicInfoVo);
//		System.out.println(team_number);
//		if (userVo != null) {
			try {
				musicService.musicUpdate(musicInfoVo);
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			}
//		}
		return entity;
	}

//	삭제하기
	@RequestMapping(value = "/delete/{art_number}/{music_number}/{team_number}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("art_number") int art_number,
			@PathVariable("music_number") int music_number, @PathVariable("team_number") int team_number)
			throws Exception {
		ResponseEntity<String> entity = null;
		try {
			MusicInfoVo musicInfoVo = new MusicInfoVo();
			musicInfoVo.setArt_number(art_number);
			musicInfoVo.setMusic_number(music_number);
			musicInfoVo.setTeam_number(team_number);
			musicService.musicDelete(musicInfoVo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 가사입력하기
	@RequestMapping(value = "/lyrics", method = RequestMethod.POST)
	public ResponseEntity<String> musicLyrics(@RequestBody MusicLyricsVo musicLyricsVo) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			musicService.musicLyrics(musicLyricsVo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 가사찾기
	@RequestMapping(value="/getLyrics/{music_number}", method = RequestMethod.GET, produces="application/text;charset=utf-8")
	public ResponseEntity<String> getLyrics(@PathVariable("music_number") int music_number) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			String lyrics = musicService.getLyrics(music_number);
			System.out.println(lyrics);
			entity = new ResponseEntity<String>(lyrics, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 가사수정
	@RequestMapping(value="/updateLyrics/{music_number}", method = RequestMethod.PUT)
	public ResponseEntity<String> updateLyrics(@PathVariable("music_number") int music_number, @RequestBody MusicLyricsVo musicLyricsVo) throws Exception {
		ResponseEntity<String> entity = null;
		try {
			System.out.println(musicLyricsVo);
			musicService.updateLyrics(musicLyricsVo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}