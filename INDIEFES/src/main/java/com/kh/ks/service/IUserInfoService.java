package com.kh.ks.service;

import com.kh.ks.domain.UserInfoVo;

public interface IUserInfoService {
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception;
}
