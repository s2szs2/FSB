package com.ezen.FSB.dto;

public class RefundDTO { // 환불 DTO
	private int refund_num;			// 환불 seq
	private int order_num;			// 주문 seq
	private int mem_num;			// 환불신청회원 seq
	private String refund_date;		// 환불 요청일 (date)
	private int refund_progress;	// 환불 처리 단계 (1. 환불 요청 2. 환불 접수 3. 환불 처리중 4. 환불 완료)
	
	public int getRefund_num() {
		return refund_num;
	}
	public void setRefund_num(int refund_num) {
		this.refund_num = refund_num;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}
	public int getRefund_progress() {
		return refund_progress;
	}
	public void setRefund_progress(int refund_progress) {
		this.refund_progress = refund_progress;
	}
	
	

}
