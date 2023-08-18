package com.ezen.FSB;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.service.MapMapper;


@Controller
public class MapController {
	
	@Autowired
	MapMapper mapMapper;
	
	@Resource(name = "uploadPath")
	private String upPath;
	//map 불러오기 
	@RequestMapping("/map.do")
	public ModelAndView mapdisp(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("map/mapMain");
		List<BusinessProfileDTO> list = mapMapper.locationList();
		HttpSession session = req.getSession();
		session.setAttribute("locationList", list);
		mav.addObject("locationList", list);
		mav.addObject("mode");
		return mav;
	}
	//map 검색 ajax
	@ResponseBody
	@RequestMapping("map_search.do")
	public ModelAndView findPlace(HttpServletRequest req) {
		String searchString =req.getParameter("searchString");
		List<BusinessProfileDTO> plist = mapMapper.findPlace(searchString);
		ModelAndView mav = new ModelAndView("map/mapList");
		
		HttpSession session = req.getSession();
		session.setAttribute("plist", plist);
		mav.addObject("plist",plist);
		return mav;
	}
	//maplist에 뜬 매장명 클릭시 주소이동
	@RequestMapping("map_click.do")
	public ModelAndView loadMap(HttpServletRequest req, @RequestParam int bp_num) {
		
		ModelAndView mav = new ModelAndView("map/map");
		HttpSession session = req.getSession();
		BusinessProfileDTO bdto = mapMapper.getLoca(bp_num);
		ProfileDTO pdto = mapMapper.getBprof(bdto.getMem_num());
		mav.addObject("bdto",bdto);
		mav.addObject("pimage",pdto.getProf_img());
		mav.addObject("locationList", session.getAttribute("locationList"));
		return mav;
	}
	//서치한 후 매장명 클릭시 주소이동
	@RequestMapping("map_click_search.do")
	public ModelAndView loadMap_search(HttpServletRequest req, @RequestParam int bp_num) {
		
		ModelAndView mav = new ModelAndView("map/map");
		HttpSession session = req.getSession();
		mav.addObject("plist", session.getAttribute("plist"));
		BusinessProfileDTO bdto = mapMapper.getLoca(bp_num);
		ProfileDTO pdto = mapMapper.getBprof(bdto.getMem_num());
		mav.addObject("bdto",bdto);
		mav.addObject("pimage",pdto.getProf_img());
		
		if(session.getAttribute("plist")==null) {
			List<BusinessProfileDTO> plist = mapMapper.findPlace(req.getParameter("searchString"));
			mav.addObject("plist",plist);
		}
		String mode="search";
		mav.addObject("mode",mode);
		
		
		return mav;
	}
}
