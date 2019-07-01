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

import com.kh.ts.service.IBoardService;
import com.kh.ts.util.FileUploadUtil;

@Controller
@RequestMapping("/upload")
public class UploadController {

	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml (id="uploadPath")
	
	@Inject
	private IBoardService boardService;
	
	@RequestMapping(value="/test")
	public void uploadTest() throws Exception {
		System.out.println("uploadPath:" + uploadPath);
		// -> 브라우저에서 localhost/upload/test 를 요청 -> 404 -> jsp 없음 (무시)
	}
	
	
	// Ajax 방식이 아닌 form 으로 파일을 받을 경우
	// 메서드의 파라미터로 (MultipartHttpServletRequest request)를 사용
	// request.getParameter("name") 또는 커맨드 객체를 사용
	// MultipartFile file = request.getFile("file")
	@RequestMapping(value="/uploadAjax", method=RequestMethod.POST, 
			produces="text/plain; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		String originalName = file.getOriginalFilename();
		System.out.println("originalName:" + originalName);
		ResponseEntity<String> entity = null;
		try {
			// dirPath -> 2019/5/17/fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
			String dirPath = FileUploadUtil.uploadFile(uploadPath, originalName, file.getBytes());
			String path = dirPath.replace("\\", "/");
			entity = new ResponseEntity<>(path, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/displayFile")
	public ResponseEntity<byte[]> displayFile(@RequestParam("fileName") String fileName) throws Exception {
//		System.out.println("fileName:" + fileName);
		// -> /2019/5/17/58d2f428-feb3-4c57-9d67-350dd294b25e_Chrysanthemum.jpg
		String realPath = uploadPath + File.separator + fileName;
		// -> H:/upload/2019/5/17/58d2f428-feb3-4c57-9d67-350dd294b25e_Chrysanthemum.jpg
		
		// 파일의 확장자 얻기
//		int dotIndex = fileName.lastIndexOf(".");
//		String extName = fileName.substring(dotIndex + 1).toUpperCase();
		String formatName = FileUploadUtil.getFormatName(fileName).toUpperCase();
		
		MediaType mediaType = null;
		if (formatName.equals("JPG")) {
			mediaType = MediaType.IMAGE_JPEG; 	// image/jpeg
		} else if (formatName.equals("PNG")) {
			mediaType = MediaType.IMAGE_PNG;	// image/png
		} else if (formatName.equals("GIF")) {
			mediaType = MediaType.IMAGE_GIF;	// image/gif
		} 
		
		ResponseEntity<byte[]> entity = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			boolean isImage = FileUploadUtil.isImage(formatName);
			
			
			if (isImage == true) {
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
			FileInputStream is = new FileInputStream(realPath);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/deleteFile", method=RequestMethod.GET)
	public ResponseEntity<String> deleteFile(@RequestParam("fileName") String fileName) throws Exception {
		System.out.println("fileName:" + fileName);
		ResponseEntity<String> entity = null;
		try {
			// 파일 삭제 처리
			String formatName = FileUploadUtil.getFormatName(fileName);
			boolean isImage = FileUploadUtil.isImage(formatName);
			String realPath = uploadPath + File.separator + fileName;
			File f = new File(realPath);
			if (f.exists()) {
				f.delete();
			}
			if (isImage == true) {
				String[] arrStr = FileUploadUtil.splitFileName(fileName);
				String front = arrStr[0];
				String rear = arrStr[1];
				String thumbnailName = uploadPath + File.separator + front + "s_" + rear;
				File f2 = new File(thumbnailName);
				if (f2.exists()) {
					f2.delete();
				}
			}
			// TODO 데이터 삭제
			boardService.deleteAttach(fileName);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
