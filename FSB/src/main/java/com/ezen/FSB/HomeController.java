package com.ezen.FSB;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.service.AdminBoardMapper;
import com.ezen.FSB.service.AdminMapper;
import com.ezen.FSB.service.AdminMemberMapper;
import com.ezen.FSB.service.AdminShopMapper;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	AdminMapper adminMapper;
	@Autowired
	AdminShopMapper adminShopMapper;
	@Autowired
	AdminBoardMapper adminBoardMapper;
	@Autowired
	AdminMemberMapper adminMemberMapper;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "user/user_main";
	}

	// 사용자 메인
	@RequestMapping("user_main.do")
	public ModelAndView user_main(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("user/user_main");
		
		// ** 로그인 오류
		// 아이디가 틀리고 비밀번호가 맞으면 null 500 오류
		
		return mav;
	}

	// 관리자 메인
	@RequestMapping("admin_main.do")
	public ModelAndView admin_main(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/admin_main");
		HttpSession session = req.getSession();
		// 관리자 로그인 세션 저장
		MemberDTO dto = adminMemberMapper.findMember("admin@a.a");
		session.setAttribute("login_mem", dto);
		
		// 보드게임 한줄평 미처리 신고내역
		int gameReport = adminMapper.homeGameReport();
		session.setAttribute("gameReport", gameReport);
		
		// 쇼핑몰 문의 답변 미처리 내역
		int shopQnA = adminShopMapper.listShopQnACheck().size();
		session.setAttribute("shopQnA", shopQnA);
		
		// 게시판, 댓글 미처리 신고내역
		int boardReport = adminBoardMapper.totalListBoard2().size() + adminBoardMapper.totalListBr2().size();
		session.setAttribute("boardReport", boardReport);
		
		// 쇼핑몰 주문 요청 내역
		int shopOrder = adminShopMapper.shopOrderList1().size();
		session.setAttribute("shopOrder", shopOrder);
		
		// 사업자회원 가입 신청 내역
		int joinMember = adminMemberMapper.joinListMember().size();
		session.setAttribute("joinMember", joinMember);
		
		// 재고 5개 미만
		int inventory = adminShopMapper.checkInventory();
		session.setAttribute("inventory", inventory);
		
		// 전체 회원 신고 내역
		int memReport = adminMemberMapper.listReportMember("sort").size();
		session.setAttribute("memReport", memReport);
		
//		// 쇼핑몰 환불 요청 내역
//				int shopRefund = adminShopMapper.shopRefundList1().size();
//				session.setAttribute("shopRefund", shopRefund);
		
		// 전체 피드 신고 내역
		int feedReport = adminMemberMapper.listFeedReport("sort").size();
		session.setAttribute("feedReport", feedReport);
		
		return mav;
	}
	
}

