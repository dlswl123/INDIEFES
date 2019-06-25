package com.kh.jij.util;

import java.io.File;


import org.springframework.util.FileCopyUtils;

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
		
		File target = new File(path);
		File f = new File(filePath);
		if (!target.exists()) {
			target.mkdirs();
		}
		FileCopyUtils.copy(fileData, f);
		
		return fileName;
	}
	
}
