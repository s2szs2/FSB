package com.ezen.FSB.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.FSB.dto.BusinessCouponDTO;
import com.ezen.FSB.dto.BusinessCouponUserDTO;
import com.ezen.FSB.dto.BusinessProfileDTO;
import com.ezen.FSB.dto.BusinessReviewDTO;
import com.ezen.FSB.dto.MemberDTO;
import com.ezen.FSB.dto.ShopReviewDTO;


@Service
public class BusinessProfileMapper {

	@Autowired
	private SqlSession sqlSession;
	
	
	//비즈니스 프로필 불러오기 
		public BusinessProfileDTO BPlist(int mem_num) {
			return sqlSession.selectOne("BPlist",mem_num);
		}
	//만료날짜 쿠폰 삭제
		public int expireBcoupon() {
			return sqlSession.delete("expireBcoupon");
		}
	//비즈니스 쿠폰 불러오기
		public List<BusinessCouponDTO> getBC_bp(int bp_num) {
			return sqlSession.selectList("getBC_bp",bp_num);
		}
	//비즈니스 프로필 수정하기
		public int updateBP(BusinessProfileDTO dto) { 
			return sqlSession.update("updateBP",dto); 
		}
	// 쿠폰 등록
		public int insertBcoupon1(BusinessCouponDTO dto) { // 만료일 지정 O
			return sqlSession.insert("insertBcoupon1", dto);
		}
	// 쿠폰 등록
		public int insertBcoupon2(BusinessCouponDTO dto) { // 만료일 지정 X
			return sqlSession.insert("insertBcoupon2", dto);
		}
	//해당 매장 발급 쿠폰 수
		public int getCount(int bp_num) {
			return sqlSession.selectOne("getCountCoupon", bp_num);
		}
	// 쿠폰 삭제 (사장님)
		public int deleteBcoupon(int bc_num) {
			return sqlSession.delete("deleteBcoupon",bc_num) ;
		}
	//발급 쿠폰 갯수
		public int getCountBC(int bp_num) {
			return sqlSession.selectOne("getCountBC",bp_num);
		}
	//발급된 쿠폰 리스트(사장님 페이지)
		public List<BusinessCouponUserDTO> bcouponList(Map<String, Integer> params) {
			return sqlSession.selectList("bcouponList",params);
		}
	//쿠폰 사용처리
		public BusinessCouponUserDTO useBcoupon(Map<Object, Object> params) {
			return sqlSession.selectOne("useBcoupon",params);
		}
	//쿠폰 사용 취소 처리
		public BusinessCouponUserDTO cancelBCoupon(Map<Object, Object> params) {
			return sqlSession.selectOne("cancelBcoupon",params);
		}
//사용자 쿠폰 리스트 
		public List<BusinessCouponUserDTO> getBC_m(Map<String,Integer> params) {
			return sqlSession.selectList("getBC_m", params);
		}
	//쿠폰 발급받기위해 쿠폰정보 꺼내기
		public List<BusinessCouponDTO> getBC_bc(int bc_num) {
			return sqlSession.selectList("getBC_bc",bc_num);
		}
		//디티오
		public BusinessCouponDTO BClist_bc(int bc_num) {
			return sqlSession.selectOne("getBC_bc",bc_num);
		}
	//사용자 쿠폰 받기	
		public int getBCoupon(BusinessCouponUserDTO udto) {
			return sqlSession.insert("getBCoupon",udto);
		}
	//사용자가 쿠폰 발급시 수량 차감
		public int	minusQty(int bc_num) {
			return sqlSession.update("minusQty",bc_num);
		}
	//쿠폰 받은 사용자 정보	
		public List<MemberDTO> getMember_bc(Map<String,Integer> params) {
			return sqlSession.selectList("getMember_bc",params);
		}
	//쿠폰 받은 사용자 유무 체크 리스트
		public List<BusinessCouponUserDTO> listBCUser(int bc_num) {
			return sqlSession.selectList("listBCUser",bc_num);
		}
	//매장 번호로 비즈니스 프로필 불러오기 
		public BusinessProfileDTO getBP(int bp_num) {
			return sqlSession.selectOne("getBP", bp_num);
		}
	//매장 리뷰 갯수 카운트	
		public int b_reviewCount(int bp_num) {
			return sqlSession.selectOne("b_reviewCount", bp_num);
		}
	//매장 리뷰 리스트
		public List<BusinessReviewDTO> BPReviewList(Map<String, Integer> params) {
			return sqlSession.selectList("BPReviewList",params);
		}
	//별점 평점 내기 	
		public int b_reviewAvg(int bp_num) {
			return sqlSession.selectOne("b_reviewAvg", bp_num);
		}
	//매장 리뷰 작성 (사용자)
		public int insertBPReview(BusinessReviewDTO dto) {
			return sqlSession.insert("insertBPReview", dto);
		}
	//매장 리뷰 작성 후 매장 자체 별점 update
		public int setStarrating(Map<Object, Object> params1) {
			return sqlSession.update("setStarrating",params1);
		}
	//리뷰 상세보기
		public BusinessReviewDTO getBreview(int bpr_num) {
			return sqlSession.selectOne("getBreview", bpr_num);
		}
	//리뷰 삭제
		public int deleteBreview(int bpr_num) {
			return sqlSession.delete("deleteBreview", bpr_num);
		}
	//리뷰 수정	
		public int updateBreview(BusinessReviewDTO dto) {
			return sqlSession.update("updateBreview", dto);
		}
	//리뷰 게시 중단(사장님)
		public int blockReview(Map<String, Integer> params) {
			return sqlSession.update("blockReview", params);
		}
	//리뷰 게시 중단 해제 ( 사장님)
		public int unblockReview(Map<String, Integer> params) {
			return sqlSession.update("unblockReview", params);
		}
	
}
