package com.ezen.FSB;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ShopCartDTO;
import com.ezen.FSB.dto.ShopLikeDTO;
import com.ezen.FSB.dto.ShopOrderDTO;
import com.ezen.FSB.dto.ShopOrderDetailDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;
import com.ezen.FSB.service.ShopMapper;
import com.ezen.FSB.service.ShopMyPageMapper;

@Controller
public class ShopMyPageController {
	@Autowired
	public ShopMyPageMapper shopMyPageMapper;
	
	@Autowired
	public ShopMapper shopMapper;
	
	// 유저 마이페이지로 이동
	@RequestMapping("user_shop_myPage.do")
	public ModelAndView userShopMyPage(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/myPage_main");
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		mav.addObject("mem_num", mem_num);
		
		// 회원의 전체 주문 목록과 주문 개수
		List<ShopOrderDTO> olist = shopMapper.listOrder(mem_num);
		for(int i = 0; i < olist.size(); i++) {
				ShopOrderDTO odto = olist.get(i);
				// 회원의 주문 목록에 대한 주문상품상세
				List<ShopOrderDetailDTO> listOD = shopMapper.listOrderDetail(odto.getOrder_num());
				// 첫번째 주문상품상세
				ShopOrderDetailDTO dto = listOD.get(0);
				String prod_img = dto.getGame_img();
				String prod_company = dto.getProd_company();
				String prod_name = dto.getGame_name();
				int prod_count = listOD.size();
				odto.setProd_img(prod_img);
				odto.setProd_company(prod_company);
				odto.setProd_name(prod_name);
				odto.setProd_count(prod_count);
		}
		mav.addObject("listOrder", olist);
		return mav;
		
	}

	// 주문 취소
	@RequestMapping("shop_deleteOrder.do")
	public ModelAndView deleteOrder(HttpServletRequest req, @ModelAttribute ShopPointHistoryDTO dto, @RequestParam int order_num, @RequestParam int order_point) {
		ModelAndView mav = new ModelAndView("shop/myPage_main");
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		dto.setMem_num(mem_num);
				
		// 사용 포인트 재등록
		dto.setPoint_type("+");
		dto.setPoint_content("주문취소 적립");
		dto.setPoint_amount(order_point);
		dto.setPoint_total(order_point + shopMapper.userPointTotal(mem_num));
		shopMapper.pointOrder(dto);
		
		// 상품 개수 조정
		List<ShopOrderDetailDTO> odList = shopMapper.getRefundOrder(order_num);
		for(ShopOrderDetailDTO oddto : odList) {
			int prod_num = oddto.getProd_num();
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			pdto.setProd_qty(pdto.getProd_qty() + oddto.getDetail_qty());
			shopMapper.updateProd(pdto);
		}
		
		shopMapper.deleteOrder(order_num);
		return mav;
	}

	//환불 요청
	@RequestMapping("shop_refund.do")
	public ModelAndView refund(HttpServletRequest req, @ModelAttribute ShopOrderDTO odto) {
		ModelAndView mav = new ModelAndView("shop/myPage_main");
		
		// 구매처리단계 0(환불요청)으로 조정
		odto.setOrder_progress(0);
		shopMapper.updateOrder(odto);
		
		return mav;
	}	

	//환불 취소
	@RequestMapping("shop_refundReset.do")
	public ModelAndView resetRefund(HttpServletRequest req, @ModelAttribute ShopOrderDTO odto) {
		ModelAndView mav = new ModelAndView("shop/myPage_main");
		
		// 구매처리단계 4(환불취소 후)으로 조정
		odto.setOrder_progress(4);
		shopMapper.updateOrder(odto);
		
		return mav;
	}	

	
	//환불완료 -----------------관리자 영역임!
	@RequestMapping("ssssssshop_refund.do")
	public ModelAndView refundddd(HttpServletRequest req, @ModelAttribute ShopPointHistoryDTO dto, @ModelAttribute ShopOrderDTO odto, @RequestParam int order_num, @RequestParam int order_receiptprice) {
		ModelAndView mav = new ModelAndView("shop/myPage_main");
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		dto.setMem_num(mem_num);
		
		// 환불금 포인트 적립
		dto.setPoint_type("+");
		dto.setPoint_content("환불 적립");
		dto.setPoint_amount(order_receiptprice);
		dto.setPoint_total(order_receiptprice + shopMapper.userPointTotal(mem_num));
		shopMapper.pointOrder(dto);
		
		// 상품 개수 조정
		List<ShopOrderDetailDTO> odList = shopMapper.getRefundOrder(order_num);
		for(ShopOrderDetailDTO oddto : odList) {
			int prod_num = oddto.getProd_num();
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			pdto.setProd_qty(pdto.getProd_qty() + oddto.getDetail_qty());
			shopMapper.updateProd(pdto);
		}
		
		// 구매처리단계 0(환불요청)으로 조정
		odto.setOrder_progress(-1);
		shopMapper.updateOrder(odto);
		
		return mav;
	}
	
	// 찜한 목록
	@RequestMapping("shop_myPage_listLike.do")
	public ModelAndView shopMyPageListLike(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/myPage_listLike");
			
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		
		int count = shopMapper.likeCount(mem_num);
		mav.addObject("mem_num", mem_num);
		mav.addObject("count", count);// 찜한 상품 개수
		List<ShopLikeDTO> listLike = shopMapper.listLike(mem_num);
		mav.addObject("listLike", listLike);// 찜한 상품 목록

		return mav;
	}	
	
	// 장바구니
	@RequestMapping("shop_myPage_listCart.do")
	public ModelAndView shopMyPageListCart(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/myPage_listCart");
		
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		int count = shopMapper.cartCount(dto.getMem_num());
		mav.addObject("mem_num", dto.getMem_num());
		mav.addObject("count", count);// 장바구니 개수
		List<ShopCartDTO> listCart = shopMapper.listCart(dto.getMem_num());
		mav.addObject("listCart", listCart);// 장바구니 목록

		return mav;
	}
	
	// 마이페이지 리뷰
	@RequestMapping("shop_myPage_review.do")
	public ModelAndView shopMyPageReview(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("getMemNum", dto.getMem_num());
		
		int pageSize = 2;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = shopMyPageMapper.shopReviewCount(dto.getMem_num());
		if (endRow > count)
			endRow = count;
		Map<String, Integer> params = new HashMap<>();
		params.put("start", startRow);
		params.put("end", endRow);
		params.put("mem_num", dto.getMem_num());
		List<ShopReviewDTO> list = null;
		if (count > 0) {
			list = shopMyPageMapper.myPageReview(params);
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
			mav.addObject("myPageReview", list);
		}
		mav.addObject("count", count);
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum", rowNum);
		mav.setViewName("shop/myPage_review");
		return mav;
	}
	
	// 마이페이지 리뷰 수정페이지
	@RequestMapping("shop_myPage_review_updateForm.do")
	public ModelAndView shopMyPageReviewUpdate(HttpServletRequest req, int sr_num) {
		ModelAndView mav = new ModelAndView();
			
		// 상품명 구하기
		List<ShopProductDTO> listProd = shopMapper.listProd(); 
		mav.addObject("listProd", listProd);
			
		// review 구하기
		ShopReviewDTO dto = shopMyPageMapper.getMyPageReview(sr_num);
		mav.addObject("getReview", dto);
		mav.setViewName("shop/myPage_review_update");

		return mav;
	}
		
	// 마이페이지 리뷰 수정 처리
	@RequestMapping("shop_myPage_review_updateOk.do")
	public ModelAndView shopMyPageReviewUpdateOk(HttpServletRequest req, @RequestParam Map<String, String> map, @ModelAttribute ShopReviewDTO dto, BindingResult result) {
		if (result.hasErrors()) {}
		
		ModelAndView mav = new ModelAndView("message");
		
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		
		// 기존 이미지 널 처리
		dto.setSr_img1("");
		dto.setSr_img2("");
		dto.setSr_img3("");
		dto.setSr_img4("");
		
		// 이미지 처리
		for(int i=0; i<4; ++i) {
		String imgs = (String) map.get("imgs"+i);
		if(imgs == null) break; // 받아온 이미지가 더 없으면 for문 나가기
		if(imgs.equals("1") || imgs.equals("2") || imgs.equals("3") || imgs.equals("4")) {
			if(i==0) dto.setSr_img1((String) map.get("sr_img"+imgs));
			if(i==1) dto.setSr_img2((String) map.get("sr_img"+imgs));
			if(i==2) dto.setSr_img3((String) map.get("sr_img"+imgs));
			if(i==3) dto.setSr_img4((String) map.get("sr_img"+imgs));
		}else {
			byte[] imageData = Base64.decodeBase64(imgs.getBytes()); // 디코딩
			String fileName = UUID.randomUUID().toString() + ".png"; // 랜덤이름 생성
			if(i==0) dto.setSr_img1(fileName);
			if(i==1) dto.setSr_img2(fileName);
			if(i==2) dto.setSr_img3(fileName);
			if(i==3) dto.setSr_img4(fileName);
							
			File file = new File(upPath, fileName);
			// 저장공간에 비어있는 파일 생성
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
			
		// 삭제된 이미지 서버에서 삭제
		String deleted_img = (String)map.get("deleted_img");
		String[] arr = deleted_img.split(","); // 1번 방부터 시작, 총 길이는 삭제된 개수+1

		for(int i=1; i<arr.length; i++) {
			int delImgNum = Integer.parseInt(arr[i]);
			String delImgName = (String)map.get("sr_img"+delImgNum);
			File file = new File(upPath, delImgName);
			if (file.exists()) {
				file.delete();
			}
		}
		
		mav.addObject("getMemNum", dto2.getMem_num());
		int res = shopMyPageMapper.updateMyPageReview(dto);
		if(res > 0) {
			mav.addObject("msg", "상품 리뷰 수정 성공");
			mav.addObject("url", "shop_myPage_review.do?mem_num=" + dto2.getMem_num() + "&pageNum=1");
		}
		return mav;
	}
	
	// 마이페이지 리뷰 삭제
	@RequestMapping("shop_myPage_review_delete.do")
	public ModelAndView shopMyPageReviewDelete(HttpServletRequest req, @RequestParam Map<String, Object> params, int sr_num) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		String sr_img1 = (String)params.get("sr_img1");
		String sr_img2 = (String)params.get("sr_img2");
		String sr_img3 = (String)params.get("sr_img3");
		String sr_img4 = (String)params.get("sr_img4");
		
		ModelAndView mav = new ModelAndView("message");
		int res = shopMyPageMapper.deleteShopReview(sr_num);
		if (res > 0) {
			String upPath = session.getServletContext().getRealPath("/resources/img");
			File file1 = new File(upPath, sr_img1);
			File file2 = new File(upPath, sr_img2);
			File file3 = new File(upPath, sr_img3);
			File file4 = new File(upPath, sr_img4);

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
				mav.addObject("msg", "상품 리뷰 이미지, 글 삭제 성공");
			} else {
				mav.addObject("msg", "상품 리뷰 이미지 실패, 글 삭제 성공");
			}
		} else {
			mav.addObject("msg", "상품 리뷰 삭제 실패, 관리자에게 문의해주세요");
			mav.addObject("url", "shop_myPage_review.do?mem_num=" + dto.getMem_num() + "&pageNum=1");
		}
		mav.addObject("url", "shop_myPage_review.do?mem_num=" + dto.getMem_num() + "&pageNum=1");
		return mav;
	}

	
	// 마이페이지 상품 QnA
	@RequestMapping("shop_myPage_prodQnA.do")
	public ModelAndView shopMyPageProdQnA(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("getMemNum", dto.getMem_num());
		
		// 상품명 구하기
		List<ShopProductDTO> listProd = shopMapper.listProd(); 
		mav.addObject("listProd", listProd);
		
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = shopMyPageMapper.shopQnACount(dto.getMem_num());
		if (endRow > count)
			endRow = count;
		Map<String, Integer> params = new HashMap<>();
		params.put("start", startRow);
		params.put("end", endRow);
		params.put("mem_num", dto.getMem_num());
		List<ShopQnADTO> list = null;
		if (count > 0) {
			list = shopMyPageMapper.myPageQnA(params);
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
			mav.addObject("myPageQnA", list);
		}
		mav.addObject("count", count);
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum", rowNum);
		mav.setViewName("shop/myPage_prodQnA");
		return mav;
	}
	
	// 마이페이지 상품QnA 삭제
	@RequestMapping("shop_myPage_qna_delete.do")
	public ModelAndView shopMyPageQnADelete(HttpServletRequest req, @RequestParam Map<String, Object> params, int sq_num) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		String sq_img1 = (String)params.get("sq_img1");
		String sq_img2 = (String)params.get("sq_img2");
		String sq_img3 = (String)params.get("sq_img3");
		String sq_img4 = (String)params.get("sq_img4");
		
		ModelAndView mav = new ModelAndView("message");
		int res = shopMyPageMapper.deleteShopQnA(sq_num);
		if (res > 0) {
			String upPath = session.getServletContext().getRealPath("/resources/img");
			File file1 = new File(upPath, sq_img1);
			File file2 = new File(upPath, sq_img2);
			File file3 = new File(upPath, sq_img3);
			File file4 = new File(upPath, sq_img4);

			if (file1.exists()) {
				file1.delete();
				mav.addObject("msg", "상품 문의 이미지, 글 삭제 성공");
			} else if (file1.exists() && file2.exists()) {
				file1.delete();
				file2.delete();
				mav.addObject("msg", "상품 문의 이미지, 글 삭제 성공");
			} else if (file1.exists() && file2.exists() && file3.exists()) {
				file1.delete();
				file2.delete();
				file3.delete();
				mav.addObject("msg", "상품 문의 이미지, 글 삭제 성공");
			} else if (file1.exists() && file2.exists() && file3.exists() && file4.exists()) {
				file1.delete();
				file2.delete();
				file3.delete();
				file4.delete();
				mav.addObject("msg", "상품 문의 이미지, 글 삭제 성공");
			} else {
				mav.addObject("msg", "상품 문의 이미지 실패, 글 삭제 성공");
			}
		} else {
			mav.addObject("msg", "상품 문의 삭제 실패, 관리자에게 문의해주세요");
			mav.addObject("url", "shop_myPage_prodQnA.do?mem_num=" + dto.getMem_num() + "&pageNum=1");
		}
		mav.addObject("url", "shop_myPage_prodQnA.do?mem_num=" + dto.getMem_num() + "&pageNum=1");
		return mav;
	}
	
	// 마이페이지 상품 QnA 수정폼
	@RequestMapping("shop_myPage_ProdQnA_updateForm.do")
	public ModelAndView shopMyPageQnAUpdate(HttpServletRequest req, int sq_num) {
		ModelAndView mav = new ModelAndView();
		
		// 상품명 구하기
		List<ShopProductDTO> listProd = shopMapper.listProd(); 
		mav.addObject("listProd", listProd);
		
		// QnA 구하기
		ShopQnADTO dto = shopMyPageMapper.getMyPageQnA(sq_num);
		mav.addObject("getQnA", dto);
		mav.setViewName("shop/myPage_prodQnA_update");
		return mav;
	}
	
	// 마이페이지 상품QnA 수정 처리
	@RequestMapping("shop_myPage_ProdQnA_updateOk.do")
	public ModelAndView shopMyPageQnAUpadateOk(HttpServletRequest req, @RequestParam Map<String, String> map, @ModelAttribute ShopQnADTO dto, BindingResult result) {
		ModelAndView mav = new ModelAndView("message");
		
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		if (result.hasErrors()) {}
		
		MemberDTO dto2 = (MemberDTO)session.getAttribute("login_mem");
		
		// 기존 이미지 널 처리
		dto.setSq_img1("");
		dto.setSq_img2("");
		dto.setSq_img3("");
		dto.setSq_img4("");
		
		// 이미지 처리
		for(int i=0; i<4; ++i) {
		String imgs = (String)map.get("imgs"+i);
		if(imgs == null) break; // 받아온 이미지가 더 없으면 for문 나가기
		if(imgs.equals("1") || imgs.equals("2") || imgs.equals("3") || imgs.equals("4")) {
			if(i==0) dto.setSq_img1((String) map.get("sq_img"+imgs));
			if(i==1) dto.setSq_img2((String) map.get("sq_img"+imgs));
			if(i==2) dto.setSq_img3((String) map.get("sq_img"+imgs));
			if(i==3) dto.setSq_img4((String) map.get("sq_img"+imgs));
		}else {
			byte[] imageData = Base64.decodeBase64(imgs.getBytes()); // 디코딩
			String fileName = UUID.randomUUID().toString() + ".png"; // 랜덤이름 생성
			if(i==0) dto.setSq_img1(fileName);
			if(i==1) dto.setSq_img2(fileName);
			if(i==2) dto.setSq_img3(fileName);
			if(i==3) dto.setSq_img4(fileName);
							
			File file = new File(upPath, fileName);
			// 저장공간에 비어있는 파일 생성
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
			
		// 삭제된 이미지 서버에서 삭제
		String deleted_img = (String)map.get("deleted_img");
		String[] arr = deleted_img.split(","); // 1번 방부터 시작, 총 길이는 삭제된 개수+1

		for(int i=1; i<arr.length; i++) {
			int delImgNum = Integer.parseInt(arr[i]);
			String delImgName = (String)map.get("sq_img"+delImgNum);
			File file = new File(upPath, delImgName);
			if (file.exists()) {
				file.delete();
			}
		}
		
		mav.addObject("getMemNum", dto2.getMem_num());
		int res = shopMyPageMapper.updateMyPageQnA(dto);
		if(res > 0) {
			mav.addObject("msg", "상품 문의글 수정 성공");
			mav.addObject("url", "shop_myPage_prodQnA.do?mem_num=" + dto2.getMem_num() + "&pageNum=1");
		}
		return mav;

	}
	
	// 마이페이지 포인트
	@RequestMapping("shop_myPage_point.do")
	public ModelAndView ShopMyPagePoint(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		// 갖고있는 총 포인트
		ModelAndView mav = new ModelAndView();
		int point_total = shopMyPageMapper.getTotalPoint(dto.getMem_num());
		mav.addObject("pointTotal", point_total);
		
		// 포인트 내역
		List<ShopPointHistoryDTO> list = shopMyPageMapper.MemPointList(dto.getMem_num());
		mav.addObject("MemPointList", list);
		
		mav.setViewName("shop/myPage_point");
		return mav;
	}
	
	// 마이페이지 내 쿠폰
	@RequestMapping("shop_myPage_coupon.do")
	public ModelAndView shopMyPageCoupon(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		ModelAndView mav = new ModelAndView();
		
		// 쿠폰 리스트
		List<ShopUserCouponDTO> list = shopMyPageMapper.myPageCoupon(dto.getMem_num());
		mav.addObject("myPageCoupon", list);
		
		// 쿠폰 개수
		int count = shopMyPageMapper.getCoupon(dto.getMem_num());
		mav.addObject("getCoupon", count);
		
		// 만료일 지난 쿠폰 삭제
		shopMyPageMapper.deleteCoupon();
		
		mav.setViewName("shop/myPage_coupon");
		return mav;
	}
}
