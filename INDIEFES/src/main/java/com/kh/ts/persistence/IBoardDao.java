package com.kh.ts.persistence;

import java.util.List;

import com.kh.ts.domain.BoardVo;

public interface IBoardDao {
	// �۾���
	public void insert(BoardVo vo)throws Exception;
	// ����ȸ
	public BoardVo select(int board_number)throws Exception;
	// �۸��
	public List<BoardVo> selectAll()throws Exception;
	// ��ȸ��
	public void updateViewcnt(int board_number)throws Exception;
	// �ۼ���
	public void update(BoardVo vo)throws Exception;
	// �ۻ���
	public void delete(int board_number)throws Exception;
	
}
