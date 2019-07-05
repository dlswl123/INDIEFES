package com.kh.jij.domain;

import java.sql.Date;

public class PayLogVo {

	private String user_id;
	private int music_number;
	private int price;
	private Date pay_date;
	private int pay_ok;
	private String music_title;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getMusic_number() {
		return music_number;
	}
	public void setMusic_number(int music_number) {
		this.music_number = music_number;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public int getPay_ok() {
		return pay_ok;
	}
	public void setPay_ok(int pay_ok) {
		this.pay_ok = pay_ok;
	}
	
	public String getMusic_title() {
		return music_title;
	}
	public void setMusic_title(String music_title) {
		this.music_title = music_title;
	}
	@Override
	public String toString() {
		return "PayLogVo [user_id=" + user_id + ", music_number=" + music_number + ", price=" + price + ", pay_date="
				+ pay_date + ", pay_ok=" + pay_ok + ", music_title=" + music_title + "]";
	}
	
}
