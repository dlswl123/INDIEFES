package com.kh.jij.service;


import java.util.Map;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.TeamMemberVo;

public interface IArtInfoService {
	// 글쓰기
	public void insert(ArtInfoVo vo) throws Exception;
	// 팀생성
	public void teamInsert(Map<String, Object> map) throws Exception;
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
}
