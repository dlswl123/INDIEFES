package com.kh.jij.domain;

public class music_lyrics {

	private int music_number;
	private String lyrics;

	public int getMusic_number() {
		return music_number;
	}

	public void setMusic_number(int music_number) {
		this.music_number = music_number;
	}

	public String getLyrics() {
		return lyrics;
	}

	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}

	@Override
	public String toString() {
		return "music_lyrics [music_number=" + music_number + ", lyrics=" + lyrics + "]";
	}

}
