package com.kh.ks.persistence;

import java.util.List;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ts.domain.PagingDto;

public interface IUserInfoDao {
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception;
	
	public UserInfoVo readWith(String user_id) throws Exception;
	
	public boolean createAccount(UserInfoVo userInfoVo)throws Exception;
	
	public UserInfoVo idCheck(String user_id) throws Exception;
	
	public UserInfoVo nickCheck(String user_nick) throws Exception;
	
	public void userInfoAdjust(UserInfoVo userInfoVo) throws Exception;
	
	public void userDelete(String user_id) throws Exception;
	
	public List<UserInfoVo> userInfo(PagingDto pagingDto) throws Exception;
	
	public int userCount(PagingDto pagingDto)throws Exception;
}
