package com.kh.jij.domain;

public class indie_teamVo {
	
	private int team_number;
	private String art_team;
	
	public int getTeam_number() {
		return team_number;
	}
	public void setTeam_number(int team_number) {
		this.team_number = team_number;
	}
	public String getArt_team() {
		return art_team;
	}
	public void setArt_team(String art_team) {
		this.art_team = art_team;
	}
	@Override
	public String toString() {
		return "indie_teamVo [team_number=" + team_number + ", art_team=" + art_team + "]";
	}

}
