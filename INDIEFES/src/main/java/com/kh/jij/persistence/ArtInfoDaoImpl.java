package com.kh.jij.persistence;


import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.jij.domain.ArtInfoVo;

@Repository
public class ArtInfoDaoImpl implements IArtInfoDao {
	
	private static final String NAMESPACE = "art";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insert(ArtInfoVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public void attach(String file_path) throws Exception {
		sqlSession.insert(NAMESPACE + ".attach", file_path);
	}

	@Override
	public void art_read(String user_id) throws Exception {
		sqlSession.selectOne(NAMESPACE + ".art_read", user_id);
		
	}

	@Override
	public void music_read(int art_number) throws Exception {
		sqlSession.selectOne(NAMESPACE + ".music_read", art_number);
	}

}
