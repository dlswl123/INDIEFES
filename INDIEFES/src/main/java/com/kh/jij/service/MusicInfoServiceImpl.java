package com.kh.jij.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.MusicLyricsVo;
import com.kh.jij.persistence.IMusicInfoDao;

@Service
public class MusicInfoServiceImpl implements IMusicInfoService{

	@Inject
	private IMusicInfoDao musicDao;
	
	// 노래 정보 가져오기
	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = musicDao.musicRead(art_number);
		return musicList;
	}
	
	// 노래 등록
	@Override
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception {
		musicDao.musicInsert(musicInfoVo);
	}
	// 트랙넘버 가져오기
	@Override
	public int getMaxTrackNum(int art_number) throws Exception {
		int track_number = musicDao.getMaxTrackNum(art_number);
		return track_number;
	}
	// 노래 수정
	@Override
	public void musicUpdate(MusicInfoVo musicInfoVo) throws Exception {
		musicDao.musicUpdate(musicInfoVo);
	}
	// 노래 삭제
	@Override
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception {
		musicDao.musicDelete(musicInfoVo);
	}
	// 노래가사 입력
	@Override
	public void musicLyrics(MusicLyricsVo musicLyricsVo) throws Exception {
		musicDao.musicLyrics(musicLyricsVo);
		
	}
	
}
