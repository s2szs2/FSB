package com.ezen.FSB.dto;

public class TagDTO {
	private int game_num;			// 보드게임 등록 번호 (fk)
	private int theme_num;			// 테마 등록 번호 (fk)
	
	public int getGame_num() {
		return game_num;
	}
	
	public void setGame_num(int game_num) {
		this.game_num = game_num;
	}

	public int getTheme_num() {
		return theme_num;
	}

	public void setTheme_num(int theme_num) {
		this.theme_num = theme_num;
	}
	

}
