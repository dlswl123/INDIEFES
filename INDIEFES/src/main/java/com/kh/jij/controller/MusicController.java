package com.kh.jij.controller;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.jij.persistence.IMusicInfoDao;

@Controller
@RequestMapping("music/*")
public class MusicController {

	@Inject
	IMusicInfoDao musicService;
	
}
