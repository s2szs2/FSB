package com.ezen.FSB.dto;

public class ShopLikeDTO {
	private int sl_num;		//쇼핑몰상품 좋아요번호
	private int prod_num;	//상품 번호(foreign key)
	private int mem_num;	//회원 번호(foreign key)
	
	// join 을 위한 멤버필드
	private int game_num;	//게임 번호
	private String game_name;
	private String game_img;
	private String prod_company;
	private int prod_price;
	private int prod_point;
	
	public int getSl_num() {
		return sl_num;
	}
	public void setSl_num(int sl_num) {
		this.sl_num = sl_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getGame_num() {
		return game_num;
	}
	public void setGame_num(int game_num) {
		this.game_num = game_num;
	}
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
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
}
