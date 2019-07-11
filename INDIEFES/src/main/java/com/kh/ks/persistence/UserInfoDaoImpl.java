package com.kh.ks.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.kh.ks.domain.UserInfoVo;
import com.kh.ks.service.UserInfoServiceImpl;
import com.kh.ts.domain.PagingDto;

@Repository
public class UserInfoDaoImpl implements IUserInfoDao {
	Logger logger = LoggerFactory.getLogger(UserInfoServiceImpl.class);

	@Inject
	private SqlSession sqlsession;
	
	private static final String NAMESPACE = "userinfo";
	
	// 회원로그인
	@Override
	public UserInfoVo readWithPw(String user_id, String user_pw) throws Exception {
//		System.out.println("UserInfoDaoImpl, readWithPw, user_id:" + user_id); 
//		System.out.println("UserInfoDaoImpl, readWithPw, user_pw:" + user_pw); // 3.service에서 넘어온 데이터
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("user_id", user_id);
		paramMap.put("user_pw", user_pw);
		UserInfoVo userInfoVo = sqlsession.selectOne(NAMESPACE + ".readWithPw", paramMap);
//		System.out.println("UserInfoDaoImpl, readWithPw, userInfoVo:" + userInfoVo); // 4.다시 service로 넘겨줌
		return userInfoVo;
	}

	// 회원정보조회
	@Override
	public UserInfoVo readWith(String user_id) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("user_id", user_id);
		UserInfoVo userInfoVo = sqlsession.selectOne(NAMESPACE + ".readWith", paramMap); 
		return userInfoVo;
	}

	// 회원가입
	@Override
	public boolean createAccount(UserInfoVo userInfoVo) throws Exception {
//		System.out.println("Dao createAccount 호출됨");
//		System.out.println("Dao createAccount userInfoVo : " + userInfoVo);
		sqlsession.insert(NAMESPACE + ".createAccount", userInfoVo); 
		return true;
	}

	// 아이디 중복체크
	@Override
	public UserInfoVo idCheck(String user_id) throws Exception {
//		System.out.println("아이디 중복 체크 Daoimpl : " + user_id);
		UserInfoVo idChk = sqlsession.selectOne(NAMESPACE + ".idCheck", user_id);
//		System.out.println("아이디 중복 체크 Daoimpl(service로 넘겨주는 데이터) : " + idChk);
		return idChk;
	}

	// 닉네임 중복체크
	@Override
	public UserInfoVo nickCheck(String user_nick) throws Exception {
//		System.out.println("닉네임 중복 체크 Daoimpl : " + user_nick);
		UserInfoVo nickChk = sqlsession.selectOne(NAMESPACE + ".nickCheck", user_nick);
//		System.out.println("닉네임 중복 체크 Daoimpl(service로 넘겨주는 데이터) : " + nickChk);
		return nickChk;
	}

	// 회원정보 수정
	@Override
	public void userInfoAdjust(UserInfoVo userInfoVo) throws Exception {
		
		sqlsession.update(NAMESPACE + ".userUpdate", userInfoVo);
		
	}

	@Override
	public void userDelete(String user_id) throws Exception {
//		System.out.println(user_id);
		sqlsession.update(NAMESPACE + ".userDelete", user_id);
	}

	// 회원목록
	@Override
	public List<UserInfoVo> userInfo(PagingDto pagingDto) throws Exception {
//		System.out.println("userinfoimpl 실행됨");
		List<UserInfoVo> list = sqlsession.selectList(NAMESPACE + ".userInfo", pagingDto);
		return list;
	}

	// 회원수
	@Override
	public int userCount(PagingDto pagingDto) throws Exception {
		int count = sqlsession.selectOne(NAMESPACE + ".userCount", pagingDto);
//		System.out.println("userDaoImpl userCount 실행됨 :" + count);
		return count;
	}

	// 인디 팀 신청
	@Override
	public void userIndieUpdate(String user_id) throws Exception {
		sqlsession.update(NAMESPACE + ".userIndieUpdate", user_id);
	}

	

	

	
	
	
	
	
	
	

}
