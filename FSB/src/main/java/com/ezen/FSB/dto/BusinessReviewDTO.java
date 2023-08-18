package com.ezen.FSB.dto;

public class BusinessReviewDTO { // 보드게임 매장 리뷰 
	
	private int bpr_num; // 리뷰넘
	private int bp_num; //비즈니스 프로필 넘버
	private int mem_num; // 리뷰 등록 회원 넘버
	private int bpr_starrating; // 리뷰 별점
	private String bpr_img1; // 이미지
	private String bpr_img2;
	private String bpr_img3;
	private String bpr_img4;
	private String bpr_title; // 리뷰제목
	private String bpr_content; // 리뷰내용
	private String bpr_regdate; // 리뷰 작성일
	private int bpr_hide; // 매장 사장님이 리뷰 제한할 수 있게 하는 컬럼
	
	private String mem_nickname;
	
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public int getBpr_num() {
		return bpr_num;
	}
	public void setBpr_num(int bpr_num) {
		this.bpr_num = bpr_num;
	}
	public int getBp_num() {
		return bp_num;
	}
	public void setBp_num(int bp_num) {
		this.bp_num = bp_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getBpr_starrating() {
		return bpr_starrating;
	}
	public void setBpr_starrating(int bpr_starrating) {
		this.bpr_starrating = bpr_starrating;
	}
	public String getBpr_img1() {
		return bpr_img1;
	}
	public void setBpr_img1(String bpr_img1) {
		this.bpr_img1 = bpr_img1;
	}
	public String getBpr_img2() {
		return bpr_img2;
	}
	public void setBpr_img2(String bpr_img2) {
		this.bpr_img2 = bpr_img2;
	}
	public String getBpr_img3() {
		return bpr_img3;
	}
	public void setBpr_img3(String bpr_img3) {
		this.bpr_img3 = bpr_img3;
	}
	public String getBpr_img4() {
		return bpr_img4;
	}
	public void setBpr_img4(String bpr_img4) {
		this.bpr_img4 = bpr_img4;
	}
	public String getBpr_title() {
		return bpr_title;
	}
	public void setBpr_title(String bpr_title) {
		this.bpr_title = bpr_title;
	}
	public String getBpr_content() {
		return bpr_content;
	}
	public void setBpr_content(String bpr_content) {
		this.bpr_content = bpr_content;
	}
	public String getBpr_regdate() {
		return bpr_regdate;
	}
	public void setBpr_regdate(String bpr_regdate) {
		this.bpr_regdate = bpr_regdate;
	}
	public int getBpr_hide() {
		return bpr_hide;
	}
	public void setBpr_hide(int bpr_hide) {
		this.bpr_hide = bpr_hide;
	}

}
