package com.kh.jij.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jij.domain.art_infoVo;
import com.kh.jij.persistence.art_infoDao;


@Service
public class art_infoServiceImpl implements art_infoService {
	
	@Inject
	private art_infoDao artDao;

	@Transactional
	@Override
	// write()
	public void insert(art_infoVo vo) throws Exception {
		artDao.insert(vo);
//		String file = vo.getArt_cover();
//		if(file != null) {
//			artDao.attach(file); // insert
//		}
	}


}
