package com.ezen.FSB.dto;

public class ShopCouponDTO { // 쇼핑몰 쿠폰 - 관리자용
	private int sc_num;			// 쿠폰 넘버
	private String sc_name;		// 쿠폰 이름
	private String sc_type;		// 쿠폰 타입 (금액/비율)
	private int sc_discount;	// 쿠폰 할인율 (금액/비율)
	private String sc_regdate;	// 쿠폰 등록일 (관리자가 쿠폰을 등록한 일자)
	private String sc_duedate;	// 쿠폰 만료일 (not empty: 모든 사용자에게 공통되는 기한이 있는 경우 / empty : 사용자마다 기한이 다른 쿠폰의 경우)
	private int sc_min;			// 쿠폰 사용을 위한 최소 주문금액 (~원 이상 구매시)
	private int sc_limit;		// 타입 % 인 경우, 최대 ~원 할인 (할인 금액 제한)
	
	// jsp 만료일 표시를 위한
	private int sc_check;		// 만료일 7일전부터 1 로 표시 (일반 쿠폰 0)
	
	public int getSc_check() {
		return sc_check;
	}
	public void setSc_check(int sc_check) {
		this.sc_check = sc_check;
	}
	public int getSc_min() {
		return sc_min;
	}
	public void setSc_min(int sc_min) {
		this.sc_min = sc_min;
	}
	public int getSc_limit() {
		return sc_limit;
	}
	public void setSc_limit(int sc_limit) {
		this.sc_limit = sc_limit;
	}
	public int getSc_num() {
		return sc_num;
	}
	public void setSc_num(int sc_num) {
		this.sc_num = sc_num;
	}
	public String getSc_name() {
		return sc_name;
	}
	public void setSc_name(String sc_name) {
		this.sc_name = sc_name;
	}
	public String getSc_type() {
		return sc_type;
	}
	public void setSc_type(String sc_type) {
		this.sc_type = sc_type;
	}
	public int getSc_discount() {
		return sc_discount;
	}
	public void setSc_discount(int sc_discount) {
		this.sc_discount = sc_discount;
	}
	public String getSc_regdate() {
		return sc_regdate;
	}
	public void setSc_regdate(String sc_regdate) {
		this.sc_regdate = sc_regdate;
	}
	public String getSc_duedate() {
		return sc_duedate;
	}
	public void setSc_duedate(String sc_duedate) {
		this.sc_duedate = sc_duedate;
	}
	

}
