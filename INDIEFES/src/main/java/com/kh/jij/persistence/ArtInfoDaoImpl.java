package com.kh.jij.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.ts.domain.PagingDto;
import com.kh.jij.domain.MusicInfoVo;

@Repository
public class ArtInfoDaoImpl implements IArtInfoDao {

	private static final String NAMESPACE = "art";

	@Inject
	private SqlSession sqlSession;

	@Override
	public void insert(ArtInfoVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	@Override
	public ArtInfoVo artInfo(int team_number) throws Exception {
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artInfo",team_number);
		return artVo;
	}

	@Override
	public void teamInsert(IndieTeamVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".teamInsert", vo);
	}

	@Override
	public void teamInput(TeamMemberVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".memberInsert", vo);

	}
	@Override
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception {
		List<TeamMemberVo> memberList = sqlSession.selectList(NAMESPACE + ".memberList", team_number);
		return memberList;
	}
	@Override
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception {
		List<ArtInfoVo> teamArtList = sqlSession.selectList(NAMESPACE + ".teamArtList",team_number);
		return teamArtList;
	}
	@Override
	public ArtInfoVo artRead(int art_number) throws Exception {
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artRead", art_number);
		return artVo;
	}
	
	// 수정
	@Override
	public ArtInfoVo artModify(String user_id, int art_number) throws Exception {
		HashMap<String, Object> artMap = new HashMap<>();
		artMap.put("user_id", user_id);
		artMap.put("art_number", art_number);
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artModify", artMap);
		return artVo;
	}

	@Override
	public List<MusicInfoVo> musicRead(int art_number) throws Exception {
		List<MusicInfoVo> musicList = sqlSession.selectList(NAMESPACE + ".musicRead", art_number);
		return musicList;
	}

	@Override
	public List<ArtInfoVo> allArtList(PagingDto pagingDto) throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".artList", pagingDto);
		return artList;
	}

	@Override
	public List<IndieTeamVo> getIndieTeam() throws Exception {
		List<IndieTeamVo> teamList = sqlSession.selectList(NAMESPACE + ".getIndieTeam");
		return teamList;
	}

	@Override
	public List<String> getCover() {
		List<String> coverList = sqlSession.selectList(NAMESPACE + ".getCover");
		return coverList;
	}

	@Override
	public int getIndieNumber(String user_id) throws Exception {
		int indieNumber = sqlSession.selectOne(NAMESPACE + ".getIndieNumber", user_id);
		return indieNumber;
	}

	@Override
	public String getTeamName(int team_number) throws Exception {
		String teamName = sqlSession.selectOne(NAMESPACE + ".getTeamName", team_number);
		return teamName;
	}

	@Override
	public int artCount(PagingDto pagingDto) throws Exception {
		int artCount = sqlSession.selectOne(NAMESPACE + ".artCount", pagingDto);
		return artCount;
	}

}
