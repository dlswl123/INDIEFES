package com.kh.hj.service;

import java.util.List;

import com.kh.hj.domain.ConcertInfoVo;

public interface IConcertService {
	// 공연 홍보 글쓰기
	public void insertConcertInfo(ConcertInfoVo vo) throws Exception;
	
	// 공연 홍보 목록 불러오기
	public List<ConcertInfoVo> getConcertInfoList() throws Exception;
	
	// 공연 홍보 글 불러오기
	public ConcertInfoVo getConcertInfo(int concert_number) throws Exception;
	
	// 공연 홍보 글 파일 불러오기
	public List<String> getConcertInfoFiles(int concert_number) throws Exception;
	
	// 공연 홍보 글 삭제
	public void deleteConcertInfo(int concert_number) throws Exception;
}
