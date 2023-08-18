package com.ezen.FSB;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.AlarmDTO;
import com.ezen.FSB.dto.BoardDTO;
import com.ezen.FSB.dto.BusinessCouponUserDTO;
import com.ezen.FSB.dto.DontgoDTO;
import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.NoticeDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.service.AdminMapper;
import com.ezen.FSB.service.AlarmMapper;
import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.MemberMapper;
import com.ezen.FSB.service.MypageMapper;

@Controller
public class MyPageController {
	@Autowired
	private LoginMapper loginMapper;
//	@Autowired
//	private BoardMapper boardMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	MypageMapper myPageMapper;
	
	@Autowired
	AlarmMapper alarmMapper;

	@RequestMapping("/myPage.do") // 계정관리 클릭
	public String myPageIndex(HttpSession session, HttpServletRequest req) {
		
		return "mypage/myPageChange";
	}

	@RequestMapping("/myPageChange.do") // 내 정보 수정
	public String Change(HttpSession session, HttpServletRequest req) {
		
		return "mypage/myPageChange";
	}

	@ResponseBody

	@RequestMapping("/ImgNormal.do") // 프로필 이미지 기본사진으로
	public ModelAndView ImageNormal(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("mypage/normalImg");
		MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
		dto.setMem_img("default_profile.png");

		return mav;
	}

	@RequestMapping("/changeId.do") // 프로필 이미지 기본사진으로
	public String changeId() {

		return "mypage/changeId";
	}

	@RequestMapping(value = "/saveImg.do", method = RequestMethod.POST) // 프로필 이미지 기본사진으로
	public String SaveImg(HttpServletRequest req, HttpSession session) throws IllegalStateException, IOException {
	

		MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
		
		// 이미지 받기
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;

		MultipartFile mf = mr.getFile("file");
		//tem.out.println("받았니");

		String pimage = mf.getOriginalFilename();
		
		UUID uuid = UUID.randomUUID(); // 이미지 중복 시 엑스박스 방지용 랜덤 파일명

		session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		session.setAttribute("upPath", upPath);

		if (!mf.isEmpty()) { // 이미지 첨부 되어있을 시
			pimage = uuid.toString() + "_" + pimage;
			File file = new File(upPath, pimage);
			try {
				mf.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
				//tem.out.println("file 수정중 오류 발생");
			}
			dto.setMem_img(pimage);
			dto.setMem_id(dto.getMem_id());
			
			/*
			 * File file01 = new File(upPath, (String)req.getAttribute("file")); String
			 * file22 = (String)req.getAttribute("file"); if (file22!="default_profile.png")
			 * { if(file01.exists()) { // 파일이 존재하면 file01.delete(); } file01.delete(); } }
			 */
		} else if (mf.isEmpty()) { // 이미지 첨부 안되어있을시
			dto.setMem_img("default_profile.png");
			dto.setMem_id(dto.getMem_id());
		}

		req.setAttribute("dto", dto);

		int res = loginMapper.imageUpdate(dto);
		if (res > 0) {
			req.setAttribute("msg", "이미지 등록 성공");
			req.setAttribute("url", "myPageChange.do");

		} else {
			req.setAttribute("msg", "이미지 등록 실패");
			req.setAttribute("url", "myPageChange.do");
		}
		
		session.setAttribute("login_mem", dto);
		return "message";
	}



//	@RequestMapping("/changePw.do") // 로그인 인덱스로 이동
//	public String ChangePw(HttpSession session, HttpServletRequest req) {
//
//		return "mypage/changePw";
//	}
	
	@RequestMapping("/changePw.do") //  비밀번호 찾기
	public String changePw(HttpServletRequest req) {
		String id = req.getParameter("id");
		req.setAttribute("id", id);
		return "mypage/changePw2";
	}
	
	@RequestMapping("/close_nomessage.do") //메세지 없이 창닫기
	public String close_nomessage(HttpServletRequest req) {
		req.setAttribute("msg", "창을 닫습니다.");
		return "closeWindow";
	}
	
	@RequestMapping("/changePwOk.do") // 비밀번호 찾기 완료 눌렀을때
	public String changePwOk(HttpServletRequest req) {
		String id = req.getParameter("id");
		
		String passwd = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");
		
		String msg;
		MemberDTO dto = loginMapper.findMember(id);
		
		if(dto.getMem_passwd().equals(passwd)) {
			//tem.out.println("여기오니=");
			dto.setMem_passwd(confirmPassword);
			int res = loginMapper.changePw(dto);
			msg = "변경되었습니다.";
			
		}else {
			msg = "현재 비밀번호가 틀립니다.";
		}
		
		
		req.setAttribute("msg", msg);	
		
		return "message_close";
	}
	
	@RequestMapping("/changeNick.do") //  닉네임변경 및 중복확인
	public String changeNick(HttpServletRequest req) {
		String id = req.getParameter("id");
		req.setAttribute("id", id);
		return "mypage/changeNick";
	}
	
		
	@RequestMapping("/changeNickCheck.do") //  닉네임 및 중복확인 버튼 눌렀을때
	public String changeNickCheck(HttpServletRequest req) {
		String nickname = req.getParameter("nickName");
		int res;
		MemberDTO dto = loginMapper.findNick(nickname);
		if(dto==null) {
			res = 0;
		} else res=1;
		
	
		req.setAttribute("result", res);
		req.setAttribute("nickname", nickname);
		return "mypage/nickCheck";
	}
	
	@RequestMapping("/nickChangeOK.do") // 닉네임 변경 적용
	public String nickChangeOK(HttpServletRequest req, HttpSession session) {
		String nickname = req.getParameter("nickname");
		//tem.out.println("nic닉="+nickname);
		String id = req.getParameter("id");
	
		MemberDTO dto = loginMapper.findMember(id);
		dto.setMem_nickname(nickname);
		dto.setMem_id(id);
		int res = myPageMapper.changeNick(dto);
		
		// 닉네임 프로필 수정
		ProfileDTO pdto = new ProfileDTO();
		pdto.setMem_num(dto.getMem_num());
		// 프로필 삽입
		String[] CHO = { "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ",
				"ㅎ" };
		String[] JOONG = { "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ",
				"ㅡ", "ㅢ", "ㅣ" };
		String[] JONG = { "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ",
				"ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" };
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
		pdto.setProf_nickname_separated(nickname_separated);
		
		int res2 = memberMapper.updateNicknameProfile(pdto);
		if(res2>0) {
			//tem.out.println("닉네임 프로필 수정 성공");
		}else {
			//tem.out.println("닉네임 프로필 수정 실패");			
		}
		
		session.setAttribute("login_mem", dto);
		req.setAttribute("msg", "닉네임이 변경되었습니다.");
		
		return "closeWindow";
	}
	
	
	@RequestMapping("/changePhone.do") //  핸드폰 번호 변경 버튼 클릭시
	public String changePhone(HttpServletRequest req) {
		String id = req.getParameter("id");
		req.setAttribute("id", id);
		return "mypage/changePhone";
	}
	
	@RequestMapping("/changePhoneSMS.do") //  핸드폰 번호 변경 / 인증번호 클릭시
	public String changePhoneSMS(@RequestParam Map<String, String> params, HttpServletRequest req) {

		String phoneNumber = params.get("phoneNumber");
		String id = params.get("id");
		
		Random rand  = new Random(); //랜덤숫자 생성하기 !!
		String numStr = "";
		for(int i=0; i<4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr+=ran;
		}
		
		LoginController.certifiedPhoneNumber(phoneNumber, numStr); 
		req.setAttribute("phoneNumber", phoneNumber);
		req.setAttribute("numStr", numStr);

		return "mypage/changePhone2";
	}

	@RequestMapping("/changePhoneSMS_ok.do") //  핸드폰 번호 변경 버튼 클릭시
	public String changePhoneSMS_ok(@RequestParam Map<String, String> params, HttpServletRequest req) {
		String phoneNumber = params.get("phoneNumber");
		String numberok = params.get("numberok");
		req.setAttribute("phoneNumber", phoneNumber);
		req.setAttribute("numberok", numberok);
		
		return "mypage/changePhone3";
	}
	
	@RequestMapping("/changePhoneSMS_change.do") //  핸드폰 번호 변경 버튼 클릭시
	public String changePhoneSMS_change(@RequestParam Map<String, String> params, HttpServletRequest req, HttpSession session) {
		String phoneNumber = params.get("phoneNumber");
		String numberok = params.get("numberok");
		String id = params.get("id");
		
		
		req.setAttribute("phoneNumber", phoneNumber);
		req.setAttribute("numberok", numberok);
		
		MemberDTO dto = loginMapper.findMember(id);
		dto.setMem_hp1(phoneNumber.substring(0, 3));
		dto.setMem_hp2(phoneNumber.substring(3, 7));
		dto.setMem_hp3(phoneNumber.substring(7, 11));
		dto.setMem_id(id);
		
		int res = myPageMapper.changePhone(dto);
		
		req.setAttribute("msg", "핸드폰 번호가 변경되었습니다.");
		session.setAttribute("login_mem", dto);
		return "closeWindow";
	}
	

	/*
	 * @RequestMapping("/changeMsg.do") // 상태메세지 변경 버튼 누르면 public String
	 * changeMsg(HttpServletRequest req, HttpSession session) { String id =
	 * req.getParameter("id"); req.setAttribute("id", id);
	 * 
	 * return "mypage/changeMsg"; }
	 * 
	 * @RequestMapping("/changeMsg_ok.do") // 상메 변경 완료 public String
	 * changeMsg_ok(@RequestParam Map<String, String> params, HttpServletRequest
	 * req, HttpSession session) { String id = params.get("id"); String changeMsg =
	 * params.get("changeMsg");
	 * 
	 * MemberDTO dto = loginMapper.findMember(id); dto.setMem_msg(changeMsg);
	 * dto.setMem_id(id);
	 * 
	 * int res = loginMapper.changeMsg(dto);
	 * 
	 * req.setAttribute("id", id); req.setAttribute("msg", "상태메세지가 변경되었습니다.");
	 * req.setAttribute("changeMsg", changeMsg); session.setAttribute("login_mem",
	 * dto);
	 * 
	 * return "closewindow"; }
	 */
	
	@RequestMapping("/changeBadge.do") //  뱃지 설정 버튼 누르면
	public String changeBadge(HttpServletRequest req, HttpSession session) {
		String id = req.getParameter("id");
		
		req.setAttribute("id", id);
	
		
		 MemberDTO dto = loginMapper.findMember(id); 
		 
		 if (dto.getMem_count()>=10) {
			 dto.setBadge_king("1"); 
		 }
		 int num = dto.getMem_num();
		 
		 int boardCount = myPageMapper.memCountBoard(num);
		 int replyCount = myPageMapper.memCountReply(num);
		
		 if (boardCount>=3) {
			 dto.setBadge_write("1");
		 }
		 
		 if (replyCount>=1) {
			 dto.setBadge_1004("1");
		 }
		 
		 int likeCount = myPageMapper.memCountLike(num);
		 int shopCount = myPageMapper.memCountShop(num);
		 
		 if (likeCount>=10) {
			 dto.setBadge_good("1");
		 }
		 
		 if (shopCount>=10) {
			 dto.setBadge_rich("1");
		 }

		 int res = myPageMapper.changeBadge(dto);
		 
		 req.setAttribute("badge_king", dto.getBadge_king());
		 req.setAttribute("badge_write", dto.getBadge_write());
		 req.setAttribute("badge_1004", dto.getBadge_1004());
		 req.setAttribute("badge_good", dto.getBadge_good());
		 req.setAttribute("badge_rich", dto.getBadge_rich());
		return "mypage/changeBadge";
	}
	
	// 뱃지 설정부분
	// 뱃지 컬럼 설정 -> king , write, 1004, good, rich + Mem_id
	// 컬럼의 기본값 0
	// 얼마 이상되면 1로 바뀌게 설정
	// 체인지 뱃지jsp-> 컬럼 꺼내서 if 저 컬럼들이 1이면 -> able -> 0이면 disable로 보이게!!
	// 완료를 누르면!! 체크가 된 애들만 (if(?.value.check이런식으로) -> 새로운 컬럼
	// king_2 , write_2, 1004_2, good_2, rich_2 // 이 컬럼기본 셋팅 0 -> 체크 된애들 1로
	// 그 애들만 , 뱃지 목록에 띄워줌 
	
	@RequestMapping("/changeBadgeOk.do") //  뱃지 설정 버튼 누르면
	public String changeBadgeOk(HttpServletRequest req, HttpSession session) {
		String id = req.getParameter("id");
		//tem.out.println("id="+id);

		MemberDTO dto = loginMapper.findMember(id);
	
		
		if (req.getParameter("check1")==null) {
			dto.setBadge_king_2("0");
			}else dto.setBadge_king_2("1");
		
		if (req.getParameter("check2")==null) {
			dto.setBadge_write_2("0");
		}else dto.setBadge_write_2("1");
		
		if (req.getParameter("check3")==null) {
			dto.setBadge_1004_2("0");
		}else dto.setBadge_1004_2("1");
		
		if (req.getParameter("check4")==null) {
			dto.setBadge_good_2("0");
		}else dto.setBadge_good_2("1");
		
		if (req.getParameter("check5")==null) {
			dto.setBadge_rich_2("0");
		}else dto.setBadge_rich_2("1");
		
		int res = myPageMapper.changeBadgeOk(dto);

		 req.setAttribute("badge_king_2", dto.getBadge_king_2());
		 req.setAttribute("badge_write_2", dto.getBadge_write_2());
		 req.setAttribute("badge_1004_2", dto.getBadge_1004_2());
		 req.setAttribute("badge_good_2", dto.getBadge_good_2());
		 req.setAttribute("badge_rich_2", dto.getBadge_rich_2());
		session.setAttribute("login_mem", dto);
		req.setAttribute("msg", "뱃지 설정이 완료되었습니다.");
		
		return "closeWindow";
	}
	
	@RequestMapping("/changeTag.do") //  뱃지 설정 버튼 누르면
	public String changeTag(HttpServletRequest req, HttpSession session) {
		String num = req.getParameter("num");

		MemberDTO dto = loginMapper.findIdnum(num);
		req.setAttribute("login_mem", dto);
		req.setAttribute("tag1", dto.getTag_1());
		req.setAttribute("tag2", dto.getTag_2());
		req.setAttribute("tag3", dto.getTag_3());
		req.setAttribute("tag4", dto.getTag_4());
		req.setAttribute("tag5", dto.getTag_5());
		req.setAttribute("tag6", dto.getTag_6());
		req.setAttribute("tag7", dto.getTag_7());
		req.setAttribute("tag8", dto.getTag_8());
		
		
		return "mypage/changeTag";
	}
	
	@RequestMapping("/changeTagOk.do") //  뱃지 설정 버튼 누르면
	public String changeTagOk(HttpServletRequest req, HttpSession session) {
		String id = req.getParameter("id");
		
		MemberDTO dto = loginMapper.findMember(id);

		
		if (req.getParameter("check1")==null) {
			dto.setTag_1("0");
		}else dto.setTag_1("1");
		
		if (req.getParameter("check2")==null) {
			dto.setTag_2("0");
		}else dto.setTag_2("1");
		
		if (req.getParameter("check3")==null) {
			dto.setTag_3("0");
		}else dto.setTag_3("1");
		
		if (req.getParameter("check4")==null) {
			dto.setTag_4("0");
		}else dto.setTag_4("1");
		
		if (req.getParameter("check5")==null) {
			dto.setTag_5("0");
		}else dto.setTag_5("1");
		
		if (req.getParameter("check6")==null) {
			dto.setTag_6("0");
		}else dto.setTag_6("1");
		
		if (req.getParameter("check7")==null) {
			dto.setTag_7("0");
		}else dto.setTag_7("1");
		
		if (req.getParameter("check8")==null) {
			dto.setTag_8("0");
		}else dto.setTag_8("1");
		
		int res = myPageMapper.changeTag(dto);
		
	
		
		
		session.setAttribute("login_mem", dto);
		req.setAttribute("msg", "해쉬태그가 변경되었습니다.");
		
		return "closeWindow";
	}
	
	@RequestMapping("/changeBirth.do") //  뱃지 설정 버튼 누르면
	public String changeBirth(HttpServletRequest req, HttpSession session) {
		String id = req.getParameter("id");
		String birthday = req.getParameter("birthday");
		
		req.setAttribute("id", id);
		
		return "message";
	}
	
	// 내가쓴글 페이지
	
	@RequestMapping("/myBoard.do") //  뱃지 설정 버튼 누르면
	public String myBoard(HttpServletRequest req, HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");

		int num = dto.getMem_num();
		
		//1. 글 수
		int shboard = myPageMapper.memCountShBoard(num);
		int freeboard = myPageMapper.memCountFreeBoard(num);
		int secretboard = myPageMapper.memCountSecretBoard(num);
		int allboard = shboard+freeboard+secretboard ;
		
		java.util.Map<String, Integer> params = new HashMap<>();
		params.put("num", num);
		//2. 댓글 수
		List<BoardDTO> list = myPageMapper.freeReply(params);
		int f_list = list.size();
		
		List<BoardDTO> list2 = myPageMapper.secretReply(params);
		int sc_list = list2.size();
		
		List<BoardDTO> list3 = myPageMapper.shReply(params);
		int sh_list = list3.size();
		
		int allReply = f_list+sc_list+sh_list;
		
		
		req.setAttribute("shboard", shboard);
		req.setAttribute("freeboard", freeboard);
		req.setAttribute("secretboard", secretboard);
		req.setAttribute("allboard", allboard);
		req.setAttribute("f_list", f_list);
		req.setAttribute("sc_list", sc_list);
		req.setAttribute("sh_list", sh_list);
		req.setAttribute("allReply", allReply);
		
		return "mypage/myBoard";
	}
	
	//자유게시판 내가쓴글 리스트 
		@RequestMapping("/myFreeBoard.do")
		public ModelAndView myFreeBoard(HttpServletRequest req, java.util.Map<String, Integer> params) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = req.getSession();
			MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
			int num = dto.getMem_num();
			
			session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
			
			//페이지 넘버
			int pageSize = 10;
			
			String pageNum = req.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			int count = myPageMapper.memCountFreeBoard(num);
			params.put("start", startRow);
			params.put("end", endRow);
			params.put("num", num);

			if (endRow > count)
				endRow = count;
			List<BoardDTO> list = null;
			
			if (count > 0) {
				list = myPageMapper.MemfreelistBoard(params);
				
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
			
			mav.addObject("count", count);
			
			mav.addObject("listBoard", list);
			mav.setViewName("mypage/myFreeBoard");
			return mav;
		}
		
		//중고 게시판 내가쓴글 리스트 
				@RequestMapping("/myShBoard.do")
				public ModelAndView myShBoard(HttpServletRequest req, java.util.Map<String, Integer> params) {
					ModelAndView mav = new ModelAndView();
					HttpSession session = req.getSession();
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					int num = dto.getMem_num();
					
					session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
					
					//페이지 넘버
					int pageSize = 10;
					
					String pageNum = req.getParameter("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = myPageMapper.memCountFreeBoard(num);
					params.put("start", startRow);
					params.put("end", endRow);
					params.put("num", num);

					if (endRow > count)
						endRow = count;
					List<BoardDTO> list = null;
					
					if (count > 0) {
						list = myPageMapper.MemShlistBoard(params);
						
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
					
					mav.addObject("count", count);
					
					mav.addObject("listBoard", list);
					mav.setViewName("mypage/myShBoard");
					return mav;
				}
			
				
				//익명게시판 내가쓴글 리스트 
				@RequestMapping("/mySecretBoard.do") 
				public ModelAndView mySecretBoard(HttpServletRequest req, java.util.Map<String, Integer> params) {
					ModelAndView mav = new ModelAndView();
					HttpSession session = req.getSession();
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					int num = dto.getMem_num();
					
					session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
					
					//페이지 넘버
					int pageSize = 10;
					
					String pageNum = req.getParameter("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = myPageMapper.memCountFreeBoard(num);
					params.put("start", startRow);
					params.put("end", endRow);
					params.put("num", num);

					if (endRow > count)
						endRow = count;
					List<BoardDTO> list = null;
					
					if (count > 0) {
						list = myPageMapper.MemSecretlistBoard(params);
						
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
					
					mav.addObject("count", count);
					
					mav.addObject("listBoard", list);
					mav.setViewName("mypage/mySecretBoard");
					return mav;
				}
			
				//댓글
				@RequestMapping("/myFreeReply.do")
				public ModelAndView myFreeReply(HttpServletRequest req, java.util.Map<String, Integer> params) {
					ModelAndView mav = new ModelAndView();
					HttpSession session = req.getSession();
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					int num = dto.getMem_num();
					//tem.out.println("num="+num);
					session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
					
					//페이지 넘버
					int pageSize = 10;
					
					String pageNum = req.getParameter("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = myPageMapper.memCountFreeBoard(num);
					params.put("start", startRow);
					params.put("end", endRow);
					params.put("num", num);

					if (endRow > count)
						endRow = count;
					List<BoardDTO> list = null;
					
					if (count > 0) {
						list = myPageMapper.freeReply(params);
						
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
						mav.addObject("dto", dto);
					}
					
					mav.addObject("count", count);
					
					mav.addObject("listBoard", list);
					mav.setViewName("mypage/myFreeBoard");
					return mav;
				}
				
				@RequestMapping("/myShReply.do") //중고게시판 내가쓴 댓글 목록 
				public ModelAndView myShReply(HttpServletRequest req, java.util.Map<String, Integer> params) {
					ModelAndView mav = new ModelAndView();
					HttpSession session = req.getSession();
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					int num = dto.getMem_num();
					//tem.out.println("num="+num);
					session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
					
					//페이지 넘버
					int pageSize = 10;
					
					String pageNum = req.getParameter("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = myPageMapper.memCountFreeBoard(num);
					params.put("start", startRow);
					params.put("end", endRow);
					params.put("num", num);

					if (endRow > count)
						endRow = count;
					List<BoardDTO> list = null;
					
					if (count > 0) {
						list = myPageMapper.shReply(params);
						
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
					
					mav.addObject("count", count);
					
					mav.addObject("listBoard", list);
					mav.setViewName("mypage/myShBoard");
					return mav;
				}
	
				@RequestMapping("/mySecretReply.do") //익명게시판 내가쓴 댓글목록 
				public ModelAndView mySecretReply(HttpServletRequest req, java.util.Map<String, Integer> params) {
					ModelAndView mav = new ModelAndView();
					HttpSession session = req.getSession();
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					int num = dto.getMem_num();
					//tem.out.println("num="+num);
					session.setAttribute("upPath", session.getServletContext().getRealPath("resources/images"));
					
					//페이지 넘버
					int pageSize = 10;
					
					String pageNum = req.getParameter("pageNum");
					if (pageNum == null) {
						pageNum = "1";
					}
					int currentPage = Integer.parseInt(pageNum);
					int startRow = (currentPage - 1) * pageSize + 1;
					int endRow = startRow + pageSize - 1;
					int count = myPageMapper.memCountFreeBoard(num);
					params.put("start", startRow);
					params.put("end", endRow);
					params.put("num", num);

					if (endRow > count)
						endRow = count;
					List<BoardDTO> list = null;
					
					if (count > 0) {
						list = myPageMapper.secretReply(params);
						
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
					
					mav.addObject("count", count);
					
					mav.addObject("listBoard", list);
					mav.setViewName("mypage/mySecretBoard");
					return mav;
				}
				
				@RequestMapping("/dontgo.do") //  회원 탈퇴 누르면 
				public String dontgo() {
					return "mypage/dontgo";
				}
				
				@RequestMapping("/dontgoplz.do") // 탈퇴 이유 담기
				public String dontgoplz(HttpServletRequest req, HttpSession session, @ModelAttribute DontgoDTO dto2) {
					int res = memberMapper.reason(dto2);
					
					return "mypage/dontgoplz";
				}
				
				@RequestMapping("/dontgoplzOk.do") //  탈퇴 시켜줘~ 
				public String dontgoplzOk(HttpServletRequest req, HttpSession session) {
					String writePasswd = req.getParameter("passwd");
					MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
					String realPasswd = dto.getMem_passwd();
					
					if (realPasswd.equals(writePasswd)){
						int res = memberMapper.deleteMem(dto.getMem_id());
						req.setAttribute("msg", "회원탈퇴가 완료되었습니다.");
						req.setAttribute("url", "user_main.do");
						session.invalidate();
					}else {
						req.setAttribute("msg", "비밀번호가 틀립니다.");
						req.setAttribute("url", "myPage.do");
					}
					
					return "message";
				}
				

				// 좋아요한 보드게임 목록
					@RequestMapping("game_like_list.do")
					public ModelAndView gameLikeList(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("mypage/gameLikeList");
						
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						
						List<GameDTO> list = myPageMapper.myPageGameLikeList(dto.getMem_num());
						mav.addObject("gameLikeList", list);
						return mav;
					}
					
					// 쿠폰 목록
					@RequestMapping("myCoupon.do")
					public ModelAndView myCoupon(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("mypage/couponList");
						
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						
						// 비즈니스 쿠폰 만료일 삭제
						myPageMapper.expireBcouponUser();
				         
						List<BusinessCouponUserDTO> list = myPageMapper.myPageCouponList(dto.getMem_num());
					
						mav.addObject("CouponList", list);
					
						
						return mav;
					}
					
					// 쿠폰 삭제
					@RequestMapping("couponDel.do")
					public ModelAndView couponDel(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("mypage/couponList");
						
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						String num2 = req.getParameter("bc_num");
						int num = Integer.parseInt(num2);
						System.out.println(num2 +"넘 투 ");
						int res = myPageMapper.delCoupon(num);
					
						List<BusinessCouponUserDTO> list = myPageMapper.myPageCouponList(dto.getMem_num());
						mav.addObject("CouponList", list);
						
						
						return mav;
					}
					
					//알림함!! 
					@RequestMapping("myAlarm.do")
					public ModelAndView myAlarm(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("mypage/myAlarm");
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
			
						// 새 알람이 등록됐을
						List<AlarmDTO> list = alarmMapper.boardAlarmList(dto.getMem_num());
						
						// 안읽은 알람
						List<AlarmDTO> listCount = alarmMapper.boardunReadAlarmList(dto.getMem_num());
						//총 알람의 갯수
						int count = listCount.size();
						
						mav.addObject("boardAlarmList", list);
						//본인의 알람갯수 맞나요?
						
						session.setAttribute("alarmCount", count);
						
						return mav;
					}

					//알림 지우기 
					@RequestMapping("alarmDel.do")
					public ModelAndView alarmDel(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("message");
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						
						int num = Integer.parseInt(req.getParameter("num"));
						//삭제하기
						int res = alarmMapper.delAlarm(num);
						
						List<AlarmDTO> list = alarmMapper.boardAlarmList(dto.getMem_num());
						mav.addObject("boardAlarmList", list);
						mav.addObject("msg", "알람이 삭제 되었습니다.");
						mav.addObject("url", "myAlarm.do");
						
						return mav;
					}
					
					//알림확인누르면 !! 
					@RequestMapping("alarmOk.do")
					public ModelAndView alarmOk(HttpServletRequest req) {
						ModelAndView mav = new ModelAndView("message");
						HttpSession session = req.getSession();
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						
						int num = Integer.parseInt(req.getParameter("num"));
						//tem.out.print("sjdgjs"+num+"냐냐냐냥");
						//알람 디티오를 만들고 -> 알람 넘을 넣어서 -> 해당 알람의 리드를 1로 만들어줌!! 
//						AlarmDTO dto3 = new AlarmDTO();
//						dto3.setAlm_read(1);
						int res = alarmMapper.readAlarm(num);
						
						List<AlarmDTO> list = alarmMapper.boardunReadAlarmList(dto.getMem_num());
						
						mav.addObject("msg", "알람이 확인 되었습니다.");
						mav.addObject("url", "myAlarm.do");
						int count = list.size();
					
						session.setAttribute("alarmCount", count);
						return mav;
					}

				
					
						@RequestMapping("/alarmContent.do") // 알람 상세보기시 이동!!
					public String alarmContent(HttpServletRequest req, HttpSession session) {
						
						MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
						String sort = req.getParameter("sort");
						if (sort.equals("보드게임")){
							req.setAttribute("msg", "보드게임으로 이동합니다 .");
							req.setAttribute("url", "game_list.do");
						}else if (sort.equals("댓글")){
							req.setAttribute("msg","내 게시글 목록으로 이동합니다 .");
							req.setAttribute("url", "myBoard.do");
						}else if (sort.equals("신고")){
							req.setAttribute("msg","공지사항으로 이동합니다 .");
							req.setAttribute("url", "myPage_notice.do");
						}
						

						return "message";
					}
					
						//자주 묻는 질문		
						@RequestMapping("mypage_FAQ.do")
						public ModelAndView mypageFAQ() {
							ModelAndView mav = new ModelAndView("mypage/myPageFAQ");
							String n_mode = "qna";
							List<NoticeDTO> nlist = adminMapper.sortNotice(n_mode);
							mav.addObject("nlist",nlist);
							return mav;
						}
						
						// 공지사항
						@RequestMapping("myPage_notice.do")
						public ModelAndView myPage_notice(HttpServletRequest req, String n_mode) {
							ModelAndView mav = new ModelAndView("mypage/myPage_notice");
							List<NoticeDTO> list = adminMapper.sortNotice(n_mode);
							mav.addObject("noticeList", list);
							return mav;
						}

		}
