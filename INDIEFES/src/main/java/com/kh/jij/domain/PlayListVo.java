package com.kh.jij.domain;

public class PlayListVo {

	private String user_id;
	private int music_number;
	private int play_index;
	
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
	public int getPlay_index() {
		return play_index;
	}
	public void setPlay_index(int play_index) {
		this.play_index = play_index;
	}
	@Override
	public String toString() {
		return "PlayListVo [user_id=" + user_id + ", music_number=" + music_number + ", play_index=" + play_index + "]";
	}

}
