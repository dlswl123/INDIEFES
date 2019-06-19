package com.kh.jij.persistence;

import com.kh.jij.domain.art_infoVo;

public interface art_infoDao {
	// 글쓰기
	public void insert(art_infoVo vo) throws Exception;
	
	// 파일경로 인서트(첨부)
	public void attach(String file_path) throws Exception;
	
}
