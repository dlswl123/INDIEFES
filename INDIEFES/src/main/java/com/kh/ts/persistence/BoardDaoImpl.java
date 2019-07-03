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
	// 페이지갯수
	@Override
	public int listCount(PagingDto pagingDto) throws Exception {
		int count = sqlSession.selectOne(Namespace + ".listCount", pagingDto);
		return count;
	}
	// 파일경로 Insert
	@Override
	public void attach(String file_path) throws Exception {
		sqlSession.insert(Namespace + ".attach", file_path);
		
	}
	// 파일경로 Get
	@Override
	public List<String> getAttach(int board_number) throws Exception {
		List<String> list = sqlSession.selectList(Namespace + ".getAttach", board_number);
		return list;
	}
	// 파일삭제 
	@Override
	public void deleteAttach(String file_path) throws Exception {
		sqlSession.delete(Namespace + ".deleteAttach", file_path);
		
	}
	// 파일데이터삭제
	@Override
	public void deleteAttachByBno(int board_number) throws Exception {
		sqlSession.delete(Namespace + ".deleteAttachByBno", board_number);
		
	}
	// 댓글업데이트
	@Override
	public void updateReplycnt(int board_number) throws Exception {
		sqlSession.update(Namespace + ".updateReplycnt", board_number);
	}
}
