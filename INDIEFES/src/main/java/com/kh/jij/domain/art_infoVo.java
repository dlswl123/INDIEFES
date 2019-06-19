package com.kh.jij.domain;

import java.sql.Date;

public class art_infoVo {
	
	private int art_number;
	private String art_genre;
	private String user_id;
	private int team_number;
	private String art_title;
	private String art_cover;
	private String art_pr;
	Date reg_art;
	private int liked_count;
	private int good_count;
	private int deleted;
	
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
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	@Override
	public String toString() {
		return "art_infoVo [art_number=" + art_number + ", art_genre=" + art_genre + ", user_id=" + user_id
				+ ", team_number=" + team_number + ", art_title=" + art_title + ", art_cover=" + art_cover + ", art_pr="
				+ art_pr + ", reg_art=" + reg_art + ", liked_count=" + liked_count + ", good_count=" + good_count
				+ ", deleted=" + deleted + "]";
	}

}
