package com.kh.jij.domain;

public class MusicInfoVo {

	private int art_number;
	private int music_number;
	private int track_number;
	private String music_title;
	private int heard_count;
	private int price;
	private int pay_count;
	private int upload_check;
	private String file_path;
	private int team_number;
	
	private String team_name;
	private int play_index;

	public int getArt_number() {
		return art_number;
	}

	public void setArt_number(int art_number) {
		this.art_number = art_number;
	}

	public int getMusic_number() {
		return music_number;
	}

	public void setMusic_number(int music_number) {
		this.music_number = music_number;
	}

	public int getTrack_number() {
		return track_number;
	}

	public void setTrack_number(int track_number) {
		this.track_number = track_number;
	}

	public String getMusic_title() {
		return music_title;
	}

	public void setMusic_title(String music_title) {
		this.music_title = music_title;
	}

	public int getHeard_count() {
		return heard_count;
	}

	public void setHeard_count(int heard_count) {
		this.heard_count = heard_count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getPay_count() {
		return pay_count;
	}

	public void setPay_count(int pay_count) {
		this.pay_count = pay_count;
	}

	public int getUpload_check() {
		return upload_check;
	}

	public void setUpload_check(int upload_check) {
		this.upload_check = upload_check;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public int getTeam_number() {
		return team_number;
	}

	public void setTeam_number(int team_number) {
		this.team_number = team_number;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public int getPlay_index() {
		return play_index;
	}

	public void setPlay_index(int play_index) {
		this.play_index = play_index;
	}

	@Override
	public String toString() {
		return "MusicInfoVo [art_number=" + art_number + ", music_number=" + music_number + ", track_number="
				+ track_number + ", music_title=" + music_title + ", heard_count=" + heard_count + ", price=" + price
				+ ", pay_count=" + pay_count + ", upload_check=" + upload_check + ", file_path=" + file_path
				+ ", team_number=" + team_number + ", team_name=" + team_name + ", play_index=" + play_index + "]";
	}

}
