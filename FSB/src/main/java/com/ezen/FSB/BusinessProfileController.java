package com.ezen.FSB;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.BusinessCouponDTO;
import com.ezen.FSB.dto.BusinessCouponUserDTO;
import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.BusinessReviewDTO;
import com.ezen.FSB.dto.FeedDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.service.BusinessProfileMapper;
import com.ezen.FSB.service.FeedMapper;
import com.ezen.FSB.service.ProfileMapper;

@Controller
public class BusinessProfileController {
	@Autowired
	private BusinessProfileMapper bpMapper;

	@Autowired
	private ProfileMapper profileMapper;

	@Autowired
	private FeedMapper feedMapper;

	@Resource(name = "uploadPath")
	private String upPath;

	// 멤버 정보 재설정 //memberDTO 반환
	private MemberDTO setLoginMember(HttpServletRequest req) {
		HttpSession session = req.getSession();
		// 멤버&프로필 정보 재설정
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		// 멤버 설정
		int mem_num = mdto.getMem_num();
		mdto = profileMapper.getMember(mem_num);
		//비즈니스 sns top 메뉴 들어가기 위해 
				if(mdto.getMem_mode().equals("사업자")) {
					BusinessProfileDTO dto = bpMapper.BPlist(mdto.getMem_num());
					int bp_num = dto.getBp_num(); 
					session.setAttribute("bp_num", bp_num);
						}
		// 프로필 설정
		ProfileDTO pdto = profileMapper.getProfile(mem_num);
		// 팔로우 팔로워 확인
		int[] ff = profileMapper.getFollows(mem_num);
		pdto.setProf_following(ff[0]);
		pdto.setProf_follower(ff[1]);
		session.setAttribute("login_mem", mdto);
		session.setAttribute("profile", pdto);

		return mdto;
	}

	// 개인 페이지
	@RequestMapping(value = "/b_personalHome.do")
	public ModelAndView b_personalHome(@RequestParam int num, HttpServletRequest req) {
		HttpSession session = req.getSession();
		ModelAndView mav = new ModelAndView();
		
		//비회원이 지도 타고 들어올 때
		MemberDTO dto_non = (MemberDTO) session.getAttribute("login_mem");
		if( dto_non== null) {
			mav.setViewName("Bfeed/b_personalHome_non");
			// 프로필 가져오기
			int friend_num = num;
			int bp_num = Integer.parseInt(req.getParameter("bp_num"));
			ProfileDTO pdto = profileMapper.getProfile(friend_num);
			BusinessProfileDTO dto = bpMapper.BPlist(friend_num);
			
			mav.addObject("bp_num", bp_num);
			mav.addObject("b_profile", dto);
			
			// 비즈니스 쿠폰 만료일 삭제
			bpMapper.expireBcoupon();
			// 비즈니스 쿠폰 호출
			List<BusinessCouponDTO> blist = bpMapper.getBC_bp(bp_num);
		
			// 사용자일 시 가지고 있는 쿠폰 리스트
			Map<String, Integer> params = new HashMap<String, Integer>();
			
			params.put("mem_num", num);
			params.put("bp_num", bp_num);

			List<BusinessCouponUserDTO> ulist = bpMapper.getBC_m(params);
			mav.addObject("userCoupon", ulist);

			// 없는 쿠폰 리스트 담을 ...list
			List<BusinessCouponDTO> exlist = new ArrayList<>();
			exlist.addAll(blist);
			for (BusinessCouponDTO cdto : blist) {
				for (BusinessCouponUserDTO udto : ulist) {
					if (cdto.getBc_num() == udto.getBc_num()) {
						exlist.remove(cdto);
					}
				}
			}
			mav.addObject("exlist", exlist);
			mav.addObject("couponlist", blist);
			int[] ff = profileMapper.getFollows(friend_num);
			pdto.setProf_following(ff[0]);
			pdto.setProf_follower(ff[1]);
			mav.addObject("target_profile", pdto);

			// 개인 타임라인 가져오기
				String[] follow = profileMapper.followCheck(0, friend_num);
				String prof_open = pdto.getProf_open();
				// 아무도 블락하지 않았다면
					if (prof_open.equals("open")) { // 공개계정 (비공개 제외 가져오기)
						List<FeedDTO> list = feedMapper.getOnesTimeline_open(friend_num);
						mav.addObject("target_listFeed", list);
					} else { // 비공개 계정 (팔로우 확인)
						if (follow[0].equals("follow")) {// (내가)팔로우 상태라면 (모두 가져오기)
							List<FeedDTO> list = feedMapper.getOnesTimeline_secret(friend_num);
							mav.addObject("target_listFeed", list);
						} else { // 팔로우 상태가 아니라면
							mav.addObject("profWho", "notFollow");
						}
				}
		//로그인 한 멤버라면			
		}else {
		// 초기설정
		MemberDTO mdto = setLoginMember(req);	
		// 사이드 바 모드 설정
		session.setAttribute("bar_mode", "feed");
		int mem_num = mdto.getMem_num();

		mav.setViewName("Bfeed/b_personalHome");

		// 프로필 가져오기
		int friend_num = num;
		ProfileDTO pdto = profileMapper.getProfile(friend_num);
		BusinessProfileDTO dto = bpMapper.BPlist(friend_num);
		
		// 비즈니스 프로필 호출
		int bp_num = dto.getBp_num();
		mav.addObject("bp_num", bp_num);
		mav.addObject("b_profile", dto);
		// 비즈니스 쿠폰 만료일 삭제
		bpMapper.expireBcoupon();
		// 비즈니스 쿠폰 호출
		List<BusinessCouponDTO> blist = bpMapper.getBC_bp(bp_num);
		mav.addObject("couponlist", blist);
		
		// 사용자일 시 가지고 있는 쿠폰 리스트
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("mem_num", mdto.getMem_num());
		params.put("bp_num", bp_num);

		List<BusinessCouponUserDTO> ulist = bpMapper.getBC_m(params);
		mav.addObject("userCoupon", ulist);

		// 없는 쿠폰 리스트 담을 ...list
		List<BusinessCouponDTO> exlist = new ArrayList<>();
		exlist.addAll(blist);
		for (BusinessCouponDTO cdto : blist) {
			for (BusinessCouponUserDTO udto : ulist) {
				if (cdto.getBc_num() == udto.getBc_num()) {
					exlist.remove(cdto);
				}
			}
		}
		mav.addObject("exlist", exlist);
		mav.addObject("dto", dto);
		mav.addObject("bp_num", bp_num);
		

		int[] ff = profileMapper.getFollows(friend_num);
		pdto.setProf_following(ff[0]);
		pdto.setProf_follower(ff[1]);
		mav.addObject("target_profile", pdto);

		// 개인 타임라인 가져오기
		if (mem_num == friend_num) { // 내 계정일 때 (모두 가져오기)
			List<FeedDTO> list = feedMapper.getOnesTimeline_secret(friend_num);
			mav.addObject("target_listFeed", list);
			mav.addObject("profWho", "me");
			return mav;
		}else { //남의 계정일 때
			//팔로우 상태&프로필 공개 상태 확인
			String[] states = profileMapper.followCheck(mem_num, friend_num);
			if(states[0] == null) states[0] = "none";
			if(states[1] == null) states[1] = "none";
			pdto.setM_friend_accept(states[0]);
			pdto.setF_friend_accept(states[1]);	
			
			String prof_open = pdto.getProf_open();
			
			if(prof_open.equals("hide")) { //숨김처리된 계정이라면
				mav.addObject("profWho","hide");
			}else if(states[0].equals("block")) { //내가 블락했다면
				mav.addObject("profWho","blocked");
			}else if(states[1].equals("block")) { //상대가 블락했다면
				mav.addObject("profWho","gotBlocked");
				
			}else { //아무도 블락하지 않았다면
				if(prof_open.equals("open")) { //공개계정 (비공개 제외 가져오기)
					List<FeedDTO> list = feedMapper.getOnesTimeline_open(friend_num);
					mav.addObject("target_listFeed", list);
				}else { //비공개 계정 (팔로우 확인)
					if(states[0].equals("follow")) {//(내가)팔로우 상태라면 (모두 가져오기)
						List<FeedDTO> list = feedMapper.getOnesTimeline_secret(friend_num);
						mav.addObject("target_listFeed", list);
					}else { //팔로우 상태가 아니라면
						mav.addObject("profWho","notFollow");
					}
				}
			}
		}
	}
		return mav; // profWho: me hide blocked gotBlocked notFollow
	}

	
	// 비즈니스 프로필 수정
	@RequestMapping(value = "b_profile_update.do", method = RequestMethod.GET)
	public ModelAndView b_profile_update(HttpServletRequest req, int bp_num) {
		HttpSession session = req.getSession();
		session.setAttribute("upPath", session.getServletContext().getRealPath("/resources/img"));
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		ModelAndView mav = new ModelAndView("Bfeed/b_profileUpdateForm"); // 메인 실행
		if(mdto == null) {
			session.invalidate();
			mav.setViewName("message_back");
			mav.addObject("msg","로그인 해주세요" );
			return mav;
		}
		BusinessProfileDTO dto = bpMapper.BPlist(mdto.getMem_num());
		mav.addObject("dto", dto);
		mav.addObject("bp_num", bp_num);
		return mav;
	}

	// 비즈니스 프로필 수정 ok
	@RequestMapping(value = "/b_profile_update.do", method = RequestMethod.POST)
	public ModelAndView b_profile_update_pro(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.setAttribute("upPath", session.getServletContext().getRealPath("/resources/img"));
		ModelAndView mav = new ModelAndView("message");
		MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		if(mdto == null) {
			session.invalidate();
			mav.setViewName("message_back");
			mav.addObject("msg","로그인 해주세요" );
			return mav;
		}
		BusinessProfileDTO dto = bpMapper.BPlist(mdto.getMem_num());
		dto.setBp_num(Integer.parseInt(req.getParameter("bp_num")));
		dto.setBp_info(req.getParameter("bp_info"));
		dto.setBp_location(req.getParameter("bp_location"));
		dto.setBp_d_location(req.getParameter("bp_d_location"));
		dto.setBp_store_name(req.getParameter("bp_store_name"));
		dto.setBp_tel(req.getParameter("bp_tel"));
		
		
		mav.addObject("num", mdto.getMem_num());
		int res = bpMapper.updateBP(dto);
		if (res > 0) {
			mav.addObject("msg", "수정을 성공하였습니다.");
			mav.addObject("url", "b_personalHome.do?num=" + mdto.getMem_num());

		} else {
			mav.addObject("msg", "수정을 실패하였습니다.");
			mav.addObject("url", "b_personalHome.do?num=" + mdto.getMem_num());
		}
		return mav;
	}

	// 비즈니스 쿠폰 발행하기
	@RequestMapping(value = "insert_bcoupon.do", method = RequestMethod.GET)
	public ModelAndView insert_coupon(HttpServletRequest req, int bp_num) {
		LocalDate now = LocalDate.now();
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		//로그인 체크 
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		mav.setViewName("Bfeed/b_insertCoupon");
		mav.addObject("now", now);
		mav.addObject("bp_num", bp_num);
		mav.addObject("mem_num", mdto.getMem_num());
		return mav;
	}

	// 쿠폰 등록 처리
	@RequestMapping(value = "insert_bcoupon.do", method = RequestMethod.POST)
	public ModelAndView insertOkScoupon(@ModelAttribute BusinessCouponDTO dto, BindingResult result,
			@RequestParam Map<String, String> params) {
		if (result.hasErrors()) {
		}
		dto.setBp_num(Integer.parseInt(params.get("bp_num")));
		dto.setMem_num(Integer.parseInt(params.get("mem_num")));

		int res;
		// 만료일 지정하지 않음을 선택한 경우
		if (params.get("bc_duedate2") != null) {
			res = bpMapper.insertBcoupon2(dto);
		} else { // 만료일을 지정하는 경우
			String date = dto.getBc_duedate().substring(2);
			date = date.replace('-', '/');
			//tem.out.println(date);
			dto.setBc_duedate(date);
			res = bpMapper.insertBcoupon1(dto);
		}

		ModelAndView mav = new ModelAndView("closeWindow");

		if (res > 0) {
			mav.addObject("msg", "쿠폰 등록 성공!");
		} else {
			mav.addObject("msg", "쿠폰 등록 실패!");
		}

		return mav;
	}

	// 쿠폰 삭제
	@RequestMapping("/delete_bcoupon.do")
	public ModelAndView deletebcoupon(HttpServletRequest req, @RequestParam int bc_num, @RequestParam int bp_num) {
		ModelAndView mav = new ModelAndView("message");
		//로그인 체크 
		HttpSession session= req.getSession();
			MemberDTO mdto1 = (MemberDTO)session.getAttribute("login_mem");
			if(mdto1 == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		// 초기설정
		MemberDTO mdto = setLoginMember(req);
		List<BusinessCouponUserDTO> list = bpMapper.listBCUser(bc_num);
		if (list.size() > 0) {
			mav.addObject("msg", "쿠폰을 소유한 회원이 있어, 삭제 불가!");
			mav.addObject("url", "b_couponList.do?bp_num="+bp_num);
		} else {
			int res = bpMapper.deleteBcoupon(bc_num);
			if (res > 0) {
				mav.addObject("msg", "쿠폰 삭제 성공!");
				mav.addObject("url", "b_couponList.do?bp_num="+bp_num);
			} else {
				mav.addObject("msg", "쿠폰 삭제 실패!");
				mav.addObject("url", "b_couponList.do?bp_num="+bp_num);
			}
		}
		return mav;
	}

	// 쿠폰 받기(일반 사용자)
	@RequestMapping("/get_bcoupon.do")
	public ModelAndView getbcoupon(HttpServletRequest req, @RequestParam int bp_num, @RequestParam int bc_num) {
		ModelAndView mav = new ModelAndView("message");
		HttpSession session = req.getSession();
		//로그인 체크 
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		BusinessCouponDTO dto = bpMapper.BClist_bc(bc_num);
		BusinessCouponUserDTO udto = new BusinessCouponUserDTO();
		MemberDTO dto3 = (MemberDTO) session.getAttribute("login_mem");
		udto.setMem_num(dto3.getMem_num());
		udto.setBp_num(bp_num);
		udto.setBc_num(bc_num);
		udto.setBc_title(dto.getBc_title());
		udto.setBc_content(dto.getBc_content());
		udto.setBc_duedate(dto.getBc_duedate());
		int res = bpMapper.getBCoupon(udto);
		bpMapper.minusQty(bc_num);
		if (res > 0) {
			mav.addObject("msg", "쿠폰이 발급 되었습니다. 쿠폰함을 확인하세요");
			mav.addObject("url", "b_personalHome.do?num="+dto.getMem_num());
		} else {
			mav.addObject("msg", "쿠폰이 발급 실패,관리자에게 문의하세요");
			mav.addObject("url", "b_personalHome.do?num="+dto.getMem_num()); // 나중에 사장님 피드 찢을때 거기로 보내기
		}
		// 쿠폰함에 리스트 뽑기
		return mav;
	}

	// 발급된 쿠폰 리스트 보기 (사장님)
	@RequestMapping("/b_couponList.do")
	public ModelAndView bcouponlist(HttpServletRequest req, @RequestParam int bp_num, java.util.Map<String, Integer> params) {
		ModelAndView mav = new ModelAndView("/Bfeed/b_couponList");
		//로그인 체크 
		HttpSession session= req.getSession();
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		List<BusinessCouponDTO> blist = bpMapper.getBC_bp(bp_num);
		// 페이지 넘버
		int pageSize = 10;

		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "0") {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = bpMapper.getCountBC(bp_num);
		params.put("start", startRow);
		params.put("end", endRow);
		params.put("bp_num", bp_num);
		if (endRow > count)
			endRow = count;
		List<BusinessCouponUserDTO> list = null;
		if (count > 0) {
			list = bpMapper.bcouponList(params);
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 2;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount)
				endPage = pageCount;

			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
		}
		mav.addObject("couponListUser", list);
		mav.addObject("bcouponlist",blist);
		mav.addObject("count", count);
		mav.addObject("bp_num", bp_num);

		return mav;
	}

	// 쿠폰 리스트에서 쿠폰 상세보기 (사장님)
	@ResponseBody
	@RequestMapping("/b_couponView.do")
	public ModelAndView bcouponview(HttpServletRequest req, @RequestParam int bc_num, @RequestParam int mem_num,
			@RequestParam int bc_using) {
		ModelAndView mav = new ModelAndView("/Bfeed/b_couponView");
		//로그인 체크 
		HttpSession session= req.getSession();
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		List<BusinessCouponDTO> blist = bpMapper.getBC_bc(bc_num);
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("mem_num", mem_num);
		params.put("bc_num", bc_num);
		List<MemberDTO> mlist = bpMapper.getMember_bc(params);
		mav.addObject("bc_using", bc_using);
		mav.addObject("dto", blist);
		mav.addObject("mdto", mlist);
		return mav;
	}

	// (사장님) 쿠폰 처리하기
	@ResponseBody
	@RequestMapping("/b_useBcoupon.do")
	public ModelAndView useBcoupon(HttpServletRequest req, @RequestParam Map<Object, Object> params) {
		ModelAndView mav = new ModelAndView();
		//로그인 체크 
		HttpSession session= req.getSession();
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		String bc_using = (String) params.get("bc_using");
		mdto.setBc_using(Integer.parseInt(bc_using));
		bpMapper.useBcoupon(params);

		mav.setViewName("Bfeed/b_couponView");
		return mav;
	}

	// (사장님) 쿠폰 처리 취소하기
	@RequestMapping("/b_cancelUsingBcoupon.do")
	public ModelAndView cancelBcoupon(HttpServletRequest req,@RequestParam Map<Object, Object> params) {
		ModelAndView mav = new ModelAndView("message");
		//로그인 체크 
		HttpSession session= req.getSession();
			MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
			if(mdto == null) {
				session.invalidate();
				mav.setViewName("message_back");
				mav.addObject("msg","로그인 해주세요" );
				return mav;
			}
		bpMapper.cancelBCoupon(params);
		mav.addObject("msg", "쿠폰 사용이 취소처리 되었습니다.");
		mav.addObject("url", "b_couponList.do?bp_num=" + params.get("bp_num") + "&pageNum=1");
		return mav;
	}
	//리뷰 페이지로 이동하기
	@RequestMapping("/b_review.do")
	public ModelAndView Breview(HttpServletRequest req, @RequestParam int bp_num) {
		ModelAndView mav = new ModelAndView("Bfeed/b_storeReview");
		
		//비즈니스 프로필 dto 꺼내오기
		BusinessProfileDTO bpdto = bpMapper.getBP(bp_num);
		mav.addObject("bp_num",bp_num);
		mav.addObject("bp_mem" , bpdto.getMem_num());
		//매장 별점 계산하기
		int count =bpMapper.b_reviewCount(bp_num);
		mav.addObject("count", count);
		mav.addObject("bp", bpdto);
		if(count != 0) {
			double reviewAvg = bpMapper.b_reviewAvg(bp_num);
			reviewAvg = Math.round(reviewAvg*10)/10;
			
			mav.addObject("reviewAvg", reviewAvg);
			mav.addObject("count", count);
			
			
			//매장 별점 계산해서 업데이트 시키기
			Map<Object,Object> params1 = new HashMap<>();
			params1.put("bp_starrating", reviewAvg);
			params1.put("bp_num", bp_num);
			bpMapper.setStarrating(params1);
		}
		
		
		//리스트 페이지 수 
		int pageSize = 5;
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
		params.put("bp_num" , bp_num);
		
		List<BusinessReviewDTO> list = null;
		if (count > 0) {
			list =bpMapper.BPReviewList(params);
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 2;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("count", count);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
			mav.addObject("getViewReview", list);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum", rowNum);
		return mav;		
	}

	//매장 리뷰 등록
	@RequestMapping(value="/bp_insertReview.do", method=RequestMethod.GET)
	public ModelAndView insertBReview(HttpServletRequest req,@RequestParam int bp_num) {
		ModelAndView mav= new ModelAndView("Bfeed/b_insertReview");
		//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
		mav.addObject("bp_num",bp_num);
		return mav;
	}
	//매장 리뷰 등록 ok
	@RequestMapping(value="/bp_insertReview.do", method=RequestMethod.POST)
	public ModelAndView insertBReviewOK(HttpServletRequest req,@RequestParam Map<String, Object> map,@ModelAttribute BusinessReviewDTO dto,  BindingResult result) {
		ModelAndView mav= new ModelAndView("message");
		HttpSession session = req.getSession();
		MemberDTO dto3 = (MemberDTO)session.getAttribute("login_mem");
		if(dto3 == null) {
			session.invalidate();
			mav.setViewName("message_back");
			mav.addObject("msg","로그인 해주세요" );
			return mav;
		}
		int mem_num = dto3.getMem_num();
		dto.setMem_num(mem_num);
		int bp_num=Integer.parseInt(req.getParameter("bp_num"));
		dto.setBp_num(bp_num);
		dto.setMem_nickname(dto3.getMem_nickname());		
		String upPath = session.getServletContext().getRealPath("/resources/img");
		session.setAttribute("upPath", upPath);
		for(int i=0; i<4; ++i) {
			String imgs = (String) map.get("imgs"+i);
			if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
			
			byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
			String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
			
			if(i==0) dto.setBpr_img1(fileName);
			if(i==1) dto.setBpr_img2(fileName);
			if(i==2) dto.setBpr_img3(fileName);
			if(i==3) dto.setBpr_img4(fileName);
			
			File file = new File(upPath, fileName);
			//저장공간에 비어있는 파일 생성
			try{
				file.createNewFile();
			}catch(IOException e) {
				e.printStackTrace();
			}
			// 파일에 이미지 출력
			try {
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(imageData);
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		int res =bpMapper.insertBPReview(dto);
		if(res>0) {
			mav.addObject("msg", "리뷰가 등록되었습니다. 감사합니다😊");
			mav.addObject("url", "b_review.do?bp_num="+bp_num);
		}else {
			mav.addObject("msg", "리뷰 등록 실패! 다시 시도해 주세요");
			mav.addObject("url", "b_review.do?bp_num="+bp_num);
		}
		return mav;
	}
	//매장 리뷰 상세보기 (ajax)
	@ResponseBody
	@RequestMapping("/b_viewBreview.do") 
	public ModelAndView viewBreview(HttpServletRequest req,@RequestParam int bpr_num,@RequestParam int bp_num) {
		ModelAndView mav = new ModelAndView("Bfeed/b_viewBreview"); 
		BusinessReviewDTO dto = bpMapper.getBreview(bpr_num);
		ProfileDTO pdto = profileMapper.getProfile(dto.getMem_num());
		BusinessProfileDTO bpdto =bpMapper.getBP(bp_num);
		mav.addObject("bpmem",bpdto.getMem_num());
		mav.addObject("getBR", dto);
		mav.addObject("getMem",pdto);
		mav.addObject("bpr_num", bpr_num);
		mav.addObject("bp_num",dto.getBp_num());
		return mav;
		
	}
	// 매장 리뷰 삭제	
		
		@RequestMapping("/b_deleteReview.do")
	   public ModelAndView BReviewDelete(HttpServletRequest req, @RequestParam Map<Object, Object> params) {
			//로그인 체크 
				HttpSession session= req.getSession();
				  ModelAndView mav = new ModelAndView("message");
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
	      // 스트링 인티쟈 오류로 바끰!!!!!!!!! 이제 작업 하십셔!!!!!!!!!
	      // form 에서 내용을 보낼때는 id 가 아니라, name 으로 적ㄱ기`~~~~~~~~~~~~
	      // input type="hidden" id="bpr_num" 대신 name="bpr_num" ~~ - 괴도 승미
	      
	      String bpr_num =(String)params.get("bpr_num");
	      String bp_num =(String)params.get("bp_num");
	      String bpr_img1 = (String)params.get("bpr_img1");
	      String bpr_img2 = (String)params.get("bpr_img2");
	      String bpr_img3 = (String)params.get("bpr_img3");
	      String bpr_img4 = (String)params.get("bpr_img4");
	      
	      int res = bpMapper.deleteBreview(Integer.parseInt(bpr_num));
	      if (res > 0) {
	         String upPath = session.getServletContext().getRealPath("/resources/img");
	         File file1 = new File(upPath, bpr_img1);
	         File file2 = new File(upPath, bpr_img2);
	         File file3 = new File(upPath, bpr_img3);
	         File file4 = new File(upPath, bpr_img4);

	         if (file1.exists()) {
	            file1.delete();
	            mav.addObject("msg", "상품 리뷰 이미지, 글 삭제 성공");
	         } else if (file1.exists() && file2.exists()) {
	            file1.delete();
	            file2.delete();
	            mav.addObject("msg", "상품 리뷰 이미지, 글 삭제 성공");
	         } else if (file1.exists() && file2.exists() && file3.exists()) {
	            file1.delete();
	            file2.delete();
	            file3.delete();
	            mav.addObject("msg", "상품 리뷰 이미지, 글 삭제 성공");
	         } else if (file1.exists() && file2.exists() && file3.exists() && file4.exists()) {
	            file1.delete();
	            file2.delete();
	            file3.delete();
	            file4.delete();
	            mav.addObject("msg", "리뷰 이미지, 글 삭제 성공");
	         } else {
	            mav.addObject("msg", "상품 리뷰 이미지 실패, 글 삭제 성공");
	         }
	      } else {
	         mav.addObject("msg", "리뷰 삭제 실패, 관리자에게 문의해주세요");
	         mav.addObject("url", "b_review.do?bp_num="+Integer.parseInt(bp_num)+"&pageNum=1");
	      }
	      mav.addObject("url","b_review.do?bp_num="+Integer.parseInt(bp_num)+"&pageNum=1");
	      return mav;
	   }
		//매장 리뷰 수정
		@RequestMapping(value="/b_updateReview.do", method=RequestMethod.GET)
		public ModelAndView updateBReview(HttpServletRequest req,@RequestParam int bp_num, @RequestParam int bpr_num) {
			ModelAndView mav= new ModelAndView("Bfeed/b_updateReview");
			//로그인 체크 
			HttpSession session= req.getSession();
				MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
				if(mdto == null) {
					session.invalidate();
					mav.setViewName("message_back");
					mav.addObject("msg","로그인 해주세요" );
					return mav;
				}
			BusinessReviewDTO rdto = bpMapper.getBreview(bpr_num);
			mav.addObject("bp_num",bp_num);
			mav.addObject("bpr_num",bpr_num);
			mav.addObject("getReview",rdto);
			return mav;
		}

// 마이페이지 리뷰 수정 처리
	@RequestMapping("/b_updateReviewOK.do")
	public ModelAndView updateBreviewOK(HttpServletRequest req, @RequestParam Map<String, String> map,
			@ModelAttribute BusinessReviewDTO dto, BindingResult result) {
		if (result.hasErrors()) {
		}

		ModelAndView mav = new ModelAndView("message");
		//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
		String upPath = session.getServletContext().getRealPath("/resources/img");

		// 기존 이미지 널 처리
		dto.setBpr_img1("");
		dto.setBpr_img2("");
		dto.setBpr_img3("");
		dto.setBpr_img4("");

		// 이미지 처리
		for (int i = 0; i < 4; ++i) {
			String imgs = (String) map.get("imgs" + i);
			if (imgs == null)
				break; // 받아온 이미지가 더 없으면 for문 나가기
			if (imgs.equals("1") || imgs.equals("2") || imgs.equals("3") || imgs.equals("4")) {
				if (i == 0)
					dto.setBpr_img1((String) map.get("bpr_img" + imgs));
				if (i == 1) 	
					dto.setBpr_img2((String) map.get("bpr_img" + imgs));
				if (i == 2)
					dto.setBpr_img3((String) map.get("bpr_img" + imgs));
				if (i == 3)
					dto.setBpr_img4((String) map.get("bpr_img" + imgs));
			} else {
				byte[] imageData = Base64.decodeBase64(imgs.getBytes()); // 디코딩
				String fileName = UUID.randomUUID().toString() + ".png"; // 랜덤이름 생성
				if (i == 0)
					dto.setBpr_img1(fileName);
				if (i == 1)
					dto.setBpr_img2(fileName);
				if (i == 2)
					dto.setBpr_img3(fileName);
				if (i == 3)
					dto.setBpr_img4(fileName);

				File file = new File(upPath, fileName);
				// 저장공간에 비어있는 파일 생성
				try {
					file.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
				// 파일에 이미지 출력
				try {
					FileOutputStream fos = new FileOutputStream(file);
					fos.write(imageData);
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		// 삭제된 이미지 서버에서 삭제
		String deleted_img = (String) map.get("deleted_img");
		String[] arr = deleted_img.split(","); // 1번 방부터 시작, 총 길이는 삭제된 개수+1

		for (int i = 1; i < arr.length; i++) {
			int delImgNum = Integer.parseInt(arr[i]);
			String delImgName = (String) map.get("bpr_img" + delImgNum);
			File file = new File(upPath, delImgName);
			if (file.exists()) {
				file.delete();
			}
		}
		int res = bpMapper.updateBreview(dto);
		if (res > 0) {
			mav.addObject("msg", "리뷰 수정 성공");
			mav.addObject("url", "b_review.do?bp_num=" + dto.getBp_num()+ "&pageNum=1");
		}
		return mav;
	}
	 // 사장님 리뷰 숨기기
	@RequestMapping("b_blockBreview.do")
	public ModelAndView blockBreview(HttpServletRequest req,@RequestParam int bp_num, @RequestParam int bpr_num) {
		ModelAndView mav = new ModelAndView("message");
		//로그인 체크 
				HttpSession session= req.getSession();
					MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
					if(mdto == null) {
						session.invalidate();
						mav.setViewName("message_back");
						mav.addObject("msg","로그인 해주세요" );
						return mav;
					}
		Map<String,Integer> params = new HashMap<>();
		params.put("bp_num",bp_num);
		params.put("bpr_num",bpr_num);
		//tem.out.println(bp_num + "제한 비피넘");
		//tem.out.println(bpr_num + "제한 비피r넘");
		int res=bpMapper.blockReview(params);
		if(res>0){
			mav.addObject("msg", "리뷰 게시 중단 성공");
			mav.addObject("url", "b_review.do?bp_num=" + bp_num+ "&pageNum=1");
		}else {
			mav.addObject("msg", "리뷰 숨기기 실패");
			mav.addObject("url", "b_review.do?bp_num=" +bp_num+ "&pageNum=1");
		}
		
		return mav;
	}
	
	 // 사장님 리뷰 숨기기 해제
		@RequestMapping("b_unblockBreview.do")
		public ModelAndView unblockBreview(HttpServletRequest req,@RequestParam int bp_num, @RequestParam int bpr_num) {
			ModelAndView mav = new ModelAndView("message");
			//로그인 체크 
			HttpSession session= req.getSession();
				MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
				if(mdto == null) {
					session.invalidate();
					mav.setViewName("message_back");
					mav.addObject("msg","로그인 해주세요" );
					return mav;
				}
			Map<String,Integer> params = new HashMap<>();
			params.put("bp_num",bp_num);
			params.put("bpr_num",bpr_num);
			
			int res=bpMapper.unblockReview(params);
			if(res>0){
				mav.addObject("msg", "리뷰 게시 성공");
				mav.addObject("url", "b_review.do?bp_num=" + bp_num+ "&pageNum=1");
			}else {
				mav.addObject("msg", "리뷰 게시 실패");
				mav.addObject("url", "b_review.do?bp_num=" +bp_num+ "&pageNum=1");
			}
			
			return mav;
		}
}
