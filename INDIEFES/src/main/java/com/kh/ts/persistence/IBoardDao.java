package com.kh.ts.persistence;

import java.util.List;

import com.kh.ts.domain.BoardVo;

public interface IBoardDao {
	// 글쓰기
	public void insert(BoardVo vo)throws Exception;
	
	// 글조회
	public BoardVo select(int board_number) throws Exception;
	
	// 글목록
	public List<BoardVo> selectAll() throws Exception;
	
}
