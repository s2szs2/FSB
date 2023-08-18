package com.ezen.FSB.dto;

public class AlarmDTO {
	private int mem_num; //멤 넘 
	private int alm_num;  // 알람 넘버 
	private String alm_cate; //알림 카테고리(쿠폰,친구,피드 등)
	private String alm_title; //알림 제목
	private String alm_content; //알림 내용 
	private String alm_regdate; //알림 생성 날짜
	private int alm_read;  //알림 읽음 여부 0은 안읽음 1은 읽음 
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getAlm_num() {
		return alm_num;
	}
	public void setAlm_num(int alm_num) {
		this.alm_num = alm_num;
	}
	public String getAlm_cate() {
		return alm_cate;
	}
	public void setAlm_cate(String alm_cate) {
		this.alm_cate = alm_cate;
	}
	public String getAlm_title() {
		return alm_title;
	}
	public void setAlm_title(String alm_title) {
		this.alm_title = alm_title;
	}
	public String getAlm_content() {
		return alm_content;
	}
	public void setAlm_content(String alm_content) {
		this.alm_content = alm_content;
	}
	public int getAlm_read() {
		return alm_read;
	}
	public void setAlm_read(int alm_read) {
		this.alm_read = alm_read;
	}
	public String getAlm_regdate() {
		return alm_regdate;
	}
	public void setAlm_regdate(String alm_regdate) {
		this.alm_regdate = alm_regdate;
	}
	

	
			
}
