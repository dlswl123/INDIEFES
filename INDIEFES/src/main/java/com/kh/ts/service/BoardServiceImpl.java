package com.kh.ts.service;

import java.util.List;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ts.domain.BoardVo;
import com.kh.ts.domain.PagingDto;
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
		String[] files = vo.getFiles();
		if (files !=null) {
			for (String file: files) {
				boardDao.attach(file); // insert
			}
		}
		
	}
	// 글조회
	@Override
	public BoardVo select(int board_number) throws Exception {
		BoardVo vo = boardDao.select(board_number); // select
		return vo;
	}
	// 글목록
	@Override
	public List<BoardVo> selectAll(PagingDto pagingDto) throws Exception {
		List<BoardVo> list = boardDao.selectAll(pagingDto); // selectAll
		return list;
	}
	// 조회수
	@Override
	public void updateViewcnt(int board_number) throws Exception {
		boardDao.updateViewcnt(board_number); // updateViewcent
		System.out.println("BoardServiceImp, updateViewcnt");
	}
	// 글수정
	@Override
	public void update(BoardVo vo) throws Exception {
		boardDao.update(vo); // update
	}
	// 글삭제
	@Transactional
	@Override
	public void delete(int board_number) throws Exception {
		List<String> list = boardDao.getAttach(board_number);
		if (list != null) {
			boardDao.deleteAttachByBno(board_number); // tbl_file 로우삭제
		}
		boardDao.delete(board_number); // delete
	}
	// 페이징갯수
	@Override
	public int listCount(PagingDto pagingDto) throws Exception {
		int count = boardDao.listCount(pagingDto);
		return count;
	}
	// 파일경로 가져오기
	@Override
	public List<String> getAttach(int board_number) throws Exception {
		List<String> list = boardDao.getAttach(board_number);
		return list;
	}
	// 파일삭제
	@Override
	public void deleteAttach(String file_path) throws Exception {
		boardDao.deleteAttach(file_path);
		
	}
	// 게시물파일삭제
	@Override
	public void deleteAttachByBno(int board_number) throws Exception {
		boardDao.deleteAttachByBno(board_number);
	}
}
