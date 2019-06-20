package com.kh.ts.service;

import java.util.List;

import com.kh.ts.domain.BoardVo;

public interface IBoardService {
	// �۾���
	public void insert(BoardVo vo) throws Exception;
	// ����ȸ
	public BoardVo select(int board_number) throws Exception;
	// �۸��
	public List<BoardVo> selectAll() throws Exception;
	// ��ȸ��
	public void updateViewcnt(int board_number) throws Exception;
}
