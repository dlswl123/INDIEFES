package com.kh.ts.persistence;

import java.util.List;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.ts.domain.ReplyVo;

@Repository
public class ReplyDaoImpl implements IReplyDao {

	private static final String NAMESPACE = "reply";
	
	@Inject
	private SqlSession sqlSession;
	
	// 댓글쓰기
	@Override
	public void insert(ReplyVo replyVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", replyVo);
	}
	
	// 댓글수정
	@Override
	public void update(ReplyVo replyVo) throws Exception {
		sqlSession.update(NAMESPACE + ".update", replyVo);
		
	}

	// 댓글삭제
	@Override
	public void delete(int reply_number) throws Exception {
		sqlSession.delete(NAMESPACE + ".delete", reply_number);
		
	}

	// 댓글목록
	@Override
	public List<ReplyVo> list(int board_number) throws Exception {
		System.out.println("ReplyDaoImpl, list() 실행됨");
		List<ReplyVo> list = sqlSession.selectList(NAMESPACE + ".list", board_number);
		return list;
	}


}
