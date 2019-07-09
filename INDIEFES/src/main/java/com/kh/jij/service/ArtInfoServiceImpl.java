package com.kh.jij.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.GoodLogVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.LikeLogVo;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.PayLogVo;
import com.kh.jij.domain.PlayListVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.jij.persistence.IArtInfoDao;
import com.kh.jij.persistence.IMusicInfoDao;
import com.kh.ts.domain.PagingDto;


@Service
public class ArtInfoServiceImpl implements IArtInfoService {
	
	@Inject
	private IArtInfoDao artDao;

	@Inject
	private IMusicInfoDao musicDao;
	
	// 앨범정보입력
	@Override
	public void insert(ArtInfoVo vo) throws Exception {
		artDao.insert(vo);
	}
	
	// 입력앨범정보
	@Override
	public ArtInfoVo artInfo(int team_number) throws Exception {
		ArtInfoVo artVo = artDao.artInfo(team_number);
		return artVo;
	}
	
	// 팀생성
	@Transactional
	@Override
	public void teamInsert(Map<String, Object> map) throws Exception {
		IndieTeamVo teamVo = (IndieTeamVo)map.get("teamVo");
		String user_id = (String)map.get("user_id");
		String user_nick = (String)map.get("user_nick");
		TeamMemberVo memberVo = new TeamMemberVo();
		memberVo.setUser_id(user_id);
		memberVo.setUser_nick(user_nick);
		memberVo.setTeam_level(0);
		artDao.teamInsert(teamVo);
		artDao.teamInput(memberVo);
		
	}
	// 팀가입
	@Override
	public void teamInput(TeamMemberVo vo) throws Exception {
		vo.setTeam_level(1);
		artDao.teamInput(vo);
	}
	// 팀 정보
	@Override
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception {
		List<TeamMemberVo> memberList = artDao.teamInfo(team_number);
		return memberList;
	}
	// 팀 앨범
	@Override
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception {
		List<ArtInfoVo> teamArtList = artDao.teamArtList(team_number);
		return teamArtList;
	}
	// 앨범 읽기
	@Override
	public ArtInfoVo artRead(int art_number) throws Exception {
		ArtInfoVo artVo = artDao.artRead(art_number);
		return artVo;
	}
	// 앨범 수정폼
	@Override
	public ArtInfoVo artModifyForm(String user_id, int art_number) throws Exception {
		ArtInfoVo artVo = artDao.artModifyFrom(user_id, art_number);
		return artVo;
	}
	// 앨범 수정처리
	@Override
	public void artModify(ArtInfoVo artInfoVo) throws Exception {
		artDao.artModify(artInfoVo);
	}
	// 앨범 삭제
	@Override
	public void artDelete(int art_number, String user_id) throws Exception {
		artDao.artDelete(art_number, user_id);
	}
	// 앨범 리스트
	@Override
	public List<ArtInfoVo> allArtList(PagingDto pagingDto) throws Exception {
		List<ArtInfoVo> artList = artDao.allArtList(pagingDto);
		return artList;
	}
	// 인디그룹 이름 가져오기
	@Override
	public List<IndieTeamVo> getIndieTeam() throws Exception {
		List<IndieTeamVo> teamList = artDao.getIndieTeam();
		return teamList;
	}
	// 앨범 커버이미지
	@Override
	public List<String> getCover() {
		List<String> coverList =  artDao.getCover();
		return coverList;
	}
	// 팀 넘버
	@Override
	public int getIndieNumber(String user_id) throws Exception {
		int indieNumber = artDao.getIndieNumber(user_id);
		return indieNumber;
	}
	// 팀 이름
	@Override
	public String getTeamName(int team_number) throws Exception {
		String teamName = artDao.getTeamName(team_number);
		return teamName;
	}
	// 앨범 수
	@Override
	public int artCount(PagingDto pagingDto) throws Exception {
		int artCount = artDao.artCount(pagingDto);
		return artCount;
	}
	// 플레이리스트
	@Override
	public List<PlayListVo> playListInfo(String user_id) throws Exception {
		List<PlayListVo> playListInfo = artDao.playListInfo(user_id);
		return playListInfo;
	}
	// 리스트에 곡 가져오기
	@Override
	public List<MusicInfoVo> playList(String user_id) throws Exception {
		List<MusicInfoVo> playList = artDao.playList(user_id);
		return playList;
	}
	
	// 리스트에서 곡 등록
	@Override
	public void playInsert(Map<String, Object> map) throws Exception {
		MusicInfoVo musicVo = (MusicInfoVo)map.get("musicVo");
		String user_id = (String)map.get("user_id");
//		System.out.println(user_id);
//		System.out.println(musicVo);
		PlayListVo vo = new PlayListVo();
		vo.setUser_id(user_id);
		vo.setMusic_number(musicVo.getMusic_number());
		System.out.println(vo);
		artDao.playInsert(vo);
		
	}
	// 리스트에서 곡 삭제
	@Override
	public void playDelete(int play_index) throws Exception {
		artDao.playDelete(play_index);
	}
	// 최신앨범
	@Override
	public List<ArtInfoVo> toDayList() throws Exception {
		List<ArtInfoVo> artList = artDao.toDayList();
		return artList;
	}
	// 인기앨범
	@Override
	public List<ArtInfoVo> goodList() throws Exception {
		List<ArtInfoVo> artList = artDao.goodList();
		return artList;
	}
	// 카트에 담기
	@Override
	public void cartInput(PayLogVo payVo) throws Exception {
		artDao.cartInput(payVo);
	}
	// 결제 리스트
	@Override
	public List<PayLogVo> payList(String user_id) throws Exception {
		List<PayLogVo> payList = artDao.payList(user_id);
		return payList;
	}
	// 결제 목록 삭제
	@Override
	public void payDelete(PayLogVo payVo) throws Exception {
		artDao.payDelete(payVo);
	}
	// 결제 처리
	@Override
	public void payOk(String user_id) throws Exception {
		artDao.payOk(user_id);
	}
	// 앨범등록 승인요청
	@Transactional
	@Override
	public void artUploadApproReq(int art_number, String user_id, int team_number) throws Exception {
		artDao.artUploadApproReq(art_number, user_id);
		musicDao.musicUploadApproReq(art_number, team_number);
	}
	
	// 앨범등록 승인
	@Transactional
	@Override
	public void artUploadAppro(int art_number) throws Exception {
		artDao.artUploadAppro(art_number);
		musicDao.musicUploadAppro(art_number);
	}

	// 앨범등록 반려
	@Transactional
	@Override
	public void artUploadReturn(int art_number) throws Exception {
		artDao.artUploadReturn(art_number);
		musicDao.musicUploadReturn(art_number);
	}

	@Override
	public void artLikedCount(int liked_count, int art_number) throws Exception {
		artDao.artLikedCount(liked_count, art_number);
	}

	@Override
	public List<LikeLogVo> artLikedCheckById(LikeLogVo likeVo, String nowPage) throws Exception {
		List<LikeLogVo> list = artDao.artLikedCheckById(likeVo, nowPage);
		return list;
	}

	@Override
	public void artLikedInsert(LikeLogVo likeVo) throws Exception {
		artDao.artLikedInsert(likeVo);
	}

	@Override
	public void artLikedDelete(LikeLogVo likeVo) throws Exception {
		artDao.artLikedDelete(likeVo);
	}

	@Override
	public void artGoodCount(int good_count, int art_number) throws Exception {
		artDao.artGoodCount(good_count, art_number);
	}

	@Override
	public void artGoodInsert(GoodLogVo goodVo) throws Exception {
		artDao.artGoodInsert(goodVo);
	}

	@Override
	public void artGoodDelete(GoodLogVo goodVo) throws Exception {
		artDao.artGoodDelete(goodVo);
	}

	@Override
	public int artGoodCheckById(GoodLogVo goodVo) throws Exception {
		int count = artDao.artGoodCheckById(goodVo);
		return count;
	}

	@Override
	public int artLikedCountCheck(int art_number) throws Exception {
		int likedCount = artDao.artLikedCountCheck(art_number);
		return likedCount;
	}

	@Override
	public int artGoodCountCheck(int art_number) throws Exception {
		int goodCount = artDao.artGoodCountCheck(art_number);
		return goodCount;
	}
}
