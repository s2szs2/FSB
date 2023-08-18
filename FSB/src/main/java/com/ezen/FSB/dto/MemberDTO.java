package com.ezen.FSB.dto;

public class MemberDTO {

	private int mem_num; //회원 번호
	private String mem_id; //회원 아이디
	private String mem_passwd; // 회원 비밀번호
	private String mem_name; //회원 이름
	private String mem_nickname;  //회원 닉네임
	private String mem_mode;  //회원 모드(개인/사업자)
	private String mem_join;  // 가입신청대기(개인1/사업자2)
	private int mem_report;  //회원 신고 누적 횟수
	private String mem_img; //회원 프로필 이미지
	private String mem_regdate;  //회원 가입일
	
	private String mem_hp1; //회원 핸드폰 첫번호
	private String mem_hp2; //회원 핸드폰 가운데번호
	private String mem_hp3; //회원 핸드폰 끝 번호
	
	private String mem_sel_agree; //선택동의
	
	private int mem_count;// 로그인시 마다 방문횟수 +1
	
	//배지
	private String badge_king;
	private String badge_write;
	private String badge_1004;
	private String badge_good;
	private String badge_rich;
	
	//배지설정
	private String badge_king_2;
	private String badge_write_2;
	private String badge_1004_2;
	private String badge_good_2;
	private String badge_rich_2;
	
	//태그 목록
	private String tag_1;
	private String tag_2;
	private String tag_3;
	private String tag_4;
	private String tag_5;
	private String tag_6;
	private String tag_7;
	private String tag_8;
	
	
	private int bc_using; // 비즈니스 쿠폰 사용 확인용
	
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_passwd() {
		return mem_passwd;
	}
	public void setMem_passwd(String mem_passwd) {
		this.mem_passwd = mem_passwd;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public String getMem_mode() {
		return mem_mode;
	}
	public void setMem_mode(String mem_mode) {
		this.mem_mode = mem_mode;
	}
	public String getMem_join() {
		return mem_join;
	}
	public void setMem_join(String mem_join) {
		this.mem_join = mem_join;
	}
	public int getMem_report() {
		return mem_report;
	}
	public void setMem_report(int mem_report) {
		this.mem_report = mem_report;
	}
	public String getMem_img() {
		return mem_img;
	}
	public void setMem_img(String mem_img) {
		this.mem_img = mem_img;
	}
	public String getMem_regdate() {
		return mem_regdate;
	}
	public void setMem_regdate(String mem_regdate) {
		this.mem_regdate = mem_regdate;
	}
	
	public String getMem_hp1() {
		return mem_hp1;
	}
	public void setMem_hp1(String mem_hp1) {
		this.mem_hp1 = mem_hp1;
	}
	public String getMem_hp2() {
		return mem_hp2;
	}
	public void setMem_hp2(String mem_hp2) {
		this.mem_hp2 = mem_hp2;
	}
	public String getMem_hp3() {
		return mem_hp3;
	}
	public void setMem_hp3(String mem_hp3) {
		this.mem_hp3 = mem_hp3;
	}
	
	public String getAllHp() {
		if(mem_hp1==null) return "전화없음";
		return mem_hp1+mem_hp2+mem_hp3;
	}
	
	public String getMem_sel_agree() {
		return mem_sel_agree;
	}
	public void setMem_sel_agree(String mem_sel_agree) {
		this.mem_sel_agree = mem_sel_agree;
	}

	public int getBc_using() {
		return bc_using;
	}
	public void setBc_using(int bc_using) {
		this.bc_using = bc_using;
	}
	public int getMem_count() {
		return mem_count;
	}
	public void setMem_count(int mem_count) {
		this.mem_count = mem_count;
	}
	public String getBadge_king() {
		return badge_king;
	}
	public void setBadge_king(String badge_king) {
		this.badge_king = badge_king;
	}
	public String getBadge_write() {
		return badge_write;
	}
	public void setBadge_write(String badge_write) {
		this.badge_write = badge_write;
	}
	public String getBadge_1004() {
		return badge_1004;
	}
	public void setBadge_1004(String badge_1004) {
		this.badge_1004 = badge_1004;
	}
	public String getBadge_good() {
		return badge_good;
	}
	public void setBadge_good(String badge_good) {
		this.badge_good = badge_good;
	}
	public String getBadge_rich() {
		return badge_rich;
	}
	public void setBadge_rich(String badge_rich) {
		this.badge_rich = badge_rich;
	}
	public String getBadge_king_2() {
		return badge_king_2;
	}
	public void setBadge_king_2(String badge_king_2) {
		this.badge_king_2 = badge_king_2;
	}
	public String getBadge_write_2() {
		return badge_write_2;
	}
	public void setBadge_write_2(String badge_write_2) {
		this.badge_write_2 = badge_write_2;
	}
	public String getBadge_1004_2() {
		return badge_1004_2;
	}
	public void setBadge_1004_2(String badge_1004_2) {
		this.badge_1004_2 = badge_1004_2;
	}
	public String getBadge_good_2() {
		return badge_good_2;
	}
	public void setBadge_good_2(String badge_good_2) {
		this.badge_good_2 = badge_good_2;
	}
	public String getBadge_rich_2() {
		return badge_rich_2;
	}
	public void setBadge_rich_2(String badge_rich_2) {
		this.badge_rich_2 = badge_rich_2;
	}
	public String getTag_1() {
		return tag_1;
	}
	public void setTag_1(String tag_1) {
		this.tag_1 = tag_1;
	}
	public String getTag_2() {
		return tag_2;
	}
	public void setTag_2(String tag_2) {
		this.tag_2 = tag_2;
	}
	public String getTag_3() {
		return tag_3;
	}
	public void setTag_3(String tag_3) {
		this.tag_3 = tag_3;
	}
	public String getTag_4() {
		return tag_4;
	}
	public void setTag_4(String tag_4) {
		this.tag_4 = tag_4;
	}
	public String getTag_5() {
		return tag_5;
	}
	public void setTag_5(String tag_5) {
		this.tag_5 = tag_5;
	}
	public String getTag_6() {
		return tag_6;
	}
	public void setTag_6(String tag_6) {
		this.tag_6 = tag_6;
	}
	public String getTag_7() {
		return tag_7;
	}
	public void setTag_7(String tag_7) {
		this.tag_7 = tag_7;
	}
	public String getTag_8() {
		return tag_8;
	}
	public void setTag_8(String tag_8) {
		this.tag_8 = tag_8;
	}

}
