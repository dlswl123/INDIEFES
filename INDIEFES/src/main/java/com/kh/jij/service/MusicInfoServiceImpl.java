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
	
	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = musicDao.musicRead(art_number);
		return musicList;
	}

	@Override
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception {
		musicDao.musicInsert(musicInfoVo);
	}

	@Override
	public int getMaxTrackNum(int art_number) throws Exception {
		int track_number = musicDao.getMaxTrackNum(art_number);
		return track_number;
	}

	@Override
	public void musicUpdate(MusicInfoVo musicInfoVo, String user_id) throws Exception {
		musicDao.musicUpdate(musicInfoVo, user_id);
	}

	@Override
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception {
		musicDao.musicDelete(musicInfoVo);
	}

	@Override
	public void musicLyrics(MusicLyricsVo musicLyricsVo) throws Exception {
		musicDao.musicLyrics(musicLyricsVo);
		
	}
	
}
