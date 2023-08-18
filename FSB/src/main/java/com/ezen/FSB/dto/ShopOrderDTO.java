package com.ezen.FSB.dto;

public class ShopOrderDTO { // 주문 DTO
	private int order_num;			// 주문 seq
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
	private String order_invoice;	// 운송장 번호(배송시작과 동시에 생성)
	private String order_hp;		// 배송지 전화번호
	private String order_name;		// 수령자
	
	// join 을 위한
	private String mem_hp1;
	private String mem_hp2;
	private String mem_hp3;
	private int game_num;
	private String game_name;
	private String game_img;
	private int prod_num;
	private int prod_price;
	private int detail_num;
	private int detail_qty;
	
	// jsp 표현을 위한
	private String prod_img;
	private String prod_company;
	private String prod_name;
	private int prod_count;
	
	// 관리자 jsp 표시를 위해 (배송지 나누기)
	private String order_hp1;
	private String order_hp2;
	private String order_hp3;
	private String mem_id;
	private String mem_name;
	
	
	
	
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOrder_hp1() {
	   return order_hp1;
	}
	public void setOrder_hp1(String order_hp1) {
	   this.order_hp1 = order_hp1;
	}
	public String getOrder_hp2() {
	   return order_hp2;
	}
	public void setOrder_hp2(String order_hp2) {
	   this.order_hp2 = order_hp2;
	}
	public String getOrder_hp3() {
	   return order_hp3;
	}
	public void setOrder_hp3(String order_hp3) {
	   this.order_hp3 = order_hp3;
	}
	
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getMem_hp1() {
		return mem_hp1;
	}
	public void setMem_hp1(String mem_hp1) {
		this.mem_hp1 = mem_hp1;
	}
	public String getMem_hp2() {
		return mem_hp2;
	}
	public void setMem_hp2(String mem_hp2) {
		this.mem_hp2 = mem_hp2;
	}
	public String getMem_hp3() {
		return mem_hp3;
	}
	public void setMem_hp3(String mem_hp3) {
		this.mem_hp3 = mem_hp3;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
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
	public String getOrder_invoice() {
		return order_invoice;
	}
	public void setOrder_invoice(String order_invoice) {
		this.order_invoice = order_invoice;
	}
	public String getOrder_hp() {
		return order_hp;
	}
	public void setOrder_hp(String order_hp) {
		this.order_hp = order_hp;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public int getDetail_qty() {
		return detail_qty;
	}
	public void setDetail_qty(int detail_qty) {
		this.detail_qty = detail_qty;
	}
	public String getGame_img() {
		return game_img;
	}
	public void setGame_img(String game_img) {
		this.game_img = game_img;
	}
	public String getProd_company() {
		return prod_company;
	}
	public void setProd_company(String prod_company) {
		this.prod_company = prod_company;
	}
	public int getGame_num() {
		return game_num;
	}
	public void setGame_num(int game_num) {
		this.game_num = game_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public int getDetail_num() {
		return detail_num;
	}
	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_count() {
		return prod_count;
	}
	public void setProd_count(int prod_count) {
		this.prod_count = prod_count;
	}
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}

	

}
