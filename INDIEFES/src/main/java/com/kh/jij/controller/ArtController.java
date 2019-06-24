package com.kh.jij.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.service.IArtInfoService;
import com.kh.jij.util.FileUploadUtil;
import com.kh.ks.domain.UserInfoVo;

@Controller
@RequestMapping("art/*")
public class ArtController {

	@Inject
	IArtInfoService artService;
	@Resource(name = "uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")

	// 앨범정보조회 폼
	@RequestMapping(value = "/art_info", method = RequestMethod.GET)
	public void ArtInfo(@RequestParam("art_number") int art_number, @RequestParam("team_number") int team_number, HttpSession session, Model model) throws Exception {
//		UserVo userVo = session.getAttribute("userVo");
//		System.out.println(art_number);
		String teamName = artService.getTeamName(team_number);
		ArtInfoVo artVo = artService.artRead(art_number);
		List<MusicInfoVo> musicList = artService.musicRead(art_number);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
		model.addAttribute("teamName", teamName);
//		System.out.println("ArtController, artVo : " + artVo);
//		System.out.println("ArtController, musicList : " + musicList);
	}

//	 앨범정보 수정 폼
	@RequestMapping(value = "/art_modify", method = RequestMethod.GET)
	public void ArtModify(@RequestParam("art_number") int art_number, HttpSession session, Model model)
			throws Exception {
		System.out.println(art_number);
		String user_id = "indie1";
		String team_name = "인디1";
		ArtInfoVo artVo = artService.artModify(user_id, art_number);
		List<MusicInfoVo> musicList = artService.musicRead(art_number);
		model.addAttribute("artVo", artVo);
		model.addAttribute("musicList", musicList);
		model.addAttribute("team_name", team_name);

	}

	// 앨범리스트 폼
	@RequestMapping(value = "/art_list", method = RequestMethod.GET)
	public void ArtList(HttpSession session, Model model) throws Exception {
		List<ArtInfoVo> artList = artService.allArtList();
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		model.addAttribute("artList", artList);
		model.addAttribute("teamList", teamList);
		System.out.println("ArtController, ArtList 실행됨");
		System.out.println("ArtController, ArtList, teamList" + teamList);

	}

	// 앨범 이미지 가져오기
	@RequestMapping(value = "/getCover", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getCover(@RequestParam("artCover") String artCover, @RequestParam("team_number") int team_number, HttpSession session) throws Exception {
//		System.out.println("fileName:" + fileName);
		// -> /2019/5/17/58d2f428-feb3-4c57-9d67-350dd294b25e_Chrysanthemum.jpg
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String realPath = uploadPath + File.separator + team_number + File.separator + "0" + File.separator + artCover;
		// -> H:/upload/2019/5/17/58d2f428-feb3-4c57-9d67-350dd294b25e_Chrysanthemum.jpg
		System.out.println("ArtController, getArtCober, realPath" + realPath);
		// 파일의 확장자 얻기
//		int dotIndex = fileName.lastIndexOf(".");
//		String extName = fileName.substring(dotIndex + 1).toUpperCase();
		String formatName = FileUploadUtil.getFormatName(artCover).toUpperCase();

		MediaType mediaType = null;
		if (formatName.equals("JPG")) {
			mediaType = MediaType.IMAGE_JPEG; // image/jpeg
		} else if (formatName.equals("PNG")) {
			mediaType = MediaType.IMAGE_PNG; // image/png
		} else if (formatName.equals("GIF")) {
			mediaType = MediaType.IMAGE_GIF; // image/gif
		}

		ResponseEntity<byte[]> entity = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			boolean isImage = FileUploadUtil.isImage(formatName);

			if (isImage == true) {
				headers.setContentType(mediaType); // mime type 설정 : image/jpg
			} else {
				int underscoreIndex = artCover.lastIndexOf("_");
				String downloadName = artCover.substring(underscoreIndex + 1);
				// 8비트 데이터임을 명시
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-disposition", "attachment; filename=" + downloadName);
			}
			realPath = uploadPath + File.separator + team_number + File.separator + "0" + File.separator + artCover;

			FileInputStream is = new FileInputStream(realPath);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		return entity;
	}

	// 앨범정보 입력폼
	@RequestMapping(value = "/art_info_input", method = RequestMethod.GET)
	public void ArtInfoInput() {
//		System.out.println("ArtInfoInput()");
	}

	// 앨범정보 처리
	@RequestMapping(value = "/art_info_input", method = RequestMethod.POST)
	public String registPost(ArtInfoVo artVo, @RequestParam("file") MultipartFile file, HttpSession session)
			throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		artVo.setUser_id(userVo.getUser_id());
		int indieNum = artService.getIndieNumber(userVo.getUser_id());
		artVo.setTeam_number(indieNum);
		artService.insert(artVo);
		String originalName = file.getOriginalFilename();
		try {
			FileUploadUtil.uploadFile(uploadPath, originalName, artVo, file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/art/art_info_input";
	}

	// 팀생성 및 가입 폼
	@RequestMapping(value = "/indie_team_input", method = RequestMethod.GET)
	public void TeamInfo() {
		System.out.println("TeamInput()");
	}

	// 팀생성처리
	@RequestMapping(value = "/indie_team_input", method = RequestMethod.POST)
	public String TeamInfoInput(IndieTeamVo teamVo, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("teamVo", teamVo);
		map.put("user_id", "indie1");
		artService.teamInsert(map);
		return "redirect:/art/indie_team_input";
	}

	// 팀가입 처리
	@RequestMapping(value = "/team_member_input", method = RequestMethod.GET)
	public String memberInfoInput(TeamMemberVo memberVo, HttpSession session) throws Exception {
		memberVo.setUser_id("indie2");
		artService.teamInput(memberVo);
		return "redirect:/art/indie_team_input";
	}

}
