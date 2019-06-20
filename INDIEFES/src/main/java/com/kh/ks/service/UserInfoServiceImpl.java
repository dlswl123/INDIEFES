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

	@Override
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception {
		System.out.println("UserInfoServiceImpl, readWithPw, user_id:" + user_id); 
		System.out.println("UserInfoServiceImpl, readWithPw, user_pw:" + user_pw); // 2.Controller에서 넘어온 데이터 - Dao로 넘겨줌
		UserInfoVo userInfoVo = userInfoDao.readWithPw(user_id, user_pw);
		System.out.println("UserInfoServiceImpl, readWithPw, userInfoVo:" + userInfoVo); // 5.Dao에서 다시 받아온 데이터 -> Controller로 다시 넘겨줌
		return userInfoVo;
	}

}
