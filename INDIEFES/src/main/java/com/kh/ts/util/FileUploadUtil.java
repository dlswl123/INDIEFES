package com.kh.ts.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class FileUploadUtil {

	public static String uploadFile(String uploadPath , String originalName, byte[] fileData) throws Exception {
		// 고유이름
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid);
		String uuidName = uuid + "_" + originalName; 
		
		String datePath = calcPath(uploadPath); 
		// -> 2019/5/17
		System.out.println("datePath:" + datePath);
		String filePath = uploadPath + File.separator + datePath + File.separator + uuid + "_" + originalName; 
		
		System.out.println("filePath:" + filePath);
		
		FileOutputStream fos = new FileOutputStream(new File(filePath));
		FileCopyUtils.copy(fileData, fos);
		fos.close();
		
		String formatName = getFormatName(originalName); 
		boolean isImage = isImage(formatName); 
		if (isImage) { 
			makeTumbnail(uploadPath, datePath, uuidName); 
		}
		return datePath + File.separator + uuidName;
	
	}
	

	public static void makeTumbnail(String uploadPath, String dirPath, String uuidName) throws Exception {
		// imgscalr 라이브러리 사용
		// 원본이미지를 불러다가 메모리상에서 작은 이미지 생성
		// 메모리에 생성된 작은 이미지를 파일에 저장
		String uploadedPath = uploadPath + File.separator + dirPath + File.separator + uuidName;
		// -> 업로드가 된 원본이미지 경로
		System.out.println("uploadedPath:" + uploadedPath);
		
		// 원본 이미지 파일을 메모리에 로딩
		BufferedImage sourceImg = ImageIO.read(new File(uploadedPath));
		//							자동조절, 				조절기준,				조절크기
		// 로딩된 원본 이미지를 높이값 100에 맞춰서 가로를 자동조절
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,
				Scalr.Mode.FIT_TO_HEIGHT, 100);
		// 파일명에 s_를 붙인 이름의 파일을 생성
		// /2019/5/17/aqwef-qdfqwfa_smile.jpg
		// -> /2010/5/17/s_aqwef-qdfqwfa_smile.jpg
		String thumbnailName = uploadPath + File.separator + dirPath + File.separator 
				+ "s_" + uuidName;
		String formatName = getFormatName(uuidName);
		ImageIO.write(destImg, formatName, new File(thumbnailName));
	}
	
	public static String calcPath(String uploadPath) throws Exception {
		Calendar cal = Calendar.getInstance();
		String yearPath = "" + cal.get(Calendar.YEAR); // 2019
		String monthPath = yearPath + File.separator + (cal.get(Calendar.MONTH)+ 1); // 2019/5
		String datePath = monthPath + File.separator + cal.get(Calendar.DATE); // 2019/5/17
		
		String dirPath = uploadPath + File.separator + datePath; 
		File f = new File(dirPath);
		// 해당 경로가 존재하지 않는다면
		if (!f.exists()) {
			f.mkdirs();
		}
		
		return datePath; // 2019/5/17
	}
	
	// 파일 지우기
	public static void deleteFile(String filePath) throws Exception {
		File f = new File(filePath);
		if (f.exists()) {
			f.delete();
		}
	}
	
	// 확장자 얻기
	public static String getFormatName(String fileName) {
		int dotIndex = fileName.lastIndexOf(".");
		String formatName = fileName.substring(dotIndex +1).toUpperCase(); 
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
	
	public static String[] splitFileName(String fileName) {
		int slashIndex = fileName.lastIndexOf("/");
		String front = fileName.substring(0, slashIndex + 1);
		String rear = fileName.substring(slashIndex + 1);
		String[] arrStr = { front, rear };
		return arrStr;
	}
	
	public static String getThumbnailName(String fileName) {
		int slashIndex = fileName.lastIndexOf("/");
		String front = fileName.substring(0, slashIndex + 1);
		String rear = fileName.substring(slashIndex + 1 );
		return front + "s_" + rear;
		
	}
}
