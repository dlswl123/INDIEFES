package com.kh.ts.service;



import java.util.List;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.ts.domain.ReplyVo;
import com.kh.ts.persistence.IBoardDao;
import com.kh.ts.persistence.IReplyDao;

@Service
public class ReplyServiceImpl implements IReplyService {

	@Inject
	private IReplyDao replyDao;
	
	@Inject
	private IBoardDao boardDao;
	
	// 댓글쓰기
	@Transactional
	@Override
	public void insert(ReplyVo replyVo) throws Exception {
		replyDao.insert(replyVo);
		boardDao.updateReplycnt(replyVo.getBoard_number());
	}

	// 댓글수정
	@Override
	public void update(ReplyVo replyVo) throws Exception {
		replyDao.update(replyVo);
	}

	// 댓글삭제
	@Transactional
	@Override
	public void delete(int reply_board, int board_number) throws Exception {
		replyDao.delete(reply_board);
		boardDao.updateReplycnt(board_number);
		
	}
	// 댓글목록
	@Override
	public List<ReplyVo> list(int board_number) throws Exception {
		List<ReplyVo> list = replyDao.list(board_number);
		return list;
	}

}
