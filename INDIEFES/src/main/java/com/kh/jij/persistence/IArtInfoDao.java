package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;

public interface IArtInfoDao {
	// 앨범입력
	public void insert(ArtInfoVo vo) throws Exception;
	
	// 입력앨범정보
	public ArtInfoVo artInfo(int team_number) throws Exception;
	
	// 팀생성
	public void teamInsert(IndieTeamVo vo) throws Exception;
	
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
	// 팀정보
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception;
	
	// 팀앨범 리스트 가져오기
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo artRead(int art_number) throws Exception;
	
	// 앨범 수정정보 가져오기
	public ArtInfoVo artModify(String user_id, int art_number) throws Exception;
	
	// 노래 정보 가져오기
	public List<MusicInfoVo> musicRead(int art_number) throws Exception;
	
	// 검색, paging, nowPage 나중에 추가할것.
	// 앨범 리스트 가져오기
	public List<ArtInfoVo> allArtList() throws Exception;
	public List<IndieTeamVo> getIndieTeam() throws Exception;
	// 앨범 커버리스트 가져오기
	public List<String> getCover();
	
	// 팀넘버 가져오기
	public int getIndieNumber(String user_id) throws Exception;
	
	// 팀이름 가져오기
	public String getTeamName (int team_number) throws Exception;
	
}
