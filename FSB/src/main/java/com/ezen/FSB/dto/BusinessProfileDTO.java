package com.ezen.FSB.dto;

public class BusinessProfileDTO { // 비즈니스 프로필 

	private int mem_num; //멤넘
	private int bp_num; // 비즈니스 프로필 넘버
	private String bp_location; // 매장 주소
	private String bp_d_location; // 매장 상세주소
	private String bp_info; // 매장 안내
	private int bp_starrating; // 매장 별점
	private String bp_store_name; // 매장 상호명
	private String bp_tel; // 매장 번호
	
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getBp_location() {
		return bp_location;
	}
	public void setBp_location(String bp_location) {
		this.bp_location = bp_location;
	}
	
	public String getBp_d_location() {
		return bp_d_location;
	}
	public void setBp_d_location(String bp_d_location) {
		this.bp_d_location = bp_d_location;
	}
	
	public int getBp_num() {
		return bp_num;
	}
	public void setBp_num(int bp_num) {
		this.bp_num = bp_num;
	}
	public String getBp_info() {
		return bp_info;
	}
	public void setBp_info(String bp_info) {
		this.bp_info = bp_info;
	}
	public int getBp_starrating() {
		return bp_starrating;
	}
	public void setBp_starrating(int bp_starrating) {
		this.bp_starrating = bp_starrating;
	}
	public String getBp_store_name() {
		return bp_store_name;
	}
	public void setBp_store_name(String bp_store_name) {
		this.bp_store_name = bp_store_name;
	}
	public String getBp_tel() {
		return bp_tel;
	}
	public void setBp_tel(String bp_tel) {
		this.bp_tel = bp_tel;
	}
	
}
