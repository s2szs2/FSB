package com.ezen.FSB.dto;

public class BusinessCouponUserDTO {
	private int bp_num; //비즈니스 프로필 넘버
	private int mem_num; // 로그인한 멤버 넘버
	private int bc_num; // 비즈니스 쿠폰 넘버
	private int ubc_num; // 사용자가 가진 비즈니스 쿠폰 넘버 
	private String bc_title; // 쿠폰 제목
	private String bc_content; // 쿠폰 상세내용
	private String bc_duedate; // 쿠폰 유효기간
	private int bc_using; // 쿠폰 발급/사용 여부 null- 미발급 0-발급 1-사용완료
	private String mem_nickname; // 발급  리스트에 나타낼 회원 정보 join
	private String mem_hp3; // 번호 뒷자리 join
	

	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public String getMem_hp3() {
		return mem_hp3;
	}
	public void setMem_hp3(String mem_hp3) {
		this.mem_hp3 = mem_hp3;
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
	public int getBc_num() {
		return bc_num;
	}
	public void setBc_num(int bc_num) {
		this.bc_num = bc_num;
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
	public String getBc_duedate() {
		return bc_duedate;
	}
	public void setBc_duedate(String bc_duedate) {
		this.bc_duedate = bc_duedate;
	}
	public int getBc_using() {
		return bc_using;
	}
	public void setBc_using(int bc_using) {
		this.bc_using = bc_using;
	}
	public int getUbc_num() {
		return ubc_num;
	}
	public void setUbc_num(int ubc_num) {
		this.ubc_num = ubc_num;
	}
	
	
}
