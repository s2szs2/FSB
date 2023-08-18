package com.ezen.FSB;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.DontgoDTO;
import com.ezen.FSB.dto.FeedDTO;
import com.ezen.FSB.dto.Feed_themeDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ProfileDTO;
import com.ezen.FSB.dto.ReportDTO;
import com.ezen.FSB.service.AdminMemberMapper;
import com.ezen.FSB.service.FeedMapper;
import com.ezen.FSB.service.LoginMapper;
import com.ezen.FSB.service.MemberMapper;


@Controller
public class Admin_MemberController { // 관리자 - Member Controller

	@Autowired
	AdminMemberMapper adminMemberMapper;

	@Autowired
	FeedMapper feedMapper;

	@Autowired
	LoginMapper loginMapper;
	
	
	@Autowired
	MemberMapper memberMapper;
	
	
	@Autowired
	private JavaMailSender mailSender;

	// 회원 목록
	@RequestMapping("/admin_member_list.do")
	public ModelAndView listMember(HttpServletRequest req, @RequestParam Map<String, String> params) {

		HttpSession session = req.getSession();
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);

		String view = params.get("view");
		List<MemberDTO> listMember = null;

		if (view == null) { // 일반
			if (params.get("mode") == null) { // 전체보기
				listMember = adminMemberMapper.listMember();
			} else { // 일반회원 찾기 (params.get("mode").equals("find"))
				listMember = adminMemberMapper.findMember(params);
			}
			return new ModelAndView("/admin/member_list", "listMember", listMember);
		} else { // 사업자
			if (params.get("mode") == null) { // 전체보기
				listMember = adminMemberMapper.listMemberB();
			} else { // 회원 찾기 (params.get("mode").equals("find"))
				listMember = adminMemberMapper.findMemberB(params);
			}
			return new ModelAndView("/admin/member_b_list", "listMember", listMember);
		}
	}

	// 일반 회원 등록 폼
	@RequestMapping(value = "/admin_member_insert.do", method = RequestMethod.GET)
	public String insertMember() {
		return "admin/member_insert";
	}

	// 비즈니스프로필 회원 등록 폼
	@RequestMapping("/admin_member_b_insert.do")
	public String insertBMember() {
		return "admin/member_b_insert";
	}

	// 회원 등록 처리
	@RequestMapping(value = "/admin_member_insert.do", method = RequestMethod.POST)
	public ModelAndView insertOkMember(HttpServletRequest req, @ModelAttribute MemberDTO dto, BindingResult result) {
		if (result.hasErrors()) {
		}
		// 닉네임 랜덤 생성
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 10;
		Random random = new Random();

		String nickName = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
		dto.setMem_nickname(nickName);

		// insert
		int res = adminMemberMapper.insertMember(dto);

		String view = dto.getMem_mode(); // 일반, 사업자

		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "회원 등록 성공! 회원 목록페이지 이동합니다.");
		} else {
			mav.addObject("msg", "회원 등록 실패! 회원 목록페이지 이동합니다.");
		}
		if (view.equals("일반")) { // 일반
			mav.addObject("url", "admin_member_list.do");
		} else { // 비즈니스
			mav.addObject("url", "admin_member_list.do?view=b");
		}
		return mav;
	}

	// 일반 회원 아이디 중복 검사
	@RequestMapping("/admin_member_dbcheckd.do")
	public ModelAndView checkId(@RequestParam String email) {
		MemberDTO dto = adminMemberMapper.findMember(email);
		int res = 0;
		if (dto == null) {
			res = 0;
		} else {
			res = 1;
		}
		ModelAndView mav = new ModelAndView("admin/member_checkId");
		mav.addObject("result", res);
		mav.addObject("id", email);
		return mav;
	}

	// 회원 상세보기
	@RequestMapping("/admin_member_view.do")
	public ModelAndView getMember(HttpServletRequest req, @RequestParam int mem_num, @RequestParam Map<String, String> params) {

		MemberDTO dto = adminMemberMapper.getMember(mem_num);
		if (dto == null) {
			ModelAndView mav = new ModelAndView("message_back");
			mav.addObject("msg","찾으시는 정보가 없습니다!");
			return mav;
		}
		ModelAndView mav = null;
		if (dto.getMem_mode().equals("사업자")) {
			mav = new ModelAndView("admin/member_b_view");
			BusinessProfileDTO dto2 = adminMemberMapper.getBProfile(mem_num);
			mav.addObject("getBp", dto2);
		} else {
			mav = new ModelAndView("admin/member_view");
		}
		// getMember
		mav.addObject("getMember", dto);
		// getProfile
		ProfileDTO pdto = adminMemberMapper.getProf(mem_num);
		mav.addObject("getProf", pdto);

		HttpSession session = req.getSession();
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);

		// 관리자 로그인 세션 저장
		MemberDTO mdto = adminMemberMapper.findMember("admin@a.a");
		session.setAttribute("login_mem", mdto);

		return mav;
	}

	// 해당 회원의 신고 내역 - 새창
	@RequestMapping("/admin_getmember_report_list.do")
	public ModelAndView getMemberReportList(@RequestParam int mem_num) {
		// 해당 회원의 신고내역
		List<ReportDTO> listReport = adminMemberMapper.getMemberReportList(mem_num);
		return new ModelAndView("admin/board_report_list", "listReport", listReport);
	}

	// 회원 삭제
	@RequestMapping("/admin_member_delete.do")
	public ModelAndView deleteMember(HttpServletRequest req, @RequestParam int mem_num, @RequestParam String view) {

		// 해당 회원의 신고 내역이 있는지 확인
		List<ReportDTO> listReport = adminMemberMapper.getMemberReportList(mem_num);
		if (listReport.size() > 0) {// 있다면, 삭제
			for (ReportDTO rdto : listReport) {
				int res = adminMemberMapper.delReportMember(rdto);
				if (res < 0) {
					//tem.out.println("회원 신고 내역 삭제 실패");
					break;
				}
			}
			//tem.out.println("회원 신고 내역 삭제 성공");
		}

		if (view.equals("b")) { // 사업자 회원인 경우, 비즈니스 프로필 삭제
			int res2 = adminMemberMapper.deleteBp(mem_num);
			if (res2 > 0) {
				//tem.out.println("비즈니스프로필 삭제 성공");
			} else {
				//tem.out.println("비즈니스프로필 삭제 실패");
			}
		}
		// 회원 삭제
		int res = adminMemberMapper.deleteMember(mem_num);

		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "회원 삭제 성공! 회원 목록 페이지로 이동합니다.");
		} else {
			mav.addObject("msg", "회원 삭제 실패! 회원 목록 페이지로 이동합니다.");
		}
		if (view.equals("join")) { // 가입신청내역
			mav.addObject("url", "admin_member_join_list.do");
		} else { // 일반, 사업자 회원 목록
			mav.addObject("url", "admin_member_list.do?view=" + view);
		}
		// joinMember 세션에 다시 저장
		HttpSession session = req.getSession();
		int joinMember = adminMemberMapper.joinListMember().size();
		session.setAttribute("joinMember", joinMember);
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);

		return mav;
	}

	// 회원 수정폼
	@RequestMapping(value = "/admin_member_update.do", method = RequestMethod.GET)
	public ModelAndView updateMember(int mem_num) {
		return new ModelAndView("admin/member_update", "mem_num", mem_num);
	}

	// 일반 회원 수정 처리
	@RequestMapping(value = "/admin_member_update.do", method = RequestMethod.POST)
	public ModelAndView updateOkMember(HttpServletRequest req, @RequestParam Map<String, String> params) {

		int mem_num = Integer.parseInt(params.get("mem_num"));
		Boolean report_check = false;

		int res1, res2, res3, res4 = 0;
		if (params.get("mem_passwd") != null) { // 비밀번호 수정
			res1 = adminMemberMapper.updateMemberPasswd(mem_num);
		} else
			res1 = 1;

		if (params.get("mem_nickname") != null) { // 닉네임 수정
			MemberDTO dto = adminMemberMapper.getMember(mem_num);
			// 닉네임 랜덤 생성
			int leftLimit = 48; // numeral '0'
			int rightLimit = 122; // letter 'z'
			int targetStringLength = 10;
			Random random = new Random();

			String nickName = random.ints(leftLimit, rightLimit + 1)
					.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
					.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
			dto.setMem_nickname(nickName);
			res2 = adminMemberMapper.updateMemberNickname(dto);
			if(res2>0) {
				// 닉네임 프로필 수정
				ProfileDTO pdto = new ProfileDTO();
				pdto.setMem_num(dto.getMem_num());
				// 프로필 삽입
				String nickname = dto.getMem_nickname();
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
				
				int res22 = memberMapper.updateNicknameProfile(pdto);
				if(res22>0) {
					//tem.out.println("닉네임 프로필 수정 성공");
				}else {
					//tem.out.println("닉네임 프로필 수정 실패");			
				}
			}else {
				
			}
		} else
			res2 = 1;

		if (params.get("mem_img") != null) { // 프로필 수정
			res3 = adminMemberMapper.updateMemberImg(mem_num);
		} else
			res3 = 1;

		if (params.get("mem_report") != null) { // 신고횟수 수정
			res4 = adminMemberMapper.updateMemberReport(mem_num);
		} else
			res4 = 1;

//		if(params.get("mem_msg") != null) { // 상태메세지 수정
//			res5 = adminMemberMapper.updateMemberMsg(mem_num);
//		}else res5 = 1;

		ModelAndView mav = new ModelAndView("closeWindow");

		if (res1 > 0 && res2 > 0 && res3 > 0 && res4 > 0) {
			mav.addObject("msg", "회원 수정 성공!");
		} else {
			mav.addObject("msg", "회원 수정 실패!");
		}

		// 해당 회원의 신고 내역 확인
		List<ReportDTO> listReport = adminMemberMapper.getMemberReportList(mem_num);
		if (listReport.size() > 0) {
			if (params.get("mem_msg") != null || params.get("mem_img") != null || params.get("mem_nickname") != null) {
				int rs = adminMemberMapper.checkReportMember(mem_num);
				if (rs > 0) {
					//tem.out.println("회원 신고 내역 처리 여부 반영 성공");
				} else {
					//tem.out.println("회원 신고 내역 처리 여부 반영 실패");
				}
			}
			if (params.get("mem_report") != null) {
				for (ReportDTO rdto : listReport) {
					int rs = adminMemberMapper.delReportMember(rdto);
					if (rs < 0) {
						//tem.out.println(rdto.getReport_num() + "report_num 회원 신고 내역 삭제 실패");
						break;
					}
				}
				//tem.out.println("회원 신고 내역 삭제 성공");
			}
		}
		HttpSession session = req.getSession();
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);
		return mav;
	}

	// 사업자 회원 가입 신청 내역
	@RequestMapping("/admin_member_join_list.do")
	public ModelAndView joinListMember() {
		List<MemberDTO> listMember = adminMemberMapper.joinListMember();
		return new ModelAndView("admin/member_join_list", "listMember", listMember);
	}

	// 사업자 회원 신청 승인
	@RequestMapping("/admin_member_join_ok.do")
	public ModelAndView joinOkMember(HttpServletRequest req, @RequestParam int mem_num) {
		ModelAndView mav = new ModelAndView("message");
		// mem_join 2 ->1 로 변경
		int res = adminMemberMapper.joinOkMember(mem_num);
		if (res > 0) {
			// 비즈니스 프로필 생성
			int res2 = adminMemberMapper.insertBProfile(mem_num);
			if (res2 > 0) {
				mav.addObject("msg", "회원 가입 승인/비즈니스 프로필 생성 성공!");
			} else {
				mav.addObject("msg", "회원 가입 승인 성공! 비즈니스 프로필 생성 실패!");
			}
		} else {
			mav.addObject("msg", "회원 가입 승인 실패!");
		}
		mav.addObject("url", "admin_member_join_list.do");

		// joinMember 세션에 다시 저장
		HttpSession session = req.getSession();
		int joinMember = adminMemberMapper.joinListMember().size();
		session.setAttribute("joinMember", joinMember);

		return mav;
	}

	// 비즈니스프로필 수정폼
	@RequestMapping(value = "/admin_bp_update.do", method = RequestMethod.GET)
	public ModelAndView updateBPForm(@RequestParam int bp_num) {
		ModelAndView mav = new ModelAndView("admin/member_bp_update");
		mav.addObject("bp_num", bp_num);
		return mav;
	}

	// 비즈니스 프로필 수정처리
	@RequestMapping(value = "/admin_bp_update.do", method = RequestMethod.POST)
	public ModelAndView updateOkBP(@RequestParam Map<String, String> params) {

		int bp_num = Integer.parseInt(params.get("bp_num"));

		int res1, res3, res4, res5 = 0;

		if (params.get("bp_info") != null) { // 정보 수정
			res1 = adminMemberMapper.updateBp("info", bp_num);
		} else
			res1 = 1;

//		if(params.get("bp_img") != null) { // 이미지 수정
//			res2 = adminMemberMapper.updateBp("img", bp_num);
//		}else res2 = 1;

		if (params.get("bp_location") != null) { // 주소 및 상세주소 수정
			res3 = adminMemberMapper.updateBp("location", bp_num);
		} else
			res3 = 1;

		if (params.get("bp_store_name") != null) { // 매장명 수정
			res4 = adminMemberMapper.updateBp("store", bp_num);
		} else
			res4 = 1;

		if (params.get("bp_tel") != null) { // 연락처 수정
			res5 = adminMemberMapper.updateBp("tel", bp_num);
		} else
			res5 = 1;

		ModelAndView mav = new ModelAndView("closeWindow");

		if (res1 > 0 && res3 > 0 && res4 > 0 && res5 > 0) {
			mav.addObject("msg", "비즈니스 프로필 수정 성공!");
		} else {
			mav.addObject("msg", "비즈니스 프로필 수정 실패!");
		}
		return mav;
	}

	// 회원 메일 발송 폼
	@RequestMapping(value = "/admin_member_sendEmail.do", method = RequestMethod.GET)
	public ModelAndView sendEmail(@RequestParam int mem_num) {
		ModelAndView mav = new ModelAndView("admin/member_send_email");
		mav.addObject("mem_num", mem_num);
		return mav;
	}

	// 회원 메일 발송
	@RequestMapping(value = "/admin_member_sendEmail.do", method = RequestMethod.POST)
	public ModelAndView sendEmailOk(@RequestParam int mem_num, @RequestParam Map<String, String> params)
			throws IOException {

		ModelAndView mav = new ModelAndView("closeWindow");

		// 메일 전송할 멤버 객체 꺼내기
		MemberDTO vo = adminMemberMapper.getMember(mem_num);
		if (vo != null) { // 꺼낸 객체가 NULL 이 아니라면

			String setfrom = "lucyyyy123123@gmail.com";
			String tomail = vo.getMem_id(); // 받는사람
			//tem.out.println("메일 주소" + tomail);
			String title = params.get("title");
			String content = params.get("content");

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

				messageHelper.setFrom(setfrom);
				messageHelper.setTo(tomail);
				messageHelper.setSubject(title);
				messageHelper.setText(content);

				mailSender.send(message);
			} catch (Exception e) {
				//tem.out.println(e.getMessage());
			}
		}
		mav.addObject("msg", "메일 발송 성공!");

		return mav;
	}

	// 전체 회원 신고 내역
	@RequestMapping("/admin_member_report_list.do")
	public ModelAndView reportListMember(HttpServletRequest req, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("admin/member_report_list");
		List<ReportDTO> listReport = null;
		if (params.get("mode") == null) { // 전체 보기
			listReport = adminMemberMapper.listReportMember("all");
		} else { // 미처리 신고 내역
			listReport = adminMemberMapper.listReportMember("sort");
		}
		mav.addObject("listReport", listReport);
		HttpSession session = req.getSession();
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);
		return mav;
	}

	// 회원 신고 내역 취소/삭제
	@RequestMapping("/admin_report_member_delete.do")
	public ModelAndView reportDelMember(@ModelAttribute ReportDTO dto, BindingResult result) {
		if (result.hasErrors()) {
		}
		int res = adminMemberMapper.delReportMember(dto);
		if(dto == null) {
			return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
		}
		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "신고내역 삭제 성공!");
			// 해당 member 의 mem_report -1 처리
			int mem_num = dto.getReport_target();
			MemberDTO mdto = adminMemberMapper.getMember(mem_num);
			if (mdto.getMem_report() > 0) {
				int res2 = adminMemberMapper.minusReportMember(mem_num);
				if (res2 > 0) {
					//tem.out.println("member_report 차감 성공");
				} else {
					//tem.out.println("member_report 차감 실패");
				}
			}
		} else {
			mav.addObject("msg", "신고내역 삭제 실패!");
		}
		mav.addObject("url", "admin_member_report_list.do");
		return mav;
	}

	// 프로필 수정폼
	@RequestMapping(value = "/admin_member_prof_update.do", method = RequestMethod.GET)
	public ModelAndView updateProf(@RequestParam int mem_num) {
		return new ModelAndView("admin/member_prof_update", "mem_num", mem_num);
	}

	// 프로필 수정 처리
	@RequestMapping(value = "/admin_member_prof_update.do", method = RequestMethod.POST)
	public ModelAndView updateOkProf(@RequestParam Map<String, String> params) {
		int mem_num = Integer.parseInt(params.get("mem_num"));

		int res1, res2 = 0;

		if (params.get("prof_img") != null) { // 프로필 이미지
			res1 = adminMemberMapper.updateProfMember("prof_img", mem_num);
		} else
			res1 = 1;

		if (params.get("prof_msg") != null) { // 프로필 상태메세지
			res2 = adminMemberMapper.updateProfMember("prof_msg", mem_num);
		} else
			res2 = 1;

		ModelAndView mav = new ModelAndView("closeWindow");

		if (res1 > 0 && res2 > 0) {
			mav.addObject("msg", "프로필 수정 성공!");
		} else {
			mav.addObject("msg", "프로필 수정 실패!");
		}
		return mav;
	}

	// 전체 피드 신고 내역
	@RequestMapping("/admin_feed_report_list.do")
	public ModelAndView listFeedReport(@RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("admin/feed_report_list");
		List<ReportDTO> listReport = null;
		if (params.get("mode") == null) { // 전체 신고 내역
			listReport = adminMemberMapper.listFeedReport("all");
		} else { // 미처리 신고내역
			listReport = adminMemberMapper.listFeedReport("sort");
		}
		mav.addObject("listReport", listReport);
		return mav;
	}

	// 피드 상세보기 - ajax
	@ResponseBody
	@RequestMapping(value = "/admin_feed_report_view.do")
	public ModelAndView viewFeedReport(@RequestParam int report_num) {
		

		ReportDTO dto = adminMemberMapper.getReport(report_num);
		if(dto == null) {
			ModelAndView mav = new ModelAndView("message_back");
			mav.addObject("msg","찾으시는 정보가 없습니다!");
			return mav;
		}
		
		ModelAndView mav = new ModelAndView("admin/feed_report_view");
		if (dto.getReport_mode().equals("피드")) { // 피드 상세보기
			FeedDTO fdto = feedMapper.getFeed(dto.getReport_target());
			mav.addObject("feed", fdto);

		} else { // 피드 댓글 상세보기
			int feed_num = adminMemberMapper.getFeedReply(dto.getReport_target());
			FeedDTO fdto = feedMapper.getFeed(feed_num);
			mav.addObject("feed", fdto);
		}
		return mav;
	}

	// 해당 피드 신고 내역
	@RequestMapping("/admin_get_feed_report_list.do")
	public ModelAndView getFeedReport(HttpServletRequest req, @RequestParam String view, @RequestParam int feed_num) {
		HttpSession session = req.getSession();

		// 전체 피드 신고 내역
		int feedReport = adminMemberMapper.listFeedReport("sort").size();
		session.setAttribute("feedReport", feedReport);

		List<ReportDTO> listReport = adminMemberMapper.getFeedReportList(view, feed_num);
		return new ModelAndView("admin/board_report_list", "listReport", listReport);
	}

	// 해당 피드 신고 취소
	@RequestMapping("/admin_feed_report_del.do")
	public ModelAndView feedReportDel(HttpServletRequest req, @RequestParam String view, @RequestParam int feed_num) {
		if(view.equals("피드")) {
			// FeedDTO 에서 feed_report -> 0 으로 수정
			int res2 = adminMemberMapper.feedReportUpdate(feed_num);
			if (res2 > 0) {
				//tem.out.println("피드 report 0으로 수정 성공");
			} else {
				//tem.out.println("피드 report 0으로 수정 실패");
			}
		}else { // 피드 댓글 fr_report -> 0 으로 수정
			int res2 = adminMemberMapper.feedReplyReportUpdate(feed_num); // fr_num
			if (res2 > 0) {
				//tem.out.println("피드댓글 report 0으로 수정 성공");
			} else {
				//tem.out.println("피드댓글 report 0으로 수정 실패");
			}
		}
		
		// ReportDTO 에서 지우기
		int res = adminMemberMapper.feedReportDel(view, feed_num);
		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "신고 취소 성공");
		} else {
			mav.addObject("msg", "신고 취소 실패");
		}
		mav.addObject("url", "admin_feed_report_list.do");
		HttpSession session = req.getSession();

		// 전체 피드 신고 내역
		int feedReport = adminMemberMapper.listFeedReport("sort").size();
		session.setAttribute("feedReport", feedReport);
		return mav;
	}

	// 해당 피드 삭제
	@RequestMapping("/admin_feed_del.do")
	public ModelAndView feedDel(HttpServletRequest req, @RequestParam String view, @RequestParam int feed_num) {
		ModelAndView mav = new ModelAndView("message");
		
		List<ReportDTO> list = adminMemberMapper.getFeedReportList(view, feed_num);
		if (list.size() > 0) { // 해당 피드가 신고 내역이 있고 삭제 하는 경우
			// reportDTO 에서 report_check -> 1로 변경
			int res = adminMemberMapper.feedReportCheckUpdate(view, feed_num);
			if (res > 0) {
				//tem.out.println("신고 여부 반영 성공");
			} else {
				//tem.out.println("신고 여부 반영 실패");
			}
		}
		if(view.equals("피드")) {
			// 해당 피드 삭제
			// 이미지 삭제
			//tem.out.println("피드번호는 " + feed_num);
			FeedDTO dto = feedMapper.getFeed(feed_num);
			if (dto.getFeed_img1() != null) {
				String[] imgs = new String[4];
				imgs[0] = dto.getFeed_img1();
				imgs[1] = dto.getFeed_img2();
				imgs[2] = dto.getFeed_img3();
				imgs[3] = dto.getFeed_img4();
				HttpSession session = req.getSession();
				String upPath = session.getServletContext().getRealPath("/resources/img");

				for (String img : imgs) {
					if (img != null) {
						File file = new File(upPath, img);
						if (file.exists()) {
							file.delete();
							//tem.out.println("이미지 삭제 성공");
						}
					}
				}
			}

			int res2 = feedMapper.deleteFeed(feed_num);
			int res3 = 0;
			List<Feed_themeDTO> listFeed = adminMemberMapper.listGetFeedTheme(feed_num); // 해당 피드가 가지고 있는 태그
			if (listFeed.size() > 0) { // 태그가 있다면 삭제
				res3 = feedMapper.deleteFeedTheme(feed_num);
			} else { // 없다면 패스
				res3 = 1;
			}
			
			if (res2 > 0 && res3 > 0) {
				mav.addObject("msg", "피드삭제/피드테마삭제 성공");
			} else {
				mav.addObject("msg", "삭제 실패");
			}
		}else { // 피드 댓글 삭제
			int res5 = adminMemberMapper.feedReplyDel(feed_num); // fr_num
			if(res5>0) {
				mav.addObject("msg", "피드댓글 삭제 성공");
			}else {
				mav.addObject("msg", "피드댓글 삭제 실패");
			}
		}
		
		mav.addObject("url", "admin_feed_report_list.do");
		HttpSession session = req.getSession();

		// 전체 피드 신고 내역
		int feedReport = adminMemberMapper.listFeedReport("sort").size();
		session.setAttribute("feedReport", feedReport);
		return mav;
	}
	// 탈퇴 내역
	@RequestMapping("/admin_member_by.do")
	public ModelAndView listMemberBye() {
		List<DontgoDTO> listBye = adminMemberMapper.listMemberBye();
		return new ModelAndView("admin/member_bye","listBye", listBye);
	}
}
