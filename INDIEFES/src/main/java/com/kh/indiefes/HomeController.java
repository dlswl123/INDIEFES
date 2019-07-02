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
import com.kh.ts.domain.PaginationDto;
import com.kh.ts.domain.PagingDto;


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
	public String home(Locale locale, Model model,PagingDto pagingDto) throws Exception{
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		logger.info("serverTime : {}", formattedDate);
		
//		model.addAttribute("serverTime", formattedDate );
		// 최신앨범
		pagingDto.setPerPage(9);
		List<ArtInfoVo> toDayList = artService.toDayList(pagingDto);
		List<IndieTeamVo> teamList = artService.getIndieTeam();
		PaginationDto toDayPaging = new PaginationDto();
		int toDayCount = artService.toDayCount();
		toDayPaging.setPagingDto(pagingDto);
		toDayPaging.setTotalCount(toDayCount);
		model.addAttribute("toDayList", toDayList);
		model.addAttribute("teamList", teamList);
		model.addAttribute("toDayPaging", toDayPaging);
		// 인기앨범
		List<ArtInfoVo> goodList = artService.goodList();
		System.out.println(goodList);
		model.addAttribute("goodList", goodList);
		return "home";
	}
}
