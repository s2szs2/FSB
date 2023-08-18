package com.ezen.FSB.dto;

public class ShopOrderDetailDTO{// 주문 상세 DTO
	private int detail_num;		// 주문 상세 seq
	private int order_num;		// 주문 seq
	private int prod_num;		// 상품 seq
	private int detail_qty;		// 주문 상세 수량
	
	// join 을 위한
	private String prod_company;
	private String game_name;
	private int prod_price;
	private String prod_img;
	private String game_img;
	private String order_address1;
	private String order_address2;
	private String order_address3;
	private String order_memo;
	private int order_price;
	private String order_payment;
	private int order_coupon;
	private int order_point;
	private int order_receiptprice;
	private int order_progress;
	private int order_date;
	private String order_invoice;
	private String order_hp;
	private String order_name;
	
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
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
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getDetail_num() {
		return detail_num;
	}
	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
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
	public int getOrder_receiptprice() {
		return order_receiptprice;
	}
	public void setOrder_receiptprice(int order_receiptprice) {
		this.order_receiptprice = order_receiptprice;
	}
	public int getOrder_point() {
		return order_point;
	}
	public void setOrder_point(int order_point) {
		this.order_point = order_point;
	}
	public int getOrder_progress() {
		return order_progress;
	}
	public void setOrder_progress(int order_progress) {
		this.order_progress = order_progress;
	}
	public int getOrder_date() {
		return order_date;
	}
	public void setOrder_date(int order_date) {
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

}
