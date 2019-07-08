package com.kh.hj.persistence;

import java.util.List;

import com.kh.hj.domain.ConcertInfoVo;

public interface IConcertDao {
	// 공연 홍보 글 쓰기
	public void insertConcertInfo(ConcertInfoVo vo) throws Exception;
	
	// 공연 홍보 글 작성시 포스터 파일경로 저장
	public void insertConcertInfoFiles(String file_path) throws Exception;
	
	// 공연 홍보 글 목록 불러오기
	public List<ConcertInfoVo> getConcertInfoList() throws Exception;
	
	// 공연 홍보 글 불러오기
	public ConcertInfoVo getConcertInfo(int concert_number) throws Exception;
	
	// 공연 홍보 글 파일 불러오기
	public List<String> getConcertInfoFiles(int concert_number) throws Exception;
	
	// 공연 홍보 글 파일 삭제
	public void deleteConcertInfoFiles(String file_path) throws Exception;
	
	// 공연 홍보 글 수정
	public void modifyConcertInfo(ConcertInfoVo vo) throws Exception;
	
	// 공연 홍보 글 삭제
	public void deleteConcertInfo(int concert_number) throws Exception;
	
}
