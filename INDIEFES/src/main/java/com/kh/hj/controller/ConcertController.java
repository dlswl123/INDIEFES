package com.kh.hj.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hj.domain.ConcertInfoVo;
import com.kh.hj.service.IConcertService;
import com.kh.hj.util.FileUploadUtil;
import com.kh.ks.domain.UserInfoVo;
//import com.kh.util.FileUploadUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "concert/*")
public class ConcertController {
	
	@Inject
	private IConcertService service;
	
	@Resource(name="uploadPath")
	private String uploadPath;	// servlet-context.xml (id="uploadPath")
	
	
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public void concertInfo(Model model, HttpSession session) throws Exception {
		// move to /concert/info.jsp
		List<ConcertInfoVo> list = service.getConcertInfoList();
		
		UserInfoVo vo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (vo != null) {
			int user_level = vo.getUser_level();
			model.addAttribute("user_level", user_level);
		}
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String concertInfoWrite(Model model, HttpSession session) throws Exception {
		// move to /concert/write.jsp
		// if not have userInfo, return to loginForm
		UserInfoVo userInfoVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userInfoVo == null) {
			return "/user/login";
		}
		return "/concert/write";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String concertInfoWriteRun(ConcertInfoVo vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		// get user_id by session
		UserInfoVo userInfoVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userInfoVo != null) {
			String user_id = userInfoVo.getUser_id();
			vo.setUser_id(user_id);
		} else {
			return "redirect:/user/login";
		}
		// Read ConcertInfoVo
		System.out.println("writevo : " + vo.toString());

		// insert into DBtable ConcertInfoVo information
		service.insertConcertInfo(vo);
		
		rttr.addFlashAttribute("resultMessage", "insert_success");
		
		// move to /concert/info.jsp
		return "redirect:/concert/info";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void concertInfoRead(@RequestParam("concert_number")int concert_number, HttpSession session, Model model) throws Exception {
		ConcertInfoVo vo = service.getConcertInfo(concert_number);
		List<String> list = service.getConcertInfoFiles(concert_number);
		UserInfoVo userInfoVo = (UserInfoVo)session.getAttribute("userInfoVo");
		if (userInfoVo != null) {
			String user_id = userInfoVo.getUser_id();
			model.addAttribute("user_id", user_id);
		}
		model.addAttribute("vo", vo);
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String concertInfoDelete(@RequestParam("concert_number")int concert_number) throws Exception {
		service.deleteConcertInfo(concert_number);
		return "redirect:/concert/info";
	}
	
	@RequestMapping(value="/uploadAjax", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<ConcertInfoVo> uploadAjax(/* MultipartFile file */ MultipartHttpServletRequest mhsr) throws Exception {
		// file upload method
		// get only img files
		
		
		ResponseEntity<ConcertInfoVo> entity = null;
		ConcertInfoVo vo = new ConcertInfoVo();
		List<String> list = new ArrayList<>();
		
		Iterator<String> files = mhsr.getFileNames();
			
		String concertDate = mhsr.getParameter("concertDate"); // 공연 일자 YYYY/MM 형식으로 받아옴
		System.out.println("concertDate : " + concertDate);
		
		MultipartFile file = mhsr.getFile("infoFile"); // 키 값에 따른 파일 가져오기
		System.out.println("file : " + file);
		if (file != null) {
			String originalName = file.getOriginalFilename(); // 파일명 얻기
			System.out.println("originalName : " + originalName);
			
			String infoFilePath = FileUploadUtil.uploadFile(uploadPath, originalName, concertDate, file.getBytes());
			String infoPath = infoFilePath.replace("\\", "/");
			
			vo.setInfo_file_path(infoPath);
		}
		
		while (files.hasNext()) { //파일을 하나씩 불러온다.
		 
			MultipartFile mpf = mhsr.getFile(files.next());	// 파일 가져오기
			if(mpf == file) { // infoFile 인 경우 그냥 건너뛰기
				continue;
			}
			System.out.println("multipartFile : " + mpf);
	 
	        String originalFileName = mpf.getOriginalFilename(); //파일명
	        
			String posterFilePath = FileUploadUtil.uploadFile(uploadPath, originalFileName, concertDate, mpf.getBytes());
			String posterPath = posterFilePath.replace("\\", "/");
	
	        System.out.println("fileFullPath : " + posterPath);
	        
	        list.add(posterPath);
		}
		
		if (!list.isEmpty()) {
			String[] str = new String[list.size()]; // 이름 변경한 리스트를 배열로 넣기
			for (int i = 0; i < list.size(); i++) {
				str[i] = list.get(i);
			}
			
			if (str != null) {
				vo.setFile_path(str);
			}
		}
		
		System.out.println("vo : " + vo);
		
		try {
			entity = new ResponseEntity<>(vo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	@RequestMapping(value="/displayFile")
	public ResponseEntity<byte[]> displayFile(@RequestParam("fileName") String fileName) throws Exception {
//		System.out.println("fileName : " + fileName);
		// /2019/5/17/39a2dea2-1385-4016-a8b4-326b2d26c5af_Jellyfish.jpg
		String realPath = uploadPath + File.separator + fileName;
		
		// 파일의 확장자 얻기
		String formatName = FileUploadUtil.getFormatName(fileName).toUpperCase();
		
		MediaType mediaType = null;
		
		if (formatName.equals("JPG")) {
			mediaType = MediaType.IMAGE_JPEG;	// image/jpeg
		} else if (formatName.equals("PNG")) {
			mediaType = MediaType.IMAGE_PNG;	// image/png
		} else if (formatName.equals("GIF")) {
			mediaType = MediaType.IMAGE_GIF;	// image/gif
		} else {
			mediaType = MediaType.ALL; // ALL
		}

		InputStream is = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			HttpHeaders headers = new HttpHeaders();
			// 이미지인지 확인
			boolean isImage = FileUploadUtil.isImage(formatName);
			
			if (isImage) {
				headers.setContentType(mediaType);
			} else {
				int underScoreIndex = fileName.lastIndexOf("_");
				String downloadName = fileName.substring(underScoreIndex + 1);
				// 8비트 데이터임을 명시
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-disposition", "attachment; filename=" + downloadName);
			}
			
			is = new FileInputStream(realPath);
			// 서버에 보내는 데이터가 바이너리 데이터(byte[])임을 설정
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
