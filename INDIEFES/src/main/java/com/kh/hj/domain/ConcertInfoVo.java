package com.kh.hj.domain;

import java.util.Arrays;
import java.util.Date;

public class ConcertInfoVo {
	private int concert_number;
	private String subject;
	private String user_id;
	private String summary;
	private String content;
	private Date reg_date;
	private String concert_date;
	private String place_name;
	private float place_x;
	private float place_y;
	private String info_file_path;
	
	private String[] file_path;

	public ConcertInfoVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getConcert_number() {
		return concert_number;
	}

	public void setConcert_number(int concert_number) {
		this.concert_number = concert_number;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getConcert_date() {
		return concert_date;
	}

	public void setConcert_date(String concert_date) {
		this.concert_date = concert_date;
	}

	public String getPlace_name() {
		return place_name;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public float getPlace_x() {
		return place_x;
	}

	public void setPlace_x(float place_x) {
		this.place_x = place_x;
	}

	public float getPlace_y() {
		return place_y;
	}

	public void setPlace_y(float place_y) {
		this.place_y = place_y;
	}

	public String getInfo_file_path() {
		return info_file_path;
	}

	public void setInfo_file_path(String info_file_path) {
		this.info_file_path = info_file_path;
	}

	public String[] getFile_path() {
		return file_path;
	}

	public void setFile_path(String[] file_path) {
		this.file_path = file_path;
	}

	@Override
	public String toString() {
		return "ConcertInfoVo [concert_number=" + concert_number + ", subject=" + subject + ", user_id=" + user_id
				+ ", summary=" + summary + ", content=" + content + ", reg_date=" + reg_date + ", concert_date="
				+ concert_date + ", place_name=" + place_name + ", place_x=" + place_x + ", place_y=" + place_y
				+ ", info_file_path=" + info_file_path + ", file_path=" + Arrays.toString(file_path) + "]";
	}
	
}
