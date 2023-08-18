package com.ezen.FSB.dto;

public class SH_boardDTO { // 중고게시판
	private int board_num;  // 중고게시판 번호
	private int mem_num; // 멤버 번호 
	
	private String board_title; // 중고 게시글 제목
	private String board_regdate; // 작성일
	private String board_content; //내용
	private String board_ip; //ip
	private String board_readcount; // 조회수 
	
	private String board_img1; // 이미지
	private String board_img2;
	private String board_img3;
	private String board_img4;
	
	private int board_re_level; //답글
	private int board_re_step; 
	private int board_re_group;
	
	private int board_report; // 신고
	
	private String board_location; // 주소
	private String board_price; //가격
	private String board_package; //거래 방법
	private String board_condition; // 상태

	private String mem_nickname; // 닉네임 join용
	private String mem_img; // 테이블엔 없는 이미지 디티오

	public String getMem_img() {
		return mem_img;
	}
	public void setMem_img(String mem_img) {
		this.mem_img = mem_img;
	}
	private int board_replycount; // 해당 게시글 댓글 수 
	public int getBoard_replycount() {
		return board_replycount;
	}
	public void setBoard_replycount(int board_replycount) {
		this.board_replycount = board_replycount;
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
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(String board_regdate) {
		this.board_regdate = board_regdate;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_ip() {
		return board_ip;
	}
	public void setBoard_ip(String board_ip) {
		this.board_ip = board_ip;
	}
	public String getBoard_readcount() {
		return board_readcount;
	}
	public void setBoard_readcount(String board_readcount) {
		this.board_readcount = board_readcount;
	}
	public String getBoard_img1() {
		return board_img1;
	}
	public void setBoard_img1(String board_img1) {
		this.board_img1 = board_img1;
	}
	public String getBoard_img2() {
		return board_img2;
	}
	public void setBoard_img2(String board_img2) {
		this.board_img2 = board_img2;
	}
	public String getBoard_img3() {
		return board_img3;
	}
	public void setBoard_img3(String board_img3) {
		this.board_img3 = board_img3;
	}
	public String getBoard_img4() {
		return board_img4;
	}
	public void setBoard_img4(String board_img4) {
		this.board_img4 = board_img4;
	}
	public int getBoard_re_level() {
		return board_re_level;
	}
	public void setBoard_re_level(int board_re_level) {
		this.board_re_level = board_re_level;
	}
	public int getBoard_re_step() {
		return board_re_step;
	}
	public void setBoard_re_step(int board_re_step) {
		this.board_re_step = board_re_step;
	}
	public int getBoard_re_group() {
		return board_re_group;
	}
	public void setBoard_re_group(int board_re_group) {
		this.board_re_group = board_re_group;
	}
	public int getBoard_report() {
		return board_report;
	}
	public void setBoard_report(int board_report) {
		this.board_report = board_report;
	}
	public String getBoard_location() {
		return board_location;
	}
	public void setBoard_location(String board_location) {
		this.board_location = board_location;
	}
	public String getBoard_price() {
		return board_price;
	}
	public void setBoard_price(String board_price) {
		this.board_price = board_price;
	}
	public String getBoard_package() {
		return board_package;
	}
	public void setBoard_package(String board_package) {
		this.board_package = board_package;
	}
	public String getBoard_condition() {
		return board_condition;
	}
	public void setBoard_condition(String board_condition) {
		this.board_condition = board_condition;
	}
}
