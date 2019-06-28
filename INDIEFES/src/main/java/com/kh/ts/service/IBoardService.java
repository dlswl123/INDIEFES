package com.kh.ts.service;

import java.util.List;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.domain.PagingDto;

public interface IBoardService {
	// 글쓰기
	public void insert(BoardVo vo)throws Exception;
	// 글조회
	public BoardVo select(int board_number)throws Exception;
	// 글목록
	public List<BoardVo> selectAll(PagingDto pagingDto)throws Exception;
	// 조회수
	public void updateViewcnt(int board_number)throws Exception;
	// 글수정
	public void update(BoardVo vo)throws Exception;
	// 글삭제
	public void delete(int board_number)throws Exception;
	// 페이지갯수
	public int listCount(PagingDto pagingDto)throws Exception;
	// 파일경로가져오기
	public List<String> getAttach(int board_number)throws Exception;
	// 파일삭제
	public void deleteAttach(String file_path)throws Exception;
	// 게시글파일삭제
	public void deleteAttachByBno(int board_number)throws Exception;
}
