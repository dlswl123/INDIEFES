package com.kh.jij.service;

import java.util.List;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.MusicLyricsVo;

public interface IMusicInfoService {

	// 노래 정보 가져오기
	public List<MusicInfoVo> musicRead(int art_number) throws Exception;
	
	// 노래 등록
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception;
	
	// 트랙넘버 가져오기
	public int getMaxTrackNum(int art_number) throws Exception;
	
	// 노래 수정
	public void musicUpdate(MusicInfoVo musicInfoVo) throws Exception;
	
	// 노래 삭제
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception;
	
	// 노래가사 입력
	public void musicLyrics(MusicLyricsVo musicLyricsVo) throws Exception;
	
	// 노래 가사찾기
	public String getLyrics(int music_number) throws Exception;
	
	// 노래 가사수정
	public void updateLyrics(MusicLyricsVo musicLyricsVo) throws Exception;
//	// 앨범승인요청
//	public void musicUploadApproReq(int art_number, int team_number) throws Exception;
//	// 업로드승인
//	public void musicUploadAppro(int art_number) throws Exception;
//	// 업로드승인
//	public void musicUploadReturn(int art_number) throws Exception;
//	
}
