package com.ezen.FSB.dto;

public class BoardFilesDTO {
	private int bf_num; //파일 넘버
	private int board_num; //게시글 넘버
	private String filename; // 파일이름
	private String savename; // uuid
	private int filesize; // 파일사이즈
	
	
	public int getBf_num() {
		return bf_num;
	}
	public void setBf_num(int bf_num) {
		this.bf_num = bf_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getSavename() {
		return savename;
	}
	public void setSavename(String savename) {
		this.savename = savename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	
	
}
