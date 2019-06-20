package com.kh.ts.domain;

import java.sql.Date;
import java.sql.SQLData;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;

public class BoardVo {
	private int board_number;
	private int board_cate_number;
	private String subject;
	private String user_id;
	private String content;
	private Date reg_date;
	private Date lately_date;
	private int view_count;
	private int like_count;
	private int reply_count;
	private String file_path;
	
	private String[] files;

	public int getBoard_number() {
		return board_number;
	}

	public void setBoard_number(int board_number) {
		this.board_number = board_number;
	}

	public int getBoard_cate_number() {
		return board_cate_number;
	}

	public void setBoard_cate_number(int board_cate_number) {
		this.board_cate_number = board_cate_number;
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

	public Date getLately_date() {
		return lately_date;
	}

	public void setLately_date(Date lately_date) {
		this.lately_date = lately_date;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "BoardVo [board_number=" + board_number + ", board_cate_number=" + board_cate_number + ", subject="
				+ subject + ", user_id=" + user_id + ", content=" + content + ", reg_date=" + reg_date
				+ ", lately_date=" + lately_date + ", view_count=" + view_count + ", like_count=" + like_count
				+ ", reply_count=" + reply_count + ", file_path=" + file_path + ", files=" + Arrays.toString(files)
				+ "]";
	}
	
}
