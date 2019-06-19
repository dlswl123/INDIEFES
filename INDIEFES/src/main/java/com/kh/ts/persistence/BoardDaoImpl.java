package com.kh.ts.persistence;

import java.util.List;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.ts.domain.BoardVo;

@Repository
public class BoardDaoImpl implements IBoardDao {

	private static final String Namespace = "board";
	
	@Inject
	private SqlSession sqlSession;

	// 글쓰기
	@Override
	public void insert(BoardVo vo) throws Exception {
		sqlSession.insert(Namespace + ".insert", vo);
	
	}
	// 글조회
	@Override
	public BoardVo select(int board_number) throws Exception {
		BoardVo vo = sqlSession.selectOne(Namespace + ".select", board_number);
		return vo;
	}
	// 글목록
	@Override
	public List<BoardVo> selectAll() throws Exception {
		List<BoardVo> list = sqlSession.selectList(Namespace + ".selectAll");
		return list;
	}
	
}
