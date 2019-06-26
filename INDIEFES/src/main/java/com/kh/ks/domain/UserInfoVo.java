package com.kh.ks.domain;

import java.sql.Date;

public class UserInfoVo {
	private String user_id;
	private String user_pw;
	private String user_nick;
	private String user_name;
	private String user_email;
	private String user_birth;
	private String user_gender;
	private Date reg_date;
	private int point;
	private int user_level;
	private String auto_login;
	private String reg_indie;
	private String deleted;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getUser_level() {
		return user_level;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
	public String getAuto_login() {
		return auto_login;
	}
	public void setAuto_login(String auto_login) {
		this.auto_login = auto_login;
	}
	public String getReg_indie() {
		return reg_indie;
	}
	public void setReg_indie(String reg_indie) {
		this.reg_indie = reg_indie;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	
	@Override
	public String toString() {
		return "UserInfoVo [user_id=" + user_id + ", user_pw=" + user_pw + ", user_nick=" + user_nick + ", user_name="
				+ user_name + ", user_email=" + user_email + ", user_birth=" + user_birth + ", user_gender="
				+ user_gender + ", reg_date=" + reg_date + ", point=" + point + ", user_level=" + user_level
				+ ", auto_login=" + auto_login + ", reg_indie=" + reg_indie + ", deleted=" + deleted + "]";
	}
	
	
	
	
	
	
	
}
