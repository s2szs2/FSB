package com.ezen.FSB;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.FeedDTO;
import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.GameLikeDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ReviewDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.TagDTO;
import com.ezen.FSB.dto.ThemeDTO;
import com.ezen.FSB.service.AdminGameMapper;
import com.ezen.FSB.service.FeedMapper;
import com.ezen.FSB.service.GameMapper;

@Controller
public class GameController {
	
	@Autowired
	private GameMapper gameMapper;
	
	@Autowired
	private AdminGameMapper adminGameMapper;
	
	@Autowired
	private FeedMapper feedMapper;
	
	// 게임 리스트
	@RequestMapping("game_list.do")
	public ModelAndView game_list(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("game/game_list");
		List<GameDTO> list = gameMapper.listGame();
		mav.addObject("listGame", list);
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		return mav;

	}

	// 검색 시 찾기
	@RequestMapping("game_find.do")
	public ModelAndView game_find(HttpServletRequest req, String searchString) {
		ModelAndView mav = new ModelAndView("game/game_list");

		List<GameDTO> list = gameMapper.findGame(searchString);
		mav.addObject("listGame", list);
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		return mav;
	}

	// 상세보기 체크 시 찾기
	@RequestMapping("game_checkFind.do")
	public ModelAndView game_checkFind(@RequestParam(required=false, name="theme") List<String> theme, @RequestParam(required=false, name="game_level") List<String> game_level, @RequestParam(required=false, name="game_player") List<String> game_player) {	
		ModelAndView mav = new ModelAndView("game/game_list");
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		List<GameDTO> tlist2 = null;

	    List<GameDTO> resultList = new ArrayList<GameDTO>();
	    Hashtable<Integer, GameDTO> ht = new Hashtable<Integer, GameDTO>();
	    if(theme == null) {
	         
	    } else if (theme.size() != 0) {
	       for(String t : theme) {
	          tlist2 = gameMapper.checkListGame1(Integer.parseInt(t));
	          for(GameDTO dto : tlist2) {
	             ht.put(dto.getGame_num(), dto);
	          }
	       }
	    }
	    if(game_player == null) {
	         
	    } else if (game_player.size() != 0) {
	       for(String p : game_player) {
	          tlist2 = gameMapper.checkListGame2(Integer.parseInt(p));
	          for(GameDTO dto : tlist2) {
	             ht.put(dto.getGame_num(), dto);
	          }
	       }
	    }
	    if(game_level == null) {
	         
	    } else if (game_level.size() != 0) {
	       for(String l : game_level) {
	          tlist2 = gameMapper.checkListGame3(Integer.parseInt(l));
	          for(GameDTO dto : tlist2) {
	             ht.put(dto.getGame_num(), dto);
	          }
	       }
	    }
	      
	    Enumeration enu = ht.keys();
	    while(enu.hasMoreElements()) {
	       int key = (int)enu.nextElement();
	       GameDTO dto = ht.get(key);
	       resultList.add(dto);
	    }
	    mav.addObject("listGame", resultList);
		return mav;
	}

	// 이름 순, 인원 순, 난이도 순, 좋아요 순 정렬
	@RequestMapping("game_sort.do")
	public ModelAndView game_sort(String sort) {
		ModelAndView mav = new ModelAndView();
		if (sort.equals("game_name")) {
			List<GameDTO> list = gameMapper.sortGame1(sort);
			mav.setViewName("game/game_list");
			mav.addObject("listGame", list);
		} else if (sort.equals("game_player")) {
			List<GameDTO> list = gameMapper.sortGame2(sort);
			mav.setViewName("game/game_list");
			mav.addObject("listGame", list);
		} else if (sort.equals("game_level")) {
			List<GameDTO> list = gameMapper.sortGame3(sort);
			mav.setViewName("game/game_list");
			mav.addObject("listGame", list);
		} else {
			List<GameDTO> list = gameMapper.sortGame4(sort);
			mav.setViewName("game/game_list");
			mav.addObject("listGame", list);
		}
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		return mav;
	}
	
	// 게임 상세보기
	@RequestMapping("game_view.do")
	public ModelAndView game_view(HttpServletRequest req, int game_num, String sort) {
		ModelAndView mav = new ModelAndView();
			
		// 게임 상세정보
		GameDTO dto = gameMapper.getGame(game_num);
		mav.addObject("getGame", dto);
			
		// 좋아요 총 개수
		int likeCount = gameMapper.gameLikeCount(game_num);
		mav.addObject("likeCount", likeCount);
			
		HttpSession session = req.getSession();
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		int mem_num;
		if (dto2 == null) {	// 로그인을 안했을 떄
			mem_num = 0;
		} else {	// 로그인 시 멤버 넘버 가져오기
			mem_num = dto2.getMem_num();
		}

		Map<String, Integer> params2 = new HashMap<>();
		params2.put("game_num", game_num);
		params2.put("mem_num", mem_num);
		
		// 게임 좋아요를 누른 회원이면 빨간하트, 누르지 않은 회원이면 빈 하트 표현
		List<GameLikeDTO> likeDTO = gameMapper.likeCheckMem(params2);
		if(likeDTO.size() > 0) {	// size가 0보다 크면 빨간하트
			mav.addObject("like", 1);
		} else {					// 빈하트
			mav.addObject("like", 0);
		}		
			
		// 게임 태그 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		List<TagDTO> tagList = gameMapper.gameTag(game_num);
		mav.addObject("gameTag", tagList);

		// 게임 상세보기에서의 한줄평 별점 평균
		int count = gameMapper.getCount(game_num);
		if (count != 0) {
		int reviewAvg = gameMapper.reviewAvg(game_num);
		//tem.out.println("평균 어딨니" + reviewAvg);
			mav.addObject("reviewAvg", reviewAvg);
			mav.addObject("count", count);
		}
		
		// 해당 쇼핑몰로 이동 시키기 위해 prod_num 세팅
		ShopProductDTO dto3 = gameMapper.getGameProduct(game_num);
		int prod_num = 0;
		if (dto3 == null) {
			prod_num = 0;
		} else {
			prod_num = dto3.getProd_num();
		}
		mav.addObject("getProdNum", prod_num);

			
		// 한줄평 보기(페이지 번호 같이, 최신 순/오래된 순/별점 높은 순/별점 낮은 순 정렬 같이)
		int pageSize = 15;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		if (endRow > count)
			endRow = count;
		Map<String, Integer> params = new HashMap<>();
		params.put("start", startRow);
		params.put("end", endRow);
		params.put("game_num", game_num);
		List<ReviewDTO> list = null;
		if (count > 0) {
			if (sort.equals("review_regdate1")) {
				list = gameMapper.sortReview1(params);
			} else if (sort.equals("review_regdate2")) {
				list = gameMapper.sortReview2(params);
			} else if (sort.equals("review_starrating1")) {
				list = gameMapper.sortReview3(params);
			} else if (sort.equals("review_starrating2")){
				list = gameMapper.sortReview4(params);
			} else {	// sort = "all"
				list = gameMapper.listReview(params);
			}
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("count", count);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
			mav.addObject("listReview", list);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum", rowNum);
		mav.setViewName("game/game_view");
		mav.addObject("game_num", game_num);
		return mav;
	}
		
	// 게임 좋아요 기능
	@ResponseBody
	@RequestMapping(value = "gameLike.do")
	public ModelAndView gameLike(HttpServletRequest req, int game_num) {
		HttpSession session = req.getSession();
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		GameLikeDTO dto = new GameLikeDTO();

		dto.setMem_num(dto2.getMem_num());
		dto.setGame_num(game_num);
		
		ModelAndView mav = new ModelAndView();
		int res = gameMapper.GameLike(dto);
		if (res > 0) {
			GameDTO dto3 = new GameDTO();
			int likeCount = gameMapper.gameLikeCount(game_num);
			dto3.setGame_likeCount(likeCount);
			// gameDTO에 game_likeCount update하기
			Map<String, Integer> params = new HashMap<>();
			params.put("game_likeCount", dto3.getGame_likeCount());
			params.put("game_num", game_num);
			gameMapper.gameLikeUpdate(params);
		}
		mav.addObject("like", 1);
		mav.setViewName("game/game_view");
		return mav;
	}
	
	// 게임 좋아요 해제 기능
	@ResponseBody
	@RequestMapping(value = "gameLikeDelete.do")
	public ModelAndView gameLikeDelete(HttpServletRequest req, int game_num) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");		

		Map<String, Integer> params = new HashMap<>();
		params.put("game_num", game_num);
		params.put("mem_num", dto.getMem_num());
		ModelAndView mav = new ModelAndView();
		int res = gameMapper.gameLikeDelete(params);
		if (res > 0) {
			GameDTO dto2 = new GameDTO();
			int likeCount = gameMapper.gameLikeCount(game_num);
			dto2.setGame_likeCount(likeCount);
			// gameDTO에 game_likeCount update하기
			Map<String, Integer> params2 = new HashMap<>();
			params2.put("game_likeCount", dto2.getGame_likeCount());
			params2.put("game_num", game_num);
			gameMapper.gameLikeUpdate(params2);
		}
		mav.setViewName("game/game_view");
		return mav;
	}
	
	// 회원 신고(jsp)
	@RequestMapping("mem_report.do")
	public ModelAndView memReport(int mem_num) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("mem_num", mem_num);
		mav.setViewName("user/member_report");
		return mav;
	}
	
	// 회원 신고
	@RequestMapping("mem_reportOk.do")
	public ModelAndView memReportOk(HttpServletRequest req, @ModelAttribute ReportDTO dto, @RequestParam int mem_report) {
	    ModelAndView mav = new ModelAndView("closeWindow");

	    dto.setReport_content(mem_report);
	    dto.setReport_mode("회원");
	    gameMapper.GameReviewReport(dto);
	    int res = gameMapper.updateMemReport(dto.getReport_target());
	    if (res > 0) {
	       mav.addObject("msg", "신고되었습니다.");
	       mav.addObject("url", "game_view.do");
	    } else {
	       mav.addObject("msg", "신고 실패, 관리자에게 문의해 주세요");
	       mav.addObject("url", "game_view.do");
	    }
	    
	  return mav;

	}

	// 한줄평 등록
	@RequestMapping("review_input.do")
	public ModelAndView review_input(HttpServletRequest req, @ModelAttribute ReviewDTO dto, BindingResult result)
			throws Exception {
		if (result.hasErrors()) {}
		
		HttpSession session = req.getSession();
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		// MemberDTO에 있는 Mem_num으로 ReviewDTO에 넣어주기
		dto.setMem_num(dto2.getMem_num());
		
		String review_starrating = req.getParameter("review_starrating");
		ModelAndView mav = new ModelAndView("message");

		int res = gameMapper.insertReview(dto);
		if (res > 0) {
			mav.addObject("msg", "한줄평이 등록되었습니다.");
			mav.addObject("url", "game_view.do?game_num=" + dto.getGame_num() + "&sort=all");
			mav.addObject("review_starrating", Integer.parseInt(review_starrating));
		} else {
			mav.addObject("msg", "한줄평 등록 실패, 다시 입력해 주세요");
			mav.addObject("url", "game_view.do?game_num=" + dto.getGame_num() + "&sort=all");
		}
		return mav;
	}

	// 한줄평 삭제
	@RequestMapping("review_delete.do")
	public ModelAndView review_delete(HttpServletRequest req, int review_num, int game_num) {
		ModelAndView mav = new ModelAndView("message");
		
		int res = gameMapper.deleteReview(review_num);
		if (res > 0) {
			mav.addObject("msg", "한줄평이 삭제되었습니다.");
			mav.addObject("url", "game_view.do?game_num=" + game_num + "&sort=all");
		} else {
			mav.addObject("msg", "한줄평 삭제 실패, 관리자에게 문의해 주세요");
			mav.addObject("url", "game_view.do?game_num=" + game_num + "&sort=all");
		}
		return mav;
	}

	// 한줄평 신고(jsp)
	@RequestMapping("report.do")
	public ModelAndView report(HttpServletRequest req, int game_num) {
		ModelAndView mav = new ModelAndView();
		
		int pageSize = 15;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = gameMapper.getCount(game_num);
		if (endRow > count)
			endRow = count;
		Map<String, Integer> params = new HashMap<>();
		params.put("start", startRow);
		params.put("end", endRow);
		params.put("game_num", game_num);
		List<ReviewDTO> list = null;
		if (count > 0) {
			list = gameMapper.listReview(params);
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("count", count);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
			mav.addObject("listReview", list);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum", rowNum);
		mav.setViewName("game/report");
		mav.addObject("game_num", game_num);
		return mav;
	}

	// 한줄평 신고
	@RequestMapping("review_report.do")
	public ModelAndView review_report(HttpServletRequest req, @ModelAttribute ReportDTO dto, int review_num, int review_report) {
		ModelAndView mav = new ModelAndView("closeWindow");

		HttpSession session = req.getSession();
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		dto.setMem_num(dto2.getMem_num());
		dto.setReport_content(review_report);
		dto.setReport_target(review_num);
		dto.setReport_mode("보드게임한줄평");
		gameMapper.GameReviewReport(dto);
		int res = gameMapper.updateReviewReport(review_num);
		if (res > 0) {
			mav.addObject("msg", "신고되었습니다.");
			mav.addObject("url", "game_view.do");
		} else {
			mav.addObject("msg", "신고 실패, 관리자에게 문의해 주세요");
			mav.addObject("url", "game_view.do");
		}
		return mav;
	}

	// 보드게임 별 피드
	@RequestMapping("game_tag.do")
	public ModelAndView game_tag(int game_num) {
		ModelAndView mav = new ModelAndView("game/game_tag");
		
		// 게임 가져오기
		GameDTO dto = gameMapper.getGame(game_num);
		mav.addObject("getGame", dto);
		
		// 게임 번호 별 피드
		List<FeedDTO> flist = feedMapper.getGameFeedList(game_num); 
		mav.addObject("listFeed", flist);
		
		return mav;
	}
	
	// 게임 리스트						
	@RequestMapping("feed_game_list.do")						
	public ModelAndView feed_game_list(HttpServletRequest req) {						
		ModelAndView mav = game_list(req);					
		mav.setViewName("feed/gameSelect");		
		
		return mav;					
	}						
								
	// 검색 시 찾기						
	@RequestMapping("feed_game_find.do")						
	public ModelAndView feed_game_find(HttpServletRequest req, String searchString) {						
		ModelAndView mav = game_find(req, searchString);					
		mav.setViewName("feed/gameSelect");				
		
		return mav;					
	}						
								
	// 상세보기 체크 시 찾기						
	@RequestMapping("feed_game_checkFind.do")						
	public ModelAndView feed_game_checkFind(@RequestParam(required=false, name="theme") List<String> theme, @RequestParam(required=false, name="game_level") List<String> game_level, @RequestParam(required=false, name="game_player") List<String> game_player) {						
		ModelAndView mav = game_checkFind(theme, game_level, game_player);					
		mav.setViewName("feed/gameSelect");		
		
		return mav;					
	}						


	// 이름 순, 인원 순, 별점 순, 좋아요 순 정렬						
	@RequestMapping("feed_game_sort.do")						
	public ModelAndView feed_game_sort(String sort) {						
		ModelAndView mav = game_sort(sort);					
		mav.setViewName("feed/gameSelect");			
		
		return mav;					
	}			
}
