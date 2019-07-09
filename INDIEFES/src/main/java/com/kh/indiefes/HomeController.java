package com.kh.indiefes;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.jij.domain.ArtInfoVo;
import com.kh.jij.domain.IndieTeamVo;
import com.kh.jij.service.IArtInfoService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	IArtInfoService artService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception{
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		logger.info("serverTime : {}", formattedDate);
		
//		model.addAttribute("serverTime", formattedDate );
		// 최신앨범
		List<ArtInfoVo> toDayList = artService.toDayList();
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		model.addAttribute("toDayList", toDayList);
		model.addAttribute("teamList", teamList);
		// 인기앨범
		List<ArtInfoVo> goodList = artService.goodList();
		model.addAttribute("goodList", goodList);
		return "home";
	}
}
