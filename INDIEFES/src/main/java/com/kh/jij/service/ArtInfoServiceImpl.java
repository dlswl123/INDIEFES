package com.kh.jij.service;


import java.util.Map;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.persistence.IArtInfoDao;


@Service
public class ArtInfoServiceImpl implements IArtInfoService {
	
	@Inject
	private IArtInfoDao artDao;

	@Override
	// 앨범정보입력
	public void insert(ArtInfoVo vo) throws Exception {
		artDao.insert(vo);
	}
	// 팀생성
	@Transactional
	@Override
	public void teamInsert(Map<String, Object> map) throws Exception {
		IndieTeamVo teamVo = (IndieTeamVo)map.get("teamVo");
		String user_id = (String)map.get("user_id");
		TeamMemberVo memberVo = new TeamMemberVo();
		memberVo.setUser_id(user_id);
		memberVo.setTeam_level(0);
		artDao.teamInsert(teamVo);
		artDao.teamInput(memberVo);
		
	}
	// 팀가입
	@Override
	public void teamInput(TeamMemberVo vo) throws Exception {
		vo.setTeam_level(1);
		artDao.teamInput(vo);
	}
	// 팀 정보
	@Override
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception {
		List<TeamMemberVo> memberList = artDao.teamInfo(team_number);
		return memberList;
	}
	// 팀 앨범
	@Override
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception {
		List<ArtInfoVo> teamArtList = artDao.teamArtList(team_number);
		return teamArtList;
	}
	@Override
	public void attach(String file_path) throws Exception {
		
	}

	@Override
	public ArtInfoVo artRead(int art_number) throws Exception {
		ArtInfoVo artVo = artDao.artRead(art_number);
		return artVo;
	}
	
	//  수정
//	@Override
	public ArtInfoVo artModify(String user_id, int art_number) throws Exception {
		
		ArtInfoVo artVo = artDao.artModify(user_id, art_number);
		return artVo;
	}

	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = artDao.musicRead(art_number);
		return musicList;
	}
	@Override
	public List<ArtInfoVo> allArtList() throws Exception {
		List<ArtInfoVo> artList = artDao.allArtList();
		return artList;
	}
	
	// 인디그룹 이름 가져오기
	@Override
	public List<IndieTeamVo> getIndieTeam() throws Exception {
		List<IndieTeamVo> teamList = artDao.getIndieTeam();
		return teamList;
	}
	@Override
	public List<String> getCover() {
		List<String> coverList =  artDao.getCover();
		return coverList;
	}
	@Override
	public int getIndieNumber(String user_id) throws Exception {
		int indieNumber = artDao.getIndieNumber(user_id);
		return indieNumber;
	}
	@Override
	public String getTeamName(int team_number) throws Exception {
		String teamName = artDao.getTeamName(team_number);
		return teamName;
	}


}
