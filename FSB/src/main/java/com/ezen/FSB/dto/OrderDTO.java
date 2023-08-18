package com.ezen.FSB.dto;

public class OrderDTO { // 주문 DTO
	private int order_num;			// 주문 seq
	private int cart_num;			// 카트 seq
	private int mem_num;			// 주문자 seq
	private String order_address1;	// 배송지 우편
	private String order_address2;	// 배송지 기본
	private String order_address3;	// 배송지 상세
	private String order_memo;		// 배송 메모
	private int order_price;		// 총 금액
	private String order_payment;	// 구매 결제 방식
	private int order_coupon;		// 쿠폰 사용금액
	private int order_point;		// 포인트 사용 금액
	private int order_receiptprice;	// 최종 결제 금액
	private int order_progress;		// 구매 처리단계 (1. 구매 요청 2. 배송 준비 3. 배송중 4. 구매 확정)
	private String order_date;		// 구매일
	private int order_invoice;		// 운송장 번호(배송시작과 동시에 생성)
	
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getOrder_address1() {
		return order_address1;
	}
	public void setOrder_address1(String order_address1) {
		this.order_address1 = order_address1;
	}
	public String getOrder_address2() {
		return order_address2;
	}
	public void setOrder_address2(String order_address2) {
		this.order_address2 = order_address2;
	}
	public String getOrder_address3() {
		return order_address3;
	}
	public void setOrder_address3(String order_address3) {
		this.order_address3 = order_address3;
	}
	public String getOrder_memo() {
		return order_memo;
	}
	public void setOrder_memo(String order_memo) {
		this.order_memo = order_memo;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public String getOrder_payment() {
		return order_payment;
	}
	public void setOrder_payment(String order_payment) {
		this.order_payment = order_payment;
	}
	public int getOrder_coupon() {
		return order_coupon;
	}
	public void setOrder_coupon(int order_coupon) {
		this.order_coupon = order_coupon;
	}
	public int getOrder_point() {
		return order_point;
	}
	public void setOrder_point(int order_point) {
		this.order_point = order_point;
	}
	public int getOrder_receiptprice() {
		return order_receiptprice;
	}
	public void setOrder_receiptprice(int order_receiptprice) {
		this.order_receiptprice = order_receiptprice;
	}
	public int getOrder_progress() {
		return order_progress;
	}
	public void setOrder_progress(int order_progress) {
		this.order_progress = order_progress;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getOrder_invoice() {
		return order_invoice;
	}
	public void setOrder_invoice(int order_invoice) {
		this.order_invoice = order_invoice;
	}
	
	

}
