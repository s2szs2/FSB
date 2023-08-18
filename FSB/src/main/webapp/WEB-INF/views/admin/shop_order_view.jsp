<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_order_view.jsp // 쇼핑몰 주문내역 상세보기 -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
<script type="text/javascript">
	function updateOrder(){
		document.getElementById('order_address1').readOnly = false;
		document.getElementById('order_address2').readOnly = false;
		document.getElementById('order_address3').readOnly = false;
		document.getElementById('order_memo').readOnly = false;
		document.getElementById('order_payment').readOnly = false;
		document.getElementById('order_invoice').readOnly = false;
		document.getElementById('order_progress').disabled = false;
		
		var target = document.getElementById('btn1');
		var target2 = document.getElementById('btn2');
		var target3 = document.getElementById('btn3');
		var target4 = document.getElementById('btn4');
		
		target.disabled = true;
		target2.disabled = false;
		target3.disabled = false;
		target4.disabled = false;
	}
	
	function updateX(){
		var target = document.getElementById('btn1');
		var target2 = document.getElementById('btn2');
		var target3 = document.getElementById('btn3');
		var target4 = document.getElementById('btn4');
		
		target.disabled = false;
		target2.disabled = true;
		target3.disabled = true;
		target4.disabled = true;
		
		document.getElementById('order_address1').readOnly = true;
		document.getElementById('order_address2').readOnly = true;
		document.getElementById('order_address3').readOnly = true;
		document.getElementById('order_memo').readOnly = true;
		document.getElementById('order_payment').readOnly = true;
		document.getElementById('order_invoice').readOnly = true;
		document.getElementById('order_progress').disabled = true;
	}
	
	function check() {
		if (f2.order_address1.value == "" || f2.order_address2.value == "" || f2.order_address3.value == "") {
			alert("배송지를 입력해주세요!")
			return false
		}
		if (f2.order_memo.value == "") {
			alert("배송 메모를 입력해주세요!")
			f2.order_memo.focus()
			return false
		}
		if (f2.order_payment.value == "") {
			alert("결제 방식을 입력해주세요!")
			f2.order_payment.focus()
			return false
		}
		return true
	}
	
	function invoiceCheck(){
		window.open("admin_shop_invoice_check.do", "", "width=1000, height=500")
	}
	function viewProd(prod_num){
		window.open("admin_prod_view.do?prod_num="+prod_num, "", "width=1500, height=800")
	}
	
</script>	
	
	<p>
	<p>
	<div align="left">
		<form name="f2" action="admin_shop_order_update.do" method="post" onsubmit="return check()">
			<h6><strong>주문일 : </strong>${getOrder.order_date} 
				<c:if test="${getOrder.order_progress eq 0}"><button type="button" class="btn btn-secondary btn-sm" onclick="window.location='admin_shop_refund_ok.do?order_num=${getOrder.order_num}&mem_num=${getOrder.mem_num}'">환불 승인</button></c:if>
			</h6>
			<font size="2" color="red">구매확정 단계의 주문은 환불처리만 가능합니다</font>
			<h6><strong>주문 번호 : </strong>${getOrder.order_num}
			<input type="hidden" name="order_num" value="${getOrder.order_num}">
				<button class="btn btn-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    				주문 내역 보기
  				</button>
  			</h6>
				<div class="collapse" id="collapseExample">
				  <div class="card card-body">
					<table border="0">
						<tr align="center">
							<th>상품#</th>
							<th>상품명</th>
							<th>수량</th>
							<th>금액</th>
						</tr>
						<c:if test="${empty listOrder}">
							<tr align="center">
								<td colspan="4">
									주문 상세 내역이 없습니다.
								</td>
							</tr>
						</c:if>
						<c:if test="${not empty listOrder}">
							<c:forEach items="${listOrder}" var="odto">
								<tr align="center">
									<td><a href="javascript:viewProd('${odto.prod_num}')">${odto.prod_num}</a></td>
									<td>${odto.game_name}</td>
									<td>${df.format(odto.detail_qty)}</td>
									<td>${df.format(odto.prod_price * odto.detail_qty)}</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				  </div>
				</div>
			<h6><strong>주문자 번호 : </strong>${getOrder.mem_num}</h6>
			<h6><strong>주문자 연락처 : </strong>${getOrder.mem_hp1} - ${getOrder.mem_hp2} - ${getOrder.mem_hp3}</h6>
			<h6><strong>배송지 연락처 : </strong>${getOrder.order_hp1} - ${getOrder.order_hp2} - ${getOrder.order_hp3}</h6>
			<h6><strong>배송지 : </strong><br>
				&nbsp;우편 번호 : <input type="text" id="order_address1" name="order_address1" value="${getOrder.order_address1}" readOnly size="40"><br>
				&nbsp;기본 주소 : <input type="text" id="order_address2" name="order_address2" value="${getOrder.order_address2}" readOnly size="40"><br>
				&nbsp;상세 주소 : <input type="text" id="order_address3" name="order_address3" value="${getOrder.order_address3}" readOnly size="40">
			</h6>
			<h6><strong>배송 메모 : </strong><br><input type="text" id="order_memo" name="order_memo" value="${getOrder.order_memo}" readOnly size="50"></h6>
			<h6><strong>주문 금액 : </strong>${df.format(getOrder.order_price)}</h6>
			<h6><strong>결제 방식 : </strong><input type="text" id="order_payment" name="order_payment" value="${getOrder.order_payment}" readOnly></h6>
			<h6><strong>할인 금액 : </strong>${df.format(getOrder.order_price - getOrder.order_receiptprice)}</h6>
			<%-- <h6><strong>쿠폰 사용 : </strong>${getOrder.order_coupon}</h6>
			<h6><strong>포인트 사용 : </strong>${getOrder.order_point}</h6> --%>
			<h6><strong>결제 금액 : </strong>${df.format(getOrder.order_receiptprice)}</h6>
			<h6><strong>처리 단계 : </strong>
				<select id="order_progress" name="order_progress" class="form-select" disabled>
					<%-- <c:if test="${getOrder.order_progress eq 0}">
						<option value="0" selected>입금대기</option>
						<option value="1">구매요청</option>
						<option value="2">배송준비</option>
						<option value="3">배송중</option>
						<option value="4">구매확정</option>
					</c:if> --%>
					<c:if test="${getOrder.order_progress eq 1}">
						<!-- <option value="0">입금대기</option> -->	
						<option value="1" selected>구매요청</option>
						<option value="2">배송준비</option>
						<option value="3">배송중</option>
						<option value="4">구매확정</option>
					</c:if>
					<c:if test="${getOrder.order_progress eq 2}">
						<!-- <option value="0">입금대기</option> -->
						<option value="1">구매요청</option>
						<option value="2" selected>배송준비</option>
						<option value="3">배송중</option>
						<option value="4">구매확정</option>
					</c:if>
					<c:if test="${getOrder.order_progress eq 3}">
						<!-- <option value="0">입금대기</option> -->
						<option value="1">구매요청</option>
						<option value="2">배송준비</option>
						<option value="3" selected>배송중</option>
						<option value="4">구매확정</option>
					</c:if>
					<c:if test="${getOrder.order_progress eq 4}">
						<!-- <option value="0">입금대기</option> -->
						<option value="1">구매요청</option>
						<option value="2">배송준비</option>
						<option value="3">배송중</option>
						<option value="4" selected>구매확정</option>
					</c:if>
				</select>
			</h6>
			<h6><strong>운송장 : </strong><input type="text" id="order_invoice" name="order_invoice" value="${getOrder.order_invoice}" readOnly>
				<a href="javascript:invoiceCheck()"><button type="button" class="btn btn-secondary btn-sm">배송조회</button></a>
			</h6>
			<a href="javascript:updateOrder()"><button type="button" id="btn1" class="btn btn-secondary btn-sm">수정</button></a>
			<a href="javascript:updateX()"><button type="button" id="btn3" class="btn btn-secondary btn-sm" disabled>수정 취소</button></a><br><br>
			<button type="submit" id="btn2" class="btn btn-secondary btn-sm" disabled>수정 데이터 적용</button>
			<button type="reset" id="btn4" class="btn btn-secondary btn-sm" disabled>다시 입력</button>
		</form>
	</div>