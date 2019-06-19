package com.kh.jij.persistence;


import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.jij.domain.art_infoVo;

@Repository
public class art_infoDaoImpl implements art_infoDao {
	
	private static final String NAMESPACE = "art";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insert(art_infoVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public void attach(String file_path) throws Exception {
		sqlSession.insert(NAMESPACE + ".attach", file_path);
	}

}
