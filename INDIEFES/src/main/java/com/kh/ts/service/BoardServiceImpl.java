package com.kh.ts.service;

import java.util.List;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.persistence.IBoardDao;

@Service
public class BoardServiceImpl implements IBoardService {

	@Inject
	private IBoardDao boardDao;
	
	// 글쓰기
	@Transactional
	@Override
	public void insert(BoardVo vo) throws Exception {
		boardDao.insert(vo); // insert
		
	}
	// 글조회
	@Override
	public BoardVo select(int board_number) throws Exception {
		BoardVo vo = boardDao.select(board_number); // select
		return vo;
	}
	// 글목록
	@Override
	public List<BoardVo> selectAll() throws Exception {
		List<BoardVo> list = boardDao.selectAll(); // selectAll
		return list;
	}
	// 조회수
	@Override
	public void updateViewcnt(int board_number) throws Exception {
		boardDao.updateViewcnt(board_number); // updateViewcent
		System.out.println("BoardServiceImp, updateViewcnt 실행됨");
	}
	// 글수정
	@Override
	public void update(BoardVo vo) throws Exception {
		boardDao.update(vo); // update
	}
	// 글삭제
	@Override
	public void delete(int board_number) throws Exception {
		boardDao.delete(board_number); // delete
	}
}
