<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_refund_view.jsp // 쇼핑몰 환불내역 상세보기 -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
<script type="text/javascript">
	function updateRefund(){
		document.getElementById('refund_progress').disabled = false;
		
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
		
		document.getElementById('refund_progress').disabled = true;
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
		<form name="f2" action="admin_shop_refund_update.do" method="post">
			<h6><strong>환불 번호 : </strong>${getRefund.refund_num}
			<input type="hidden" name="refund_num" value="${getRefund.refund_num}"/></h6>
			<h6><strong>주문 번호 : </strong>${getRefund.order_num}
				<button class="btn btn-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    				주문 상품 보기
  				</button></h6>
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
				<button class="btn btn-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample1">
    				주문 내역 보기
  				</button>
  				<div class="collapse" id="collapseExample1">
					<div class="card card-body">
						<h6><strong>주문일 : </strong>${getOrder.order_date}</h6>
						<h6><strong>주문 번호 : </strong>${getOrder.order_num}</h6>
						<h6><strong>주문자 번호 : </strong>${getOrder.mem_num}</h6>
						<h6><strong>주문자 연락처 : </strong>${getOrder.mem_hp1} - ${getOrder.mem_hp2} - ${getOrder.mem_hp3}</h6>
						<h6><strong>배송지 연락처 : </strong>${getOrder.order_hp1} - ${getOrder.order_hp2} - ${getOrder.order_hp3}</h6>
						<h6><strong>배송지 : </strong><br>
						&nbsp;우편 번호 : ${getOrder.order_address1}<br>
						&nbsp;기본 주소 : ${getOrder.order_address2}<br>
						&nbsp;상세 주소 : ${getOrder.order_address3}
						</h6>
						<h6><strong>배송 메모 : </strong><br>${getOrder.order_memo}</h6>
						<h6><strong>주문 금액 : </strong>${df.format(getOrder.order_price)}</h6>
						<h6><strong>결제 방식 : </strong>${getOrder.order_payment}</h6>
						<h6><strong>쿠폰 사용 : </strong>${getOrder.order_coupon}</h6>
						<h6><strong>포인트 사용 : </strong>${getOrder.order_point}</h6>
						<h6><strong>결제 금액 : </strong>${df.format(getOrder.order_receiptprice)}</h6>
						<h6><strong>처리 단계 : </strong>
							<c:if test="${getOrder.order_progress eq 0 }">입금대기</c:if>
							<c:if test="${getOrder.order_progress eq 1 }">구매요청</c:if>
							<c:if test="${getOrder.order_progress eq 2 }">배송준비</c:if>
							<c:if test="${getOrder.order_progress eq 3 }">배송중</c:if>
							<c:if test="${getOrder.order_progress eq 4 }">구매확정</c:if>
						</h6>
					<h6><strong>운송장 : </strong><input type="text" id="order_invoice" name="order_invoice" value="${getOrder.order_invoice}" readOnly>
						<a href="javascript:invoiceCheck()"><button type="button" class="btn btn-secondary btn-sm">배송조회</button></a>
					</h6>
				  </div>
				</div>
				<h6><strong>신청자 : </strong>${getRefund.mem_num}</h6>
				<h6><strong>신청일 : </strong>${getRefund.refund_date}</h6>
				<h6><strong>처리 단계 :</strong>
					<select id="refund_progress" name="refund_progress" class="form-select" disabled>
						<c:if test="${getRefund.refund_progress eq 1}">
							<option value="1" selected>환불요청</option>
							<option value="2">접수완료</option>
							<option value="3">처리중</option>
							<option value="4">환불완료</option>
						</c:if>
						<c:if test="${getRefund.refund_progress eq 2}">
							<option value="1">환불요청</option>
							<option value="2" selected>접수완료</option>
							<option value="3">처리중</option>
							<option value="4">환불완료</option>
						</c:if>
						<c:if test="${getRefund.refund_progress eq 3}">
							<option value="1">환불요청</option>
							<option value="2">접수완료</option>
							<option value="3" selected>처리중</option>
							<option value="4">환불완료</option>
						</c:if>
						<c:if test="${getRefund.refund_progress eq 4}">
							<option value="1">환불요청</option>
							<option value="2">접수완료</option>
							<option value="3">처리중</option>
							<option value="4" selected>환불완료</option>
						</c:if>
					</select>
				</h6>
				<br>
				<br>
				<a href="javascript:updateRefund()"><button type="button" id="btn1" class="btn btn-secondary btn-sm">수정</button></a>
				<a href="javascript:updateX()"><button type="button" id="btn3" class="btn btn-secondary btn-sm" disabled>수정 취소</button></a><br><br>
				<button type="submit" id="btn2" class="btn btn-secondary btn-sm" disabled>수정 데이터 적용</button>
				<button type="reset" id="btn4" class="btn btn-secondary btn-sm" disabled>다시 입력</button>
			</form>
	</div>