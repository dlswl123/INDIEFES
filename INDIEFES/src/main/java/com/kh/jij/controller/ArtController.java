package com.kh.jij.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.GoodLogVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.LikeLogVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.persistence.IMusicInfoDao;
import com.kh.jij.domain.PayLogVo;
import com.kh.jij.service.IArtInfoService;
import com.kh.jij.util.FileUploadUtil;
import com.kh.ks.domain.UserInfoVo;
import com.kh.ts.domain.PaginationDto;
import com.kh.ts.domain.PagingDto;

@Controller
@RequestMapping("art/*")
public class ArtController {

	@Inject
	IArtInfoService artService;
	
	@Inject
	IMusicInfoDao musicService;
	
	@Resource(name = "uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")

	// 앨범정보조회 폼
	@RequestMapping(value = "/art_info/{art_number}/{team_number}")
	public String artInfo(@PathVariable("art_number") int art_number, @PathVariable("team_number") int team_number, Model model, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		UserInfoVo userVo = (UserInfoVo) session.getAttribute("userInfoVo");
		String url = "";
		
		if (userVo != null) {
			ArtInfoVo artVo = artService.artRead(art_number);
			List<MusicInfoVo> musicList = musicService.musicRead(art_number);
			String nowPage = "art_info";
			String user_id = userVo.getUser_id();
			LikeLogVo likeVo = new LikeLogVo();
			likeVo.setUser_id(user_id);
			likeVo.setArt_number(art_number);
			GoodLogVo goodVo = new GoodLogVo();
			goodVo.setUser_id(user_id);
			goodVo.setArt_number(art_number);
			List<LikeLogVo> likedCount = artService.artLikedCheckById(likeVo, nowPage);
			List<GoodLogVo> goodCount = artService.artGoodCheckById(goodVo, nowPage);
			String teamName = artService.getTeamName(team_number);
			List<PayLogVo> payList = artService.payList(user_id);
			model.addAttribute("likedCount", likedCount);
			model.addAttribute("goodCount", goodCount);
			model.addAttribute("teamName", teamName);
			model.addAttribute("payList", payList);
			model.addAttribute("userVo", userVo);
			model.addAttribute("artVo", artVo);
			model.addAttribute("musicList", musicList);
	//		System.out.println("ArtController, artVo : " + artVo);
	//		System.out.println("ArtController, musicList : " + musicList);
	//		System.out.println("artController, art_info, payList" + payList);
			url = "art/art_info";
		} else {
			rttr.addFlashAttribute("message", "login_check");
			url = "redirect:/art/art_list";
		}
		return url;
	}

//	 앨범정보 수정 폼
	@RequestMapping(value = "/art_modify", method = RequestMethod.GET)
	public String artModify(@RequestParam("art_number") int art_number, @RequestParam("team_number") int team_number, HttpSession session, Model model) throws Exception {
//		System.out.println(art_number);
		UserInfoVo userVo = (UserInfoVo) session.getAttribute("userInfoVo");
		String url = "";
		if (userVo != null) {
			String user_id = userVo.getUser_id();
//			String user_id = "indie1";
//			System.out.println("ArtController, art_modify, userVo:" + userVo);
//			System.out.println("ArtController, art_modify, teamName:" + teamName);
			ArtInfoVo artVo = artService.artModifyForm(user_id, art_number);
			List<MusicInfoVo> musicList = musicService.musicRead(art_number);
			int track_number = musicService.getMaxTrackNum(art_number);
			model.addAttribute("artVo", artVo);
			model.addAttribute("musicList", musicList);
			model.addAttribute("userVo", userVo);
			model.addAttribute("track_number", track_number);
			url = "/art/art_modify";
		} else {
			url = "redirect:/art/art_info/" + art_number + "/" + art_number;
		}
		return url;
	}
	
	// 앨범 수정
	@RequestMapping(value = "/art_modify", method = RequestMethod.POST)
	public String artModify(ArtInfoVo artVo, @RequestParam("file") MultipartFile file, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		artVo.setUser_id(userVo.getUser_id());
		System.out.println("ArtController, ArtModify, artVo:" + artVo);
		artService.artModify(artVo);
		// 파일 업로드(@RequestParam("file")MultipartFile file)
		String originalName = file.getOriginalFilename();
		try {
			FileUploadUtil.artUploadFile(uploadPath, originalName, artVo, file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/art/art_info/" + artVo.getArt_number() + "/" + artVo.getTeam_number();
	}
	
	// 앨범 삭제
	@RequestMapping(value="/art_delete/{art_number}", method = RequestMethod.GET)
	public String artDelete(@PathVariable("art_number") int art_number, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		artService.artDelete(art_number, user_id);
		return "redirect:/art/art_list?page=1&searchType=working&keyword=0";
	}

	// 앨범리스트 폼
	@RequestMapping(value = "/art_list", method = RequestMethod.GET)
	public void artList(PagingDto pagingDto, Model model, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo) session.getAttribute("userInfoVo");
//		System.out.println(pagingDto);
		pagingDto.setPerPage(24);
		List<ArtInfoVo> artList = artService.allArtList(pagingDto);
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		
//		System.out.println("ArtController, ArtList, artList:" + artList);
//		System.out.println("ArtController, ArtList, teamList:" + teamList);
		PaginationDto paginationDto = new PaginationDto();
		paginationDto.setPagingDto(pagingDto);
//		System.out.println("리스트:"+paginationDto);
		int artCount = artService.artCount(pagingDto);
		paginationDto.setTotalCount(artCount);
		if (userVo != null) {
			String nowPage = "art_list";
			String user_id = userVo.getUser_id();
			LikeLogVo likeVo = new LikeLogVo();
			likeVo.setUser_id(user_id);
			List<LikeLogVo> likeCount = artService.artLikedCheckById(likeVo, nowPage);
			GoodLogVo goodVo = new GoodLogVo();
			goodVo.setUser_id(user_id);
			List<GoodLogVo> goodCount = artService.artGoodCheckById(goodVo, nowPage);
			model.addAttribute("likeCount", likeCount);
			model.addAttribute("goodCount", goodCount);
//			System.out.println("artController, likeCount" + likeCount);
		}
		model.addAttribute("artList", artList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("paginationDto", paginationDto);
		model.addAttribute("userVo", userVo);
	}
	
	// 앨범 이미지 가져오기
	@RequestMapping(value = "/getCover", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getCover(@RequestParam("artCover") String artCover, @RequestParam("team_number") int team_number,@RequestParam("art_number") int art_number) throws Exception {
		String album = "album";
		String realPath = uploadPath + File.separator + album + File.separator + team_number + File.separator + art_number + File.separator + artCover;
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
			realPath = uploadPath + File.separator + album + File.separator + team_number + File.separator + art_number + File.separator + artCover;

			FileInputStream is = new FileInputStream(realPath);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
//		System.out.println("realPath:"+realPath);
		return entity;
	}

	// 앨범정보 입력폼
	@RequestMapping(value = "/art_info_input", method = RequestMethod.GET)
	public String artInfoInput(HttpSession session) {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userVo == null) {
			return "/user/login";
		}
		return null;
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
		artVo = artService.artInfo(artVo.getTeam_number());
		// 파일 업로드(@RequestParam("file")MultipartFile file)
		String originalName = file.getOriginalFilename();
		try {
			FileUploadUtil.artUploadFile(uploadPath, originalName, artVo, file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/art/art_info_input";
	}

	// 팀생성 및 가입 폼
	@RequestMapping(value = "/indie_team_input", method = RequestMethod.GET)
	public String teamInput(HttpSession session) {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userVo == null) {
			return "/user/login";
		}
		return null;
	}

	// 팀생성처리
	@RequestMapping(value = "/indie_team_input", method = RequestMethod.POST)
	public String teamInfoInput(IndieTeamVo teamVo, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("teamVo", teamVo);
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		map.put("user_id", userVo.getUser_id());
		map.put("user_nick", userVo.getUser_nick());
		artService.teamInsert(map);
		// 팀가입 여부
		try {
			int indieNum = artService.getIndieNumber(userVo.getUser_id());
			session.setAttribute("indieNum", indieNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}

	// 팀가입 처리
	@RequestMapping(value = "/team_member_input", method = RequestMethod.GET)
	public String memberInfoInput(TeamMemberVo memberVo, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		memberVo.setUser_id(userVo.getUser_id());
		memberVo.setUser_nick(userVo.getUser_nick());
		artService.teamInput(memberVo);
		// 팀가입 여부
		try {
			int indieNum = artService.getIndieNumber(userVo.getUser_id());
			session.setAttribute("indieNum", indieNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	// 팀정보
	@RequestMapping(value = "/indie_team_info", method = RequestMethod.GET)
	public String teamInfo(HttpSession session,Model model,int team_number) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userVo == null) {
			return "/user/login";
		}
		List<TeamMemberVo> memberList = artService.teamInfo(team_number);
		String teamName = artService.getTeamName(team_number);
		List<ArtInfoVo> teamArtList = artService.teamArtList(team_number);
		model.addAttribute("memberList", memberList);
		model.addAttribute("teamName", teamName);
		model.addAttribute("teamArtList", teamArtList);
		model.addAttribute("userVo", userVo);
		return null;
	}
	// 팀정보
//	@RequestMapping(value = "/home_art_list", method = RequestMethod.GET)
//	public void HomeArtList(PagingDto pagingDto,Model model) throws Exception {
//		List<ArtInfoVo> artList = artService.allArtList(pagingDto);
//		List<IndieTeamVo> teamList = artService.getIndieTeam();
//		model.addAttribute("artList", artList);
//		model.addAttribute("teamList", teamList);
//	}
	// 카트담기
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String CartInput(HttpSession session,ArtInfoVo artVo,int music_number, String music_title) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		int team_number = artVo.getTeam_number();
		int art_number = artVo.getArt_number();
		PayLogVo vo = new PayLogVo();
		vo.setUser_id(user_id);
		vo.setMusic_number(music_number);
		vo.setMusic_title(music_title);
//		System.out.println(vo);
		artService.cartInput(vo);
		
		return "redirect:/art/art_info/"+art_number+"/"+team_number;
	}	
	
	@RequestMapping(value = "/cartAll", method = RequestMethod.POST)
	public ResponseEntity<String> CartAllInput(HttpSession session) throws Exception {
		ResponseEntity<String> entity = null;
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		try {
//			String user_id = userVo.getUser_id();
//			int team_number = artVo.getTeam_number();
//			int art_number = artVo.getArt_number();
//			List<PayLogVo> payList = artService.payList(user_id);
//			for (int i = 0; i < musicList.size(); i++) {
				
//			}
			
//			System.out.println(musicList);
//			PayLogVo vo = new PayLogVo();
//			vo.setUser_id(user_id);
//			vo.setMusic_number(music_number);
//			vo.setMusic_title(music_title);
//			System.out.println(vo);
//			artService.cartInput(vo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}	
	
	
	
	
	// 승인요청 -> 인디팀 
	@RequestMapping(value="/artUploadApproReq/{art_number}", method = RequestMethod.GET)
	public String artUploadApproReq(@PathVariable("art_number") int art_number, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		int team_number = artService.getIndieNumber(user_id);
		if (userVo != null) {
			artService.artUploadApproReq(art_number, user_id, team_number);
//			musicService.musicUploadApproReq(art_number, team_number);
		}
		return "redirect:/art/art_list?page=1&searchType=working&keyword=0";
	}
	
	// 요청 승인 -> 관리자
	@RequestMapping(value="/artUploadAppro/{art_number}", method = RequestMethod.GET)
	public String artUploadAppro(@PathVariable("art_number") int art_number, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
//		System.out.println("artController, artUploadAppro, userVo:" + userVo);
		String url = "";
		if (userVo != null) {
			artService.artUploadAppro(art_number);
//			musicService.musicUploadAppro(art_number);
			url = "redirect:/art/art_list?page=1&searchType=appro&keyword=2";
		} else {
			url = "redirect:/art/art_list";
		}
		return url;
	}
	
//	요청 반려 -> 관리자
	@RequestMapping(value="/artUploadReturn/{art_number}", method = RequestMethod.GET)
	public String artUploadReturn(@PathVariable("art_number") int art_number, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
//		System.out.println("artController, artUploadReturn, userVo:" + userVo);
		String url = "";
		if (userVo != null) {
			artService.artUploadReturn(art_number);
//			musicService.musicUploadAppro(art_number);
			url = "redirect:/art/art_list?page=1&searchType=appro&keyword=2";
		} else {
			url = "redirect:/art/art_list";
		}
		return url;
	}
	
	// 결제 페이지
	@RequestMapping(value = "/pay_info", method = RequestMethod.GET)
	public String payInfo(HttpSession session,Model model) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userVo == null) {
			return "/user/login";
		}
		String user_id = userVo.getUser_id();
		List<PayLogVo> payList = artService.payList(user_id);
		model.addAttribute("userVo", userVo);
		model.addAttribute("payList", payList);
//		System.out.println("payList: "+payList);
		return null;
	}
	// 결제 처리
	@RequestMapping(value = "/pay_ok", method = RequestMethod.GET)
	public String payOk(HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		artService.payOk(user_id);
		return "redirect:/art/pay_info";
	}
	// 결제 목록 삭제
	@RequestMapping(value = "/payDelete", method = RequestMethod.GET)
	public String payDelete(HttpSession session,int music_number) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userVo.getUser_id();
		PayLogVo payVo = new PayLogVo();
		payVo.setUser_id(user_id);
		payVo.setMusic_number(music_number);
		artService.payDelete(payVo);
		return "redirect:/art/pay_info";
	}
	
	// 좋아요 체크
	@RequestMapping(value="/likedChange", method = RequestMethod.GET)
	public ResponseEntity<String> likeChange(LikeLogVo likeVo, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		ResponseEntity<String> entity = null;
		try {
			if (userVo != null) {
				String user_id = userVo.getUser_id();
				String nowPage = "art_info";
				likeVo.setUser_id(user_id);
				List<LikeLogVo> likeCountList = artService.artLikedCheckById(likeVo, nowPage);
				int likedCount = artService.artLikedCountCheck(likeVo.getArt_number());
//				System.out.println("likeCountList:" + likeCountList);
//				System.out.println("likedCount:" + likedCount);
				boolean check = likeCountList.isEmpty();
				if (likeCountList != null && check == false) {
					artService.artLikedDelete(likeVo);
					likedCount = likedCount - 1;
					artService.artLikedCount(likedCount, likeVo.getArt_number());
					entity = new ResponseEntity<String>("likeDelete", HttpStatus.OK);
				} else {
					artService.artLikedInsert(likeVo);
					likedCount = likedCount + 1;
					artService.artLikedCount(likedCount,  likeVo.getArt_number());
					entity = new ResponseEntity<String>("likeInsert", HttpStatus.OK);
				}	
//				System.out.println("likeVo:" + likeVo);
			} else {
				entity = new ResponseEntity<String>("login_check", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/goodChange", method = RequestMethod.GET)
	// 추천수 체크
	public ResponseEntity<String> goodChange(GoodLogVo goodVo, HttpSession session) throws Exception {
		UserInfoVo userVo = (UserInfoVo)session.getAttribute("userInfoVo");
		ResponseEntity<String> entity = null;
		try {
			if (userVo != null) {
				String user_id = userVo.getUser_id();
				goodVo.setUser_id(user_id);
				String nowPage = "art_info";
				List<GoodLogVo> goodCountList = artService.artGoodCheckById(goodVo, nowPage);
				int goodCount = artService.artGoodCountCheck(goodVo.getArt_number());
//				System.out.println("goodVo:" + goodVo);
//				System.out.println("goodCountList:" + goodCountList);
//				System.out.println("goodCount:" + goodCount);
				boolean check = goodCountList.isEmpty();
				if (goodCountList != null && check == false) {
					artService.artGoodDelete(goodVo);
					goodCount = goodCount - 1;
					artService.artGoodCount(goodCount, goodVo.getArt_number());
					entity = new ResponseEntity<String>("goodDelete", HttpStatus.OK);
				} else {
					artService.artGoodInsert(goodVo);
					goodCount = goodCount + 1;
					artService.artGoodCount(goodCount,  goodVo.getArt_number());
					entity = new ResponseEntity<String>("goodInsert", HttpStatus.OK);
				}
			} else {
				entity = new ResponseEntity<String>("login_check", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}
