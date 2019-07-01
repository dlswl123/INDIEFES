package com.kh.hj.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hj.domain.ConcertInfoVo;
import com.kh.hj.persistence.IConcertDao;

@Service
public class ConcertServiceImpl implements IConcertService {
	
	@Inject
	private IConcertDao dao;

	@Transactional
	@Override
	public void insertConcertInfo(ConcertInfoVo vo) throws Exception {
		// 공연 홍보 글쓰기
		dao.insertConcertInfo(vo);
		String[] files = vo.getFile_path();
		if (files != null) {
			for (String file_path : files) {
				dao.insertConcertInfoFiles(file_path);
			}
		}
	}

	@Override
	public List<ConcertInfoVo> getConcertInfoList() throws Exception {
		// 공연 홍보 목록 불러오기
		List<ConcertInfoVo> list = dao.getConcertInfoList();
		return list;
	}

	@Override
	public ConcertInfoVo getConcertInfo(int concert_number) throws Exception {
		// 공연 홍보 글 불러오기
		ConcertInfoVo vo = dao.getConcertInfo(concert_number);
		return vo;
	}

}
