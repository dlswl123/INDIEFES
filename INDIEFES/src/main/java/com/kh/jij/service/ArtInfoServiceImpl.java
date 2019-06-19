package com.kh.jij.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jij.domain.ArtInfoVo;
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


}
