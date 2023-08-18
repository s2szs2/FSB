package com.ezen.FSB.dto;

public class ShopProductDTO {
   private int prod_num;		//상품 번호
   private int game_num;		//보드게임 번호(foreign key)
   private String prod_img;		//상품 상세이미지
   private int prod_qty;		//상품 개수(장바구니와 구매시)
   private int prod_starrating;	//상품 리뷰별점
   private int prod_discount;	//상품 할인율
   private int prod_price;		//상품 가격
   private int prod_point;		//상품 적립금
   private int prod_delchar;	//상품 배송비
   private String prod_company;	//상품 판매사
   private String prod_regdate;	//상품 등록일

   // join 을 위한 멤버필드
   private String game_name;
   private String game_img;
   private String game_content;
   private int detail_qty;
   
   // 개수를 구하기 위한 멤버 필드
   private int sr_count;			// 리뷰 개수
   private int sl_count;			// 좋아요 개수
   private int prod_starratingAvg;	// 리뷰 평균
   
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
   public String getGame_name() {
      return game_name;
   }
   public void setGame_name(String game_name) {
      this.game_name = game_name;
   }
   
   public int getProd_discount() {
      return prod_discount;
   }
   public void setProd_discount(int prod_discount) {
      this.prod_discount = prod_discount;
   }
   public int getProd_num() {
      return prod_num;
   }
   public void setProd_num(int prod_num) {
      this.prod_num = prod_num;
   }
   public int getGame_num() {
      return game_num;
   }
   public void setGame_num(int game_num) {
      this.game_num = game_num;
   }
   public String getProd_img() {
      return prod_img;
   }
   public void setProd_img(String prod_img) {
      this.prod_img = prod_img;
   }
   public int getProd_qty() {
      return prod_qty;
   }
   public void setProd_qty(int prod_qty) {
      this.prod_qty = prod_qty;
   }
   public int getProd_starrating() {
      return prod_starrating;
   }
   public void setProd_starrating(int prod_starrating) {
      this.prod_starrating = prod_starrating;
   }
   public int getProd_price() {
      return prod_price;
   }
   public void setProd_price(int prod_price) {
      this.prod_price = prod_price;
   }
   public int getProd_point() {
      return prod_point;
   }
   public void setProd_point(int prod_point) {
      this.prod_point = prod_point;
   }
   public int getProd_delchar() {
      return prod_delchar;
   }
   public void setProd_delchar(int prod_delchar) {
      this.prod_delchar = prod_delchar;
   }
   public String getProd_company() {
      return prod_company;
   }
   public void setProd_company(String prod_company) {
      this.prod_company = prod_company;
   }
   public String getProd_regdate() {
      return prod_regdate;
   }
   public void setProd_regdate(String prod_regdate) {
      this.prod_regdate = prod_regdate;
   }
   public String getGame_content() {
      return game_content;
   }
   public void setGame_content(String game_content) {
      this.game_content = game_content;
   }
   public int getSr_count() {
	return sr_count;
   }
   public void setSr_count(int sr_count) {
	this.sr_count = sr_count;
   }
   public int getSl_count() {
	   return sl_count;
   }
   public void setSl_count(int sl_count) {
	   this.sl_count = sl_count;
   }
   public int getProd_starratingAvg() {
	   return prod_starratingAvg;
   }
   public void setProd_starratingAvg(int prod_starratingAvg) {
	   this.prod_starratingAvg = prod_starratingAvg;
   }
   
}