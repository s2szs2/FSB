package com.ezen.FSB.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;

@Service
public class ShopMyPageMapper {
	@Autowired
	private SqlSession sqlSession;
	
	// 리뷰 리스트
	public List<ShopReviewDTO> myPageReview(Map<String, Integer> params) {
		return sqlSession.selectList("myPageReview", params);
	}
	
	// 리뷰 삭제
	public int deleteShopReview(int sr_num) {
		return sqlSession.delete("deleteShopReview", sr_num);
	}
	
	// 리뷰 가져오기
	public ShopReviewDTO getMyPageReview(int sr_num) {
		return sqlSession.selectOne("getMyPageReview", sr_num);
	}
	
	// 리뷰 수정
	public int updateMyPageReview(ShopReviewDTO dto) {
		return sqlSession.update("updateMyPageReview", dto);
	}
	
	// 페이지 번호를 위한 shopReviewCount
	public int shopReviewCount(int mem_num) {
		return sqlSession.selectOne("shopReviewCount", mem_num);
	}
	
	// 상품 문의 리스트
	public List<ShopQnADTO> myPageQnA(Map<String, Integer> params) {
		return sqlSession.selectList("myPageQnA", params);
	}
	
	// 페이지 번호를 위한 shopQnACount
	public int shopQnACount(int mem_num) {
		return sqlSession.selectOne("shopQnACount", mem_num);
	}
	
	// 상품 문의 가져오기
	public ShopQnADTO getMyPageQnA(int sq_num) {
		return sqlSession.selectOne("getMyPageQnA", sq_num);
	}
	
	// 상문 문의 삭제
	public int deleteShopQnA(int sq_num) {
		return sqlSession.delete("deleteShopQnA", sq_num);
	}
	
	public int updateMyPageQnA(ShopQnADTO dto) {
		return sqlSession.update("updateMyPageQnA", dto);
	}
	
	// 전체 쿠폰 리스트
	public List<ShopCouponDTO> couponList() {
		return sqlSession.selectList("couponList");
	}
	
	// 쿠폰 다운로드 (만료일이 지정 되어 있을 때)
	public int couponDownload(Map<String, Object> params) {
		return sqlSession.insert("couponDownload", params);
	}
	
	// 쿠폰 다운로드 (만료일이 지정 되어 있지 않을 때)
	public int couponDownload2(Map<String, Object> params) { 
		return sqlSession.insert("couponDownload2", params);
	}
	
	// 쿠폰 날짜 가져오기
	public String getCouponDate(int sc_num) {
		return sqlSession.selectOne("getCouponDate", sc_num);
	}
	
	// 내가 보유한 쿠폰 리스트
	public List<ShopUserCouponDTO> myPageCoupon(int mem_num) {
		return sqlSession.selectList("myPageCoupon", mem_num);
	}
	
	// 만료된 쿠폰 처리
	public int deleteCoupon() {
		return sqlSession.delete("deleteCoupon");
	}
	
	// 멤버 별 쿠폰 개수
	public int getCoupon(int mem_num) {
		return sqlSession.selectOne("getCoupon", mem_num);
	}
	
	// 멤버 별 첫 포인트 세팅
	public int memberPoint(ShopPointHistoryDTO dto) {
		return sqlSession.insert("memberPoint", dto);
	}
	
	// 리뷰 작성 시 포인트 적립
	public int reviewPoint(ShopPointHistoryDTO dto) {
		return sqlSession.insert("reviewPoint", dto);
	}
	
	// 멤버 별로 갖고있는 총 포인트
	public int getTotalPoint(int mem_num) {
		return sqlSession.selectOne("getTotalPoint", mem_num);
	}
	
	// 멤버 별로 포인트 내역
	public List<ShopPointHistoryDTO> MemPointList(int mem_num) {
		return sqlSession.selectList("MemPointList", mem_num);
	}
	
	// 카테고리 테마순
	public List<ShopProductDTO> shopCateFind(int theme_num) {
		return sqlSession.selectList("shopCateFind", theme_num);
	}
	
	// 카테고리 인원순
	public List<ShopProductDTO> shopCateFind2(int game_player) {
		return sqlSession.selectList("shopCateFind2", game_player);
	}
	
	// 카테고리 난이도순
	public List<ShopProductDTO> shopCateFind3(int game_level) {
		return sqlSession.selectList("shopCateFind3", game_level);
	}
	
	// 쇼핑몰 페이지 상품 20개씩 출력
	public List<ShopProductDTO> prodView20() {
		return sqlSession.selectList("prodView20");
	}
	
	// 쇼핑몰 페이지 상품 40개씩 출력
	public List<ShopProductDTO> prodView40() {
		return sqlSession.selectList("prodView40");
	}
		
	// 쇼핑몰 페이지 상품 60개씩 출력
	public List<ShopProductDTO> prodView60() {
		return sqlSession.selectList("prodView60");
	}
	
// !!!!!!!!!!!!!!!!!여기서 부터 추가	
	// 쇼핑몰 페이지 좋아요 개수
	public int ShopGetLikeCount(int prod_num) {
		return sqlSession.selectOne("ShopGetLikeCount", prod_num);
	}
	
	// 상세보기로 찾기(테마별)
	public List<ShopProductDTO> checkListProd1(int tag) {
		return sqlSession.selectList("checkListProd1", tag);
	}
	
	// 상세보기로 찾기(인원별)
	public List<ShopProductDTO> checkListProd2(int game_player) {
		return sqlSession.selectList("checkListProd2", game_player);
	}
	
	// 상세보기로 찾기(별점별)
	public List<ShopProductDTO> checkListProd3(int prod_starrating) {
		return sqlSession.selectList("checkListProd3", prod_starrating);
	}
}
