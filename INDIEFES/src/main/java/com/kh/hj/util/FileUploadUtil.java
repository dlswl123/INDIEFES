package com.kh.hj.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class FileUploadUtil {

	public static String uploadFile(String uploadPath, String originalName, String concertDate,
			byte[] fileData) throws Exception {
		// 고유이름
		UUID uuid = UUID.randomUUID();
		String uuidName = uuid + "_" + originalName; 
		// -> fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
		
		String dirPath = makePath(uploadPath, concertDate);
		// -> /concertInfo/2019/7
		System.out.println("datePath:" + dirPath);
		
		String filePath = uploadPath + File.separator + dirPath + File.separator + uuidName;
		// -> H:/upload/2019/5/17/fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
		System.out.println("filePath:" + filePath);
		
		File target = new File(filePath);
		FileCopyUtils.copy(fileData, target); // 폴더 내에 파일 생성
		
		return dirPath + File.separator + uuidName;
		// -> 2019/5/17/fb94d409-77e4-4ed1-a6b1-24253ffcf3c6_Chrysanthemum.jpg
	}
	
	// 작은이미지 만들기 - 더블 버퍼링
	public static void makeThumbnail(String uploadPath, String dirPath, String uuidName) throws Exception {
		// imgscalr 라이브러리 사용
		// 원본이미지를 불러다가 메모리상에서 작은 이미지 생성
		// 메모리에 생성된 작은 이미지를 파일에 저장
		String uploadedPath = uploadPath + File.separator + dirPath + File.separator + uuidName; 
		System.out.println("makeThumbnail, uploadedName:" + uploadedPath);
		// -> 업로드가 된 원본이미지 경로
		
		
		// 원본 이미지 파일을 메모리에 로딩
		BufferedImage sourceImg = ImageIO.read(new File(uploadedPath));
		
		// 로딩된 원본이미지를 높이값 100에 맞춰서 가로를 자동 조절
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, 
				Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		// 파일명에 s_를 붙인 이름의 파일을 생성
		// /2019/5/17/aqwef-qdfqwfa_smile.jpg
		// -> /2019/5/17/s_aqwef-qdfqwfa_smile.jpg
		String thumbnailName = uploadPath + File.separator + dirPath + File.separator 
				+ "s_" + uuidName;
		String formatName = getFormatName(uuidName);
		File target = new File(thumbnailName);
		ImageIO.write(destImg, formatName, target);
	}
	
	// 파일 경로에 맞춰 폴더 생성 후 경로 반환
	public static String makePath(String uploadPath, String concertDate) {
		String dirName = "concertInfo" + File.separator + concertDate;
		String dirPath = uploadPath + File.separator + dirName;
		
		File f = new File(dirPath);
		// -> H:/upload/2019/5/19
		// 해당 경로가 존재하지 않는다면
		if (!f.exists()) {
			f.mkdirs();
		}
		
		return dirName; // 2019/5/17
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
	
	// 파일 이름 얻어내기
	public static String[] splitFileName(String fileName) {
		int slashIndex = fileName.lastIndexOf("/");
		String front = fileName.substring(0, slashIndex + 1);
		String rear = fileName.substring(slashIndex + 1);
		String[] arrStr = { front, rear };
		return arrStr;
	}
	
	// 섬네일 파일 이름 얻어내기
	public static String getThumbnailName(String fileName) {
		int slashIndex = fileName.lastIndexOf("/");
		String front = fileName.substring(0, slashIndex + 1);
		String rear = fileName.substring(slashIndex + 1);
		return front + "s_" + rear;
	}
	
}
