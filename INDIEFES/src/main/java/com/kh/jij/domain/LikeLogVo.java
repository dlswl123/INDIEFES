package com.kh.jij.domain;

import java.sql.Date;

public class LikeLogVo {

	private String user_id;
	private int art_number;
	private Date like_date;

	public LikeLogVo() {
		super();
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getArt_number() {
		return art_number;
	}

	public void setArt_number(int art_number) {
		this.art_number = art_number;
	}

	public Date getLike_date() {
		return like_date;
	}

	public void setLike_date(Date like_date) {
		this.like_date = like_date;
	}

	@Override
	public String toString() {
		return "LikeLogVo [user_id=" + user_id + ", art_number=" + art_number + ", like_date=" + like_date + "]";
	}

}
