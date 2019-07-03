package com.kh.jij.service;


import java.util.Map;
import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.ts.domain.PagingDto;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.PlayListVo;

public interface IArtInfoService {
	// 앨범입력
	public void insert(ArtInfoVo vo) throws Exception;
	
	// 입력앨범정보
	public ArtInfoVo artInfo(int team_number) throws Exception;
	
	// 팀생성
	public void teamInsert(Map<String, Object> map) throws Exception;
	
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
	// 팀정보
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception;
	
	// 팀앨범 리스트 가져오기
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo artRead(int art_number) throws Exception;
	
	// 앨범 수정 가져오기
	public ArtInfoVo artModifyForm(String user_id, int art_number) throws Exception;
	
	// 앨범 정보 수정
	public void artModify(ArtInfoVo artInfoVo) throws Exception;
	
	// 앨범 삭제
	public void artDelete(int art_number, String user_id) throws Exception;
	
	// 앨범 리스트 가져오기
	public List<ArtInfoVo> allArtList(PagingDto pagingDto) throws Exception;
	public List<IndieTeamVo> getIndieTeam() throws Exception;
	// 앨범 커버 리스트 가져오기
	public List<String> getCover();
	
	// 플레이리스트
	public List<PlayListVo> playListInfo(String user_id) throws Exception;
	
	// 리스트에 곡 가져오기
	public List<MusicInfoVo> playList(String user_id) throws Exception;
	
	// 리스트에서 곡 등록
	public void playInsert(Map<String, Object> map) throws Exception;
	
	// 리스트에서 곡 삭제
	public void playDelete(int play_index) throws Exception;
	
	// 최신 앨범
	public List<ArtInfoVo> toDayList(PagingDto pagingDto) throws Exception;
	public int toDayCount()throws Exception;
	
	// 인기 앨범
	public List<ArtInfoVo> goodList() throws Exception;
	
	// 팀 넘버
	public int getIndieNumber(String user_id) throws Exception;
	
	// 팀 이름
	public String getTeamName (int team_number) throws Exception;
	
	// 앨범 수
	public int artCount(PagingDto pagingDto)throws Exception;
}
