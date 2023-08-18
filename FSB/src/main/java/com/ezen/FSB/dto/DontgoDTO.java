package com.ezen.FSB.dto;

public class DontgoDTO { // 탈퇴사유

	private String reason; // 탈퇴이유 1은 뭐 2는 뭐.. 쭉 9까지 
	private String nickname; // 탈퇴한 사람 닉네임 (아이디는, 개인정보니까..?ㅎ)
	private String regdate; //탈퇴 날짜
	
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	


}
