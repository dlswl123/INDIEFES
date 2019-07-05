package com.kh.ts.service;


import java.util.List;

import com.kh.ts.domain.ReplyVo;

public interface IReplyService {

	// 댓글쓰기
	public void insert(ReplyVo replyVo)throws Exception;
	// 댓글수정
	public void update(ReplyVo replyVo)throws Exception;
	// 댓글삭제
	public void delete(int reply_board, int board_number)throws Exception;
	// 댓글목록
	public List<ReplyVo> list(int board_number)throws Exception;
}
