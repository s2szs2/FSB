package com.ezen.FSB;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.codec.binary.Base64;

import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.FeedDTO;
import com.ezen.FSB.dto.FeedReplyDTO;
import com.ezen.FSB.dto.Feed_likeDTO;
import com.ezen.FSB.dto.Feed_themeDTO;
import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.GameLikeDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.dto.ThemeDTO;
import com.ezen.FSB.service.AdminGameMapper;
import com.ezen.FSB.service.AdminMapper;
import com.ezen.FSB.service.BusinessProfileMapper;
import com.ezen.FSB.service.FeedMapper;
import com.ezen.FSB.service.ProfileMapper;

@Controller
public class FeedController {
	
	@Autowired
	private FeedMapper feedMapper;
	@Autowired
	private AdminGameMapper adminGameMapper;
	@Autowired
	private ProfileMapper profileMapper;
	@Autowired
	private BusinessProfileMapper bpMapper;
   
	@Resource(name="uploadPath")
	private String uploadPath;
	
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
   
	//멤버 정보 재설정 //memberDTO 반환
	private MemberDTO setLoginMember(HttpServletRequest req) {
		HttpSession session = req.getSession();
		//멤버&프로필 정보 재설정
		MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		//멤버 설정
		int mem_num = mdto.getMem_num();
		mdto = profileMapper.getMember(mem_num);
      
		//비즈니스 sns top 메뉴 들어가기 위해 
		if(mdto.getMem_mode().equals("사업자")) {
			BusinessProfileDTO dto = bpMapper.BPlist(mdto.getMem_num());
			int bp_num = dto.getBp_num(); 
			session.setAttribute("bp_num", bp_num);
		}
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
	
	//-------------------------------------------------------------------------------------------------------------
	//메인 타임라인
	@RequestMapping(value = "/feed.do")
	public ModelAndView feed(HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//이미지 저장 경로 등록 & 사이드 바 모드 설정 //이거 그냥 메인 페이지에서 할까봐? //아니다... 링크로 들어올 수 있는 모든 경로에서 해야함
		HttpSession session = req.getSession();
		session.setAttribute("upPath", session.getServletContext().getRealPath("/resources/img"));
		session.setAttribute("bar_mode", "feed");
		
		//타임라인 가져오기
		int mem_num = mdto.getMem_num();
		List<FeedDTO> list = feedMapper.getTimeline(mem_num);
		ModelAndView mav = new ModelAndView("feed/timeLine");
		mav.addObject("listFeed", list);
		
		return mav;
	}
	
	//개인 페이지
	@RequestMapping(value = "/personalHome.do")
	public ModelAndView personalHome(@RequestParam int num, HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//사이드 바 모드 설정
		HttpSession session = req.getSession();
		session.setAttribute("bar_mode", "feed");
		int mem_num = mdto.getMem_num();
		
		ModelAndView mav = new ModelAndView("feed/personalHome");
		
		//프로필 가져오기
		int friend_num = num;
		ProfileDTO pdto = profileMapper.getProfile(friend_num);
		int[] ff = profileMapper.getFollows(friend_num);
		pdto.setProf_following(ff[0]);
		pdto.setProf_follower(ff[1]);
		mav.addObject("target_profile", pdto);
		
		//개인 타임라인 가져오기
		if(mem_num == friend_num) { //내 계정일 때 (모두 가져오기)
			List<FeedDTO> list = feedMapper.getOnesTimeline_secret(friend_num);
			mav.addObject("target_listFeed", list);
			mav.addObject("profWho","me");
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
		
		return mav; //profWho: me hide blocked gotBlocked notFollow
	}
	
	//프로필 수정 폼
	@RequestMapping(value = "/profileUpdateForm.do")
	public ModelAndView profileUpdateForm(@RequestParam Map<String, Object> map, HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("feed/profileUpdate");
		int mem_num = Integer.parseInt((String)map.get("mem_num"));
		String mem_nickname = (String)map.get("mem_nickname");
		String prof_nickname_separated = (String)map.get("prof_nickname_separated");
		String prof_img = (String)map.get("prof_img");
		String prof_msg = (String)map.get("prof_msg");
		String prof_open = (String)map.get("prof_open");
		
		String business = (String)map.get("business");
		if(business!=null) mav.addObject("business","business");
		
		ProfileDTO dto = new ProfileDTO();
		dto.setMem_num(mem_num);
		dto.setMem_nickname(mem_nickname);
		dto.setProf_nickname_separated(prof_nickname_separated);
		dto.setProf_img(prof_img);
		dto.setProf_msg(prof_msg);
		dto.setProf_open(prof_open);
		
		mav.addObject("target_profile", dto);
		return mav;
	}
	
	//프로필 수정 등록
	@RequestMapping(value = "/profileUpdateOK.do")
	public ModelAndView profileUpdateOK(@RequestParam Map<String, Object> map, HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//프로필 업데이트
		int mem_num = Integer.parseInt((String)map.get("mem_num"));
		String mem_nickname = (String)map.get("mem_nickname");
		String prof_msg = (String)map.get("prof_msg");
		String old_prof_img = (String)map.get("old_prof_img");
		String old_mem_nickname = (String)map.get("old_mem_nickname");
		String old_prof_nickname_separated = (String)map.get("old_prof_nickname_separated");
		int isDef = Integer.parseInt((String)map.get("isDef"));
		int isCancle = Integer.parseInt((String)map.get("isCancle"));
		
		//tem.out.println("멤버번호:"+mem_num+" 닉네임:"+mem_nickname+" 상메"+prof_msg);
		//tem.out.println("닉넴분리:"+old_prof_nickname_separated);
		
		
		Map<String, Object> map2 = new Hashtable<>();
		map2.put("mem_num", mem_num);
		map2.put("mem_nickname", mem_nickname);
		map2.put("prof_msg", prof_msg);
		
		//프로필 잠금처리
		String prof_open = (String)map.get("prof_open"); //체크 상태면 on 아니면 null
		if(prof_open !=null && prof_open.equals("on")) {
			prof_open = "secret";
		}else {
			prof_open = "open";
		}
		map2.put("prof_open", prof_open);
		
		//tem.out.println((String)map.get("prof_open"));
		//tem.out.println("잠금:" + prof_open);
		
		//이미지 처리
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("prof_img"); //이미지 파일
		String prof_img = UUID.randomUUID().toString() + ".png"; //이미지 랜덤 이름
		
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		session.setAttribute("upPath", upPath); //업로드 경로
		
		//이미지 처리
		if(isDef==1) { //(디폴트) 디폴트 체크
			map2.put("prof_img", "default_profile.png");
			//tem.out.println("이미지를 디폴트로 설정");
			//원래 이미지 삭제 (원래 디폴트가 아니었을 때에만)
			if(!old_prof_img.equals("default_profile.png")) {
				File delFile = new File(upPath, old_prof_img);
				if (delFile.exists()) {
					delFile.delete();
				}
			}
			
		}else if(isCancle==1 || mf == null || mf.isEmpty()) { //(원본) 취소 체크, 혹은 체크 없이 이미지 없음
			map2.put("prof_img", old_prof_img);
			//tem.out.println("이미지를 원래대로 설정");
		}else { //이미지 첨부됨
			File file = new File(upPath, prof_img);
			try{mf.transferTo(file);}catch(Exception e){e.printStackTrace();};
			map2.put("prof_img", prof_img);
			//tem.out.println("이미지를 새로 설정 "+ file +"을 다음이름으로 저장 "+ prof_img);
			//원래 이미지 삭제 (원래 디폴트가 아니었을 때에만)
			if(!old_prof_img.equals("default_profile.png")) {
				File delFile = new File(upPath, old_prof_img);
				if (delFile.exists()) {
					delFile.delete();
				}
			}
		}
		
		//닉네임 분리 변경
		if(!old_mem_nickname.equals(mem_nickname)) {
			String[] CHO = { "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ",
					"ㅎ" };
			String[] JOONG = { "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
					"ㅡ", "ㅢ", "ㅣ" };
			String[] JONG = { "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ",
					"ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" };

			String nickname = mem_nickname;
			String nickname_separated = "";

			for (int i = 0; i < nickname.length(); i++) {
				char uniVal = nickname.charAt(i);

				// 한글일 경우만 시작해야 하기 때문에 0xAC00부터 아래의 로직을 실행한다
				if (uniVal >= 0xAC00) {
					uniVal = (char) (uniVal - 0xAC00);

					char cho = (char) (uniVal / 28 / 21);
					char joong = (char) ((uniVal) / 28 % 21);
					char jong = (char) (uniVal % 28);

					nickname_separated += CHO[cho];
					nickname_separated += JOONG[joong];
					nickname_separated += JONG[jong];
				} else {
					nickname_separated += uniVal;
				}
			}
			map2.put("prof_nickname_separated", nickname_separated);
		}else {
			map2.put("prof_nickname_separated", old_prof_nickname_separated);
		}
		
		//수정(프로필, 멤버 순차적으로)
		int res = profileMapper.updateProfile(map2);
		
		
		//개인 페이지로 보내기
		ModelAndView mav = personalHome(mem_num, req);
		String business = (String)map.get("business");
		if(business!=null && business.equals("business")) {
			mav.setViewName("message");
			mav.addObject("url", "b_personalHome.do?num="+mem_num);
			mav.addObject("msg", "수정 완료");
		}
		return mav;
	}
	
	//피드 상세보기
	@ResponseBody
	@RequestMapping(value = "/timeLine_feedView.do")
	public ModelAndView feedview(HttpServletRequest req, @RequestParam Map<String, Object> map) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//HttpSession session = req.getSession();
		//MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		
		ModelAndView mav = new ModelAndView("feed/feedView");
		int feed_num = Integer.parseInt((String)map.get("feed_num"));
		FeedDTO dto = feedMapper.getFeed(feed_num, mem_num);
		mav.addObject("feed", dto);
		
		return mav;
	}
	
	//피드 글쓰기 폼
	@RequestMapping(value = "/feedForm.do")
	public ModelAndView feedForm(HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("feed/feedForm");
		
		//테마 목록받아서 넘겨주기 (+세션에 저장)
		List<ThemeDTO> listTheme = adminGameMapper.listTheme();
		mav.addObject("listTheme", listTheme);
		
		//모드 설정 (등록인지 수정인지)
		HttpSession session = req.getSession();
		session.setAttribute("feedForm_mode", "insert");
		
		return mav;
	}
	
	//피드 수정 폼
	@RequestMapping(value = "/updateFeedForm.do")
	public ModelAndView updateFeedForm(@RequestParam int feed_num, HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("feed/feedForm");
		
		//테마 목록받아서 넘겨주기 + 이 피드에서 선택된 테마 체크하기
		List<ThemeDTO> listTheme = adminGameMapper.listTheme();
		List<ThemeDTO> feedTheme = feedMapper.getFeedTheme(feed_num);
		List<Integer> list = new ArrayList<Integer>();
		for(ThemeDTO theme :feedTheme) {
			list.add(theme.getTheme_num());
		}
		for(ThemeDTO theme :listTheme) {
			if(list.contains(theme.getTheme_num())) {
				theme.setFeed_checked(1);//포함되어 있으면 
			}else {
				theme.setFeed_checked(0);//없으면
			}
		}
		mav.addObject("listTheme", listTheme);
		
		//피드 찾아서 보내기
		FeedDTO dto = feedMapper.getFeed(feed_num);
		mav.addObject("feed", dto);
		
		//모드 설정 (등록인지 수정인지)
		HttpSession session = req.getSession();
		session.setAttribute("feedForm_mode", "update");
		
		return mav;
	}
	
	//피드 등록
	@RequestMapping(value = "/feedFormOk.do")
	public ModelAndView feedFormOk(@ModelAttribute FeedDTO dto, BindingResult result, @RequestParam Map<String, Object> map, HttpServletRequest req){
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		if(result.hasErrors()){} //항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
		
		int feed_num = dto.getFeed_num(); //0이면 새 글, 다른 값이면 임시저장글
		int game_num = dto.getGame_num(); //0이면 장소 선택 안 함, 다른 값이면 선택
		
		HttpSession session = req.getSession();
		String upPath = (String)session.getAttribute("upPath");
		
		//새 글이라면
		if(feed_num == 0) {
			//이미지 처리
			for(int i=0; i<4; ++i) {
				String imgs = (String) map.get("imgs"+i);
				if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
				
				byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
				String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
				
				if(i==0) dto.setFeed_img1(fileName);
				if(i==1) dto.setFeed_img2(fileName);
				if(i==2) dto.setFeed_img3(fileName);
				if(i==3) dto.setFeed_img4(fileName);
				
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
			//tem.out.println(upPath); //콘솔에 확인용 경로 출력
			
			//등록
			feed_num = feedMapper.getNextFeedNum();
			dto.setFeed_num(feed_num);
			if(game_num == 0) {
				feedMapper.insertFeed_noGame(dto);
			}else {
				feedMapper.insertFeed(dto);
			}
			
			//태그 처리
			String[] list = req.getParameterValues("theme");
			feedMapper.insertFeedTheme(feed_num, list);
			
		}else {
		//임시저장글이라면
			//tem.out.println("임시저장");
		}
		
		ModelAndView mav = feed(req); //메인 실행
		return mav;
	}
	
	//피드 수정
	@RequestMapping(value = "/feedUpdateOk.do")
	public ModelAndView feedUpdateOk(@ModelAttribute FeedDTO dto, BindingResult result, @RequestParam Map<String, Object> map, HttpServletRequest req){
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		if(result.hasErrors()){} //항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
		
		int feed_num = dto.getFeed_num();
		int Game_num = dto.getGame_num(); //0이면 장소 선택 안 함, 다른 값이면 선택
		
		HttpSession session = req.getSession();
		String upPath = (String)session.getAttribute("upPath");
		
		//이미지 처리
		for(int i=0; i<4; ++i) {
			String imgs = (String) map.get("imgs"+i);
			if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
			if(imgs.equals("1") || imgs.equals("2") || imgs.equals("3") || imgs.equals("4")) {
				if(i==0) dto.setFeed_img1((String) map.get("old_feed_img"+imgs));
				if(i==1) dto.setFeed_img2((String) map.get("old_feed_img"+imgs));
				if(i==2) dto.setFeed_img3((String) map.get("old_feed_img"+imgs));
				if(i==3) dto.setFeed_img4((String) map.get("old_feed_img"+imgs));
			}else {
				byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
				String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
				if(i==0) dto.setFeed_img1(fileName);
				if(i==1) dto.setFeed_img2(fileName);
				if(i==2) dto.setFeed_img3(fileName);
				if(i==3) dto.setFeed_img4(fileName);
				
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
		}
		
		//삭제된 이미지 서버에서 삭제
		String deleted_img = (String) map.get("deleted_img");
		String[] arr = deleted_img.split(","); //1번 방부터 시작, 총 길이는 삭제된 개수+1

		for(int i=1; i<arr.length; i++) {
			int delImgNum = Integer.parseInt(arr[i]);
			String delImgName = (String) map.get("old_feed_img"+delImgNum);
			File file = new File(upPath, delImgName);
			if (file.exists()) {
				file.delete();
			}
		}
		
		//등록
		if(Game_num == 0) {
			feedMapper.updateFeed_noGame(dto);
		}else {
			feedMapper.updateFeed(dto);
		}
		
		//태그 처리
		String[] list = req.getParameterValues("theme");
		feedMapper.updateFeedTheme(feed_num, list);
		
		ModelAndView mav = feed(req); //메인 실행 //이전에 어디에서 왔는지를 가를 필요 있음
		return mav;
	}
	
	//피드 삭제
	@RequestMapping(value = "/deleteFeed.do")
	public ModelAndView deleteFeed(@RequestParam int feed_num, HttpServletRequest req) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//이미지 삭제
		//tem.out.println("피드번호는 "+feed_num);
		FeedDTO dto = feedMapper.getFeed(feed_num);
		if(dto.getFeed_img1() != null) {
			String[] imgs = new String[4];
			imgs[0]=dto.getFeed_img1();
			imgs[1]=dto.getFeed_img2();
			imgs[2]=dto.getFeed_img3();
			imgs[3]=dto.getFeed_img4();
			
			HttpSession session = req.getSession();
			String upPath = (String)session.getAttribute("upPath");
			
			for(String img :imgs) {
				if(img != null) {
					File file = new File(upPath, img);
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}
		
		feedMapper.deleteFeed(feed_num);
		feedMapper.deleteFeedTheme(feed_num);
		
		ModelAndView mav = feed(req); //메인 실행
		return mav;
	}
	
	//피드 좋아요 기능
	@ResponseBody
	@RequestMapping(value = "feedLike.do")
	public ModelAndView gameLike(HttpServletRequest req, @RequestParam int feed_num) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//HttpSession session = req.getSession();
		//MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		Feed_likeDTO dto = new Feed_likeDTO();

		dto.setMem_num(mdto.getMem_num());
		dto.setFeed_num(feed_num);
		int res = feedMapper.feedLike(dto); //좋아요 정보 등록
		
		if (res > 0) { //feed 좋아요 갯수 올리기
			res = feedMapper.addLikeFeed(feed_num, mem_num);
		}
		
		ModelAndView mav = new ModelAndView("feed/timeLine_icons");
		FeedDTO fdto = feedMapper.getFeed(feed_num, mem_num);
		mav.addObject("feed", fdto);
		return mav;
	}
		
	//피드 좋아요 해제 기능
	@ResponseBody
	@RequestMapping(value = "feedLikeDelete.do")
	public ModelAndView gameLikeDelete(HttpServletRequest req, @RequestParam int feed_num) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//HttpSession session = req.getSession();
		//MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		
		Hashtable<String, Integer> ht = new Hashtable<>();
		ht.put("feed_num", feed_num);
		ht.put("mem_num", mem_num);
		int res = feedMapper.feedLikeDelete(ht); //좋아요 정보 삭제
		
		if (res > 0) { //feed 좋아요 갯수 내리기
			res = feedMapper.minusLikeFeed(feed_num, mem_num);
		}
		
		ModelAndView mav = new ModelAndView("feed/timeLine_icons");
		FeedDTO fdto = feedMapper.getFeed(feed_num, mem_num);
		mav.addObject("feed", fdto);
		return mav;
	}
	
	//테마별 피드 가져오기
	@RequestMapping(value = "/themeTimeline.do")
	public ModelAndView themeTimeline(HttpServletRequest req, int theme_num) {
		//tem.out.println("테마 타임라인~");
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
				
		//타임라인 가져오기
		int mem_num = mdto.getMem_num();
		List<FeedDTO> list = feedMapper.getThemeFeedList(theme_num, mem_num);
		//tem.out.println(theme_num+"테마번호, 멤버번호"+mem_num);
		ModelAndView mav = new ModelAndView("feed/timeLine");
		mav.addObject("listFeed", list);
		
		return mav;		
	}
	
	//게임별 피드 가져오기 //현재 사용하지 않는 메소드.아마도?
	@RequestMapping(value = "/gameTimeline.do")
	public ModelAndView gameTimeline(HttpServletRequest req) {
		//초기설정
		MemberDTO mdto = setLoginMember(req);
		
		//이미지 저장 경로 등록 & 사이드 바 모드 설정 //이거 그냥 메인 페이지에서 할까봐? //아니다... 링크로 들어올 수 있는 모든 경로에서 해야함
		HttpSession session = req.getSession();
		session.setAttribute("upPath", session.getServletContext().getRealPath("/resources/img"));
		session.setAttribute("bar_mode", "feed");
		
		//타임라인 가져오기
		int mem_num = mdto.getMem_num();
		//List<FeedDTO> list = feedMapper.getGameTimeline(mem_num);
		ModelAndView mav = new ModelAndView("feed/timeLine");
		//mav.addObject("listFeed", list);
		
		return mav;
	}
	
	//피드 보기(비회원 가능)
	@RequestMapping(value = "/feedView_only.do")
	public ModelAndView feedView_only(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView("feed/feedView_only");
		int feed_num = Integer.parseInt((String)map.get("feed_num"));
		FeedDTO dto = feedMapper.getFeed(feed_num);
		mav.addObject("feed", dto);
		
		return mav;
	}
	
	//피드 댓글 작성
	@ResponseBody
	@RequestMapping("/insertfeedReply.do")
	public ModelAndView InsertfeedReply(HttpServletRequest req, @RequestParam Map<String, Object> map) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		//멤버세팅
		//HttpSession session = req.getSession();
		//MemberDTO mdto = (MemberDTO)session.getAttribute("login_mem");
		
		int fr_re_group = 0; //묶음
		int	fr_re_step = 0; //묶음 내 순서
		int	fr_re_level = 0; //깊이
		
		int feed_num = Integer.parseInt((String)map.get("feed_num"));
		String fr_content = (String) map.get("fr_content");
		
		int mem_num = mdto.getMem_num();
		ProfileDTO pdto = profileMapper.getProfile(mem_num);
		String fr_open = pdto.getProf_open();
		
		//피드 댓글 DTO
		FeedReplyDTO dto = new FeedReplyDTO();
		dto.setFr_re_group(fr_re_group);
		dto.setFr_re_step(fr_re_step);
		dto.setFr_re_level(fr_re_level);
		dto.setFeed_num(feed_num);
		dto.setFr_content(fr_content);
		dto.setFr_open(fr_open);

		dto.setMem_num(mem_num);
		
		feedMapper.insertFeedReply(dto);
		ModelAndView mav = feedview(req, map);
		return mav;
	}
	
	//피드 댓글 수정 폼 열기
	@ResponseBody
	@RequestMapping("updatefeedReply_form.do")
	public ModelAndView updatefeedReply_form(HttpServletRequest req, int fr_num) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("feed/replyEditForm");
		FeedReplyDTO dto = feedMapper.getFeedReply(fr_num);
		mav.addObject("reply", dto);
		return mav;
	}
	
	//피드 댓글 수정 등록
	@ResponseBody
	@RequestMapping("updatefeedReply_OK.do")
	public ModelAndView updatefeedReply_OK(HttpServletRequest req, @RequestParam Map<String, Object> map) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("feed/replyDiv");
		int fr_num = Integer.parseInt((String) map.get("fr_num"));
		String fr_content = (String) map.get("fr_content");
		int res = feedMapper.updateFeedReply(fr_num, fr_content);
		FeedReplyDTO dto = feedMapper.getFeedReply(fr_num);
		dto.setVisible("ok");
		mav.addObject("reply", dto);
		return mav;
	}
	
	//피드 댓글 삭제
	@ResponseBody
	@RequestMapping("deletefeedReply.do")
	public int deletefeedReply(HttpServletRequest req, @RequestParam int fr_num, @RequestParam int feed_num) {
		int res = feedMapper.deleteFeedReply(fr_num, feed_num);
		return res; //댓글 수 반환
	}
	
	//피드&피드댓글 신고창 띄우기
	@RequestMapping("/feed_report.do")
	public ModelAndView reportFeed(HttpServletRequest req, String mode) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("message");
		if(mode.equals("feed")) {//피드일 떄
			mav.addObject("feed_num", Integer.parseInt(req.getParameter("feed_num")));
			mav.addObject("mode", "feed");
		}else {
			mav.addObject("fr_num", Integer.parseInt(req.getParameter("fr_num")));
			mav.addObject("mode", "feedReply");
		}
		mav.setViewName("feed/reportForm");
		return mav;
	}
	
	//피드&피드댓글 신고 넘기기
	@RequestMapping(value="/feed_report.do", method = RequestMethod.POST)
	public ModelAndView reportFeedPro(HttpServletRequest req, String mode, @ModelAttribute ReportDTO dto, BindingResult result) {
		//로그인 체크&초기설정
		if(checkLogin(req)) return sentBack();
		MemberDTO mdto = setLoginMember(req);
		
		ModelAndView mav = new ModelAndView("closeWindow");
		HttpSession session = req.getSession();
		
		//신고자, 신고사유 세팅
		MemberDTO dto3 = (MemberDTO)session.getAttribute("login_mem");
		dto.setMem_num(dto3.getMem_num());
		dto.setReport_content(Integer.parseInt(req.getParameter("feed_report")));
		
		if(mode.equals("feed")) {//피드일 떄
			int feed_num = Integer.parseInt(req.getParameter("feed_num"));
			dto.setReport_target(feed_num);
			dto.setReport_mode("피드");
			feedMapper.report(dto); //신고 DTO 넘기기
			int res = feedMapper.reportFeed(feed_num); //신고된 피드로 처리
			if (res > 0) {
				mav.addObject("msg", "신고되었습니다.");
			} else {
				mav.addObject("msg", "신고 실패, 관리자에게 문의해 주세요");
			}
		}else {//피드 댓글일 때
			int fr_num = Integer.parseInt(req.getParameter("fr_num"));
			dto.setReport_mode("피드댓글");
			dto.setReport_target(fr_num);
			feedMapper.report(dto); //신고 DTO 넘기기
			int res = feedMapper.reportFeedReply(fr_num); //신고된 댓글로 처리
			if (res > 0) {
				mav.addObject("msg", "신고되었습니다.");
			} else {
				mav.addObject("msg", "신고 실패, 관리자에게 문의해 주세요");
			}
		}
		return mav;
	}
	
}
