package com.kh.hj.domain;

public class ConcertInfoFileVo {
	private int concert_number;
	private String file_path;

	public int getConcert_number() {
		return concert_number;
	}

	public void setConcert_number(int concert_number) {
		this.concert_number = concert_number;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public ConcertInfoFileVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "ConcertInfoFileVo [concert_number=" + concert_number + ", file_path=" + file_path + "]";
	}

}
