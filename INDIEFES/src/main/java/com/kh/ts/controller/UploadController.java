package com.kh.ts.controller;

import java.io.File;
import java.io.FileInputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.ts.util.FileUploadUtil;
import com.kh.ts.service.IBoardService;

@Controller
@RequestMapping("/upload/*")
public class UploadController {
	
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")
	
	@Inject
	private IBoardService boardSerivce;
	
	@RequestMapping(value="/test")
	public void uploadTest() throws Exception {
		System.out.println("uploadPath:" + uploadPath);
	}

	@RequestMapping(value="/uploadAjax", method=RequestMethod.POST,
				produces="text/plain; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
					
			String originalName = file.getOriginalFilename();
			System.out.println("originalName:" + originalName);
			ResponseEntity<String> entity = null;
			try {
				String dirPath = FileUploadUtil.uploadFile(uploadPath, originalName, file.getBytes());
				System.out.println("UploadController, uploadAjax(), dirPath:" + dirPath);
				String path = dirPath.replace("\\", "/");
				System.out.println("UploadController, uploadAjax(), path:" + path);
				entity = new ResponseEntity<>(path, HttpStatus.OK);
			} catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
			}
			return entity;
		}
	
		@RequestMapping(value="/displayFile")
		public ResponseEntity<byte[]> displayFile(@RequestParam("fileName") String fileName)throws Exception {
			String realPath = null;
			// -> H:/upload/2019/5/17/58d2f428-feb3-4c57-9d67-350dd294b25e_Chrysanthemum.jpg
			
			// 파일의 확장자 얻기
//			int dotIndex = fileName.lastIndexOf(".");
//			String extName = fileName.substring(dotIndex + 1).toUpperCase();
			String formatName = FileUploadUtil.getFormatName(fileName);
			System.out.println("UploadController, displayFile, formatName:" + formatName);
			MediaType mediaType = null;
			if (formatName.equals("JPG")) {
				System.out.println("UploadController, displayFile, formatName:" + "JPG");
				mediaType = MediaType.IMAGE_JPEG; 	// image/jpeg
			} else if (formatName.equals("PNG")) {
				mediaType = MediaType.IMAGE_PNG;	// image/png
			} else if (formatName.equals("GIF")) {
				mediaType = MediaType.IMAGE_GIF;	// image/gif
			} else {
				// 일반 바이너리 데이터(8비트(1바이트))
				// 파일명 지정
			}
			ResponseEntity<byte[]> entity = null;
			try {
				HttpHeaders headers = new HttpHeaders();
				boolean isImage = FileUploadUtil.isImage(formatName);
				
				
				if (isImage == true) {
					System.out.println("UploadController, displayFile, headers:" + headers);
					System.out.println("UploadController, displayFile, mediaType:" + mediaType);
					headers.setContentType(mediaType); // mime type 설정 : image/jpg
				} else {
					int underscoreIndex = fileName.lastIndexOf("_");
					String downloadName = fileName.substring(underscoreIndex + 1);
					// 8비트 데이터임을 명시
					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
					headers.add("Content-disposition", 
							"attachment; filename=" + downloadName);
				}
			
				realPath = uploadPath + File.separator + fileName;
				System.out.println("UploadController, displayFile, realPath:" + realPath);
				System.out.println("realPath:" + realPath);
				FileInputStream is = new FileInputStream(realPath);
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}
			return entity;
		}

	}
