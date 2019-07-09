package com.kh.hj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.hj.domain.ConcertInfoFileVo;
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
	
	@Override
	public List<String> getConcertInfoFiles(int concert_number) throws Exception {
		// 공연 홍보 글 파일 불러오기
		List<String> list = dao.getConcertInfoFiles(concert_number);
		return list;
	}
	
	@Override
	public void deleteConcertInfoFiles(String file_path) throws Exception {
		// 공연 홍보 글 파일 삭제
		dao.deleteConcertInfoFiles(file_path);
	}
	
	@Override
	public void modifyConcertInfo(ConcertInfoVo vo) throws Exception {
		// 공연 홍보 글 수정
		dao.modifyConcertInfo(vo);
		if (vo.getFile_path() != null) {
			for (String file_path : vo.getFile_path()) {
				Map<String, Object> map = new HashMap<>();
				map.put("concert_number", vo.getConcert_number());
				map.put("file_path", file_path);
//				ConcertInfoFileVo fileVo = new ConcertInfoFileVo();
//				fileVo.setConcert_number(vo.getConcert_number());
//				fileVo.setFile_path(file_path);
				dao.updateConcertInfoFiles(map);
			}
		}
	}

	@Override
	public void deleteConcertInfo(int concert_number) throws Exception {
		// 공연 홍보 글 삭제
		dao.deleteConcertInfo(concert_number);
	}

}
