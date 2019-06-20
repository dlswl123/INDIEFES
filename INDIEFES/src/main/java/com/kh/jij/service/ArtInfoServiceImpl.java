package com.kh.jij.service;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.persistence.IArtInfoDao;


@Service
public class ArtInfoServiceImpl implements IArtInfoService {
	
	@Inject
	private IArtInfoDao artDao;

	@Transactional
	@Override
	// write()
	public void insert(ArtInfoVo vo) throws Exception {
		artDao.insert(vo);
//		String file = vo.getArt_cover();
//		if(file != null) {
//			artDao.attach(file); // insert
//		}
	}

	@Override
	public void attach(String file_path) throws Exception {
		
	}

	@Override
	public ArtInfoVo art_read(String user_id) throws Exception {
		ArtInfoVo artVo = artDao.art_read(user_id);
		return artVo;
	}

	@Override
	public List<MusicInfoVo> music_read(int art_number) throws Exception {
		List<MusicInfoVo> musicList = artDao.music_read(art_number);
		return musicList;
	}


}
