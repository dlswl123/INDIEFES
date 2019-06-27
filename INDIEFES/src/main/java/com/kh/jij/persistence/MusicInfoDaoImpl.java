package com.kh.jij.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.jij.domain.MusicInfoVo;

@Repository
public class MusicInfoDaoImpl implements IMusicInfoDao {

	private static final String NAMESPACE = "music";

	@Inject
	private SqlSession sqlSession;
	
	// 음악정보 가져오기
	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = sqlSession.selectList(NAMESPACE + ".musicRead", art_number);
		return musicList;
	}

	@Override
	public void musicInsert(MusicInfoVo musicinfoVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", musicinfoVo);
	}

	
}
