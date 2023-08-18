package com.ezen.FSB;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.service.ProfileMapper;

@Controller
public class ProfileController {
	
	@Autowired
	ProfileMapper profileMapper;
	
	//로그인 체크
	public Boolean checkLogin(HttpServletRequest req) {
		HttpSession session= req.getSession();
		MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		if(mdto == null) {return true;}
		else {return false;}
	}
	//메인으로 튕기는 mav 만들기
	public ModelAndView sentBack() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("message");
		mav.addObject("url","user_main.do");
		mav.addObject("msg","로그인 해주세요" );
		return mav;
	}
	
	//사이드바 설정 및 멤버 정보 재설정 //memberDTO 반환
	public MemberDTO setFriendSidebar(HttpServletRequest req) {
		HttpSession session = req.getSession();
		//멤버&프로필 정보 재설정
		MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		//멤버 설정
		int mem_num = mdto.getMem_num();
		mdto = profileMapper.getMember(mem_num);
		//프로필 설정
		ProfileDTO pdto = profileMapper.getProfile(mem_num);
		//팔로우 팔로워 확인
		int[] ff = profileMapper.getFollows(mem_num);
		pdto.setProf_following(ff[0]);
		pdto.setProf_follower(ff[1]);
		session.setAttribute("login_mem", mdto);
		session.setAttribute("profile", pdto);
		
		return mdto;
	}

	//-------------------------------------------------------------------------------------
	//친구관리 페이지
	@RequestMapping(value = "/friendRequest.do")
	public ModelAndView feed(HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setFriendSidebar(req);
		
		//세션에서 멤버 꺼내오기
		int mem_num = mdto.getMem_num();
		
		ModelAndView mav = new ModelAndView("friend/friendRequest");
		
		//받은 요청 리스트
		List<ProfileDTO> list = profileMapper.requestGotList(mem_num);
		mav.addObject("listGotRequest", list);
		
		//보낸 요청 리스트
		list = profileMapper.requestSentList(mem_num);
		mav.addObject("listSentRequest", list);
		
		return mav;
	}
	
	//친구 검색 자동완성
	@ResponseBody
	@RequestMapping(value = "/friendFindAuto.do")
	public ModelAndView autoFind(@RequestParam String text, HttpServletRequest req) {
		//로그인 체크&초기설정
		MemberDTO mdto = setFriendSidebar(req);
		
		ModelAndView mav = new ModelAndView("friend/autoComplete");
		
		//초중종성 분리
		String[] CHO = {"ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"};
		String[] JOONG = {"ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"};
		String[] JONG = {"","ㄱ","ㄲ","ㄳ","ㄴ","ㄵ","ㄶ","ㄷ","ㄹ","ㄺ","ㄻ","ㄼ","ㄽ","ㄾ","ㄿ","ㅀ","ㅁ","ㅂ","ㅄ","ㅅ","ㅆ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"};
		
		String text_separated = "";
		
		for(int i = 0; i < text.length(); i++) {
			char uniVal = text.charAt(i);
			
			// 한글일 경우만 시작
			if(uniVal >= 0xAC00) {
				uniVal = (char)(uniVal - 0xAC00);
				
				char cho = (char)(uniVal/28/21);
				char joong = (char) ((uniVal)/28%21);
				char jong = (char) (uniVal%28);
				
				text_separated += CHO[cho];
				text_separated += JOONG[joong];
				text_separated += JONG[jong];
			} else {
				text_separated += uniVal;
			}
		}
		
		List<ProfileDTO> list = profileMapper.getAutoNickname(text_separated);
		Iterator<ProfileDTO> iterator = list.iterator();
		while (iterator.hasNext()) {
			ProfileDTO prof = iterator.next();
			int mem_num = mdto.getMem_num();
			int friend_num = prof.getMem_num();
			String[] states = profileMapper.followCheck(mem_num, friend_num);
			if(mem_num == friend_num) { //나 자신이라면 목록에서 삭제
				iterator.remove();
			}else if(states[0] != null && states[0].equals("block")){ //내가 차단했다면 목록에서 삭제
				iterator.remove();
			}else if(states[1] != null && states[1].equals("block")) { //차단 당했다면 목록에서 삭제
				iterator.remove();
			}else { //모두 아니라면 친구상태 넣기
				prof.setM_friend_accept(states[0]);
				prof.setF_friend_accept(states[1]);	
			}
		}
		mav.addObject("listProf", list);
		return mav;
	}
	
	//팔로우(를 설정하는) 버튼 클릭
	@ResponseBody
	@RequestMapping(value = "/follow.do")
	public ModelAndView followClick(@RequestParam Map<String, String> map, HttpServletRequest req) {
		//로그인 체크&초기설정
		MemberDTO mdto = setFriendSidebar(req);
		
		String mode = map.get("mode");
		String where = map.get("where");
		System.out.println(mode);
		int mem_num = Integer.parseInt(map.get("mem_num"));
		int friend_num = Integer.parseInt(map.get("friend_num"));
		
		//모드에 따라 처리하기
		if(mode.equals("follow")){ //팔로우라면
			profileMapper.follow(mem_num, friend_num);
		}else if(mode.equals("request")){ //팔로우 요청이라면
			profileMapper.followRequest(mem_num, friend_num);
		}else if(mode.equals("block")){ //차단이라면
			profileMapper.followBlock(mem_num, friend_num);
			
		}else if(mode.equals("confirm")){ //팔로우 요청 승인이라면
			profileMapper.followConfirm(mem_num, friend_num);
		}else if(mode.equals("reject")){ //팔로우 요청 거절이라면
			profileMapper.followReject(mem_num, friend_num);
			
		}else{ //언팔로우&요청 취소&차단 해제라면
			profileMapper.resetFriend(mem_num, friend_num);
		}
		
		//발신지에 따라 데이터 보내기
		ModelAndView mav = new ModelAndView();
		if(where.equals("autoBox")) {
			mav = autoFind(map.get("text"), req);
		}else if(where.equals("gotBox")) {
			List<ProfileDTO> list = profileMapper.requestGotList(mem_num);
			mav.addObject("listGotRequest", list);
			mav.setViewName("friend/gotBox");
		}else if(where.equals("sentBox")) {
			List<ProfileDTO> list = profileMapper.requestSentList(mem_num);
			mav.addObject("listSentRequest", list);
			mav.setViewName("friend/sentBox");
		}else {//개인페이지라면
			ProfileDTO pdto = profileMapper.getProfile(friend_num);
			String[] states = profileMapper.followCheck(mem_num, friend_num);
			if(states[0] == null) states[0] = "none";
			if(states[1] == null) states[1] = "none";
			pdto.setM_friend_accept(states[0]);
			pdto.setF_friend_accept(states[1]);
			mav.addObject("target_profile", pdto);
			System.out.println(pdto.getProf_open());
			mav.setViewName("friend/followZone");
		}
		return mav;
	}
	
	//요청박스 새로고침
	@ResponseBody
	@RequestMapping(value = "/setSentBox.do")
	public ModelAndView setSentBox(@RequestParam int mem_num, HttpServletRequest req) {
		//로그인 체크&초기설정
		MemberDTO mdto = setFriendSidebar(req);

		List<ProfileDTO> list = profileMapper.requestSentList(mem_num);
		ModelAndView mav = new ModelAndView();
		mav.addObject("listSentRequest", list);
		mav.setViewName("friend/sentBox");
		
		return mav;
	}
}
