package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.GoodLogVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.domain.LikeLogVo;
import com.kh.jij.domain.TeamMemberVo;
import com.kh.ts.domain.PagingDto;
import com.kh.jij.domain.MusicInfoVo;
import com.kh.jij.domain.PayLogVo;
import com.kh.jij.domain.PlayListVo;

public interface IArtInfoDao {
	// 앨범입력
	public void insert(ArtInfoVo vo) throws Exception;
	
	// 입력앨범정보
	public ArtInfoVo artInfo(int team_number) throws Exception;
	
	// 팀생성
	public void teamInsert(IndieTeamVo vo) throws Exception;
	
	// 팀가입
	public void teamInput(TeamMemberVo vo) throws Exception;
	
	// 팀정보
	public List<TeamMemberVo> teamInfo(int team_number) throws Exception;
	
	// 팀앨범 리스트 가져오기
	public List<ArtInfoVo> teamArtList(int team_number) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo artRead(int art_number) throws Exception;
	
	// 앨범 수정정보 가져오기
	public ArtInfoVo artModifyFrom(String user_id, int art_number) throws Exception;
	
	// 앨범 수정
	public void artModify(ArtInfoVo artInfoVo) throws Exception;
	
	// 앨범 삭제
	public void artDelete(int art_number, String user_id) throws Exception;
	
	// 검색, paging, nowPage 나중에 추가할것.
	// 앨범 리스트 가져오기
	public List<ArtInfoVo> allArtList(PagingDto pagingDto) throws Exception;
	public List<IndieTeamVo> getIndieTeam() throws Exception;
	// 앨범 커버리스트 가져오기
	public List<String> getCover();
	
	// 팀넘버 가져오기
	public int getIndieNumber(String user_id) throws Exception;
	
	// 팀이름 가져오기
	public String getTeamName (int team_number) throws Exception;
	
	// 플레이리스트
	public List<PlayListVo> playListInfo(String user_id) throws Exception;
	
	// 리스트에 노래 가져오기
	public List<MusicInfoVo> playList(String user_id) throws Exception;
	
	// 리스트에서 곡 등록
	public void playInsert(PlayListVo vo) throws Exception;
	
	// 리스트에서 곡 삭제
	public void playDelete(int play_index) throws Exception;
	
	// 최신앨범
	public List<ArtInfoVo> toDayList(PagingDto pagingDto) throws Exception;
	
	// 최신앨범 수
	public int toDayCount()throws Exception;
	
	// 인기앨범
	public List<ArtInfoVo> goodList() throws Exception;
	
	// 앨범 수
	public int artCount(PagingDto pagingDto)throws Exception;
	
	// 카트에 담기
	public void cartInput(PayLogVo payVo)throws Exception;
	
	// 결제 목록
	public List<PayLogVo> payList(String user_id )throws Exception;
	
	// 결제 목록에서 삭제
	public void payDelete(PayLogVo payVo)throws Exception;
	
	// 결제 처리
	public void payOk(String user_id)throws Exception;
	
	// 앨범승인요청
	public void artUploadApproReq(int art_number, String user_id) throws Exception;
	// 업로드승인
	public void artUploadAppro(int art_number) throws Exception;
	// 업로드반려
	public void artUploadReturn(int art_number) throws Exception;
	
	// 앨범에 좋아요 수정
	public void artLikedCount(int liked_count, int art_number) throws Exception;
	// 좋아요 체크
	public int artLikedCheckById(LikeLogVo likeVo) throws Exception;
	// 좋아요 하기
	public void artLikedInsert(LikeLogVo likeVo) throws Exception;
	// 좋아요 취소
	public void artLikedDelete(LikeLogVo likeVo) throws Exception;
	// 해당앨범 좋아요수 체크
	public int artLikedCountCheck(int art_number) throws Exception;
	// 앨범에 추천수 수정
	public void artGoodCount(int good_count, int art_number) throws Exception;
	// 추천 하기
	public void artGoodInsert(GoodLogVo goodVo) throws Exception;
	// 추천 취소
	public void artGoodDelete(GoodLogVo goodVo) throws Exception;
	// 추천 체크
	public int artGoodCheckById(GoodLogVo goodVo) throws Exception; 
	// 해당앨범 추천수 체크
	public int artGoodCountCheck(int art_number) throws Exception;
}
