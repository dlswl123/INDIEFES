package com.kh.jij.service;


import java.util.Map;
import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.domain.MusicInfoVo;

public interface IArtInfoService {
	// 글쓰기
	public void insert(ArtInfoVo vo) throws Exception;
	// 팀생성
	public void teamInsert(Map<String, Object> map) throws Exception;
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
	// 파일경로 인서트(첨부)
	public void attach(String file_path) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo art_read(String user_id, int art_number) throws Exception;
	
	// 노래 정보 가져오기
	public List<MusicInfoVo> music_read(int art_number) throws Exception;
}