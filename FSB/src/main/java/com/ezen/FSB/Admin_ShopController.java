package com.ezen.FSB;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.PointHistoryDTO;
import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopOrderDTO;
import com.ezen.FSB.dto.ShopOrderDetailDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopRefundDTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;
import com.ezen.FSB.service.AdminMapper;
import com.ezen.FSB.service.AdminMemberMapper;
import com.ezen.FSB.service.AdminShopMapper;
import com.ezen.FSB.service.ShopMapper;

@Controller
public class Admin_ShopController { // 관리자 - Shop Controller

	@Autowired
	AdminShopMapper adminShopMapper;
	
	@Autowired
	AdminMemberMapper adminMemberMapper;
	
	@Autowired
	ShopMapper shopMapper;

	// 상품 목록
	@RequestMapping("/admin_prod_list.do")
	public ModelAndView listProduct(HttpServletRequest req, @RequestParam Map<String, String> params) {

		HttpSession session = req.getSession();
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		session.setAttribute("df", df);

		String mode = params.get("mode");
		String sort = params.get("sort");

		List<ShopProductDTO> listProd = null;

		if (mode.equals("all")) { // 전체보기
			if (sort.equals("all")) { // 기본 정렬
				listProd = adminShopMapper.listProd();
			} else {
				listProd = adminShopMapper.sortProd(sort);
			}
		} else { // 찾기
			String search = params.get("search");
			String searchString = params.get("searchString");
			if (search.equals("game_name")) { // 상품 이름
				listProd = adminShopMapper.findProdGameName(searchString);
			} else if (search.equals("prod_company")) { // 판매사
				listProd = adminShopMapper.findProdCompany(searchString);
			}
		}
		return new ModelAndView("admin/prod_list", "listProd", listProd);
	}

	// 상품 상세보기
	@RequestMapping("/admin_prod_view.do")
	public ModelAndView getProduct(@RequestParam int prod_num) {
		ModelAndView mav = new ModelAndView("admin/prod_view");

		// 상품 DTO
		ShopProductDTO pdto = adminShopMapper.getProd(prod_num);
		if(pdto == null) {
			return new ModelAndView("message_back","msg","찾으시는 정보가 없습니다!");
		}
		// 상품의 리뷰 개수
		int count = adminShopMapper.getProdReviewCount(prod_num);
		if (count > 0) {
			// 상품의 리뷰 별점 총합
			int sum = adminShopMapper.getProdStar(prod_num);
			// 별점 평균
			double starrating = (double) (sum * 1.0) / count;
			starrating = Math.round(starrating * 100) / 100.0;
			mav.addObject("starrating", starrating);
		}
		mav.addObject("reviewCount", count);
		// 리뷰 DTO
		List<ShopReviewDTO> listReview = adminShopMapper.listProdReview(prod_num);

		mav.addObject("getProd", pdto);
		mav.addObject("listReview", listReview);

		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);
		// 상품 좋아요 수
		int prodLike = adminShopMapper.getProdLike(prod_num);
		mav.addObject("prodLike", prodLike);
		return mav;
	}

	// 상품 리뷰 이미지 상세보기
	@RequestMapping("/admin_prod_view_img.do")
	public ModelAndView getProdReviewImg(@RequestParam int sr_num) {
		ShopReviewDTO dto = adminShopMapper.getProdReviewImg(sr_num);
		ModelAndView mav = new ModelAndView("admin/img_view");

		mav.addObject("img1", dto.getSr_img1());
		if (dto.getSr_img2() == null) {
		} else {
			mav.addObject("img2", dto.getSr_img2());
		}
		if (dto.getSr_img3() == null) {
		} else {
			mav.addObject("img3", dto.getSr_img3());
		}
		if (dto.getSr_img4() == null) {
		} else {
			mav.addObject("img4", dto.getSr_img4());
		}
		return mav;
	}

	// 상품 등록폼
	@RequestMapping(value = "/admin_prod_insert.do", method = RequestMethod.GET)
	public ModelAndView insertProduct() {
		List<GameDTO> listNotProdGame = adminShopMapper.listNotProdGame();
		return new ModelAndView("admin/prod_insert", "listNotProdGame", listNotProdGame);
	}

	// 상품 등록 처리
	@RequestMapping(value = "/admin_prod_insert.do", method = RequestMethod.POST)
	public ModelAndView insertOkProduct(HttpServletRequest req, @ModelAttribute ShopProductDTO dto,
			BindingResult result) {
		if (result.hasErrors()) {
			dto.setProd_img("0"); // 초기 상품 상세 이미지 세팅
		}
		// 파일 업로드
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("prod_img");
		String prod_img = mf.getOriginalFilename();

		// 파일명 중복 방지
		UUID uuid = UUID.randomUUID();
		prod_img = uuid.toString() + "_" + prod_img;

		// 파일 객체 생성, 업로드
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		//tem.out.println(upPath);
		File file = new File(upPath, prod_img);
		try {
			mf.transferTo(file);
		} catch (IOException e) {
			e.printStackTrace();
			//tem.out.println("file 업로드 오류 발생");
		}
		// 파일 이름 dto 세팅
		dto.setProd_img(prod_img);

		// point 가격의 0.1 로 고정
		int su = (int) (dto.getProd_price() * 0.1);
		dto.setProd_point(su);
		// insert
		int res = adminShopMapper.insertProd(dto);

		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "상품 등록 성공! 파일 업로드 성공! 상품 목록 페이지로 이동합니다.");
			mav.addObject("url", "admin_prod_list.do?mode=all&sort=all");
		} else {
			mav.addObject("msg", "상품 등록 실패! 파일 업로드 성공! 상품 등록 페이지로 이동합니다.");
			mav.addObject("url", "admin_prod_insert.do");
		}
		return mav;
	}

	// 상품 수정폼
	@RequestMapping(value = "/admin_prod_update.do", method = RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam int prod_num) {
		ShopProductDTO dto = adminShopMapper.getProd(prod_num);
		ModelAndView mav = new ModelAndView("admin/prod_update");
		mav.addObject("getProd", dto);
		// 상품의 리뷰 개수
		int count = adminShopMapper.getProdReviewCount(prod_num);
		if (count > 0) {
			// 상품의 리뷰 별점 총합
			int sum = adminShopMapper.getProdStar(prod_num);
			// 별점 평균
			double starrating = (double) (sum * 1.0) / count;
			starrating = Math.round(starrating * 100) / 100.0;
			mav.addObject("starrating", starrating);
		}
		return mav;
	}

	// 상품 수정 처리
	@RequestMapping(value = "/admin_prod_update.do", method = RequestMethod.POST)
	public ModelAndView updateOkProduct(HttpServletRequest req, @RequestParam Map<String, String> params,
			@ModelAttribute ShopProductDTO dto, BindingResult result) {
		if (result.hasErrors()) { // 초기 이미지 세팅
			dto.setProd_img("0");
		}
		// 파일 업로드
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("prod_img");
		String prod_img = mf.getOriginalFilename();

		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");

		// 파일명 중복 방지
		UUID uuid = UUID.randomUUID();
		prod_img = uuid.toString() + "_" + prod_img;

		if (!mf.isEmpty()) { // 이미지 수정 하는 경우
			// 파일 객체 생성, 업로드
			File file = new File(upPath, prod_img);
			try {
				mf.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
				//tem.out.println("file 수정중 오류 발생");
			}
			// 파일 이름 dto 세팅
			dto.setProd_img(prod_img);
			// 이전 파일 지우기
			File file01 = new File(upPath, params.get("prod_img2"));
			if (file01.exists()) { // 파일이 존재하면
				file01.delete();
			}
		} else { // 이미지 수정 하지 않는 경우
			// 파일 이름만 dto 세팅
			dto.setProd_img(params.get("prod_img2"));
		}

		int res = adminShopMapper.updateProd(dto);
		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "상품 수정 성공! 상품 상세보기 페이지로 이동합니다.");
			mav.addObject("url", "admin_prod_view.do?prod_num=" + dto.getProd_num());
		} else {
			mav.addObject("msg", "상품 수정 실패! 상품 수정 페이지로 이동합니다.");
			mav.addObject("url", "admin_prod_update.do?prod_num=" + dto.getProd_num());
		}
		return mav;
	}

	// 상품 삭제
	@RequestMapping("/admin_prod_delete.do")
	public ModelAndView deleteProduct(HttpServletRequest req, @RequestParam Map<String, String> params) {

		// 상품 삭제
		int res = adminShopMapper.deleteProd(Integer.parseInt(params.get("prod_num")));

		ModelAndView mav = new ModelAndView("message");

		if (res > 0) {
			HttpSession session = req.getSession();
			String upPath = session.getServletContext().getRealPath("/resources/img");

			// 파일 삭제
			File file = new File(upPath, params.get("prod_img"));
			if (file.exists()) { // 파일이 존재하면
				file.delete();
				mav.addObject("msg", "상품 삭제/파일 삭제/리뷰 삭제 성공! 상품 목록 페이지로 이동합니다.");
			} else { // 파일이 없는 경우
				mav.addObject("msg", "상품 삭제/리뷰 삭제 성공! 파일 삭제 실패! 상품 목록 페이지로 이동합니다.");
			}
		} else {
			mav.addObject("msg", "상품 삭제 실패! 상품 목록 페이지로 이동합니다.");
		}
		mav.addObject("url", "admin_prod_list.do?mode=all&sort=all");
		return mav;
	}

	// 쿠폰 목록
	@RequestMapping("/admin_scoupon_list.do")
	public ModelAndView listScoupon(@RequestParam int sc_num) {
		
		// 만료일  하루 지난 쿠폰 삭제 (만료일 지나는 동시에, user_coupon 은 삭제 되므로, 삭제 가능
		int res = adminShopMapper.deleteScouponDuedate();
		if(res>0) {
			//tem.out.println("만료일 지난 쿠폰 삭제 성공");
		}else {
			//tem.out.println("만료일 지난 쿠폰 삭제 실패");
		}
		
		ModelAndView mav = new ModelAndView("admin/scoupon_list");
		
		if(sc_num != 0) { // 기본 쿠폰 목록 + 소유한 회원 목록
			List<ShopUserCouponDTO> listUsc = adminShopMapper.listUsc(sc_num);
			mav.addObject("listUsc", listUsc);
		}
		
		// 쿠폰 목록
		List<ShopCouponDTO> listScoupon = adminShopMapper.listScoupon();
		//만료일 쿠폰 리스트
		List<ShopCouponDTO> sortScoupon = adminShopMapper.sortScoupon();
		for(ShopCouponDTO sdto : sortScoupon) {
			for(ShopCouponDTO ldto : listScoupon) {
				if(sdto.getSc_num() == ldto.getSc_num()) {
					// 만료일 다가온 쿠폰은 1로 체크 (7일전까지)
					ldto.setSc_check(1);
				}
			}
		}
		mav.addObject("listScoupon", listScoupon);
		// , 형식
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);
		return mav;
	}

	// 쿠폰 등록 폼
	@RequestMapping(value = "/admin_scoupon_insert.do", method = RequestMethod.GET)
	public ModelAndView insertScoupon() {
		// 쿠폰 등록 만료일은 최소 오늘 날짜 (오늘 날짜 구하기)
		LocalDate now = LocalDate.now();
		return new ModelAndView("admin/scoupon_insert", "now", now);
	}

	// 쿠폰 등록 처리
	@RequestMapping(value = "/admin_scoupon_insert.do", method = RequestMethod.POST)
	public ModelAndView insertOkScoupon(@ModelAttribute ShopCouponDTO dto, BindingResult result,
			@RequestParam Map<String, String> params) {
		if (result.hasErrors()) {
		}

		if (!dto.getSc_type().equals("%")) { // 쿠폰 타입이 할인이 아닌 경우,
			// 최대 할인 금액 (sc_limit -> 0원으로 설정)
			dto.setSc_limit(0);
		}

		int res;
		// 만료일 지정하지 않음을 선택한 경우
		if (params.get("sc_duedate2") != null) {
			res = adminShopMapper.insertScoupon2(dto);
		} else { // 만료일을 지정하는 경우
			String date = dto.getSc_duedate().substring(2);
			date = date.replace('-', '/');
			//tem.out.println(date);
			dto.setSc_duedate(date);
			res = adminShopMapper.insertScoupon1(dto);
		}

		ModelAndView mav = new ModelAndView("message");

		if (res > 0) {
			mav.addObject("msg", "쿠폰 등록 성공! 쿠폰 목록 페이지로 이동합니다.");
			mav.addObject("url", "admin_scoupon_list.do?sc_num=0");
		} else {
			mav.addObject("msg", "쿠폰 등록 실패! 쿠폰 등록 페이지로 이동합니다.");
			mav.addObject("url", "admin_scoupon_insert.do");
		}

		return mav;
	}

	// 쿠폰 삭제
	@RequestMapping("/admin_scoupon_delete.do")
	public ModelAndView deleteScoupon(@RequestParam int sc_num) {

		ModelAndView mav = new ModelAndView("message");

		List<ShopUserCouponDTO> listUsc = adminShopMapper.listUsc(sc_num);
		if (listUsc.size() > 0) { // sc_num 쿠폰을 가지고 있는 사용자가 있다. 삭제 불가
			mav.addObject("msg", "쿠폰을 소유한 회원이 있어, 삭제 불가! 쿠폰 목록 페이지로 이동합니다.");
		} else { // sc_num 쿠폰을 가지고 있는 사용자가 없다. 삭제 가능
			int res = adminShopMapper.deleteScoupon(sc_num);
			if (res > 0) {
				mav.addObject("msg", "쿠폰 삭제 성공! 쿠폰 목록 페이지로 이동합니다.");
			} else {
				mav.addObject("msg", "쿠폰 삭제 실패! 쿠폰 목록 페이지로 이동합니다.");
			}
		}
		mav.addObject("url", "admin_scoupon_list.do?sc_num=0");
		return mav;
	}

	// 문의 내역
	@RequestMapping("/admin_shop_qna_list.do")
	public ModelAndView listShopQna(@RequestParam String mode) {
		List<ShopQnADTO> list = null;
		if (mode.equals("all")) { // 문의 내역 전체 보기
			list = adminShopMapper.listShopQnA();
		} else { // 미처리 내역 보기
			list = adminShopMapper.listShopQnACheck();
		}
		return new ModelAndView("admin/shop_qna_list", "listShopQna", list);
	}

	// 문의 내역 자세히 보기 // ajax
	@ResponseBody
	@RequestMapping(value = "/admin_shop_qna_view.do")
	public ModelAndView ViewShopQna(@RequestParam int sq_num) {
		ModelAndView mav = new ModelAndView("admin/shop_qna_view");
		ShopQnADTO dto = adminShopMapper.getShopQnA(sq_num);
		mav.addObject("getShopQna", dto);
		return mav;
	}

	// 문의 답변 insert, update
	@RequestMapping(value = "/admin_shop_qna_reply.do")
	public ModelAndView insertShopReply(HttpServletRequest req, @RequestParam Map<Object, Object> params) {
		ModelAndView mav = new ModelAndView("message");
		String sq_num = (String) params.get("sq_num");

		ShopQnADTO dto = adminShopMapper.getShopQnA(Integer.parseInt(sq_num));
		String reply_mode = (String) params.get("reply_mode");
		String sq_reply = (String) params.get("sq_reply");
		dto.setSq_reply(sq_reply);

		int res = adminShopMapper.shopQnaReply(dto);

		Map<String, Integer> map = new HashMap<>();
		map.put("check", 1);
		map.put("sq_num", Integer.parseInt(sq_num));

		if (res > 0) {
			int res2 = adminShopMapper.shopQnaReplyCheck(map);
			if (res2 > 0) {
				if (reply_mode.equals("insert")) { // 등록
					mav.addObject("msg", "답변 등록 성공!");
				} else { // 수정
					mav.addObject("msg", "답변 수정 성공!");
				}
			} else {
				if (reply_mode.equals("insert")) { // 등록
					mav.addObject("msg", "답변 등록 성공! 체크여부 수정 실패!");
				} else { // 수정
					mav.addObject("msg", "답변 수정 성공! 체크여부 수정 실패!");
				}
			}
		} else {
			if (reply_mode.equals("insert")) { // 등록
				mav.addObject("msg", "답변 등록 실패!");
			} else { // 수정
				mav.addObject("msg", "답변 수정 실패!");
			}
		}
		mav.addObject("url", "admin_shop_qna_list.do?mode=all");

		// 쇼핑몰 문의 답변 미처리 내역
		HttpSession session = req.getSession();
		int shopQnA = adminShopMapper.listShopQnACheck().size();
		session.setAttribute("shopQnA", shopQnA);

		return mav;
	}

	// 문의 답변 삭제
	@RequestMapping("/admin_shop_qna_reply_del.do")
	public ModelAndView deleteShopReply(HttpServletRequest req, @RequestParam int sq_num) {
		ModelAndView mav = new ModelAndView("message");
		// 문의 답변 NULL 로 수정
		int res = adminShopMapper.shopQnaReplyDel(sq_num);

		Map<String, Integer> map = new HashMap<>();
		map.put("check", 0);
		map.put("sq_num", sq_num);

		if (res > 0) {
			int res2 = adminShopMapper.shopQnaReplyCheck(map);
			if (res2 > 0) {
				mav.addObject("msg", "답변 삭제 성공!");
			} else {
				mav.addObject("msg", "답변 삭제 성공! 처리여부 수정 실패!");
			}
		} else {
			mav.addObject("msg", "답변 삭제 실패!");
		}
		mav.addObject("url", "admin_shop_qna_list.do?mode=all");

		// 쇼핑몰 문의 답변 미처리 내역
		HttpSession session = req.getSession();
		int shopQnA = adminShopMapper.listShopQnACheck().size();
		session.setAttribute("shopQnA", shopQnA);

		return mav;
	}

	// 전체 상품 리뷰 목록
	@RequestMapping("/admin_shop_total_review.do")
	public ModelAndView totalShopReview(@RequestParam String sort) {
		ModelAndView mav = new ModelAndView("admin/shop_total_review_list");

		List<ShopReviewDTO> listShopReview = null;
		if (sort.equals("all")) { // 기본 정렬
			listShopReview = adminShopMapper.totalShopReview();
		} else if (sort.equals("starrating_desc")) { // 별점 높은 순
			listShopReview = adminShopMapper.totalShopReview3();
		} else { // 별점 낮은 순
			listShopReview = adminShopMapper.totalShopReview2();
		}
		mav.addObject("listShopReview", listShopReview);
		return mav;
	}

	// 전체 상품 리뷰 목록 - 상세보기 // ajax
	@ResponseBody
	@RequestMapping(value = "/admin_total_shop_review_view.do")
	public ModelAndView totalShopReview_view(@RequestParam int sr_num) {
		ModelAndView mav = new ModelAndView("admin/shop_total_review_view");
		ShopReviewDTO dto = adminShopMapper.totalGetShopReview(sr_num);
		mav.addObject("getReview", dto);
		return mav;
	}

	// 주문 내역
	@RequestMapping("admin_shop_order_list.do")
	public ModelAndView shopOrderList(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/shop_order_list");

		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);

		List<ShopOrderDTO> list0 = adminShopMapper.shopOrderList0();
		List<ShopOrderDTO> list1 = adminShopMapper.shopOrderList1();
		List<ShopOrderDTO> list2 = adminShopMapper.shopOrderList2();
		List<ShopOrderDTO> list3 = adminShopMapper.shopOrderList3();
		List<ShopOrderDTO> list4 = adminShopMapper.shopOrderList4();
		mav.addObject("list0", list0);
		mav.addObject("count0", list0.size());
		mav.addObject("list1", list1);
		mav.addObject("count1", list1.size());
		mav.addObject("list2", list2);
		mav.addObject("count2", list2.size());
		mav.addObject("list3", list3);
		mav.addObject("count3", list3.size());
		mav.addObject("list4", list4);
		mav.addObject("count4", list4.size());

		HttpSession session = req.getSession();
		// 쇼핑몰 주문 요청 내역
		int shopOrder = adminShopMapper.shopOrderList1().size();
		session.setAttribute("shopOrder", shopOrder);

		return mav;
	}

	// 주문내역 상세보기 - ajax
	@ResponseBody
	@RequestMapping(value = "/admin_shop_order_view.do")
	public ModelAndView shopOrderView(@RequestParam int order_num) {
		ModelAndView mav = new ModelAndView("admin/shop_order_view");
		ShopOrderDTO dto = adminShopMapper.getShopOrder(order_num);
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);
		// 배송지 전화번호 나누기
		
		dto.setOrder_hp1(dto.getOrder_hp().substring(0,3));
		dto.setOrder_hp2(dto.getOrder_hp().substring(3,7));
		dto.setOrder_hp3(dto.getOrder_hp().substring(7,11));
		// Order 담기
		mav.addObject("getOrder", dto);

		// 주문 상세내역
		List<ShopOrderDetailDTO> listOrder = adminShopMapper.listOrderDetail(order_num);
		mav.addObject("listOrder", listOrder);

		return mav;
	}

	// 주문내역 수정
	@RequestMapping("/admin_shop_order_update.do")
	public ModelAndView shopOrderUpdate(@ModelAttribute ShopOrderDTO dto, BindingResult result) {
		if (result.hasErrors()) {
		}
		int res = adminShopMapper.updateShopOrder(dto);
		ModelAndView mav = new ModelAndView("message");
		if (res > 0) {
			mav.addObject("msg", "주문내역 수정 성공!");
			mav.addObject("url", "admin_shop_order_list.do");
		} else {
			mav.addObject("msg", "주문내역 수정 실패!");
			mav.addObject("url", "admin_shop_order_list.do");
		}
		return mav;
	}

	// 배송조회
	@RequestMapping("/admin_shop_invoice_check.do")
	public String invoiceCheck() {
		return "admin/shop_invoice_check";
	}

	// 매출 내역
	@RequestMapping("/admin_shop_sales_list.do")
	public ModelAndView listSales() {
		ModelAndView mav = new ModelAndView("admin/shop_sales_list");

		// 그래프 데이터
		for (int i = 1; i < 13; ++i) {
			int sum = adminShopMapper.sumSales(i);
			sum = sum / 10000;
			//tem.out.println(sum);
			mav.addObject("sum" + i, sum);
		}
		// 매출 순위
		List<Map<String, Object>> rankOrder = adminShopMapper.rankSales();

		// 상품 리스트 ( 매출 순위로 담기)
		List<ShopProductDTO> listProd = new ArrayList<>();
		for (int i = 0; i < rankOrder.size(); ++i) {
			// map 에 담아온 데이터 하나씩 꺼내기
			Map map = rankOrder.get(i);
			String imsi = map.toString().replace("{", "").replace("}", "");
			//tem.out.println("map 데이터 : " + imsi);
			// split
			String str[] = imsi.trim().split(",");
			// 판매 수량
			str[0] = str[0].substring(16);
			//tem.out.println("판매 수량 " + str[0]);
			int detail_qty = Integer.parseInt(str[0]);
			// 상품 번호
			str[1] = str[1].substring(10);
			//tem.out.println("상품 번호 " + str[1]);
			int prod_num = Integer.parseInt(str[1]);

			// 해당 상품 꺼내서 담기
			ShopProductDTO dto2 = adminShopMapper.getProd(prod_num);
			dto2.setDetail_qty(detail_qty); // 총 판매수량으로 세팅
			listProd.add(dto2);
		}

		mav.addObject("listRank", listProd);
		mav.addObject("count", listProd.size());

		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);

		return mav;
	}
	// 재고 관리 목록
	@RequestMapping("/admin_shop_inventory_list.do")
	public ModelAndView listInventory(HttpServletRequest req, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("admin/shop_inventory_list");
		
		// 재고량 5개 미만 상품 수
		HttpSession session = req.getSession();
		int inventory = adminShopMapper.checkInventory();
		session.setAttribute("inventory", inventory);
		mav.addObject("count", inventory);
		// 상품 목록
		List<ShopProductDTO> listProd = null;
		if(params.get("mode") == null) { // 전체 보기
			listProd = adminShopMapper.listInventory();
		}else { // 찾기 (find)
			listProd = adminShopMapper.findProdGameName(params.get("searchString"));
		}
		mav.addObject("listProd", listProd);
		return mav;
	}
	// 재고관리 등록 - ajax
	@ResponseBody
	@RequestMapping(value="/admin_shop_inventory_insert.do", method=RequestMethod.GET)
	public ModelAndView insertInventory() {
		List<ShopProductDTO> listProd = adminShopMapper.listProd();
		return new ModelAndView("admin/shop_inventory_insert", "listProd" , listProd);
	}
	// 재고관리 수정 - ajax
	@ResponseBody
	@RequestMapping(value="/admin_shop_inventory_update.do", method=RequestMethod.GET)
	public ModelAndView updateInventory(@RequestParam int prod_num) {
		ShopProductDTO dto = adminShopMapper.getProd(prod_num);
		return new ModelAndView("admin/shop_inventory_update", "getProd", dto);
	}
	// 재고관리 등록 처리
	@RequestMapping(value="/admin_shop_inventory_insert.do", method=RequestMethod.POST)
	public ModelAndView insertOkInventory(@RequestParam Map<Object, Object> params) {
		
		ModelAndView mav = new ModelAndView("message");
		mav.addObject("url","admin_shop_inventory_list.do");

		// 1~5번
		for(int i=1; i<6; ++i) {
			if(!params.get("prod_num"+i).equals("")) {
				int prod_num = Integer.parseInt((String)params.get("prod_num"+i));
				int prod_qty = Integer.parseInt((String)params.get("prod_qty"+i));
				ShopProductDTO dto = new ShopProductDTO();
				dto.setProd_num(prod_num);
				dto.setProd_qty(prod_qty);
				int res = adminShopMapper.insertInventory(dto);
				if(res<0) {
					mav.addObject("msg", i+"번 재고 등록중 오류 발생!");
					return mav;
				}
			}	
		}
		mav.addObject("msg","재고 등록 성공!");
		return mav;
	}
	// 재고 관리 수정 처리
	@RequestMapping(value="/admin_shop_inventory_update.do", method=RequestMethod.POST)
	public ModelAndView updateOkInventory(@RequestParam int prod_num, @RequestParam int prod_qty) {
		ShopProductDTO dto = new ShopProductDTO();
		dto.setProd_num(prod_num);
		dto.setProd_qty(prod_qty);
		int res = adminShopMapper.updateInventory(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg","재고 수정 성공!");
		}else {
			mav.addObject("msg","재고 수정 실패!");			
		}
		mav.addObject("url","admin_shop_inventory_list.do");
		return mav;
	}
//	// 환불 내역
//	@RequestMapping(value="/admin_shop_refund_list.do")
//	public ModelAndView listRefund(HttpServletRequest req) {
//		ModelAndView mav = new ModelAndView("admin/shop_refund_list");
//		
//		for(int i=1; i<5; ++i) {
//			List<ShopOrderDTO> listRefund = adminShopMapper.shopRefundList1();
//			mav.addObject("listRefund"+i, listRefund);
//			mav.addObject("count"+i, listRefund.size());
//		}
//		HttpSession session = req.getSession();
//
//		// 쇼핑몰 환불 요청 내역
//		int shopRefund = adminShopMapper.shopRefundList1().size();
//		session.setAttribute("shopRefund", shopRefund);
//		
//		return mav;
//	}
//	// 환불 내역 - 상세보기 ajax
//	@ResponseBody
//	@RequestMapping(value="/admin_shop_refund_view.do", method=RequestMethod.GET)
//	public ModelAndView viewRefund(@RequestParam int refund_num) {
//		ModelAndView mav = new ModelAndView("admin/shop_refund_view");
//		// 환불 내역 상세보기
//		ShopRefundDTO rdto = adminShopMapper.getRefund(refund_num);
//		mav.addObject("getRefund", rdto);
//		// 해당 환불내역의 주문 내역 보기
//		ShopOrderDTO odto = adminShopMapper.getShopOrder(rdto.getOrder_num());
//		mav.addObject("getOrder", odto);
//		// 해당 주문의 상세내역
//		List<ShopOrderDetailDTO> listOrder = adminShopMapper.listOrderDetail(rdto.getOrder_num());
//		mav.addObject("listOrder", listOrder);
//		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
//		mav.addObject("df", df);
//		return mav;
//	}
//	// 환불 내역 수정
//	@RequestMapping("/admin_shop_refund_update.do")
//	public ModelAndView updateOkRefund(HttpServletRequest req, @ModelAttribute ShopRefundDTO dto, BindingResult result) {
//		if(result.hasErrors()) {}
//		
//		ModelAndView mav = new ModelAndView("message");
//		// 환불 처리 단계 수정
//		int res = adminShopMapper.updateRefund(dto);
//		if(res>0) {
//			mav.addObject("msg", "환불 처리단계 수정 성공");
//		}else {
//			mav.addObject("msg", "환불 처리단계 수정 실패");			
//		}
//		mav.addObject("url","admin_shop_refund_list.do");
//		
//		HttpSession session = req.getSession();
//
//		// 쇼핑몰 환불 요청 내역
//				int shopRefund = adminShopMapper.shopRefundList1().size();
//				session.setAttribute("shopRefund", shopRefund);
//		
//		return mav;
//	}
	// 주문 찾기
	@RequestMapping(value="/admin_shop_order_find.do", method=RequestMethod.POST)
	public ModelAndView findOrder(HttpServletRequest req, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("admin/shop_order_list");
		//tem.out.println("찾으러 옴?");
		List<ShopOrderDTO> findOrder = adminShopMapper.findOrder(params.get("search"), params.get("searchString"));
		mav.addObject("findOrder", findOrder);
		// 일반 주문내역
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		mav.addObject("df", df);

//		List<ShopOrderDTO> list0 = adminShopMapper.shopOrderList0();
		List<ShopOrderDTO> list1 = adminShopMapper.shopOrderList1();
		List<ShopOrderDTO> list2 = adminShopMapper.shopOrderList2();
		List<ShopOrderDTO> list3 = adminShopMapper.shopOrderList3();
		List<ShopOrderDTO> list4 = adminShopMapper.shopOrderList4();
//		mav.addObject("list0", list0);
//		mav.addObject("count0", list0.size());
		mav.addObject("list1", list1);
		mav.addObject("count1", list1.size());
		mav.addObject("list2", list2);
		mav.addObject("count2", list2.size());
		mav.addObject("list3", list3);
		mav.addObject("count3", list3.size());
		mav.addObject("list4", list4);
		mav.addObject("count4", list4.size());

		HttpSession session = req.getSession();
		// 쇼핑몰 주문 요청 내역
		int shopOrder = adminShopMapper.shopOrderList1().size();
		session.setAttribute("shopOrder", shopOrder);
		return mav;
	}
//	// 환불 내역 찾기
//	@RequestMapping("/admin_shop_refund_find.do")
//	public ModelAndView findRefund(HttpServletRequest req, @RequestParam Map<String, String> params) {
//		
//		ModelAndView mav = new ModelAndView("admin/shop_refund_list");
//		
//		// 환불내역 찾기
//		List<ShopRefundDTO> findRefund = adminShopMapper.findRefund(params.get("search"), params.get("searchString"));
//		mav.addObject("findRefund", findRefund);
//		// 전체 환불 내역
//		for(int i=1; i<5; ++i) {
//			List<ShopRefundDTO> listRefund = adminShopMapper.listRefund(i);
//			mav.addObject("listRefund"+i, listRefund);
//			mav.addObject("count"+i, listRefund.size());
//		}
//		HttpSession session = req.getSession();
//
//		// 쇼핑몰 환불 요청 내역
//				int shopRefund = adminShopMapper.shopRefundList1().size();
//				session.setAttribute("shopRefund", shopRefund);
//		
//		return mav;
//	}
	// 환불 승인
	@RequestMapping("/admin_shop_refund_ok.do")
	public ModelAndView refundOk(@RequestParam int order_num, @RequestParam int mem_num) {
		
		ModelAndView mav = new ModelAndView("message");
		ShopOrderDTO odto = adminShopMapper.getShopOrder(order_num);
		
		ShopPointHistoryDTO dto = new ShopPointHistoryDTO();
		dto.setMem_num(mem_num);
		// 환불금 포인트 적립
		dto.setPoint_type("+");
		dto.setPoint_content("환불 적립");
		dto.setPoint_amount(odto.getOrder_receiptprice());
		dto.setPoint_total(odto.getOrder_receiptprice() + shopMapper.userPointTotal(mem_num));
		shopMapper.pointOrder(dto);
		// 상품 개수 조정
		List<ShopOrderDetailDTO> odList = shopMapper.getRefundOrder(order_num);
		for (ShopOrderDetailDTO oddto : odList) {
			int prod_num = oddto.getProd_num();
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			pdto.setProd_qty(pdto.getProd_qty() + oddto.getDetail_qty());
			shopMapper.updateProd(pdto);
		}
		int res = adminShopMapper.refundOk(order_num);
		if(res>0) {
			mav.addObject("msg","환불 처리 성공");
		}else {
			mav.addObject("msg","환불 처리 실패");
		}
		mav.addObject("url","admin_shop_order_list.do");
		return mav;
	}
}
