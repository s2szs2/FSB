package com.ezen.FSB.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.GameDTO;
import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopOrderDTO;
import com.ezen.FSB.dto.ShopOrderDetailDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopRefundDTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;

@Service
public class AdminShopMapper { // 쇼핑몰
	
	@Autowired
	private SqlSession sqlSession;

		// 상품 목록
		public List<ShopProductDTO> listProd(){
			return sqlSession.selectList("adminListProd");
		}
		// 상품 꺼내기
		public ShopProductDTO getProd(int prod_num) {
			return sqlSession.selectOne("adminGetProd", prod_num);
		}
		// 상품의 별점 총합
		public int getProdStar(int prod_num) {
			return sqlSession.selectOne("adminGetProdStar", prod_num);
		}
		// 상품의 리뷰 수
		public int getProdReviewCount(int prod_num) {
			return sqlSession.selectOne("adminGetProdReviewCount", prod_num);
		}
		// 리뷰의 이미지 꺼내기
		public ShopReviewDTO getProdReviewImg(int sr_num) {
			return sqlSession.selectOne("adminGetProdReviewImg", sr_num);
		}
		// 상품 등록
		public List<GameDTO> listNotProdGame(){
			return sqlSession.selectList("adminNotProdGameList");
		}
		public int insertProd(ShopProductDTO dto) {
			return sqlSession.insert("adminInsertProd", dto);
		}
		// 상품 수정
		public int updateProd(ShopProductDTO dto) {
			return sqlSession.update("adminUpdateProd", dto);
		}
		// 상품 삭제
		public int deleteProd(int prod_num) {
			return sqlSession.delete("adminDeleteProd", prod_num);
		}
		// 상품 찾기
		public List<ShopProductDTO> findProdGameName(String searchString){
			return sqlSession.selectList("adminFindGameName", searchString);
		}
		public List<ShopProductDTO> findProdCompany(String searchString){
			return sqlSession.selectList("adminFindProdCompany", searchString);
		}
		// 상품 정렬
		public List<ShopProductDTO> sortProd(String sort){
			if(sort.equals("name_asc")) {
				return sqlSession.selectList("adminSortProd1");
			}else if(sort.equals("name_desc")) {
				return sqlSession.selectList("adminSortProd2");
			}else if(sort.equals("price_asc")) {
				return sqlSession.selectList("adminSortProd3");
			}else if(sort.equals("price_desc")) {
				return sqlSession.selectList("adminSortProd4");
			}else if(sort.equals("dis_asc")) {
				return sqlSession.selectList("adminSortProd5");
			}else if(sort.equals("dis_desc")) {
				return sqlSession.selectList("adminSortProd6");
			}else if(sort.equals("regdate_asc")) {
				return sqlSession.selectList("adminSortProd7");
			}else {
				return sqlSession.selectList("adminSortProd8");
			}
		}
		// 상품 관련 리뷰 목록
		public List<ShopReviewDTO> listProdReview(int prod_num){
			return sqlSession.selectList("adminGetProdReview", prod_num);
		}
		// 쿠폰 목록
		public List<ShopCouponDTO> listScoupon(){
			return sqlSession.selectList("adminListScoupon");
		}
		// 쿠폰 만료일 다가온 목록
		public List<ShopCouponDTO> sortScoupon(){
			return sqlSession.selectList("adminSortScoupon");
		}
		// 만료일 지난 쿠폰 삭제
		public int deleteScouponDuedate() {
			return sqlSession.delete("adminDeleteScouponDuedate");
		}
		// 쿠폰 등록
		public int insertScoupon1(ShopCouponDTO dto) { // 만료일 지정 O
			return sqlSession.insert("adminInsertScoupon1", dto);
		}
		// 쿠폰 등록
		public int insertScoupon2(ShopCouponDTO dto) { // 만료일 지정 X
			return sqlSession.insert("adminInsertScoupon2", dto);
		}
		// 쿠폰 삭제
		public int deleteScoupon(int sc_num) {
			return sqlSession.delete("adminDeleteScoupon", sc_num);
		}
		// 해당 쿠폰을 가지고 있는 사용자 목록
		public List<ShopUserCouponDTO> listUsc(int sc_num){
			return sqlSession.selectList("adminListUsc", sc_num);
		}
		// 쇼핑몰 문의 내역
		public List<ShopQnADTO> listShopQnA(){
			return sqlSession.selectList("adminShopQnaList");
		}
		// 쇼핑몰 문의 내역 미처리 꺼내기
		public List<ShopQnADTO> listShopQnACheck(){
			return sqlSession.selectList("adminShopQnaListCheck");
		}
		// 쇼핑몰 문의 내역 꺼내기
		public ShopQnADTO getShopQnA(int sq_num) {
			return sqlSession.selectOne("adminShopQnaGet", sq_num);
		}
		// 쇼핑몰 문의 내역 답변달기
		public int shopQnaReply(ShopQnADTO dto) {
			return sqlSession.update("adminShopQnaReply", dto);
		}
		// 쇼핑몰 문의 내역 답변 삭제
		public int shopQnaReplyDel(int sq_num) {
			return sqlSession.update("adminShopQnaReplyDel", sq_num);
		}
		// 쇼핑몰 문의 내역 체크
		public int shopQnaReplyCheck(java.util.Map<String, Integer> params) {
			return sqlSession.update("adminShopQnaReplyCheck", params);
		}
		// 전체 상품 리뷰 목록 정렬
		public List<ShopReviewDTO> totalShopReview(){ // 기본(날짜 최근순)
			return sqlSession.selectList("adminTotalShopReview");
		}
		// 전체 상품 리뷰 목록 정렬
		public List<ShopReviewDTO> totalShopReview2(){ // 별점 낮은순
			return sqlSession.selectList("adminTotalShopReview2");
		}
		// 전체 상품 리뷰 목록 정렬
		public List<ShopReviewDTO> totalShopReview3(){ // 별점 높은순
			return sqlSession.selectList("adminTotalShopReview3");
		}
		// 전체 상품 리뷰 목록 - 상세보기
		public ShopReviewDTO totalGetShopReview(int sr_num) {
			return sqlSession.selectOne("adminTotalGetShopReview", sr_num);
		}
		// 주문내역
		public List<ShopOrderDTO> shopRefundList1(){
			return sqlSession.selectList("adminShopRefundList1");
		}
		// 주문내역
		public List<ShopOrderDTO> shopOrderList0(){
			return sqlSession.selectList("adminShopOrderList0");
		}
		public List<ShopOrderDTO> shopOrderList1(){
			return sqlSession.selectList("adminShopOrderList1");
		}
		public List<ShopOrderDTO> shopOrderList2(){
			return sqlSession.selectList("adminShopOrderList2");
		}
		public List<ShopOrderDTO> shopOrderList3(){
			return sqlSession.selectList("adminShopOrderList3");
		}
		public List<ShopOrderDTO> shopOrderList4(){
			return sqlSession.selectList("adminShopOrderList4");
		}
		// 주문내역 - 상세보기
		public ShopOrderDTO getShopOrder(int order_num) {
			return sqlSession.selectOne("adminGetShopOrder", order_num);
		}
		// 주문내역 - 수정
		public int updateShopOrder(ShopOrderDTO dto) {
			return sqlSession.update("adminUpdateShopOrder", dto);
		}
		// 해당 주문 상세내역 가져오기
		public List<ShopOrderDetailDTO> listOrderDetail(int order_num){
			return sqlSession.selectList("adminGetOrderDetail", order_num);
		}
		// 매출 내역
		public int sumSales(int month) {
			int res = 0;
			if(month == 1) {
				res = sqlSession.selectOne("adminSumSales01");
			}else if(month ==2) {
				res = sqlSession.selectOne("adminSumSales02");
			}else if(month ==3) {
				res = sqlSession.selectOne("adminSumSales03");
			}else if(month ==4) {
				res = sqlSession.selectOne("adminSumSales04");
			}else if(month ==5) {
				res = sqlSession.selectOne("adminSumSales05");
			}else if(month ==6) {
				res = sqlSession.selectOne("adminSumSales06");
			}else if(month ==7) {
				res = sqlSession.selectOne("adminSumSales07");
			}else if(month ==8) {
				res = sqlSession.selectOne("adminSumSales08");
			}else if(month ==9) {
				res = sqlSession.selectOne("adminSumSales09");
			}else if(month ==10) {
				res = sqlSession.selectOne("adminSumSales10");
			}else if(month ==11) {
				res = sqlSession.selectOne("adminSumSales11");
			}else {
				res = sqlSession.selectOne("adminSumSales12");
			}
			return res;
		}
		// 매출 순위
		public List<Map<String, Object>> rankSales(){
			return sqlSession.selectList("adminRankSales");
		}
		// 재고 순 상품 목록
		public List<ShopProductDTO> listInventory(){
			return sqlSession.selectList("adminListInventory");
		}
		// 재고 5개 미만 상품 수
		public int checkInventory() {
			return sqlSession.selectOne("adminCheckInventory");
		}
		// 재고 등록
		public int insertInventory(ShopProductDTO dto) {
			return sqlSession.update("adminInsertInventory", dto);
		}
		// 재고 수정
		public int updateInventory(ShopProductDTO dto) {
			return sqlSession.update("adminUpdateInventory", dto);
		}
//		// 환불 요청
//		public List<ShopRefundDTO> listRefund(int refund_progress){
//			return sqlSession.selectList("adminRefundList", refund_progress);
//		}
//		// 환불 상세보기
//		public ShopRefundDTO getRefund(int refund_num) {
//			return sqlSession.selectOne("adminGetRefund", refund_num);
//		}
//		// 환불 내역 수정
//		public int updateRefund(ShopRefundDTO dto) {
//			return sqlSession.update("adminUpdateRefund", dto);
//		}
		// 주문 내역 찾기
		public List<ShopOrderDTO> findOrder(String search, String searchString){
			if(search.equals("mem_name")) { // 주문자 NAME
				return sqlSession.selectList("adminFindOrderName", searchString);
			}else { //  주문자 ID
				return sqlSession.selectList("adminFindOrderID", searchString);
			}
		}
		// 환불 내역 찾기
//		public List<ShopRefundDTO> findRefund(String search, String searchString){
//			if(search.equals("mem_name")) { // 신청자 NAME
//				return sqlSession.selectList("adminFindRefundName", searchString);
//			}else { //  신청자 ID
//				return sqlSession.selectList("adminFindRefundID", searchString);
//			}
//		}
		// 상품 좋아요 수
		public int getProdLike(int prod_num) {
			return sqlSession.selectOne("adminGetProdLike", prod_num);
		}
		// 환불 승인
		public int refundOk(int order_num) {
			return sqlSession.update("adminRefundOk", order_num);
		}
}
