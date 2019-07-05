package com.kh.ts.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ks.service.IUserInfoService;
import com.kh.ts.domain.ReplyVo;
import com.kh.ts.service.IReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	
	@Inject
	private IReplyService replyService;
	
	@Inject
	private IUserInfoService userInfoService;
	
	// 댓글 입력
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ResponseEntity<String> insert(@RequestBody ReplyVo replyVo, 
			HttpSession session) throws Exception {
		System.out.println("ReplyControler, insert() 실행됨");
		ResponseEntity<String> entity = null;
		try {
			UserInfoVo userInfoVo =(UserInfoVo)session.getAttribute("userInfoVo");
//			System.out.println("ReplyControler, insert(), userInfoVo:" + userInfoVo);
//			System.out.println("ReplyControler, insert(), replyVo:" + replyVo);
			replyVo.setUser_id(userInfoVo.getUser_id());
			replyService.insert(replyVo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	// 댓글 수정
	@RequestMapping(value="/update/{reply_number}", method=RequestMethod.PUT)
	public ResponseEntity<String> update(@PathVariable("reply_number") int reply_number,
										@RequestBody ReplyVo replyVo) {
		replyVo.setReply_number(reply_number);
		System.out.println("ReplyController reply_number:" + reply_number);
		ResponseEntity<String> entity = null;
		try {
			replyService.update(replyVo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 댓글 삭제
	@RequestMapping(value="/delete/{reply_number}/{board_number}", method=RequestMethod.DELETE)
	public ResponseEntity<String> delete(
			@PathVariable("reply_number") int reply_number,
			@PathVariable("board_number") int board_number) {
//		System.out.println("ReplyController reply_number:" + reply_number);
		ResponseEntity<String> entity = null;
		try {
			replyService.delete(reply_number, board_number);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 댓글목록
	@RequestMapping(value="/list/{board_number}", method=RequestMethod.GET)
	public ResponseEntity<List<ReplyVo>> list(@PathVariable("board_number") int board_number) {
		ResponseEntity<List<ReplyVo>> entity = null;
		try {
			List<ReplyVo> list = replyService.list(board_number);
			System.out.println("ReplyController, list(), list:" + list);
			entity = new ResponseEntity<List<ReplyVo>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVo>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
