package com.kh.hj.controller;


import java.io.FileInputStream;
import java.io.InputStream;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.hj.domain.ConcertInfoVo;
import com.kh.hj.service.IConcertService;
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
	public void concertInfo(Model model) throws Exception {
		// move to /concert/info.jsp
		
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void concertInfoWrite(Model model) throws Exception {
		// move to /concert/write.jsp
		
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String concertInfoWriteRun(ConcertInfoVo vo, RedirectAttributes rttr, HttpSession session) throws Exception {

		// get user_id by session
		UserInfoVo userInfoVo = (UserInfoVo)session.getAttribute("userInfoVo");
		String user_id = userInfoVo.getUser_id();
		vo.setUser_id(user_id);
		
		// Read ConcertInfoVo
		System.out.println("vo : " + vo.toString());
		
		// insert into DBtable ConcertInfoVo information
		service.insertConcertInfo(vo);
		
		rttr.addFlashAttribute("resultMessage", "insert_success");
		
		// move to /concert/info.jsp
		return "redirect:/concert/info";
	}
	
//	@RequestMapping(value="/uploadAjax", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
//	@ResponseBody
//	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
//		// file upload method
//		// get only img files
//		String originalName = file.getOriginalFilename();
//		
//		ResponseEntity<String> entity = null;
//		
//		try {
//			String dirPath = FileUploadUtil.uploadFile(uploadPath, originalName, file.getBytes());
//			String path = dirPath.replace("\\", "/");
//			entity = new ResponseEntity<>(path, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
//		}
//		
//		return entity;
//	}
	
	
//	@RequestMapping(value="/displayFile")
//	public ResponseEntity<byte[]> displayFile(@RequestParam("fileName") String fileName) throws Exception {
////		System.out.println("fileName : " + fileName);
//		// /2019/5/17/39a2dea2-1385-4016-a8b4-326b2d26c5af_Jellyfish.jpg
//		String realPath = uploadPath + fileName;
//		
//		// 파일의 확장자 얻기
//		String formatName = FileUploadUtil.getFormatName(fileName).toUpperCase();
//		
//
//		
//		// 이미지이면 섬네일 경로 출력
////		if (isImage) {
////			int slashIndex = realPath.lastIndexOf("/");
////			String front = realPath.substring(0, slashIndex + 1);
////			String rear = realPath.substring(slashIndex + 1);
////			realPath = front + "s_" + rear;
////		}
//		
//		MediaType mediaType = null;
//		
//		if (formatName.equals("JPG")) {
//			mediaType = MediaType.IMAGE_JPEG;	// image/jpeg
//		} else if (formatName.equals("PNG")) {
//			mediaType = MediaType.IMAGE_PNG;	// image/png
//		} else if (formatName.equals("GIF")) {
//			mediaType = MediaType.IMAGE_GIF;	// image/gif
//		} else {
//			
//		}
//
//		InputStream is = null;
//		ResponseEntity<byte[]> entity = null;
//		
//		try {
//			HttpHeaders headers = new HttpHeaders();
//			// 이미지인지 확인
//			boolean isImage = FileUploadUtil.isImage(formatName);
//			
//			if (isImage) {
////				int slashIndex = realPath.lastIndexOf("/");
////				String front = realPath.substring(0, slashIndex + 1); // 2019/5/17/
////				String rear = realPath.substring(slashIndex + 1); // fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
////				realPath = front + "s_" + rear;
//				headers.setContentType(mediaType);
//			} else {
//				int underScoreIndex = fileName.lastIndexOf("_");
//				String downloadName = fileName.substring(underScoreIndex + 1);
//				// 8비트 데이터임을 명시
//				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//				headers.add("Content-disposition", "attachment; filename=" + downloadName);
//			}
//			
//			is = new FileInputStream(realPath);
//			// 서버에 보내는 데이터가 바이너리 데이터(byte[])임을 설정
////			headers.add("Content-Disposition", headerValue);
//			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}
}
