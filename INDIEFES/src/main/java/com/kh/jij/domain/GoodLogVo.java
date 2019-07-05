package com.kh.jij.domain;

import java.sql.Date;

public class GoodLogVo {

	private String user_id;
	private int art_number;
	private Date good_date;

	public GoodLogVo() {
		super();
		// TODO Auto-generated constructor stub
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

	public Date getGood_date() {
		return good_date;
	}

	public void setGood_date(Date good_date) {
		this.good_date = good_date;
	}

	@Override
	public String toString() {
		return "GoodLogVo [user_id=" + user_id + ", art_number=" + art_number + ", good_date=" + good_date + "]";
	}

}
