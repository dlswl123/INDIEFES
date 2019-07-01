package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.MusicLyricsVo;

public interface IMusicInfoDao {

	// 노래 정보 가져오기
	public List<MusicInfoVo> musicRead(int art_number) throws Exception;
	// 노래 추가
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception;
	// 트랙넘버 가져오기
	public int getMaxTrackNum(int art_number) throws Exception;
	// 노래 수정
	public void musicUpdate(MusicInfoVo musicInfoVo, String user_id) throws Exception;
	// 노래 삭제
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception;
	// 노래가사 입력
	public void musicLyrics(MusicLyricsVo musicLyricsVo) throws Exception;
	
}
