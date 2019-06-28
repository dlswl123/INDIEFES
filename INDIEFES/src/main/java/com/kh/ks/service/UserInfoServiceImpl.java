package com.kh.ks.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ks.persistence.IUserInfoDao;

@Service
public class UserInfoServiceImpl implements IUserInfoService {
	
	
	@Inject
	private IUserInfoDao userInfoDao;

	// 회원정보(아이디, 비밀번호 입력)
	@Override
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception {
//		System.out.println("UserInfoServiceImpl, readWithPw, user_id:" + user_id); 
//		System.out.println("UserInfoServiceImpl, readWithPw, user_pw:" + user_pw); // 2.Controller에서 넘어온 데이터 - Dao로 넘겨줌
		UserInfoVo userInfoVo = userInfoDao.readWithPw(user_id, user_pw);
//		System.out.println("UserInfoServiceImpl, readWithPw, userInfoVo:" + userInfoVo); // 5.Dao에서 다시 받아온 데이터 -> Controller로 다시 넘겨줌
		return userInfoVo;
	}

	//회원정보 (아이디만 입력)
	@Override
	public UserInfoVo readWith(String user_id) throws Exception {
		UserInfoVo userInfoVo = userInfoDao.readWith(user_id);
//		System.out.println("UserInfoServiceImpl, readWith, userInfoVo:" + userInfoVo); 
		return userInfoVo;
	}

	// 회원가입
	@Override
	public boolean createAccount(UserInfoVo userInfoVo) throws Exception {
//		System.out.println("serive createAccount 호출됨");
//		System.out.println("serive createAccount userInfoVo : " + userInfoVo);
		userInfoDao.createAccount(userInfoVo);
		
		return true;
	}

	// 아이디 중복 체크
	@Override
	public UserInfoVo idCheck(String user_id) throws Exception {
		System.out.println("아이디 중복 체크 service : " + user_id);
		UserInfoVo idChk = userInfoDao.idCheck(user_id);
		System.out.println("아이디 중복 체크 service(Controller로 넘겨주는 데이터) : " + idChk);
		return idChk;
	}

	// 닉네임 중복 체크
	@Override
	public UserInfoVo nickCheck(String user_nick) throws Exception {
		System.out.println("닉네임 중복 체크 service : " + user_nick);
		UserInfoVo nickChk = userInfoDao.nickCheck(user_nick);
		System.out.println("닉네임 중복 체크 service(Controller로 넘겨주는 데이터) : " + nickChk);
		return nickChk;
	}

}
