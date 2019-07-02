package com.kh.jij.service;

import java.util.List;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.MusicLyricsVo;

public interface IMusicInfoService {

	// 노래 정보 가져오기
	public List<MusicInfoVo> musicRead(int art_number) throws Exception;
	
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception;
	
	// 트랙넘버 가져오기
	public int getMaxTrackNum(int art_number) throws Exception;
	
	// 노래 수정
	public void musicUpdate(MusicInfoVo musicInfoVo) throws Exception;
	
	// 노래 삭제
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception;
	
	// 노래가사 입력
	public void musicLyrics(MusicLyricsVo musicLyricsVo) throws Exception;
}
