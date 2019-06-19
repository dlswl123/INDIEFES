package com.kh.jij.domain;

import java.sql.Date;

public class art_infoVo {
	
	private int art_number; // 뮤지션 분류코드
	private String art_genre; // 앨범 장르
	private String user_id; // 유저아이디
	private int team_number; // 뮤지션 넘버
	private String art_title; // 앨범명
	private String art_cover; // 앨범 이미지
	private String art_pr; // 앨범 설명
	Date reg_art; // 앨범 등록일
	private int liked_count; // 좋아요
	private int good_count; // 추천
	private int upload_check; // 업로드 확인
	
	public int getArt_number() {
		return art_number;
	}
	public void setArt_number(int art_number) {
		this.art_number = art_number;
	}
	public String getArt_genre() {
		return art_genre;
	}
	public void setArt_genre(String art_genre) {
		this.art_genre = art_genre;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getTeam_number() {
		return team_number;
	}
	public void setTeam_number(int team_number) {
		this.team_number = team_number;
	}
	public String getArt_title() {
		return art_title;
	}
	public void setArt_title(String art_title) {
		this.art_title = art_title;
	}
	public String getArt_cover() {
		return art_cover;
	}
	public void setArt_cover(String art_cover) {
		this.art_cover = art_cover;
	}
	public String getArt_pr() {
		return art_pr;
	}
	public void setArt_pr(String art_pr) {
		this.art_pr = art_pr;
	}
	public Date getReg_art() {
		return reg_art;
	}
	public void setReg_art(Date reg_art) {
		this.reg_art = reg_art;
	}
	public int getLiked_count() {
		return liked_count;
	}
	public void setLiked_count(int liked_count) {
		this.liked_count = liked_count;
	}
	public int getGood_count() {
		return good_count;
	}
	public void setGood_count(int good_count) {
		this.good_count = good_count;
	}
	public int getUpload_check() {
		return upload_check;
	}
	public void setUpload_check(int upload_check) {
		this.upload_check = upload_check;
	}
	@Override
	public String toString() {
		return "art_infoVo [art_number=" + art_number + ", art_genre=" + art_genre + ", user_id=" + user_id
				+ ", team_number=" + team_number + ", art_title=" + art_title + ", art_cover=" + art_cover + ", art_pr="
				+ art_pr + ", reg_art=" + reg_art + ", liked_count=" + liked_count + ", good_count=" + good_count
				+ ", upload_check=" + upload_check + "]";
	}
	
}
