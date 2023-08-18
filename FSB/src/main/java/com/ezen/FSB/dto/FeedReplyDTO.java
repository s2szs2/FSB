package com.ezen.FSB.dto;

public class FeedReplyDTO {
	private int fr_num;
	private int fr_re_group;
	private int fr_re_step;
	private int fr_re_level;
	private int feed_num;
	private int mem_num;
	private String fr_content;
	private int fr_report;
	private String fr_regdate;
	private String fr_open;
	
	//join용 멤버필드
	private String mem_id; //회원 아이디
	private String mem_nickname; //회원 닉네임
	
	private String prof_img;
	private String prof_open;
	private String prof_hide;
	
	private int friend_num;
	private String friend_accept;
	
	private String visible; //보이는지 여부 //ok, no
	
	public int getFr_num() {
		return fr_num;
	}
	public void setFr_num(int fr_num) {
		this.fr_num = fr_num;
	}
	public int getFr_re_group() {
		return fr_re_group;
	}
	public void setFr_re_group(int fr_re_group) {
		this.fr_re_group = fr_re_group;
	}
	public int getFr_re_step() {
		return fr_re_step;
	}
	public void setFr_re_step(int fr_re_step) {
		this.fr_re_step = fr_re_step;
	}
	public int getFr_re_level() {
		return fr_re_level;
	}
	public void setFr_re_level(int fr_re_level) {
		this.fr_re_level = fr_re_level;
	}
	public int getFeed_num() {
		return feed_num;
	}
	public void setFeed_num(int feed_num) {
		this.feed_num = feed_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getFr_content() {
		return fr_content;
	}
	public void setFr_content(String fr_content) {
		this.fr_content = fr_content;
	}
	public int getFr_report() {
		return fr_report;
	}
	public void setFr_report(int fr_report) {
		this.fr_report = fr_report;
	}
	public String getFr_regdate() {
		return fr_regdate;
	}
	public void setFr_regdate(String fr_regdate) {
		this.fr_regdate = fr_regdate;
	}
	public String getFr_open() {
		return fr_open;
	}
	public void setFr_open(String fr_open) {
		this.fr_open = fr_open;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public String getProf_img() {
		return prof_img;
	}
	public void setProf_img(String prof_img) {
		this.prof_img = prof_img;
	}
	public String getProf_open() {
		return prof_open;
	}
	public void setProf_open(String prof_open) {
		this.prof_open = prof_open;
	}
	public String getProf_hide() {
		return prof_hide;
	}
	public void setProf_hide(String prof_hide) {
		this.prof_hide = prof_hide;
	}
	public int getFriend_num() {
		return friend_num;
	}
	public void setFriend_num(int friend_num) {
		this.friend_num = friend_num;
	}
	public String getFriend_accept() {
		return friend_accept;
	}
	public void setFriend_accept(String friend_accept) {
		this.friend_accept = friend_accept;
	}
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
	
}
