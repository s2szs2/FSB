package com.ezen.FSB.dto;

public class ThemeDTO {
	private int theme_num;			// 테마 등록 번호(pk)
	private String theme_name;		// 테마 이름
	private int feed_checked;
	
	public int getTheme_num() {
		return theme_num;
	}
	public void setTheme_num(int theme_num) {
		this.theme_num = theme_num;
	}
	public String getTheme_name() {
		return theme_name;
	}
	public void setTheme_name(String theme_name) {
		this.theme_name = theme_name;
	}
	public int getFeed_checked() {
		return feed_checked;
	}
	public void setFeed_checked(int feed_checked) {
		this.feed_checked = feed_checked;
	}
	
}
