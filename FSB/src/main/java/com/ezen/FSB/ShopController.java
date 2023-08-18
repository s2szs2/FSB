package com.ezen.FSB;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ShopCartDTO;
import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopDeliveryDTO;
import com.ezen.FSB.dto.ShopLikeDTO;
import com.ezen.FSB.dto.ShopOrderDTO;
import com.ezen.FSB.dto.ShopOrderDetailDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;
import com.ezen.FSB.dto.ThemeDTO;
import com.ezen.FSB.service.AdminGameMapper;
import com.ezen.FSB.service.AdminShopMapper;
import com.ezen.FSB.service.ShopMapper;
import com.ezen.FSB.service.ShopMyPageMapper;

@Controller
public class ShopController {

	@Autowired
	private ShopMapper shopMapper;
	
	@Autowired
	private ShopMyPageMapper shopMyPageMapper;
	
	@Autowired
	private AdminGameMapper adminGameMapper;
	
	@Autowired
	private AdminShopMapper adminShopMapper;
	
	// 쇼핑몰 메인페이지 탑(테마별)
	@RequestMapping("shop_cateFind.do")
	public ModelAndView shopCateFind(int theme_num) {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		//tem.out.println("카테고리 게임 인원" + theme_num);
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가
		// 카테고리 테마별
		List<ShopProductDTO> list = shopMyPageMapper.shopCateFind(theme_num);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
		
		return mav;
	}
	
	// 쇼핑몰 메인페이지 탑(인원순)
	@RequestMapping("shop_cateFind2.do")
	public ModelAndView shopCateFind2(int game_player) {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		//tem.out.println("카테고리 게임 인원" + game_player);
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가
		// 카테고리 인원별
		List<ShopProductDTO> list = shopMyPageMapper.shopCateFind2(game_player);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
		
		return mav;
	}
	
	// 쇼핑몰 메인페이지 탑(난이도별)
	@RequestMapping("shop_cateFind3.do")
	public ModelAndView shopCateFind3(int game_level) {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		//tem.out.println("카테고리 게임 난이도" + game_level);
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가
		// 카테고리별 난이도별
		List<ShopProductDTO> list = shopMyPageMapper.shopCateFind3(game_level);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);

		return mav;
	}
	
	// 쇼핑몰 메인 20개씩 
	@RequestMapping("prod_view_20.do")
	public ModelAndView prodView20() {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가
		// 상품 20개씩 나오게 구현
		List<ShopProductDTO> list = shopMyPageMapper.prodView20();
		//tem.out.println("20개 들고와라" + list);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
		
		return mav;
		
	}
	
	// 쇼핑몰 메인 40개씩 
	@RequestMapping("prod_view_40.do")
	public ModelAndView prodView40() {
		ModelAndView mav = new ModelAndView("shop/shop_main");
			
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가
		// 상품 40개씩 나오게 구현
		List<ShopProductDTO> list = shopMyPageMapper.prodView40();
		//tem.out.println("40개 들고와라" + list);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
			
		return mav;
			
	}
		
	// 쇼핑몰 메인 60개씩 
	@RequestMapping("prod_view_60.do")
	public ModelAndView prodView60() {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		// !!!!!!!!!!!!!!!!!!!!!!!추가	
		// 상품 60개씩 나오게 구현
		List<ShopProductDTO> list = shopMyPageMapper.prodView60();
		//tem.out.println("60개 들고와라" + list);
		for(ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
			
		return mav;
			
	}
	
	
	//쇼핑몰 메인페이지(전체상품목록 및 상세검색목록)
	@RequestMapping("/shop_main.do")
	public ModelAndView mainShop(HttpServletRequest req, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("shop/shop_main");

		HttpSession session = req.getSession();
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		session.setAttribute("df", df);
	    
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		//비회원
		int mem_num = 0;
	       
		//회원 정보를 위한 회원번호
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		mav.addObject("mem_num", mem_num);
	      
		if(dto != null){
			mem_num = dto.getMem_num();
		}
	          
		//인기 보드게임
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
		for(ShopProductDTO dto2 : listProd) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listRank", listProd);
		mav.addObject("count", listProd.size());		
		
		//전체 보드게임
		List<ShopProductDTO> listProd2 = shopMapper.listProd(); 
		for(ShopProductDTO dto2 : listProd2) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", listProd2);
//		//리뷰 별점 평균
//		int count = shopMapper.shopviewReviewCount(prod_num);
//		if(count != 0) {
//			int reviewAvg = shopMapper.reviewAvg(prod_num);
//			//tem.out.println("리뷰별점평균"+reviewAvg);
//			mav.addObject("reviewAvg", reviewAvg);
//			mav.addObject("count", count);
//		}      
		return mav;
	}

	//쇼핑몰 인기 보드게임
	@RequestMapping("/shop_main_best.do")
	public ModelAndView mainBestProd(HttpServletRequest req, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView("shop/shop_main_best");

		HttpSession session = req.getSession();
		java.text.DecimalFormat df = new java.text.DecimalFormat("###,###");
		session.setAttribute("df", df);
	    
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);
		
		//비회원
		int mem_num = 0;
	       
		//회원 정보를 위한 회원번호
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		mav.addObject("mem_num", mem_num);
	      
		if(dto != null){
			mem_num = dto.getMem_num();
		}
	          
		//인기 보드게임
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
		for(ShopProductDTO dto2 : listProd) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listRank", listProd);
		mav.addObject("count", listProd.size());		
		return mav;
	}	
	
	// !!!!!!!!!!!!!!!!!!!!!!!추가
	// 상세보기 체크 시 찾기
	@RequestMapping("shop_checkFind.do")
	public ModelAndView shop_checkFind(@RequestParam(required=false, name="theme") List<String> theme, @RequestParam(required=false, name="game_player") List<String> game_player, @RequestParam(required=false, name="game_level") List<String> game_level) {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);			
		
		List<ShopProductDTO> tlist2 = null;

		List<ShopProductDTO> resultList = new ArrayList<ShopProductDTO>();
		Hashtable<Integer, ShopProductDTO> ht = new Hashtable<Integer, ShopProductDTO>();
		if(theme == null) {
			         
		} else if (theme.size() != 0) {
			for(String t : theme) {
				//tem.out.println("태그"+t);
			          tlist2 = shopMyPageMapper.checkListProd1(Integer.parseInt(t));
			          for(ShopProductDTO dto : tlist2) {
			             ht.put(dto.getGame_num(), dto);
			          }
			       }
			    }
			    if(game_player == null) {
			         
			    } else if (game_player.size() != 0) {
			       for(String p : game_player) {
			          //tem.out.println("인원"+p);
			          tlist2 = shopMyPageMapper.checkListProd2(Integer.parseInt(p));
			          for(ShopProductDTO dto : tlist2) {
			             ht.put(dto.getGame_num(), dto);
			          }
			       }
			    }
			    if(game_level == null) {
			         
			    } else if (game_level.size() != 0) {
			       for(String s : game_level) {
			          //tem.out.println("난이도"+s);
			          tlist2 = shopMyPageMapper.checkListProd3(Integer.parseInt(s));
			          for(ShopProductDTO dto : tlist2) {
			             ht.put(dto.getGame_num(), dto);
			          }
			       }
			    }
			      
			    Enumeration enu = ht.keys();
			    while(enu.hasMoreElements()) {
			       int key = (int)enu.nextElement();
			       ShopProductDTO dto = ht.get(key);
			       resultList.add(dto);
			    }
			    
			    for(ShopProductDTO dto2 : resultList) {
					// 리뷰 개수 구하기
					dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
					// 좋아요 개수 구하기
					dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
					// 리뷰 별점 평균
					int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
					if (count != 0) {
						dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
					}
				}
			    mav.addObject("listProd", resultList);
				return mav;
	}	
	//전체상품 정렬(이름순/판매순/인기순/최신순)
	@RequestMapping("prod_sort.do")
	public ModelAndView prod_sort(String sort) {
		ModelAndView mav = new ModelAndView();
		if(sort.equals("game_name")) {
			//인기 보드게임
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
			for(ShopProductDTO dto2 : listProd) {
				// 리뷰 개수 구하기
				dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
				// 좋아요 개수 구하기
				dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
				// 리뷰 별점 평균
				int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
				if (count != 0) {
					dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
				}
			}
			mav.addObject("listRank", listProd);
			
			List<ShopProductDTO> listProd2 = shopMapper.sortProd1(sort);
			for(ShopProductDTO dto2 : listProd2) {
				// 리뷰 개수 구하기
				dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
				// 좋아요 개수 구하기
				dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
				// 리뷰 별점 평균
				int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
				if (count != 0) {
					dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
				}
			}
			mav.setViewName("shop/shop_main");
			mav.addObject("listProd", listProd2);
		}else if(sort.equals("prod_regdate")) {
			//인기 보드게임
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
			for(ShopProductDTO dto2 : listProd) {
				// 리뷰 개수 구하기
				dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
				// 좋아요 개수 구하기
				dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
				// 리뷰 별점 평균
				int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
				if (count != 0) {
					dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
				}
			}
			mav.addObject("listRank", listProd);			
			
			List<ShopProductDTO> listProd2 = shopMapper.sortProd2(sort);
			for(ShopProductDTO dto2 : listProd2) {
				// 리뷰 개수 구하기
				dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
				// 좋아요 개수 구하기
				dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
				// 리뷰 별점 평균
				int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
				if (count != 0) {
					dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
				}
			}			
			mav.setViewName("shop/shop_main");
			mav.addObject("listProd", listProd2);
		}
		return mav;
	}
	
	// 상품검색
	@RequestMapping("prod_find.do")
	public ModelAndView prod_find(HttpServletRequest req, String search, String searchString) {
		ModelAndView mav = new ModelAndView("shop/shop_main");
		
		// 테마 가져오기
		List<ThemeDTO> tlist = adminGameMapper.listTheme();
		mav.addObject("listTheme", tlist);	
		
		//tem.out.println(searchString);
		List<ShopProductDTO> list = shopMapper.findProd(search, searchString);
		for (ShopProductDTO dto2 : list) {
			// 리뷰 개수 구하기
			dto2.setSr_count(adminShopMapper.getProdReviewCount(dto2.getProd_num()));
			// 좋아요 개수 구하기
			dto2.setSl_count(shopMyPageMapper.ShopGetLikeCount(dto2.getProd_num()));
			// 리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(dto2.getProd_num());
			if (count != 0) {
				dto2.setProd_starratingAvg(shopMapper.reviewAvg(dto2.getProd_num()));
			}
		}
		mav.addObject("listProd", list);
		return mav;
	}
	
	//쇼핑몰 상품상세 1.상세페이지
	@RequestMapping("/shop_view.do")
	public ModelAndView viewShop(HttpServletRequest req, @RequestParam int prod_num, @RequestParam Map<String, Integer> params) {
		ModelAndView mav = new ModelAndView("shop/shop_view");
		//위쪽 상품상세 꺼내기
		ShopProductDTO pdto = shopMapper.getProd(prod_num);
		mav.addObject("getProd", pdto);
		mav.addObject("prod_num", prod_num);
		//리뷰 별점 평균
		int count = shopMapper.shopviewReviewCount(prod_num);
		if(count != 0) {
			int reviewAvg = shopMapper.reviewAvg(prod_num);
			//tem.out.println("리뷰별점평균"+reviewAvg);
			mav.addObject("reviewAvg", reviewAvg);
			mav.addObject("count", count);
		}
		
		// 테마 가져오기
	    List<ThemeDTO> tlist = adminGameMapper.listTheme();
	    mav.addObject("listTheme", tlist);		
		
		// 쿠폰 전체 리스트
		List<ShopCouponDTO> clist = shopMyPageMapper.couponList();
		mav.addObject("couponList", clist);
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		int mem_num;
		MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
		if(dto == null) {
			mem_num = 0;
		}else {
			mem_num = dto.getMem_num();
			mav.addObject("mem_num", mem_num);//지울 예정
		}
		// 해당 상품 찜 여부
		params.put("mem_num", mem_num);
		params.put("prod_num", prod_num);		
				
		ShopLikeDTO ldto = shopMapper.getUserLike(params);
		if(ldto != null) {	// size가 0보다 크면 빨간하트
			mav.addObject("like", 1);
		} else {					// 빈하트
			mav.addObject("like", 0);
		}		
		// 상품 찜 개수
		int likeCount = shopMapper.prodLikeCount(prod_num);
		mav.addObject("likeCount", likeCount);		
		
		// 내가 보유한 쿠폰
		if(dto != null) {
			List<ShopUserCouponDTO> list = shopMyPageMapper.myPageCoupon(dto.getMem_num());
			//tem.out.println("쿠폰리스트" + list);
			mav.addObject("myPageCoupon", list);
		
			// 안가지고 있는 쿠폰 리스트를 담을 그릇 list로 선언
			List<ShopCouponDTO> exlist = new ArrayList<>();
			exlist.addAll(clist);	// clist 복사해서 exlist 복사본 만들기
		
			for (ShopCouponDTO cdto : clist) {	// 전체 쿠폰 리스트 for문
				for(ShopUserCouponDTO udto : list) {	// 가지고 있는 쿠폰 리스트 for문
					if (cdto.getSc_num() == udto.getSc_num()) {
						exlist.remove(cdto);
					}
				}
			}
			mav.addObject("exlist", exlist);
		}
		return mav;
	}
	
	// 쿠폰 다운로드
	@RequestMapping("shop_couponDownload.do")
	public ModelAndView shopCouponDownload(HttpServletRequest req, int sc_num, int prod_num) {
		ModelAndView mav = new ModelAndView("message");
		ShopProductDTO pdto = shopMapper.getProd(prod_num);
		mav.addObject("getProd", pdto);
		
		HttpSession session = req.getSession();
		MemberDTO dto = (MemberDTO)session.getAttribute("login_mem");
		
		// 쿠폰 전체 리스트
		List<ShopCouponDTO> clist = shopMyPageMapper.couponList();
		mav.addObject("couponList", clist);
		//tem.out.println("쿠폰 전체 리스트" + clist);
		
		//tem.out.println("쿠폰 번호 sc_num" + sc_num);
		
		String sc_duedate = shopMyPageMapper.getCouponDate(sc_num);
		//tem.out.println("날짜 왔니?"+sc_duedate);
		
		Map<String, Object> params = null;
		if (sc_duedate!=null) {
			params = new HashMap<>();
			params.put("mem_num", dto.getMem_num());
			params.put("sc_num", sc_num);
			params.put("sc_duedate", sc_duedate);
			int res = shopMyPageMapper.couponDownload(params);
			//tem.out.println("다운로드" + res);
			if (res > 0) { 
				mav.addObject("msg", "쿠폰이 다운로드 되었습니다. 마이페이지에서 확인해 주세요.");
				mav.addObject("url", "shop_view.do?prod_num=" + prod_num);
			} else {
				mav.addObject("msg", "쿠폰 다운로드를 실패하였습니다. 관리자에게 문의해 주세요.");
				mav.addObject("url", "shops_view.do?prod_num=" + prod_num);
			}
		} else {
			params = new HashMap<>();
			params.put("mem_num", dto.getMem_num());
			params.put("sc_num", sc_num);
			int res = shopMyPageMapper.couponDownload2(params);
			//tem.out.println("다운로드2(//date+30)" + res);
			if (res > 0) { 
				mav.addObject("msg", "쿠폰이 다운로드 되었습니다. 마이페이지에서 확인해 주세요.");
				mav.addObject("url", "shop_view.do?prod_num=" + prod_num);
//				mav.setViewName("shop/shop_prod_view");
//				mav.addObject("prod_num", prod_num);
			} else {
				mav.addObject("msg", "쿠폰 다운로드를 실패하였습니다. 관리자에게 문의해 주세요.");
				mav.addObject("url", "shop_view.do?prod_num=" + prod_num);
			}
		}		
		return mav;
	}
	
	// 쇼핑몰 상품상세 1.상세페이지-찜하기버튼
	@ResponseBody
	@RequestMapping("/shop_prodLike.do")
	public ModelAndView prodLike(HttpServletRequest req, @RequestParam int prod_num, @ModelAttribute ShopLikeDTO dto, @RequestParam Map<String, Integer> params) {
		
		ModelAndView mav = new ModelAndView("shop/shop_prod_view");
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		if(dto.getProd_num() == prod_num && dto.getMem_num() == mem_num) {
			return mav;
		}
		dto.setMem_num(mem_num);
		// 찜 상품 등록
		params.put("mem_num", mem_num);
		params.put("prod_num", prod_num);
		shopMapper.prodLike(dto);
		mav.addObject("like", 1);
		// 꽉찬 하트가 됨
		return mav;
	}
	
	// 쇼핑몰 상품상세 1.상세페이지-찜하기해제버튼
	@ResponseBody
	@RequestMapping("/shop_deleteLike.do")
	public ModelAndView deleteLike(HttpServletRequest req, @RequestParam int prod_num, @RequestParam String mode, @RequestParam Map<String, Integer> params) {

		ModelAndView mav = new ModelAndView("shop/shop_prod_view");
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		if(mode.equals("listLike")) {
			// 찜 상품 삭제
			params.put("mem_num", mem_num);
			params.put("prod_num", prod_num);
			shopMapper.deleteLike(params);			
		
			int count = shopMapper.likeCount(mem_num);
			mav.addObject("mem_num", mem_num);
			mav.addObject("count", count);// 찜한 상품 개수
			List<ShopLikeDTO> listLike = shopMapper.listLike(mem_num);
			mav.addObject("listLike", listLike);// 찜한 상품 목록
					
			return new ModelAndView("shop/myPage_listLike");
		}
				
		// 찜 상품 삭제
		params.put("mem_num", mdto.getMem_num());
		params.put("prod_num", prod_num);
		shopMapper.deleteLike(params);
		return mav;
	}
	
	
	//쇼핑몰 찜한 상품 목록
	@RequestMapping("/shop_listLike.do")
	public ModelAndView shoplistLike(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/shop_listLike");
			
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
	
	
	//쇼핑몰 상품상세 2.상품리뷰
		@RequestMapping("/shop_view2.do")
		public ModelAndView view2Shop(HttpServletRequest req, @RequestParam Map<String, Integer> params,  @RequestParam int prod_num) {
			ModelAndView mav = new ModelAndView("shop/shop_view2");
			
			//위쪽 상품상세 꺼내기
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			mav.addObject("getProd", pdto);
			
			//리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(prod_num);
			mav.addObject("count", count);
			if(count != 0) {
				int reviewAvg = shopMapper.reviewAvg(prod_num);
				//tem.out.println("리뷰별점평균"+reviewAvg);
				mav.addObject("reviewAvg", reviewAvg);
				mav.addObject("count", count);
			}

			// 회원정보를 위한 회원번호
			HttpSession session = req.getSession();
			int mem_num;
			MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
			if(dto == null) {
				mem_num = 0;
			}else {
				mem_num = dto.getMem_num();
				mav.addObject("mem_num", mem_num);//지울 예정
			}
			
			// 테마 가져오기
		    List<ThemeDTO> tlist = adminGameMapper.listTheme();
		    mav.addObject("listTheme", tlist);		
			
			//쿠폰 꺼내기
			List<ShopCouponDTO> clist = shopMyPageMapper.couponList();
			mav.addObject("couponList", clist);		
			
			// 내가 보유한 쿠폰
			if(dto != null) {
				List<ShopUserCouponDTO> list = shopMyPageMapper.myPageCoupon(dto.getMem_num());
				//tem.out.println("쿠폰리스트" + list);
				mav.addObject("myPageCoupon", list);
					
				// 안가지고 있는 쿠폰 리스트를 담을 그릇 list로 선언
				List<ShopCouponDTO> exlist = new ArrayList<>();
				exlist.addAll(clist);	// clist 복사해서 exlist 복사본 만들기
					
				for (ShopCouponDTO cdto : clist) {	// 전체 쿠폰 리스트 for문
					for(ShopUserCouponDTO udto : list) {	// 가지고 있는 쿠폰 리스트 for문
						if (cdto.getSc_num() == udto.getSc_num()) {
							exlist.remove(cdto);
						}
					}
				}
				mav.addObject("exlist", exlist);
			}
			
			// 해당 상품 찜 여부
			params.put("mem_num", mem_num);
			params.put("prod_num", prod_num);		
					
			ShopLikeDTO ldto = shopMapper.getUserLike(params);
			if(ldto != null) {	// size가 0보다 크면 빨간하트
				mav.addObject("like", 1);
			} else {					// 빈하트
				mav.addObject("like", 0);
			}				
			// 상품 찜 개수
			int likeCount = shopMapper.prodLikeCount(prod_num);
			mav.addObject("likeCount", likeCount);		
			
			//해당 상품 리뷰 꺼내기
			mav.addObject("prod_num", prod_num);//있어야 페이징함
				
			int pageSize = 5;
			String pageNum = req.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}		
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			//int count = shopMapper.shopviewReviewCount(prod_num);
			//tem.out.println("리뷰개수"+count);
			if (endRow > count)
				endRow = count;
			params.put("start", startRow);
			params.put("end", endRow);
			params.put("prod_num", prod_num);
			List<ShopReviewDTO> list = null;
			if (count > 0) {
				list = shopMapper.getViewReview(params);
				//tem.out.println("리뷰리스트"+list);
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
				mav.addObject("getViewReview", list);
			}
			int rowNum = count - (currentPage - 1) * pageSize;
			mav.addObject("rowNum", rowNum);
			return mav;		
		}
	
	//상품 리뷰 등록
	@RequestMapping(value="/shop_insertReview.do", method=RequestMethod.GET)
	public ModelAndView insertReview(HttpServletRequest req) {
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//회원이 구매한 상품만 나오도록
		List<ShopReviewDTO> listOrderProd = shopMapper.listNotReview(mem_num);
		return new ModelAndView("shop/shop_insertReview", "listOrderProd", listOrderProd);
	}
		
	//상품 리뷰 등록처리
	@RequestMapping(value="/shop_insertReview.do", method=RequestMethod.POST)
	public ModelAndView insertOkReview(HttpServletRequest req, @RequestParam Map<String, Object> map, @RequestParam int prod_num, @ModelAttribute ShopReviewDTO dto , BindingResult result) {
		if(result.hasErrors()) {}//항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
		
		//회원 정보 세션에서 꺼내기
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//tem.out.println("리뷰등록 멤버넘버" + mem_num);
		dto.setMem_num(mem_num);
		
		String upPath = session.getServletContext().getRealPath("/resources/img");
		session.setAttribute("upPath", upPath);
		for(int i=0; i<4; ++i) {
			String imgs = (String) map.get("imgs"+i);
			//tem.out.println(imgs);
			if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
			
			byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
			String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
			
			if(i==0) dto.setSr_img1(fileName);
			if(i==1) dto.setSr_img2(fileName);
			if(i==2) dto.setSr_img3(fileName);
			if(i==3) dto.setSr_img4(fileName);
			
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
		//insert
		int res = shopMapper.insertReview(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "상품 리뷰가 등록되었습니다. 감사합니다😊");
			mav.addObject("url", "shop_view2.do?prod_num="+prod_num);//shop_mypage_reviewList.do?mode=all&sort=all
		}else {
			mav.addObject("msg", "상품 등록 실패! 파일 업로드 성공! 상품 등록 페이지로 이동합니다.");
			mav.addObject("url", "shop_insertReview.do");
		}
		
		// 리뷰 작성 시 포인트 적립(300포인트)
	      String point_type = "+";
	      String point_content = "리뷰작성";
	      int point_amount = 300;
	      int point_total = shopMyPageMapper.getTotalPoint(mem_num);
	      //tem.out.println("토탈 가지고 와줘.." + point_total);
	      ShopPointHistoryDTO dto2 = new ShopPointHistoryDTO();
	      dto2.setMem_num(dto.getMem_num());
	      dto2.setPoint_type(point_type);
	      dto2.setPoint_content(point_content);
	      dto2.setPoint_amount(point_amount);
	      dto2.setPoint_total(point_total+point_amount);
	      int res2 = shopMyPageMapper.reviewPoint(dto2);

		return mav;
	}
	
	//상품 리뷰 수정
	@RequestMapping(value="/shop_updateReview.do", method=RequestMethod.GET)
	public ModelAndView updateReview(@RequestParam int sr_num) {
		ShopReviewDTO dto = shopMapper.getReview(sr_num);
		return new ModelAndView("shop/shop_updateReview", "getReview", dto);
	}
	
	//상품 리뷰 수정처리
	@RequestMapping(value="/shop_updateReview.do", method=RequestMethod.POST)
	public ModelAndView updateOkReview(HttpServletRequest req, @RequestParam Map<String, String> params, @ModelAttribute ShopReviewDTO dto, BindingResult result) {
		if(result.hasErrors()) {}		
		// 파일 업로드
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile mf = mr.getFile("sr_img1");
		String sr_img1 = mf.getOriginalFilename();
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("/resources/img");
		// 파일명 중복 방지
		UUID uuid = UUID.randomUUID();
		sr_img1 = uuid.toString() + "_" +sr_img1;
		
		if(!mf.isEmpty()) {//이미지 수정시
			// 파일 객체 생성, 업로드
			File file = new File(upPath, sr_img1);
			try {
				mf.transferTo(file);
			}catch(IOException e) {
				e.printStackTrace();
				//tem.out.println("file 수정중 오류 발생");
			}
			// 파일 이름 dto 세팅
			dto.setSr_img1(sr_img1);
			// 이전 파일 지우기
			File file01 = new File(upPath, params.get("sr_img0"));
			if(file01.exists()) { // 파일이 존재하면
				file01.delete();
			}
		}else { // 이미지 수정 하지 않는 경우
			// 파일 이름만 dto 세팅
			dto.setSr_img1(params.get("sr_img0"));
		}
		int res = shopMapper.updateReview(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "상품 리뷰가 수정 수정되었습니다.");
			mav.addObject("url", "shop_viewReview.do?sr_num="+dto.getSr_num());
		}else {
			mav.addObject("msg", "상품 리뷰 수정 실패! 상품 수정 페이지로 이동합니다.");
			mav.addObject("url", "shop_updateReview.do?sr_num="+dto.getSr_num());
		}
		return mav;
	}
	
	//상품 리뷰 삭제
	@RequestMapping("/shop_deleteReview.do")
	public ModelAndView deleteReview(HttpServletRequest req, @RequestParam Map<String, String> params) {
		// 상품 삭제
		int res = shopMapper.deleteReview(Integer.parseInt(params.get("sr_num")));
				
		ModelAndView mav = new ModelAndView("message");
				
		if(res>0) {		
			HttpSession session = req.getSession();
			String upPath = session.getServletContext().getRealPath("/resources/img");

			// 파일 삭제
			File file = new File(upPath, params.get("sr_img1"));
			if(file.exists()) { // 파일이 존재하면
				file.delete();
				mav.addObject("msg", "상품 리뷰가 삭제되었습니다.");
				mav.addObject("url", "shop_review2.do");
			}else { // 파일이 없는 경우
				mav.addObject("msg", "상품 리뷰 삭제 성공! 파일 삭제 실패! 메인 페이지로 이동합니다.");
				mav.addObject("url", "shop_main.do");
			}
		}else {
			mav.addObject("msg", "상품 리뷰 삭제 실패! 메인 페이지로 이동합니다.");
			mav.addObject("url", "shop_main.do");
		}
		return mav;
	}
	
	//쇼핑몰 상품상세 3.배송/교환/환불
		@RequestMapping("/shop_view3.do")
		public ModelAndView view3Shop(HttpServletRequest req, @RequestParam Map<String, Integer> params, @RequestParam int prod_num) {
			ModelAndView mav = new ModelAndView("shop/shop_view3");
			
			//위쪽 상품상세 꺼내기
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			mav.addObject("getProd", pdto);
			  
			//리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(prod_num);
			if(count != 0) {
				int reviewAvg = shopMapper.reviewAvg(prod_num);
				//tem.out.println("리뷰별점평균"+reviewAvg);
				mav.addObject("reviewAvg", reviewAvg);
				mav.addObject("count", count);
			}

			// 회원정보를 위한 회원번호
			HttpSession session = req.getSession();
			int mem_num;
			MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
			if(dto == null) {
				mem_num = 0;
			}else {
				mem_num = dto.getMem_num();
				mav.addObject("mem_num", mem_num);//지울 예정
			}
					
			// 테마 가져오기
			List<ThemeDTO> tlist = adminGameMapper.listTheme();
			mav.addObject("listTheme", tlist);		
					
			//쿠폰 꺼내기
			List<ShopCouponDTO> clist = shopMyPageMapper.couponList();
			mav.addObject("couponList", clist);		
					
			// 내가 보유한 쿠폰
			if(dto != null) {
				List<ShopUserCouponDTO> list = shopMyPageMapper.myPageCoupon(dto.getMem_num());
				//tem.out.println("쿠폰리스트" + list);
				mav.addObject("myPageCoupon", list);
							
				// 안가지고 있는 쿠폰 리스트를 담을 그릇 list로 선언
				List<ShopCouponDTO> exlist = new ArrayList<>();
				exlist.addAll(clist);	// clist 복사해서 exlist 복사본 만들기
							
				for (ShopCouponDTO cdto : clist) {	// 전체 쿠폰 리스트 for문
					for(ShopUserCouponDTO udto : list) {	// 가지고 있는 쿠폰 리스트 for문
						if (cdto.getSc_num() == udto.getSc_num()) {
							exlist.remove(cdto);
						}
					}
				}
				mav.addObject("exlist", exlist);
			}
			
			// 해당 상품 찜 여부
			params.put("mem_num", mem_num);
			params.put("prod_num", prod_num);		
					
			ShopLikeDTO ldto = shopMapper.getUserLike(params);
			if(ldto != null) {	// size가 0보다 크면 빨간하트
				mav.addObject("like", 1);
			} else {					// 빈하트
				mav.addObject("like", 0);
			}			
			// 상품 찜 개수
			int likeCount = shopMapper.prodLikeCount(prod_num);
			mav.addObject("likeCount", likeCount);		
			
			return mav;
		}	

	//상품 문의 등록
	@RequestMapping(value="/shop_insertQnA.do", method=RequestMethod.GET)
	public ModelAndView insertQnA(@RequestParam int prod_num) {
		return new ModelAndView("shop/shop_insertQnA", "prod_num", prod_num);
	}	
	//상품 문의 등록처리
	@RequestMapping(value="/shop_insertQnA.do", method=RequestMethod.POST)
	public ModelAndView insertOkQnA(HttpServletRequest req, @RequestParam Map<String, Object> map, @RequestParam String sq_passwd, @RequestParam int prod_num, @ModelAttribute ShopQnADTO dto , BindingResult result) {
		if(result.hasErrors()) {}//항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
		
		//회원 정보 세션에서 꺼내기
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//tem.out.println("문의등록 멤버넘버" + mem_num);
		dto.setMem_num(mem_num);
		
		//tem.out.println("비밀번호"+sq_passwd);
		//비밀번호 없다면 공개글(0), 비밀번호 있다면 비밀글(1)
		if(sq_passwd.length() == 0) {
			dto.setSq_secret(0);
		}else {
			dto.setSq_secret(1);
		}
		
		String upPath = session.getServletContext().getRealPath("/resources/img");
		session.setAttribute("upPath", upPath);
		for(int i=0; i<4; ++i) {
			String imgs = (String) map.get("imgs"+i);
			//tem.out.println(imgs);
			if(imgs == null) break; //받아온 이미지가 더 없으면 for문 나가기
			
			byte[] imageData = Base64.decodeBase64(imgs.getBytes()); //디코딩
			String fileName = UUID.randomUUID().toString() + ".png"; //랜덤이름 생성
			
			if(i==0) dto.setSq_img1(fileName);
			if(i==1) dto.setSq_img2(fileName);
			if(i==2) dto.setSq_img3(fileName);
			if(i==3) dto.setSq_img4(fileName);
			
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
		
		//insert
		int res = shopMapper.insertQnA(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "상품 문의가 등록되었습니다. 확인 후 답변드리겠습니다😄");
			mav.addObject("url", "shop_view4.do?prod_num="+prod_num);//shop_mypage_reviewList.do?mode=all&sort=all
		}else {
			mav.addObject("msg", "상품 문의 등록 실패! 파일 업로드 성공! 상품 문의등록 페이지로 이동합니다.");
			mav.addObject("url", "shop_insertQnA.do");
		}
		return mav;
	}	
	
	private void setMem_num(int mem_num) {
		// TODO Auto-generated method stub
		
	}

	//쇼핑몰 상품상세 4.QnA
		@RequestMapping("/shop_view4.do")
		public ModelAndView view4Shop(HttpServletRequest req, @RequestParam Map<String, Integer> params, @RequestParam int prod_num) {
			ModelAndView mav = new ModelAndView("shop/shop_view4");
			
			//위쪽 상품상세 꺼내기
			ShopProductDTO pdto = shopMapper.getProd(prod_num);
			mav.addObject("getProd", pdto);
			
			//리뷰 별점 평균
			int count = shopMapper.shopviewReviewCount(prod_num);
			if(count != 0) {
				int reviewAvg = shopMapper.reviewAvg(prod_num);
				//tem.out.println("리뷰별점평균"+reviewAvg);
				mav.addObject("reviewAvg", reviewAvg);
				mav.addObject("count", count);
			}

			// 회원정보를 위한 회원번호
			HttpSession session = req.getSession();
			int mem_num;
			MemberDTO dto = (MemberDTO) session.getAttribute("login_mem");
			if(dto == null) {
				mem_num = 0;
			}else {
				mem_num = dto.getMem_num();
				mav.addObject("mem_num", mem_num);//지울 예정
			}
							
			// 테마 가져오기
			List<ThemeDTO> tlist = adminGameMapper.listTheme();
			mav.addObject("listTheme", tlist);		
							
			//쿠폰 꺼내기
			List<ShopCouponDTO> clist = shopMyPageMapper.couponList();
			mav.addObject("couponList", clist);		
							
			// 내가 보유한 쿠폰
			if(dto != null) {
				List<ShopUserCouponDTO> list = shopMyPageMapper.myPageCoupon(dto.getMem_num());
				//tem.out.println("쿠폰리스트" + list);
				mav.addObject("myPageCoupon", list);
									
				// 안가지고 있는 쿠폰 리스트를 담을 그릇 list로 선언
				List<ShopCouponDTO> exlist = new ArrayList<>();
				exlist.addAll(clist);	// clist 복사해서 exlist 복사본 만들기
									
				for (ShopCouponDTO cdto : clist) {	// 전체 쿠폰 리스트 for문
					for(ShopUserCouponDTO udto : list) {	// 가지고 있는 쿠폰 리스트 for문
						if (cdto.getSc_num() == udto.getSc_num()) {
							exlist.remove(cdto);
						}
					}
				}
				mav.addObject("exlist", exlist);
			}
			
			// 해당 상품 찜 여부
			params.put("mem_num", mem_num);
			params.put("prod_num", prod_num);		
					
			ShopLikeDTO ldto = shopMapper.getUserLike(params);
			if(ldto != null) {	// size가 0보다 크면 빨간하트
				mav.addObject("like", 1);
			} else {					// 빈하트
				mav.addObject("like", 0);
			}		    

			// 상품 찜 개수
			int likeCount = shopMapper.prodLikeCount(prod_num);
			mav.addObject("likeCount", likeCount);				
			
		    //해당 상품 문의 꺼내기
		    mav.addObject("prod_num", prod_num);//있어야 페이징함
		    
			int pageSize = 5;
			String pageNum = req.getParameter("pageNum");
			if (pageNum == null) {
				pageNum = "1";
			}
			//tem.out.println(pageNum);		
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = startRow + pageSize - 1;
			//int count = shopMapper.shopviewQnACount(prod_num);
			//tem.out.println("리뷰개수"+count);
			if (endRow > count)
				endRow = count;
			params.put("start", startRow);
			params.put("end", endRow);
			params.put("prod_num", prod_num);
			List<ShopQnADTO> list = null;
			if (count > 0) {
				list = shopMapper.getViewQnA(params);
				//tem.out.println("문의리스트"+list);
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
				mav.addObject("getViewQnA", list);
			}
			int rowNum = count - (currentPage - 1) * pageSize;
			mav.addObject("rowNum", rowNum);
			
			return mav;	
		}
	//문의 상세 내용 꺼내기
	@RequestMapping("/shop_getQnA.do")
	public ModelAndView getQnA(@RequestParam int sq_num) {
		ModelAndView mav = new ModelAndView("shop/shop_view4");
		// QnA 구하기
		ShopQnADTO dto = shopMyPageMapper.getMyPageQnA(sq_num);
		mav.addObject("getQnA", dto);
		return mav;
	}
	
	//쇼핑몰 장바구니 추가
	@RequestMapping("/shop_insertCart.do")
	public ModelAndView shopInsertCart(HttpServletRequest req, @ModelAttribute ShopCartDTO dto, @RequestParam int prod_num, @RequestParam int cart_qty, BindingResult result) {
		if(result.hasErrors()) {}//항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
		
		//회원 정보 세션에서 꺼내기
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//tem.out.println("쇼핑몰 장바구니 멤버넘버" + mem_num);
		dto.setMem_num(mem_num);
		
		ModelAndView mav = new ModelAndView("message");
		
		//이미 카트에 등록된 데이터가 있다면!
	   	List<ShopCartDTO> listCart = shopMapper.listCart(mem_num);
	   	for(ShopCartDTO cdto : listCart) {
			if (cdto.getProd_num() == prod_num) {
				//tem.out.println("여기 들어오냐구!!!"+cdto.getProd_num());
				cdto.setCart_qty(cdto.getCart_qty() + cart_qty);
				//수정된 cdto로 DB 업데이트해주기
				int res = shopMapper.updateCart(cdto);
				if(res>0) { //message말고 모달을 이용?????
					mav.addObject("msg", cart_qty + "개의 상품이 장바구니에 추가되었습니다.");
					mav.addObject("url", "shop_listCart.do?prod_num=" + prod_num);					
					return mav;
				}
			}
		}
	   	//카트에 새로 담는다면!
	   	int res = shopMapper.insertCart(dto);
		if(res>0) {
			mav.addObject("msg", cart_qty + "개의 상품을 장바구니에 담았습니다.");
			mav.addObject("url", "shop_listCart.do?prod_num=" + prod_num);
		}else {
			mav.addObject("msg", "장바구니 등록 실패! 상품 상세 페이지로 이동합니다.");
			mav.addObject("url", "shop_view.do?prod_num" + prod_num);
		}
		return mav;	   	
	}
	
	//쇼핑몰 장바구니 목록
	@RequestMapping("/shop_listCart.do")
	public ModelAndView shoplistCart(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/shop_listCart");
		
		// 테마 가져오기
	    List<ThemeDTO> tlist = adminGameMapper.listTheme();
	    mav.addObject("listTheme", tlist);	
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		
		int count = shopMapper.cartCount(mem_num);
		mav.addObject("mem_num", mem_num);
		mav.addObject("count", count);// 장바구니 개수
		List<ShopCartDTO> listCart = shopMapper.listCart(mem_num);
		mav.addObject("listCart", listCart);// 장바구니 목록

		return mav;
	}

	// 쇼핑몰 장바구니 수정
	@ResponseBody
	@RequestMapping("/shop_updateCart.do")
	public ModelAndView updateOkCart(HttpServletRequest req, @ModelAttribute ShopCartDTO dto, @RequestParam int cart_qty,
			@RequestParam int prod_num) {

		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();

		ModelAndView mav = new ModelAndView("shop/shop_listCart");
		List<ShopCartDTO> listCart = shopMapper.listCart(mem_num);
		int res = shopMapper.updateCart(dto);
		if (res > 0) {
			for (ShopCartDTO cdto : listCart) {
				if (cdto.getProd_num() == prod_num) {
					//tem.out.println("여기 들어오니?????" + cdto.getProd_num());
					cdto.setCart_qty(cart_qty);
					mav.addObject("listCart", listCart);
					return mav;
				}
			}
		} else {
			mav.addObject("msg", "장바구니 수량 수정 실패! 장바구니 목록 페이지로 이동합니다.");
			mav.addObject("url", "shop_listCart.do");
		}
		return mav;
	}	
	
	// 쇼핑몰 장바구니 삭제
	@ResponseBody
	@RequestMapping("/shop_deleteCart.do")
	public ModelAndView deleteCart(@RequestParam int cart_num, @RequestParam int prod_num) {
		//tem.out.println("여기오니????????");
		ModelAndView mav = new ModelAndView("message");

		int res = shopMapper.deleteCart(cart_num);
		//tem.out.println(res);
		if (res > 0) {
			mav.addObject("msg", "장바구니 상품이 삭제 되었습니다.");
			mav.addObject("url", "shop_listCart.do");
		}
		//tem.out.println(mav.getViewName());
		return mav;
	}

	// 쇼핑몰 장바구니 선택 삭제
	@RequestMapping("/shop_checkDeleteCart.do")
	public ModelAndView checkDeleteCart(@RequestParam(required = false, name = "checkCart") List<String> checkCart,
			@RequestParam int prod_num) {
		ModelAndView mav = new ModelAndView("message");

		// checkCart는 value값이 cart_num임
		if (checkCart == null) {
			// 선택된 장바구니 상품이 있다면
		} else if (checkCart.size() != 0) {
			for (String c : checkCart) {
				//tem.out.println("장바구니 체크박스 선택 삭제! 장바구니 번호는???" + c);
				shopMapper.deleteCart(Integer.parseInt(c));
			}
		}
		mav.addObject("msg", "선택된 상품이 장바구니에서 삭제 되었습니다.");
		mav.addObject("url", "shop_listCart.do?prod_num=" + prod_num);
		return mav;
	}

	// 쇼핑몰 주문서페이지
	@RequestMapping("/shop_viewOrder.do")
	public ModelAndView viewOrder(HttpServletRequest req, @RequestParam int prod_num, @RequestParam int cart_qty) {
		ModelAndView mav = new ModelAndView("shop/shop_order");
		mav.addObject("mode", "view");
		// 상품상세 꺼내기
		ShopProductDTO pdto = shopMapper.getProd(prod_num);
		mav.addObject("getProd", pdto);

		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		mav.addObject("mem_num", mem_num);

//		// 회원 정보(아임포트에 보낼 정보들)
//		//mav.addObject("game_name", order.jsp에서);
//		//mav.addObject("amount", order.jsp에서);
//		mav.addObject("mem_email", mdto.getMem_id());
//		mav.addObject("mem_name", mdto.getMem_name());
//		mav.addObject("mem_tel", mdto.getMem_hp1()+mdto.getMem_hp2()+mdto.getMem_hp3());
		
		// 로그인회원 보유 쿠폰 전체 리스트
		List<ShopUserCouponDTO> listCoupon = shopMyPageMapper.myPageCoupon(mem_num);
		//tem.out.println("쿠폰리스트" + listCoupon);
		mav.addObject("myCoupon", listCoupon);
		int coupon_count = shopMyPageMapper.getCoupon(mem_num);
		mav.addObject("myCouponCount", coupon_count);

		// 포인트
		mav.addObject("getTotalPoint", shopMapper.userPointTotal(mem_num));
		
		// 상품 상세페이지에서 [주문하기] 클릭
		mav.addObject("cart_qty", cart_qty);
		mav.addObject("prod_num", prod_num);

		return mav;

	}

	// 쇼핑몰 주문서페이지
	@RequestMapping("/shop_cartOrder.do")
	public ModelAndView cartOrder(HttpServletRequest req,
			@RequestParam(required = false, name = "checkCart") List<String> checkCart,
			@RequestParam Map<String, String> params, @RequestParam Map<String, Integer> params2) {
		ModelAndView mav = new ModelAndView("shop/shop_order");
		mav.addObject("mode", "cart");

		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		mav.addObject("mem_num", mem_num);

//		// 회원 정보(아임포트에 보낼 정보들)
//		//mav.addObject("game_name", order.jsp에서);
//		//mav.addObject("amount", order.jsp에서);
//		mav.addObject("mem_email", mdto.getMem_id());
//		mav.addObject("mem_name", mdto.getMem_name());
//		mav.addObject("mem_tel", mdto.getMem_hp1()+mdto.getMem_hp2()+mdto.getMem_hp3());

		
		// 로그인회원 보유 쿠폰 전체 리스트
		List<ShopUserCouponDTO> listCoupon = shopMyPageMapper.myPageCoupon(mem_num);
		//tem.out.println("쿠폰리스트" + listCoupon);
		mav.addObject("myCoupon", listCoupon);
		int coupon_count = shopMyPageMapper.getCoupon(mem_num);
		mav.addObject("myCouponCount", coupon_count);

		// 포인트
		int getTotalPoint =shopMapper.userPointTotal(mem_num); 
		//tem.out.println(getTotalPoint);
		mav.addObject("getTotalPoint", getTotalPoint);
		
		// 장바구니페이지에서 [주문하기] 클릭
		if (checkCart == null) {
			mav.addObject("msg", "선택된 상품이 없습니다.");
			mav.addObject("url", "shop_listCart.do");
			mav.addObject("mem_num", mem_num);
			mav.setViewName("message");
			//tem.out.println("???주문서 여기 들어왔나???" + mem_num);
		} else if (checkCart.size() > 0) {
			params2.put("mem_num", mem_num);
			List<ShopCartDTO> getCartList = new ArrayList<ShopCartDTO>();
			for (String c : checkCart) {// 각 상품들의 장바구니 번호
				params2.put("cart_num", Integer.parseInt(c));

				ShopCartDTO getCartOrder = shopMapper.getCartOrder(params2);
				getCartList.add(getCartOrder);
			}
			mav.addObject("getCartList", getCartList);
		}
		return mav;
	}

	// 쇼핑몰 주문페이지 - 배송지 관리
	@RequestMapping("/shop_listDel.do")
	public ModelAndView listDel(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("shop/shop_listDel");

		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		mav.addObject("mem_num", mem_num);
		
		// 회원의 배송지목록과 배송지개수
		List<ShopDeliveryDTO> dlist = shopMapper.listDel(mem_num);
		mav.addObject("myDel", dlist);
		int del_count = shopMapper.shopDelCount(mem_num);
		mav.addObject("myDelCount", del_count);
		//tem.out.println(dlist);
		return mav;
	}

	// 쇼핑몰 주문페이지 - 새 배송지 추가 버튼 누르면
	@RequestMapping(value = "/shop_insertDel.do", method = RequestMethod.GET)
	public ModelAndView insertDel() {
		return new ModelAndView("shop/shop_insertDel");
	}

	// 쇼핑몰 주문페이지 - 새 배송지 추가
	@RequestMapping(value = "/shop_insertDel.do", method = RequestMethod.POST)
	public ModelAndView insertOkDel(HttpServletRequest req, @ModelAttribute ShopDeliveryDTO dto, BindingResult result) {
		if (result.hasErrors()) {
		} // 항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.

		ModelAndView mav = new ModelAndView("message");

		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		dto.setMem_num(mem_num);

		// 배송지 등록
		int res = shopMapper.insertDel(dto);

		if (res > 0) {
			mav.addObject("msg", "〔 " + dto.getDel_title() + " 〕 배송지가 추가 되었습니다.");
			mav.setViewName("message_close");
		} else {
			mav.addObject("msg", "");
			mav.addObject("url", "");
		}

		return mav;
	}
	
	// 쇼핑몰 주문페이지 - 배송지 관리 - 수정
	@RequestMapping(value="/shop_updateDel.do", method=RequestMethod.GET)
	public ModelAndView updateDel(@RequestParam int del_num) {
		ShopDeliveryDTO dto = shopMapper.getDelivery(del_num);
		return new ModelAndView("shop/shop_updateDel", "getDelivery", dto);
	}
	
	// 쇼핑몰 주문페이지 - 배송지 관리 - 수정처리
	@RequestMapping(value="/shop_updateDel.do", method=RequestMethod.POST)
	public ModelAndView updateOkDel(HttpServletRequest req, @ModelAttribute ShopDeliveryDTO dto, BindingResult result) {
		if(result.hasErrors()) {}		
		
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		dto.setMem_num(mem_num);
		
		int res = shopMapper.updateDel(dto);
		ModelAndView mav = new ModelAndView("message");
		if(res>0) {
			mav.addObject("msg", "수정되었습니다.");
			mav.addObject("url", "shop_listDel.do");
		}else {
			mav.addObject("msg", "수정 실패! 배송지 목록 페이지로 이동합니다.");
			mav.addObject("url", "shop_listDel.do");
		}
		return mav;
	}	
	
	// 쇼핑몰 주문페이지 - 배송지 관리 - 삭제
	@RequestMapping("/shop_deleteDel.do")
	public ModelAndView deleteDel(HttpServletRequest req, @RequestParam Map<String, String> params) {
		// 상품 삭제
		int res = shopMapper.deleteDel(Integer.parseInt(params.get("del_num")));
				
		ModelAndView mav = new ModelAndView("message");
				
		if(res>0) {		
				mav.addObject("msg", "삭제되었습니다.");
				mav.addObject("url", "shop_listDel.do");
		}else {
			mav.addObject("msg", "삭제 실패! 메인 페이지로 이동합니다.");
			mav.addObject("url", "shop_main.do");
		}
		return mav;
	}

	@RequestMapping("/shop_getDel.do")
	public ModelAndView getDel(@RequestParam int del_num) {
		// 배송지 정보 꺼내서 세팅
		ShopDeliveryDTO dto = shopMapper.getDelivery(del_num);
		return new ModelAndView("closeWindow", "getDelivery", dto);
	}
	
	// 결제 테스트
	@RequestMapping("/test.do")
	public String test() {
		return "shop/NewFile";
	}
	
	// 쇼핑몰 결제하기
	@RequestMapping(value="/shop_finishOrder.do", method=RequestMethod.POST)
	public ModelAndView shopfinishOrder(HttpServletRequest req, @RequestParam Map<Object, Object> params,@RequestParam Map<String, Integer> iparams,
			@ModelAttribute ShopPointHistoryDTO phdto, @ModelAttribute ShopUserCouponDTO uscdto,
			@ModelAttribute ShopOrderDTO odto, @ModelAttribute ShopOrderDetailDTO oddto, BindingResult result) {
			
		if (result.hasErrors()) {} // 항상 바인딩 에러 발생할 수 밖에 없음. 처리할 건 딱히 없음.
			 
		ModelAndView mav = new ModelAndView("shop/shop_main");
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//tem.out.println(mem_num+"아작스~~~~~~~~~~");

		phdto.setMem_num(mem_num);	// 포인트 테이블
		uscdto.setMem_num(mem_num);	// 회원 쿠폰 테이블
//		ddto.setMem_num(mem_num);	// 배송지 테이블
		odto.setMem_num(mem_num);	// 주문 테이블

		// 바로구매 주문결제 () ======================================
		String mode = (String) params.get("mode");
		if (mode.equals("view")) {
			// 1. 포인트 적립
			phdto.setPoint_type((String) params.get("view_point_type_save"));//+적립
			phdto.setPoint_content((String) params.get("view_point_content_save"));//적립내용
			String s = (String) params.get("view_savePoint");
			phdto.setPoint_amount(Integer.parseInt(s));
			phdto.setPoint_total(shopMapper.userPointTotal(mem_num) + phdto.getPoint_amount());
			shopMapper.pointOrder(phdto);
			
			// 2. 주문서
			// 주문 상세 등록을 위해서 order 등록 즉시 order_num 가져오기
			int order_num_Seq = shopMapper.order_num_Seq();
			odto.setOrder_num(order_num_Seq);
			odto.setOrder_price(Integer.parseInt((String)params.get("view_order_price")));
//tem.out.println(odto.getOrder_coupon()+"쿠폰 사용금액???????????");
//tem.out.println(odto.getOrder_point()+"포인트 사용금액???????????");
			odto.setOrder_receiptprice(odto.getOrder_price() - odto.getOrder_coupon() - odto.getOrder_point());
			shopMapper.insertOrder(odto);
			// 주문 상세내용 등록
			oddto.setOrder_num(order_num_Seq);
			String prod_num = (String) params.get("prod_num");
			oddto.setProd_num(Integer.parseInt(prod_num));
			shopMapper.insertOrderDetail(oddto);
			
			// 3. 상품 수량 수정
			//String prod_num = (String) params.get("prod_num");
			String detail_qty = (String) params.get("detail_qty");
			ShopProductDTO pdto = shopMapper.getProd(Integer.parseInt(prod_num));
			int prod_qty = pdto.getProd_qty() - Integer.parseInt(detail_qty);//상품 수량 - 주문수량
			pdto.setProd_qty(prod_qty);
			shopMapper.updateProd(pdto);		
		}
			
		// 장바구니 주문결제(mem_num, cart_num) ======================================
		if (mode.equals("cart")) {		
			// Point History 등록 : view페이지에서 적립(type '+', content '적립')  
			if(params.get("savePoint") != null) {
			phdto.setPoint_type((String) params.get("point_type_save"));//+적립
			phdto.setPoint_content((String) params.get("point_content_save"));//적립내용
			//tem.out.println(params.get("savePoint"));
			String s = (String) params.get("savePoint");
			phdto.setPoint_amount(Integer.parseInt(s));//적립포인트
			phdto.setPoint_total(shopMapper.userPointTotal(mem_num) + phdto.getPoint_amount());//최종 포인트
			shopMapper.pointOrder(phdto);
			}
			
			// Order 등록 (Detail 등록을 위해서 order 등록 즉시 order_num 가져오기)
			int order_num_Seq = shopMapper.order_num_Seq();
			odto.setOrder_num(order_num_Seq);
			//tem.out.println(odto.getOrder_coupon()+"쿠폰 사용금액???????????");
			//tem.out.println(odto.getOrder_point()+"포인트 사용금액???????????");
			odto.setOrder_receiptprice(odto.getOrder_price() - odto.getOrder_coupon() - odto.getOrder_point());
			shopMapper.insertOrder(odto);
			
			// Order Detail 등록 (주문 상세내용)
			oddto.setOrder_num(order_num_Seq);
			String c = (String)params.get("c");
			for(int i = 1; i<Integer.parseInt(c); i++) {
				String prod_num = (String) params.get("prod_num"+i);
				String detail_qty = (String) params.get("detail_qty"+i);
				oddto.setProd_num(Integer.parseInt(prod_num));
				oddto.setDetail_qty(Integer.parseInt(detail_qty));
				shopMapper.insertOrderDetail(oddto);
			}				
			
			// Product 수량 수정 - game_num view페이지에서 보내야함!
			for(int i = 1; i<Integer.parseInt(c); i++) {
				String prod_num = (String) params.get("prod_num"+i);
				String detail_qty = (String) params.get("detail_qty"+i);
				//tem.out.println("상품번호 왔심?"+prod_num);
				ShopProductDTO pdto = shopMapper.getProd(Integer.parseInt(prod_num));
				int prod_qty = pdto.getProd_qty() - Integer.parseInt(detail_qty);//상품 수량 - 주문수량
				pdto.setProd_qty(prod_qty);
				//tem.out.println(prod_qty);
				shopMapper.updateProd(pdto);
			}
			
			// Cart 수량 수정/삭제 - game_num view페이지에서 보내야함!
			iparams.put("mem_num", mem_num);
			for(int i = 1; i<Integer.parseInt(c); i++) {
				String cart_num = (String)params.get("cart_num"+i);
				String detail_qty = (String) params.get("detail_qty"+i);
				//tem.out.println("장바구니번호 왔심?"+cart_num);
				iparams.put("cart_num", Integer.parseInt(cart_num));
				ShopCartDTO cdto = shopMapper.getCartOrder(iparams);
				//tem.out.println("왜 안뺌?"+cdto.getCart_qty());
				//tem.out.println("장바구니빼라구!!!"+Integer.parseInt(detail_qty));
				int qty = cdto.getCart_qty() - Integer.parseInt(detail_qty);
				if(qty == 0) {
					shopMapper.deleteCart(Integer.parseInt(cart_num));
				}
				cdto.setCart_qty(qty);
				shopMapper.updateCart(cdto);
			}			
		}
		
		// Point History 등록 : view페이지에서 사용(type '-', content '사용')
		if(odto.getOrder_point() > 0) {
		phdto.setPoint_type((String) params.get("point_type_use"));//-사용
		phdto.setPoint_content((String) params.get("point_content_use"));//사용내용
		
		phdto.setPoint_amount(odto.getOrder_point());
		//tem.out.println(shopMapper.userPointTotal(mem_num) - odto.getOrder_point() +"총포인트??????");
		//tem.out.println(odto.getOrder_point() +"총 전 사용 포인트~~~??????");
		phdto.setPoint_total(shopMapper.userPointTotal(mem_num) - odto.getOrder_point());
		shopMapper.pointOrder(phdto);
		}
//			String o = (String) params.get("order_point");//###,###
//			if(o.substring(o.length()-4).equals(",")) {
//				for(int i=5; i<=o.length(); i++) {
//					String point_amount = o.substring(o.length()-i,o.length()-4)+o.substring(o.length()-3);
//					phdto.setPoint_amount(Integer.parseInt(point_amount));//사용포인트
//					//tem.out.println(point_amount);
//				}
//				phdto.setPoint_total(shopMapper.userPointTotal(mem_num) - phdto.getPoint_amount());//최종 포인트
//			}
			
		// User Scoupon 삭제
		String usc_num = (String) params.get("usc_num");
		//tem.out.println(usc_num+"쿠폰 사용 성공???????????");
		if(usc_num != null) {
			uscdto.setUsc_num(Integer.parseInt(usc_num));
			shopMapper.deleteUserCoupon(Integer.parseInt(usc_num));
		}
//		// Delivery 등록
//		ddto.setDel_name((String) params.get("order_name"));
//		ddto.setDel_address2((String) params.get("order_address1"));
//		ddto.setDel_address2((String) params.get("order_address2"));
//		ddto.setDel_address2((String) params.get("order_address3"));
//		ddto.setDel_hp((String) params.get("order_hp"));
//		shopMapper.insertDel(ddto);
		
		return mav;
	}
	
	@RequestMapping("/shop_orderDetail.do")
	public ModelAndView s(HttpServletRequest req, @RequestParam int order_num, @RequestParam Map<String, Integer> params) {
		ModelAndView mav = new ModelAndView("shop/shop_orderDetail");
		// 회원정보를 위한 회원번호
		HttpSession session = req.getSession();
		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
		int mem_num = mdto.getMem_num();
		//tem.out.println(mem_num+"회원번호.......................!");
				
		// 회원의 전체 주문 목록과 주문 개수
		List<ShopOrderDetailDTO> listOD = shopMapper.listOrderDetail(order_num);
		mav.addObject("listOrderDetail", listOD);
		
		// 회원의 주문 상세 내역
		params.put("mem_num", mem_num);
		//tem.out.println(mem_num+"엥"+order_num +"장바구니 상세 배송정보랑 결제정보 왜~~~");
		params.put("order_num", order_num);
		List<ShopOrderDTO> list = shopMapper.listOrderDetailView(params);
		mav.addObject("listOrderDetailView", list);
		
		return mav;
	}
	
//	// 쇼핑몰 주문 완료 페이지
//	@RequestMapping(value="/shop_finishOrder.do", method=RequestMethod.POST)
//	public ModelAndView shopfinishOrder(HttpServletRequest req, @ModelAttribute ShopOrderDTO odto) {	
//		ModelAndView mav = new ModelAndView("shop/shop_finishOrder");
//		mav.addObject("mode", "cart");
//
//		// 회원정보를 위한 회원번호
//		HttpSession session = req.getSession();
//		MemberDTO mdto = (MemberDTO) session.getAttribute("login_mem");
//		int mem_num = mdto.getMem_num();
//		mav.addObject("mem_num", mem_num);
//
////		// 회원 정보(아임포트에 보낼 정보들)
////		//mav.addObject("game_name", order.jsp에서);
////		//mav.addObject("amount", order.jsp에서);
////		mav.addObject("mem_email", mdto.getMem_id());
////		mav.addObject("mem_name", mdto.getMem_name());
////		mav.addObject("mem_tel", mdto.getMem_hp1()+mdto.getMem_hp2()+mdto.getMem_hp3());
//
//		
//		// 로그인회원 보유 쿠폰 전체 리스트
//		List<ShopUserCouponDTO> listCoupon = shopMyPageMapper.myPageCoupon(mem_num);
//		//tem.out.println("쿠폰리스트" + listCoupon);
//		mav.addObject("myCoupon", listCoupon);
//		int coupon_count = shopMyPageMapper.getCoupon(mem_num);
//		mav.addObject("myCouponCount", coupon_count);
//
//		// 포인트
//		mav.addObject("getTotalPoint", shopMapper.userPointTotal(mem_num));
//		//밑에처럼 하면 max값이 최종포인트가 됨 이렇게하면 안됨 
//		//mav.addObject("getTotalPoint", shopMyPageMapper.getTotalPoint(mem_num));
//		
//		// 장바구니페이지에서 [주문하기] 클릭
//		if (checkCart == null) {
//			mav.addObject("msg", "선택된 상품이 없습니다.");
//			mav.addObject("url", "shop_listCart.do");
//			mav.addObject("mem_num", mem_num);
//			mav.setViewName("message");
//			//tem.out.println("???주문서 여기 들어왔나???" + mem_num);
//		} else if (checkCart.size() > 0) {
//			params2.put("mem_num", mem_num);
//			List<ShopCartDTO> getCartList = new ArrayList<ShopCartDTO>();
//			for (String c : checkCart) {// 각 상품들의 장바구니 번호
//				params2.put("cart_num", Integer.parseInt(c));
//
//				ShopCartDTO getCartOrder = shopMapper.getCartOrder(params2);
//				getCartList.add(getCartOrder);
//			}
//			mav.addObject("getCartList", getCartList);
//		}
//		return mav;		
//	}
	
}