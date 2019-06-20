package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;

public interface IArtInfoDao {
	// 글쓰기
	public void insert(ArtInfoVo vo) throws Exception;
	// 팀생성
	public void teamInsert(IndieTeamVo vo) throws Exception;
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo art_read(String user_id, int art_number) throws Exception;
	
	// 노래 정보 가져오기
	public List<MusicInfoVo> music_read(int art_number) throws Exception;
}