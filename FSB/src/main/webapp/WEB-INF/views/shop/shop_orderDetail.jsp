<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_listOrder.jsp 주문결제 페이지 -->
<%@include file="myPage_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- PortOne 1. 결제 라이브러리 추가 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script type="text/javascript">
	
	//배송지 관리 페이지 새창열기!
	function listDel(){
		window.open("shop_listDel.do", "", "width=800, height=400")
	}			
	
	//넘겨야 할 데이터 작성했는지 체크! onsubmit="return check()"
	function check() {
		if (f1.order_name.value == "") {
			alert("받으실 분의 이름을 입력해주세요.")
			f1.order_name.focus()
			return false
		}	
		if (f1.order_address1.value == "") {
			alert("받으실 분의 주소를 입력해주세요.")
			f1.order_address1.focus()
			return false
		}	
		if (f1.order_hp.value == "") {
			alert("받으실 분의 전화번호 입력해주세요.")
			f1.order_hp.focus()
			return false
		}	
		var totalPoint = ${getTotalPoint};
		if (f1.order_point.value > totalPoint){
			alert("포인트를 다시 입력하세요.")
			f1.order_point.focus()
			return false
		}
		return true
	}
	
	
/* 	// PortOne 2. 결제 객체 초기화 하기
	var IMP = window.IMP; // 생략 가능
	IMP.init("imp15848178"); // 예: imp00000000a
	
	// PortOne 3. 결제 요청하기
    function requestPay() {
        IMP.request_pay({
            pg : 'kcp',
            pay_method : 'card',
            merchant_uid: "IMP"+makeMerchantUid, // 주문 번호
            name : '당근 10kg',
            amount : 1004, // 결제 금액
            buyer_email : 'Iamport@chai.finance',
            buyer_name : '포트원 기술지원팀',
            buyer_tel : '010-1234-5678',
            buyer_addr : '서울특별시 강남구 삼성동',
            buyer_postcode : '123-456'
        }, function (rsp) { // callback
            //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
              if (rsp.success) {
                    console.log(rsp);
                } else {
                    console.log(rsp);
                }
        });
    } */
	
  	function finishOrder(){
    	var data = $('#f1,#f2,#f3,#f4,#f5,#f6,#f7,#f8').serialize();
		$.ajax({
			type: "post",
			url: "shop_finishOrder.do",
			//data: $("#f1").serialize()+"@@"+$("#f2").serialize()+"@@"+$("#f3").serialize()+"@@"+
			//$("#f4").serialize()+"@@"+$("#f5").serialize()+"@@"+$("#f6").serialize()+"@@"+$("#f7").serialize()+"@@",
			data: data,
			dataType:'json',			
			//#f1,#f2,#f3,#f4,#f5,#f6,#f7
			sucess: function(data){
				alert("시스템 에러")
			},
			error: function(data){
				alert("전송 성공");
				let url = 'shop_main.do';
				location.replace(url);
			}
		});
		}
</script>


<td>				
<!-- ★★★ 센터로 보내는 div class ★★★ -->
<div class="d-flex justify-content-center">
	<div class="container px-5 py-3" id="featured-insertReview">
		<div class="row justify-content-center">
			<div class="col-9 py-2">
			<h4 class="pb-2" align="left">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
				  <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
				  <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
				</svg>	
			
			<b>주문 상세 내역 <font size="4px" color="gray"> </font></b></h4>
			<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center">
						<th width="%" style="border-right: hidden">상품명</th>
						<th width="%" style="border-right: hidden">상품 가격</th>
						<th width="%" style="border-right: hidden">수량</th>
						<th width="%">주문 금액</th>
						<th width="%"> </th>
					</tr>
					</thead>						
				<c:forEach var="dto" items="${listOrderDetail}">
					<tr align="center" valign="middle" class="table-light" height="110">																		<!-- input태그 data속성 (https://dololak.tistory.com/364) -->
						<td align="left"><img src="resources/img/${dto.game_img}" width="100" height="100"> [${dto.prod_company}] ${dto.game_name}</td>
						<td>${sessionScope.df.format(dto.prod_price)}원</td>
						<td>${sessionScope.df.format(dto.detail_qty)}개</td>
						<td>
								${sessionScope.df.format(dto.prod_price * dto.detail_qty)}원
<%-- 							<font color="green">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-p-circle-fill" viewBox="0 0 16 16">   
								<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0ZM5.5 4.002V12h1.283V9.164h1.668C10.033 9.164 11 8.08 11 6.586c0-1.482-.955-2.584-2.538-2.584H5.5Zm2.77 4.072c.893 0 1.419-.545 1.419-1.488s-.526-1.482-1.42-1.482H6.778v2.97H8.27Z"/>
							</svg>
							${sessionScope.df.format(dto.cart_qty * dto.prod_point)}점
							</font> --%>
						</td>
						<td><button class="btn btn-outline-dark" type="button" onclick="location.href='shop_insertReview.do'">리뷰쓰기</button></td>
					</tr>
				</c:forEach>
				</table>
			</div>
			<div class="col-9 py-3">
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="left" valign="middle">
						<th colspan="3" height="50"><font size="4">&nbsp배송 정보</font></th>
					</tr>
					</thead>
					<c:forEach var="dto" items="${listOrderDetailView}" begin="0" end="0">
					<tr valign="middle">
						<th class="table-light">&nbsp받으실 분 </th>
						<td>${dto.order_name}</td>
					</tr>
					<tr valign="middle">
						<th rowspan="3" class="table-light">&nbsp받으실 곳 </th>
						<td>${dto.order_address1}</td>
					</tr>		
					<tr valign="middle">
						<td style="border-top: hidden">${dto.order_address2}</td>
					</tr>
					<tr valign="middle">
						<td style="border-top: hidden">${dto.order_address3}</td>
					</tr>	
					<tr valign="middle">
						<th class="table-light">&nbsp전화번호</th>
						<td>${dto.order_hp}</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp배송 메모</th><!-- 직접 입력 시 밑에 input펼치기 -->
						<td>${dto.order_memo}</td>
					</tr>
					</c:forEach>	
				</table>
			</div>
			<div class="col-9 py-3" align="center">
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="left" valign="middle">
						<th colspan="2" height="50"><font size="4">&nbsp결제 정보</font></th>
					</tr>
					</thead>
					<c:forEach var="dto" items="${listOrderDetailView}" begin="0" end="0">
					<tr valign="middle">
						<th class="table-light" width="25%">&nbsp총 상품 금액</th>
						<td>${sessionScope.df.format(dto.order_price)}원</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp쿠폰 할인 금액</th>
						<td>${sessionScope.df.format(dto.order_coupon)}원</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp포인트 할인 금액</th>
						<td>${sessionScope.df.format(dto.order_point)}원</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp결제 방식</th>
						<td>${dto.order_payment}</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp최종 결제 금액</th>
						<td>${sessionScope.df.format(dto.order_receiptprice)}원</td>
					</tr>
					</c:forEach>	
				</table>				
				<br>
				<button class="btn btn-outline-dark" type="button" onclick="history.back()">돌아가기</button>
			</div>
		</div>
	</div>
</div>
     </td>
   </tr>
</table>
<%@include file="shop_bottom.jsp" %>