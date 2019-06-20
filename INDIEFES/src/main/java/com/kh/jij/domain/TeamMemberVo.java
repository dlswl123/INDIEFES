package com.kh.jij.domain;

public class TeamMemberVo {

	private int member_number;
	private int team_number;
	private String user_id;
	
	public int getMember_number() {
		return member_number;
	}
	public void setMember_number(int member_number) {
		this.member_number = member_number;
	}
	public int getTeam_number() {
		return team_number;
	}
	public void setTeam_number(int team_number) {
		this.team_number = team_number;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "team_memberVo [member_number=" + member_number + ", team_number=" + team_number + ", user_id=" + user_id
				+ "]";
	}
	
}
