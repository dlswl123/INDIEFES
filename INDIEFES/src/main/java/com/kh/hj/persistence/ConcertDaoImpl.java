package com.kh.hj.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.hj.domain.ConcertInfoFileVo;
import com.kh.hj.domain.ConcertInfoVo;

@Repository
public class ConcertDaoImpl implements IConcertDao {
	
	private static final String NAMESPACE = "concert";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertConcertInfo(ConcertInfoVo vo) throws Exception {
		// 공연 홍보 글 쓰기
		sqlSession.insert(NAMESPACE + ".insertConcertInfo", vo);
	}

	@Override
	public void insertConcertInfoFiles(String file_path) throws Exception {
		// 공연 홍보 글 작성시 포스터 파일경로 저장
		sqlSession.insert(NAMESPACE + ".insertConcertInfoFiles", file_path);
	}

	@Override
	public List<ConcertInfoVo> getConcertInfoList() throws Exception {
		// 공연 홍보 글 목록 불러오기
		List<ConcertInfoVo> list = sqlSession.selectList(NAMESPACE + ".getConcertInfoList");
		return list;
	}

	@Override
	public ConcertInfoVo getConcertInfo(int concert_number) throws Exception {
		// 공연 홍보 글 불러오기
		ConcertInfoVo vo = sqlSession.selectOne(NAMESPACE + ".getConcertInfo", concert_number);
		return vo;
	}

	@Override
	public List<String> getConcertInfoFiles(int concert_number) throws Exception {
		// 공연 홍보 글 파일 불러오기
		List<String> list = sqlSession.selectList(NAMESPACE + ".getConcertInfoFiles", concert_number);
		return list;
	}
	
	@Override
	public void deleteConcertInfoFiles(String file_path) throws Exception {
		// 공연 홍보 글 파일 삭제
		sqlSession.delete(NAMESPACE + ".deleteConcertInfoFiles", file_path);
	}

	@Override
	public void deleteConcertInfo(int concert_number) throws Exception {
		// 공연 홍보 글 삭제
		sqlSession.update(NAMESPACE + ".deleteConcertInfo", concert_number);
	}

	@Override
	public void modifyConcertInfo(ConcertInfoVo vo) throws Exception {
		// 공연 홍보 글 수정
		sqlSession.update(NAMESPACE + ".modifyConcertInfo", vo);
	}
	
	@Override
	public void updateConcertInfoFiles(Map<String, Object> map) throws Exception {
		// 공연 홍보 글 수정시 새 파일 업로드
		sqlSession.insert(NAMESPACE + ".updateConcertInfoFiles", map);
	}

}
