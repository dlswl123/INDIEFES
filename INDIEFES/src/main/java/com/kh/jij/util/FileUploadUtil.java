package com.kh.jij.util;

import java.io.File;
import java.io.FileInputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.jij.domain.ArtInfoVo;

public class FileUploadUtil {

	public static String uploadFile(String uploadPath, String originalName, ArtInfoVo artVo,
			 byte[] fileData) throws Exception {
		System.out.println("fileData:"+fileData);
		int teamNumber = artVo.getTeam_number();
		int artNumber = artVo.getArt_number();
		
		String filePath = uploadPath+File.separator +teamNumber+File.separator+artNumber+ File.separator + originalName;
		String path = uploadPath+File.separator +teamNumber+File.separator+artNumber;
		String fileName = teamNumber+File.separator+artNumber+File.separator+originalName;
		System.out.println("FileUploadUtil, filePath" + filePath);
		System.out.println("FileUploadUtil, path" + path);
		File target = new File(path);
		File f = new File(filePath);
		if (!target.exists()) {
			target.mkdirs();
		}
		FileCopyUtils.copy(fileData, f);
		
		return fileName;
	}
	
	// 확장자 얻기
		public static String getFormatName(String fileName) {
			int dotIndex = fileName.lastIndexOf(".");
			String formatName = fileName.substring(dotIndex + 1);
			return formatName;
		}
		
		// 이미지인지 여부
		public static boolean isImage(String formatName) {
			String[] imgFormat = { "JPG", "PNG", "GIF" };
			for (String aFormat : imgFormat) {
				if (formatName.toUpperCase().equals(aFormat)) {
					return true;
				}
			}
			return false;
		}
	
}
