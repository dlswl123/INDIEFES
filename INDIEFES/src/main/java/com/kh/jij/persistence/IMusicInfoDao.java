package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.MusicInfoVo;

public interface IMusicInfoDao {

	// 노래 정보 가져오기
	public List<MusicInfoVo> musicRead(int art_number) throws Exception;
	// 노래 추가
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception;
	// 트랙넘버 가져오기
	public int getMaxTrackNum(int art_number) throws Exception;
	// 노래 수정
	public void musicUpdate(MusicInfoVo musicInfoVo) throws Exception;
}
