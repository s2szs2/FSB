package com.ezen.FSB.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.ShopPointHistoryDTO;
import com.ezen.FSB.dto.ShopCartDTO;
import com.ezen.FSB.dto.ShopCouponDTO;
import com.ezen.FSB.dto.ShopDeliveryDTO;
import com.ezen.FSB.dto.ShopLikeDTO;
import com.ezen.FSB.dto.ShopOrderDTO;
import com.ezen.FSB.dto.ShopOrderDetailDTO;
import com.ezen.FSB.dto.ShopProductDTO;
import com.ezen.FSB.dto.ShopQnADTO;
import com.ezen.FSB.dto.ShopReviewDTO;
import com.ezen.FSB.dto.ShopUserCouponDTO;

@Service
public class ShopMapper {
	@Autowired
	private SqlSession sqlSession;
	
	//상품 검색
	public List<ShopProductDTO> findProd(String search, String searchString){
		Map<String, String> params = new HashMap<>();
		params.put("search", search);
		params.put("searchString", searchString);
		return sqlSession.selectList("findProd", params);
	}
	//인기상품 목록, 상품상세
	public ShopProductDTO getProd(int prod_num) {
		return sqlSession.selectOne("getProd", prod_num);
	}
	//전체상품 목록
	public List<ShopProductDTO> listProd(){
		return sqlSession.selectList("listProd");
	}
	//전체상품 이름순 정렬
	public List<ShopProductDTO> sortProd1(String sort){
		return sqlSession.selectList("sortProd1", sort);
	}
	//전체상품 최신순 정렬
	public List<ShopProductDTO> sortProd2(String sort){
		return sqlSession.selectList("sortProd2", sort);
	}	
	//상품상세페이지(view1, view2, view3, view4)-------------------------------------------
	
	//상품상세 리뷰 별점 평균
	public int reviewAvg(int prod_num) {
		return sqlSession.selectOne("shopReviewAvg", prod_num);
	}
	//상품상세 찜하기 등록
	public int prodLike(ShopLikeDTO dto) {
		return sqlSession.insert("shopInsertLike", dto);
	}
	//상품상세 찜하기 삭제
	public int deleteLike(Map<String, Integer> params) {
		return sqlSession.delete("shopDeleteLike", params);
	}
	//상품상세 찜 개수
	public int prodLikeCount(int prod_num) {
		return sqlSession.selectOne("shopProdLikeCount", prod_num);
	}
	//상품상세 찜한 회원
	public ShopLikeDTO getUserLike(Map<String, Integer> params) {
		return sqlSession.selectOne("shopGetProdLike", params);
	}
	//찜한 상품 목록(회원의 찜 목록)
	public List<ShopLikeDTO> listLike(int mem_num){
		return sqlSession.selectList("shopListLike", mem_num);
	}	
	//찜한 상품 개수
	public int likeCount(int mem_num) {
		return sqlSession.selectOne("shopLikeCount", mem_num);
	}		
	
	//상품 리뷰 등록
	public int insertReview(ShopReviewDTO dto) {
		return sqlSession.insert("shopinsertReview", dto);
	}
	//상품 리뷰 전체목록(관리자한테 필요할듯?)
	public List<ShopReviewDTO> listReview() {
		return sqlSession.selectList("shoplistReview");
	}
	//상품 리뷰 개수 및 목록 페이지번호
	public int shopviewReviewCount(int prod_num) {
		return sqlSession.selectOne("shopviewReviewCount", prod_num);
	}
	//상품 리뷰 꺼내기(상품상세페이지에서 꺼내기)
	public List<ShopReviewDTO> getViewReview(java.util.Map<String, Integer> params) {
		return sqlSession.selectList("shopgetViewReview", params);
	}	
	//상품 리뷰 꺼내기(수정폼에서 씀)
	public ShopReviewDTO getReview(int sr_num) {
		return sqlSession.selectOne("shopgetReview", sr_num);
	}
	//상품 리뷰 꺼내기(메인페이지에 별점평균 나타내기위해 리뷰등록할때 씀)
	public List<ShopReviewDTO> getMainReview(int prod_num) {
		return sqlSession.selectList("shopGetMainReview", prod_num);
	}	
	//상품 리뷰 삭제
	public int deleteReview(int sr_num) {
		return sqlSession.delete("shopdeleteReview", sr_num);
	}
	//상품 리뷰 수정
	public int updateReview(ShopReviewDTO dto) {
		return sqlSession.update("shopupdateReview", dto);
	}
	//상품 문의 작성
	public int insertQnA(ShopQnADTO dto) {
		return sqlSession.insert("shopinsertQnA", dto);
	}
	//상품 문의 전체목록(관리자한테 필요할듯?)
	public List<ShopQnADTO> listQnA() {
		return sqlSession.selectList("shoplistQnA");
	}	
	//상품 문의 목록 페이지번호
	public int shopviewQnACount(int prod_num) {
		return sqlSession.selectOne("shopviewQnACount", prod_num);
	}
	//상품 문의 꺼내기(상품상세페이지에서 꺼내기)
	public List<ShopQnADTO> getViewQnA(java.util.Map<String, Integer> params) {
		return sqlSession.selectList("shopgetViewQnA", params);
	}		
	//상품 장바구니 등록
	public int insertCart(ShopCartDTO dto) {
		return sqlSession.insert("shopInsertCart", dto);
	}
	//상품 장바구니 목록(회원의 장바구니 목록)
	public List<ShopCartDTO> listCart(int mem_num){
		return sqlSession.selectList("shopListCart", mem_num);
	}
	//상품 장바구니 개수구하기
	public int cartCount(int mem_num) {
		return sqlSession.selectOne("shopCartCount", mem_num);
	}		
	//상품 장바구니 수정
	public int updateCart(ShopCartDTO dto) {
		return sqlSession.update("shopUpdateCart", dto);
	}
	//상품 장바구니 삭제
	public int deleteCart(int cart_num) {
		return sqlSession.delete("shopDeleteCart", cart_num);
	}
	//주문서페이지--------------------------------------------------------------------------
	//주문페이지 선택한 장바구니 상품 꺼내기
	public ShopCartDTO getCartOrder(Map<String, Integer> params){
		return sqlSession.selectOne("shopGetCartOrder", params);
	}
	//결제완료 시, 주문페이지 포인트 사용/적립 시 pointhistory 등록
	public int pointOrder(ShopPointHistoryDTO dto) {
		return sqlSession.insert("shopPointOrder", dto);
	}
	public int userPointTotal(int mem_num) {
		return sqlSession.selectOne("shopUserPointTotal", mem_num);
	}
	//결제완료 시, 주문페이지 적용된 쿠폰 삭제
	public int deleteUserCoupon(int usc_num) {
		return sqlSession.delete("shopDeleteUsc", usc_num);
	}	
	//결제완료 시, 상품 수량 변경
	public int updateProd(ShopProductDTO dto) {
		return sqlSession.update("shopUpdateProd", dto);
	}
	
	
	
	//결제완료 시 or 주문페이지 배송지관리 - 배송지 등록
	public int insertDel(ShopDeliveryDTO dto) {
		return sqlSession.insert("shopInsertDel", dto);
	}
	//주문페이지 배송지 목록
	public List<ShopDeliveryDTO> listDel(int mem_num){
		return sqlSession.selectList("shopListDel", mem_num);
	}
	//주문페이지 배송지 개수구하기
	public int shopDelCount(int mem_num) {
		return sqlSession.selectOne("shopDelCount", mem_num);
	}	
	//주문페이지 배송지 관리 - 삭제
	public int deleteDel(int del_num) {
		return sqlSession.delete("shopDeleteDel", del_num);
	}
	//주문페이지 배송지 관리 - 수정
	public int updateDel(ShopDeliveryDTO dto) {
		return sqlSession.update("shopUpdateDel", dto);
	}
	//주문페이지 배송지 관리 - 선택
	public ShopDeliveryDTO getDelivery(int del_num) {
		return sqlSession.selectOne("shopGetDel", del_num);
	}
	
	//주문페이지 주문 등록
	public int insertOrder(ShopOrderDTO dto) {
		return sqlSession.insert("shopInsertOrder", dto);
	}
	//detail 테이블에 바로 order_num 넣기 위함
	public int order_num_Seq() {
		return sqlSession.selectOne("shopOrderNum");
	}
	//주문페이지 주문 상세(주문번호/상품번호랑/개수) 등록
	public int insertOrderDetail(ShopOrderDetailDTO dto) {
		return sqlSession.insert("shopInsertOrderDetail", dto);
	}
	//주문 삭제
	public int deleteOrder(int order_num) {
		return sqlSession.delete("shopDeleteOrder", order_num);
	}
	//마이페이지 전체 주문 목록
	public List<ShopOrderDTO> listOrder(int mem_num){
		return sqlSession.selectList("shopListOrder", mem_num);
	}
	//마이페이지 전체 주문 목록에서 상세
	public List<ShopOrderDetailDTO> listOrderDetail(int order_num){
		return sqlSession.selectList("shopListOrderDetail", order_num);
	}	
	//마이페이지 주문 상세 내역
	public List<ShopOrderDTO> listOrderDetailView(Map<String, Integer> params){
		return sqlSession.selectList("shopListOrderDetailView", params);
	}
	//이미 작성된 리뷰랑 문의글 빼고 조회하기
	public List<ShopReviewDTO> listNotReview(int mem_num){
		return sqlSession.selectList("shopListNotReview", mem_num);
	}
	
	//회원 주문 개수구하기
	public int OrderCount(int mem_num) {
		return sqlSession.selectOne("shopOrderCount", mem_num);
	}		
	//주문 상세 꺼내서 
	public List<ShopOrderDetailDTO> getRefundOrder(int order_num) {
		return sqlSession.selectList("shopGetRefundOrder", order_num);
	}
	//마이페이지 주문 목록에서 [환불=전체 반품] 누르면 order_progress = -1
	public int updateOrder(ShopOrderDTO dto) {
		return sqlSession.update("shopUpdateOrder", dto);
	}
	//마이페이지 환불 내역
	public List<ShopOrderDTO> shopRefundList(){
		return sqlSession.selectList("shopRefundList");
	}
	
}
