package com.kh.ts.persistence;

import java.util.List;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.domain.PagingDto;

public interface IBoardDao {
	// 글쓰기
	public void insert(BoardVo vo) throws Exception;
	// 글조회
	public BoardVo select(int board_number) throws Exception;
	// 글목록
	public List<BoardVo> selectAll(PagingDto pagingDto) throws Exception;
	// 조회수
	public void updateViewcnt(int board_number) throws Exception;
	// 글수정
	public void update(BoardVo vo) throws Exception;
	// 글삭제
	public void delete(int board_number) throws Exception;
	// 페이지갯수
	public int listCount(PagingDto pagingDto) throws Exception;
	// 댓글 갯수 업데이트
	public void updateReplycnt(int board_number) throws Exception;
	// 글쓰기시 파일경로 Insert 
	public void attach(String file_path) throws Exception;
	// 파일경로 Get
	public List<String> getAttach(int board_number) throws Exception;
	// 파일삭제
	public void deleteAttach(String file_path) throws Exception;
	// 파일데이터삭제
	public void deleteAttachByBno(int board_number) throws Exception;
	// 수정시 파일 첨부
	public void attachUpdate(BoardVo vo) throws Exception;
}
