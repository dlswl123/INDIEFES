package com.kh.ks.persistence;

import com.kh.ks.domain.UserInfoVo;

public interface IUserInfoDao {
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception;
}
