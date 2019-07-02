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
import com.kh.jij.domain.PlayListVo;

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
	public ArtInfoVo artModifyFrom(String user_id, int art_number) throws Exception {
		HashMap<String, Object> artMap = new HashMap<>();
		artMap.put("user_id", user_id);
		artMap.put("art_number", art_number);
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artModifyFrom", artMap);
		return artVo;
	}
	
	// 수정처리
	@Override
	public void artModify(ArtInfoVo artInfoVo) throws Exception {
		sqlSession.update(NAMESPACE + ".artModify", artInfoVo);
	}
	
	// 삭제처리
	@Override
	public void artDelete(int art_number, String user_id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("art_number", art_number);
		map.put("user_id", user_id);
		sqlSession.update(NAMESPACE + ".artDelete", map);
	}
	
	// 앨범 리스트 가져오기
	@Override
	public List<ArtInfoVo> allArtList(PagingDto pagingDto) throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".artList", pagingDto);
		return artList;
	}

	// 인디팀 목록 가져오기
	@Override
	public List<IndieTeamVo> getIndieTeam() throws Exception {
		List<IndieTeamVo> teamList = sqlSession.selectList(NAMESPACE + ".getIndieTeam");
		return teamList;
	}

	// 커버 가져오기
	@Override
	public List<String> getCover() {
		List<String> coverList = sqlSession.selectList(NAMESPACE + ".getCover");
		return coverList;
	}

	// 인디번호 가져오기
	@Override
	public int getIndieNumber(String user_id) throws Exception {
		int indieNumber = sqlSession.selectOne(NAMESPACE + ".getIndieNumber", user_id);
		return indieNumber;
	}

	// 인디팀명 가져오기
	@Override
	public String getTeamName(int team_number) throws Exception {
		String teamName = sqlSession.selectOne(NAMESPACE + ".getTeamName", team_number);
		return teamName;
	}

	// 플레이리스트 정보
	@Override
	public List<PlayListVo> playListInfo(String user_id) throws Exception {
		List<PlayListVo> playListInfo = sqlSession.selectList(NAMESPACE + ".playListInfo", user_id);
		return playListInfo;
	}
		
	// 등록된 총 앨범수 구하기
	@Override	
	public int artCount(PagingDto pagingDto) throws Exception {
		int artCount = sqlSession.selectOne(NAMESPACE + ".artCount", pagingDto);
		return artCount;
	}
	
	// 플레이리스트
	@Override
	public List<MusicInfoVo> playList(String user_id) throws Exception {
		List<MusicInfoVo> playList = sqlSession.selectList(NAMESPACE + ".playList", user_id);
		return playList;
	}
	
	// 플레이리스트 추가
	@Override
	public void playInsert(PlayListVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".playInsert", vo);
		
	}
	
	// 플레이 리스트 삭제
	@Override
	public void playDelete(int play_index) throws Exception {
		sqlSession.delete(NAMESPACE + ".playDelete", play_index);
		
	}

	@Override
	public List<ArtInfoVo> toDayList(PagingDto pagingDto) throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".toDayList",pagingDto);
		return artList;
	}
	@Override
	public List<ArtInfoVo> goodList() throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".goodList");
		return artList;
	}

	@Override
	public int toDayCount() throws Exception {
		int artCount = sqlSession.selectOne(NAMESPACE + ".toDayCount");
		return artCount;
	}

}
