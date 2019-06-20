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

	@Override
	public void attach(String file_path) throws Exception {
		
	}

	@Override
	public ArtInfoVo art_read(String user_id, int art_number) throws Exception {
		
		ArtInfoVo artVo = artDao.art_read(user_id, art_number);
		return artVo;
	}

	@Override
	public List<MusicInfoVo> music_read(int art_number) throws Exception {
		List<MusicInfoVo> musicList = artDao.music_read(art_number);
		return musicList;
	}


}
