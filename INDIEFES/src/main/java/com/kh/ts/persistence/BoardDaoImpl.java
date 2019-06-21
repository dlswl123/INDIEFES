package com.kh.ts.persistence;

import java.util.List;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.domain.PagingDto;

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
	public List<BoardVo> selectAll(PagingDto pagingDto) throws Exception {
		List<BoardVo> list = sqlSession.selectList(Namespace + ".selectAll",pagingDto);
		return list;
	}
	// 조회수
	@Override
	public void updateViewcnt(int board_number) throws Exception {
		sqlSession.update(Namespace + ".updateViewcnt",board_number);
		System.out.println("BoardDaoImpl, updateViewcnt" );
		
	}
	// 글수정
	@Override
	public void update(BoardVo vo) throws Exception {
		sqlSession.update(Namespace + ".update",vo);
		
	}
	// 글삭제
	@Override
	public void delete(int board_number) throws Exception {
		sqlSession.delete(Namespace + ".delete",board_number);		
	}
}
