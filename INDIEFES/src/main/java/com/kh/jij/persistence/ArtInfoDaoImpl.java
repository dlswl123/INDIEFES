package com.kh.jij.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.GoodLogVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.LikeLogVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.ts.domain.PagingDto;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.PayLogVo;
import com.kh.jij.domain.PlayListVo;

@Repository
public class ArtInfoDaoImpl implements IArtInfoDao {

	private static final String NAMESPACE = "art";

	@Inject
	private SqlSession sqlSession;

	// 앨범작성
	@Override
	public void insert(ArtInfoVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	// 앨범정보
	@Override
	public ArtInfoVo artInfo(int team_number) throws Exception {
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artInfo",team_number);
		return artVo;
	}
	// 팀 생성
	@Override
	public void teamInsert(IndieTeamVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".teamInsert", vo);
	}
	// 팀 가입
	@Override
	public void teamInput(TeamMemberVo vo) throws Exception {
		sqlSession.insert(NAMESPACE + ".memberInsert", vo);

	}
	// 팀 정보
	@Override
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception {
		List<TeamMemberVo> memberList = sqlSession.selectList(NAMESPACE + ".memberList", team_number);
		return memberList;
	}
	// 팀 앨범정보
	@Override
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception {
		List<ArtInfoVo> teamArtList = sqlSession.selectList(NAMESPACE + ".teamArtList",team_number);
		return teamArtList;
	}
	// 앨범정보
	@Override
	public ArtInfoVo artRead(int art_number) throws Exception {
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artRead", art_number);
		return artVo;
	}
	// 앨범 수정
	@Override
	public ArtInfoVo artModifyFrom(String user_id, int art_number) throws Exception {
		HashMap<String, Object> artMap = new HashMap<>();
		artMap.put("user_id", user_id);
		artMap.put("art_number", art_number);
		ArtInfoVo artVo = sqlSession.selectOne(NAMESPACE + ".artModifyFrom", artMap);
		return artVo;
	}
	
	// 앨범 수정처리
	@Override
	public void artModify(ArtInfoVo artInfoVo) throws Exception {
		sqlSession.update(NAMESPACE + ".artModify", artInfoVo);
	}
	
	// 앨범 삭제처리
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
	
	// 리더인디번호 가져오기
	@Override
	public List<Integer> getIndieNumberByLeader(String user_id) throws Exception {
		List<Integer> indieNumber = sqlSession.selectList(NAMESPACE + ".getIndieNumber", user_id);
		return indieNumber;
	}
	
	// 리더 팀 목록 가져오기
	@Override
	public IndieTeamVo getIndieTeamByLeader(int team_number) throws Exception {
		IndieTeamVo vo = sqlSession.selectOne(NAMESPACE + ".getIndieTeamByLeader", team_number);
		return vo;
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
	
	// 최신 앨범 
	@Override
	public List<ArtInfoVo> toDayList() throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".toDayList");
		return artList;
	}
	// 인기 앨범
	@Override
	public List<ArtInfoVo> goodList() throws Exception {
		List<ArtInfoVo> artList = sqlSession.selectList(NAMESPACE + ".goodList");
		return artList;
	}
	// 카트에 담기
	@Override
	public void cartInput(PayLogVo payVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".cartInput", payVo);
		
	}
	// 결제 목록
	@Override
	public List<PayLogVo> payList(String user_id) throws Exception {
		List<PayLogVo> payList = sqlSession.selectList(NAMESPACE + ".payList",user_id);
		return payList;
	}
	// 결제 목록 삭제
	@Override
	public void payDelete(PayLogVo payVo) throws Exception {
		sqlSession.delete(NAMESPACE + ".payDelete", payVo);
		
	}
	// 결제 처리
	@Override
	public void payOk(String user_id) throws Exception {
		sqlSession.update(NAMESPACE + ".payOk",user_id);
	}
	// 앨범등록 승인요청
	@Override
	public void artUploadApproReq(int art_number, String user_id) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("art_number", art_number);
		map.put("user_id", user_id);
		sqlSession.update(NAMESPACE + ".artUploadApproReq", map);
	}
	
	// 앨범등록 승인
	@Override
	public void artUploadAppro(int art_number) throws Exception {
		sqlSession.update(NAMESPACE + ".artUploadAppro", art_number);
	}
	@Override
	public void artUploadReturn(int art_number) throws Exception {
		sqlSession.update(NAMESPACE + ".artUploadReturn", art_number);
	}
	@Override
	public void artLikedCount(int liked_count, int art_number) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("liked_count", liked_count);
		map.put("art_number", art_number);
		sqlSession.update(NAMESPACE + ".artLikedCount", map);
	}
	@Override
	public List<LikeLogVo> artLikedCheckById(LikeLogVo likeVo, String nowPage) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_id", likeVo.getUser_id());
		map.put("art_number", likeVo.getArt_number());
		map.put("nowPage", nowPage);
//		System.out.println("ArtInfoDao, map:" + map);
		List<LikeLogVo> list = sqlSession.selectList(NAMESPACE + ".artLikedCheckById", map);
		return list;
	}
	@Override
	public void artLikedInsert(LikeLogVo likeVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".artLikedInsert", likeVo);
	}
	@Override
	public void artLikedDelete(LikeLogVo likeVo) throws Exception {
		sqlSession.delete(NAMESPACE + ".artLikedDelete", likeVo);
	}
	@Override
	public void artGoodCount(int good_count, int art_number) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("good_count", good_count);
		map.put("art_number", art_number);
		sqlSession.update(NAMESPACE + ".artGoodCount", map);
	}
	@Override
	public void artGoodInsert(GoodLogVo goodVo) throws Exception {
		sqlSession.insert(NAMESPACE + ".artGoodInsert", goodVo);
	}
	@Override
	public void artGoodDelete(GoodLogVo goodVo) throws Exception {
		sqlSession.delete(NAMESPACE + ".artGoodDelete", goodVo);
	}
	@Override
	public List<GoodLogVo> artGoodCheckById(GoodLogVo goodVo, String nowPage) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_id", goodVo.getUser_id());
		map.put("art_number", goodVo.getArt_number());
		map.put("nowPage", nowPage);
		List<GoodLogVo> goodList = sqlSession.selectList(NAMESPACE + ".artGoodCheckById", map);
		return goodList;
	}
	@Override
	public int artLikedCountCheck(int art_number) throws Exception {
		int likedCount = sqlSession.selectOne(NAMESPACE + ".artLikedCountCheck", art_number);
		return likedCount;
	}
	@Override
	public int artGoodCountCheck(int art_number) throws Exception {
		int goodCount = sqlSession.selectOne(NAMESPACE + ".artGoodCountCheck", art_number);
		return goodCount;
	}
	
	// 팀넘버 갯수 가져오기
	@Override
	public int getIndieNumberCount(String user_id) throws Exception {
		int count = sqlSession.selectOne(NAMESPACE + ".getIndieNumberCount", user_id);
		return count;
	}
	
	
}
