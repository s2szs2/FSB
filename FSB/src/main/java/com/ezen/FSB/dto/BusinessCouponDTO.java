package com.ezen.FSB.dto;

public class BusinessCouponDTO { //비즈니스 쿠폰 dto

	private int bc_num; // 쿠폰 넘버
	private int bc_qty; // 쿠폰 수량
	private String bc_title; // 쿠폰 제목
	private String bc_content; // 쿠폰 내용
	private String bc_regdate; // 작성일
	private String bc_duedate; // 쿠폰 만료일
	
	private int bp_num; // 비즈니스 프로필 넘버
	private int mem_num; // 회원 번호
	
	
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
	public int getBc_num() {
		return bc_num;
	}
	public void setBc_num(int bc_num) {
		this.bc_num = bc_num;
	}
	public int getBc_qty() {
		return bc_qty;
	}
	public void setBc_qty(int bc_qty) {
		this.bc_qty = bc_qty;
	}
	public String getBc_title() {
		return bc_title;
	}
	public void setBc_title(String bc_title) {
		this.bc_title = bc_title;
	}
	public String getBc_content() {
		return bc_content;
	}
	public void setBc_content(String bc_content) {
		this.bc_content = bc_content;
	}
	public String getBc_regdate() {
		return bc_regdate;
	}
	public void setBc_regdate(String bc_regdate) {
		this.bc_regdate = bc_regdate;
	}
	public String getBc_duedate() {
		return bc_duedate;
	}
	public void setBc_duedate(String bc_duedate) {
		this.bc_duedate = bc_duedate;
	}
	
	
	
}
