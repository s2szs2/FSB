package com.ezen.FSB.dto;

public class Board_replyDTO { // 자유, 익명 게시판 댓글
	private int br_num; // 댓글 넘
	private String br_content; // 댓글 내용
	private String br_regdate; // 댓글 작성일
	private int br_re_level; // 대댓글 
	private int br_re_step;
	private int br_re_group;
	
	private int br_report; // 댓글 신고
	
	private int board_num; // 댓글 달린 게싯글 번호
	private int mem_num; // 멤넘
	
	private String mem_nickname; //join용 닉네임
	private String mem_img; // 테이블엔 없는 이미지 디티오

	public String getMem_img() {
		return mem_img;
	}
	public void setMem_img(String mem_img) {
		this.mem_img = mem_img;
	}
	
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getBr_re_level() {
		return br_re_level;
	}
	public void setBr_re_level(int br_re_level) {
		this.br_re_level = br_re_level;
	}
	public int getBr_num() {
		return br_num;
	}
	public void setBr_num(int br_num) {
		this.br_num = br_num;
	}
	public String getBr_content() {
		return br_content;
	}
	public void setBr_content(String br_content) {
		this.br_content = br_content;
	}
	public String getBr_regdate() {
		return br_regdate;
	}
	public void setBr_regdate(String br_regdate) {
		this.br_regdate = br_regdate;
	}
	public int getBr_re_step() {
		return br_re_step;
	}
	public void setBr_re_step(int br_re_step) {
		this.br_re_step = br_re_step;
	}
	public int getBr_re_group() {
		return br_re_group;
	}
	public void setBr_re_group(int br_re_group) {
		this.br_re_group = br_re_group;
	}
	public int getBr_report() {
		return br_report;
	}
	public void setBr_report(int br_report) {
		this.br_report = br_report;
	}
	
}
