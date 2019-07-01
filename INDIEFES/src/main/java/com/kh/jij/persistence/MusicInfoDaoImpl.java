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
	
	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = sqlSession.selectList(NAMESPACE + ".musicRead", art_number);
		return musicList;
	}

	@Override
	public void musicInsert(MusicInfoVo musicInfoVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".musicInsert", musicInfoVo);
		
	}

	@Override
	public int getMaxTrackNum(int art_number) throws Exception {
		int track_number = 0;
		String tNum = sqlSession.selectOne(NAMESPACE + ".getMaxTrackNum", art_number);
		if(tNum == null) {
			track_number = 0;
		} else {
			track_number = Integer.parseInt(tNum);
		}
		return track_number;
	}

	@Override
	public void musicUpdate(MusicInfoVo musicInfoVo) throws Exception {
		sqlSession.update(NAMESPACE + ".musicUpdate", musicInfoVo);
	}

	@Override
	public void musicDelete(MusicInfoVo musicInfoVo) throws Exception {
		sqlSession.update(NAMESPACE + ".musicDelete", musicInfoVo);
		
	}
	
}
