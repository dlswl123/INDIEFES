package com.kh.jij.persistence;

import java.util.List;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.MusicInfoVo;

public interface IArtInfoDao {
	// 글쓰기
	public void insert(ArtInfoVo vo) throws Exception;
	
	// 파일경로 인서트(첨부)
	public void attach(String file_path) throws Exception;
	
	// 앨범 정보 가져오기
	public ArtInfoVo art_read(String user_id) throws Exception;
	
	// 노래 정보 가져오기
	public List<MusicInfoVo> music_read(int art_number) throws Exception;
}
