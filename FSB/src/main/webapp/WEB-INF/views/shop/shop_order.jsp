<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_listOrder.jsp 주문결제 페이지 -->
<%@include file="shop_top.jsp" %>
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
			data: data,
			dataType:'json',			
			sucess: function(data){
				alert("시스템 에러")
			},
			error: function(data){
				alert("결제 완료 되었습니다. 감사합니다 🐹");
				let url = 'user_shop_myPage.do';
				location.replace(url);
			}
		});
		}
</script>


				
<!-- ★★★ 센터로 보내는 div class ★★★ -->
<div class="d-flex justify-content-center">
	<div class="container px-5 py-3" id="featured-insertReview">
		<div class="row justify-content-center">
		
			<div class="col-9">
			<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			  <ol class="breadcrumb">
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="user_main.do">
			    	<font color="black"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
					  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5Z"/>
					  <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
					</svg></font>
			    	<font color="black">Home</font>
			    </a></li>
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_main.do"><font color="black">쇼핑몰</font></a></li>
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_listCart.do"><font color="black">장바구니</font></a></li>			    
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_listOrder.do?mode=view"><font color="black">주문결제</font></a></li>
			  </ol>
			</nav>
			<hr>
			</div>
			<div class="col-9 py-2">
			<h4 class="pb-2" align="left">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
				  <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
				  <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
				</svg>	
			
			<b>주문결제 <font size="4px" color="gray"><c:if test="${mode!='view'}"><c:set var="count" value="${fn:length(getCartList)}"></c:set>(${count}개의 상품)</c:if></font></b></h4>
				<!-- 상품상세페이지에서 주문하기를 눌렀을 때 -->
				<c:if test="${mode == 'view'}" >
				<form name="f1" id="f1" method="post">
				<input type="hidden" name="mode" value="view">
				<input type="hidden" name="game_num" value="${getProd.game_num}">
				<input type="hidden" name="prod_num" value="${getProd.prod_num}">
				<input type="hidden" name="detail_qty" value="${cart_qty}">
				<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center" class="table-light">
						<th width="48%" style="border-right: hidden">상품명</th>
						<th width="14%" style="border-right: hidden">상품 가격</th>
						<th width="8%" style="border-right: hidden">수량</th>
						<th width="11%" style="border-right: hidden">배송비</th>
						<th width="14%">주문 금액</th>
					</tr>
					</thead>
					<tr align="center" valign="middle">
						<td align="left"><img src="resources/img/${getProd.game_img}" width="100" height="100"> [${getProd.prod_company}] ${getProd.game_name}</td>
						<td>
							<c:if test="${getProd.prod_discount eq 0}">
								${getProd.prod_price}원
							</c:if>
							<c:if test="${getProd.prod_discount ne 0}">
								<font color="red"><b>${sessionScope.df.format(getProd.prod_price*(1-getProd.prod_discount/100))}원</b><br>
								${getProd.prod_discount}%</font>&nbsp<del>${sessionScope.df.format(getProd.prod_price)}원</del>
							</c:if>							
						</td>
						<td>${cart_qty}개</td>
						<td>
							<c:if test="${getProd.prod_price * cart_qty >= 50000}">무료</c:if>
							<c:if test="${getProd.prod_price * cart_qty < 50000}">${sessionScope.df.format(getProd.prod_delchar)}원</c:if>
						</td>
						<td>
							<c:if test="${getProd.prod_discount eq 0}">
								${sessionScope.df.format(getProd.prod_price * cart_qty)}원
							</c:if>
							<c:if test="${getProd.prod_discount ne 0}">
								${sessionScope.df.format(getProd.prod_price*(1-getProd.prod_discount/100))}원
							</c:if><br>
							<font color="green">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-p-circle-fill" viewBox="0 0 16 16">   
								<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0ZM5.5 4.002V12h1.283V9.164h1.668C10.033 9.164 11 8.08 11 6.586c0-1.482-.955-2.584-2.538-2.584H5.5Zm2.77 4.072c.893 0 1.419-.545 1.419-1.488s-.526-1.482-1.42-1.482H6.778v2.97H8.27Z"/>
							</svg>
							${sessionScope.df.format(cart_qty * getProd.prod_point)}점
							</font>
						</td>
					</tr>
				</table>
				</form>		
				<form name="f2" id="f2" method="post">
				<input type="hidden" name="mode" value="view">
				<c:if test="${getProd.prod_price * cart_qty >= 50000}">
				<input type="hidden" name="view_order_price" value="${getProd.prod_price * cart_qty}">
				</c:if>
				<c:if test="${getProd.prod_price * cart_qty < 50000}">
				<input type="hidden" name="view_order_price" value="${(getProd.prod_price * cart_qty) + getProd.prod_delchar}">
				</c:if>				
				<input type="hidden" name="view_point_type_save" value="+">
				<input type="hidden" name="view_point_content_save" value="적립">
				<input type="hidden" name="view_savePoint" value="${getProd.prod_point * cart_qty}">
				<table width="40%" align="right">
					<tr align="right">
						<td align="right">장바구니 총 금액</td>
						<td align="right">
							<c:if test="${getProd.prod_discount eq 0}">
								<font color="red">${sessionScope.df.format(getProd.prod_price * cart_qty)}</font>원
							</c:if>
							<c:if test="${getProd.prod_discount ne 0}">
								<font color="red">${sessionScope.df.format(getProd.prod_price*(1-getProd.prod_discount/100) * cart_qty)}</font>원
							</c:if>
						</td>
					</tr>
					<tr>
						<td align="right">장바구니 총 적립</td>
						<td align="right">			
							<c:if test="${getProd.prod_discount eq 0}">
								<font color="blue">${sessionScope.df.format(getProd.prod_point * cart_qty)}</font>점
							</c:if>
							<c:if test="${getProd.prod_discount ne 0}">
								<font color="blue">${sessionScope.df.format(getProd.prod_price*(1-getProd.prod_discount/100) * cart_qty)}</font>원
							</c:if>
						</td>
					</tr>
				</table>	
				</form>			
				</c:if>
				<!-- 장바구니에서 주문결제를 눌렀을 때 -->
 				<c:if test="${mode == 'cart'}">
 				<form name="f3" id="f3" method="post">
 				<input type="hidden" name="mode" value="cart">
				<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center" class="table-light">
						<th width="48%" style="border-right: hidden">상품명</th>
						<th width="14%" style="border-right: hidden">상품 가격</th>
						<th width="8%" style="border-right: hidden">수량</th>
						<th width="11%" style="border-right: hidden">배송비</th>
						<th width="14%">주문 금액</th>
					</tr>
					</thead>						
					<c:set var="cartTotalPrice" value="0"/>
					<c:set var="cartTotalPoint" value="0"/>
					<c:set var="cartTotalDelchar" value="0"/>
					<c:set var="i" value="1"/>
				<c:forEach var="dto" items="${getCartList}">
				<input type="hidden" name="game_num${i}" value="${dto.game_num}">
				<input type="hidden" name="prod_num${i}" value="${dto.prod_num}">
				<input type="hidden" name="detail_qty${i}" value="${dto.cart_qty}">
				<input type="hidden" name="cart_num${i}" value="${dto.cart_num}">
				<c:set var="i" value="${i+1}"></c:set>
					<c:set var="cartTotalPrice" value="${cartTotalPrice + (dto.prod_price * dto.cart_qty)}"/>
					<c:set var="cartTotalPoint" value="${cartTotalPoint + (dto.prod_point * dto.cart_qty)}"/>
					<c:set var="cartTotalDelchar" value="${cartTotalDelchar + dto.prod_delchar}"/>
					<tr align="center" valign="middle" class="table-light" height="110">																		<!-- input태그 data속성 (https://dololak.tistory.com/364) -->
						<td align="left"><img src="resources/img/${dto.game_img}" width="100" height="100"> [${dto.prod_company}] ${dto.game_name}</td>
						<td>
							<c:if test="${dto.prod_discount eq 0}">
								${sessionScope.df.format(dto.prod_price)}원
							</c:if>
							<c:if test="${dto.prod_discount ne 0}">
								<font color="red"><b>${sessionScope.df.format(dto.prod_price*(1-dto.prod_discount/100))}원</b><br>
								${dto.prod_discount}%</font><del>${sessionScope.df.format(dto.prod_price)}원</del>
							</c:if>							
						</td>
						<td>${sessionScope.df.format(dto.cart_qty)}개
						</td>
						<td>
							<c:if test="${dto.prod_price * dto.cart_qty >= 50000}">무료</c:if>
							<c:if test="${dto.prod_price * dto.cart_qty < 50000}">${sessionScope.df.format(dto.prod_delchar)}원</c:if>
						</td>
						<td>
							<c:if test="${dto.prod_discount eq 0}">
								${sessionScope.df.format(dto.prod_price * dto.cart_qty)}원
							</c:if>
							<c:if test="${dto.prod_discount ne 0}">
								${sessionScope.df.format(dto.prod_price*(1-dto.prod_discount/100))}원
							</c:if><br>
							<font color="green">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-p-circle-fill" viewBox="0 0 16 16">   
								<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0ZM5.5 4.002V12h1.283V9.164h1.668C10.033 9.164 11 8.08 11 6.586c0-1.482-.955-2.584-2.538-2.584H5.5Zm2.77 4.072c.893 0 1.419-.545 1.419-1.488s-.526-1.482-1.42-1.482H6.778v2.97H8.27Z"/>
							</svg>
							${sessionScope.df.format(dto.cart_qty * dto.prod_point)}점
							</font>
						</td>
					</tr>
				</c:forEach>
				</table>
					<input type="hidden" name="c" value="${i}">
				</form>
				<form name="f4" id="f4" method="post">
 				<input type="hidden" name="mode" value="cart">				
				<input type="hidden" name="point_type_save" value="+">
				<input type="hidden" name="point_content_save" value="적립">
				<c:if test="${cartTotalPrice >= 50000}">
				<input type="hidden" name="order_price" value="${cartTotalPrice}">
				</c:if>
				<c:if test="${cartTotalPrice < 50000}">
				<input type="hidden" name="order_price" value="${cartTotalPrice + cartTotalDelchar}">
				</c:if>
				<table width="40%" align="right">
					<tr align="right">
						<td align="right">장바구니 총 금액</td>
						<td align="right">
							<font color="red">${sessionScope.df.format(cartTotalPrice)}</font>원
						</td>
					</tr>
					<tr>
						<td align="right">장바구니 총 적립</td>
						<td align="right">			
							<font color="blue">${sessionScope.df.format(cartTotalPoint)}</font>점
							<input type="hidden" name="savePoint" value="${cartTotalPoint}">
						</td>
					</tr>
				</table>
				</form>
				</c:if>
			</div>

 			<div class="col-9 py-3">
 				<form name="f5" id="f5" method="post">
 				<input type="hidden" name="point_type_use" value="-">
				<input type="hidden" name="point_content_use" value="사용">
				<!-- <input type="hidden" name="point_amount_use" value="밑에서 input타입로 보냄"> -->
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr class="table-light" align="left" valign="middle">
						<th colspan="4" height="50"><font size="4">&nbsp 할인 정보</font></th>
					</tr>
					</thead>
					<tr valign="middle">
						<td width="47%">&nbsp 쿠폰</td>			
						<td width="35%" align="right" id="result">0</td>
						<td width="3%" align="right"><b>원</b></td>
						<td width="15%" align="right">
							<c:if test="${empty myCoupon}">
								<button class="btn btn-outline-dark disabled" type="button">쿠폰 적용</button>
							</c:if>
							<c:if test="${not empty myCoupon}">
								<button class="btn btn-outline-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-controls="collapseExample">쿠폰 적용</button>
							</c:if>
						</td>
					</tr>
					<tr id="myCoupon">
					<!-- td 행 숨기기/행 보이기 해야함!!! https://hianna.tistory.com/501 -->
						<td colspan="4" style="border-top: hidden">
							<div class="collapse" id="collapseExample">
								<div class="card card-body">
									<b>보유 쿠폰 (${myCouponCount})</b><hr>
									<c:forEach var="clist" items="${myCoupon}">
									<input type="hidden" name="usc_num" value="${clist.usc_num}">
										<c:if test="${mode == 'view'}">
										<c:if test="${clist.sc_type eq '%'}"><!-- 할인율 쿠폰의 경우 -->
											<label>
											<input class="radioBtn" type="radio" name="order_coupon" id="order_coupon" value="${getProd.prod_price * (clist.sc_discount)*0.01}">
											<img src="resources/img/coupon_3.png" class="img-fluid rounded-start" alt="할인율쿠폰" width="30px" height="30px">											
											<b>${getProd.prod_price * (clist.sc_discount)*0.01}원</b> 
											${clist.sc_discount}% ${clist.sc_name} ${sessionScope.df.format(clist.sc_min)}원 이상 구매시 (최대 ${sessionScope.df.format(clist.sc_limit)}원 할인)
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>
											</label>
										</c:if>
										</c:if>
										<c:if test="${mode == 'cart'}">
										<c:if test="${clist.sc_type eq '%'}"><!-- 할인율 쿠폰의 경우 -->
											<label>
											<input class="radioBtn" type="radio" name="order_coupon" id="order_coupon" value="${cartTotalPrice * (clist.sc_discount)*0.01}">
											<img src="resources/img/coupon_3.png" class="img-fluid rounded-start" alt="할인율쿠폰" width="30px" height="30px">											
											<b>${cartTotalPrice * (clist.sc_discount)*0.01}원</b> 
											${clist.sc_discount}% ${clist.sc_name} ${sessionScope.df.format(clist.sc_min)}원 이상 구매시 (최대 ${sessionScope.df.format(clist.sc_limit)}원 할인)
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>
											</label>
										</c:if>
										</c:if>
										<c:if test="${clist.sc_type eq '-'}"><!-- 금액 쿠폰의 경우 -->
											<label>												
											<input class="radioBtn" type="radio" name="order_coupon" id="order_coupon" value="${clist.sc_discount}">
											<img src="resources/img/coupon_2.png" class="img-fluid rounded-start" alt="금액쿠폰" width="40px" height="40px">
											<b>${clist.sc_discount}원</b> ${clist.sc_name} 
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>
											</label>
										</c:if>
										<c:if test="${clist.sc_type eq 'delchar'}"><!-- 배송비 쿠폰의 경우 -->
											<label>
											<input class="radioBtn" type="radio" name="order_coupon" id="order_coupon" value="${clist.sc_discount}">
											<img src="resources/img/coupon_1.png" class="img-fluid rounded-start" alt="배송비쿠폰" width="40px" height="40px">
											<b>${clist.sc_discount}원</b> ${clist.sc_name}
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>																							
											</label>
										</c:if>
									<script>
									// [쿠폰 적용] 버튼
/* 									$(document).ready(function(){
										$("#getCheckCoupon").on("click", function(){
											//버튼 누르면 html에 출력
											if(document.getElementById("order_coupon1")){
												var discount = document.getElementById("order_coupon1").value;
												var d = discount.toLocaleString();
												$("#getCouponDiscount").html(d);
												$("#coupontDiscount").html(d);
											}else if(document.getElementById("order_coupon2")){
												
											}
											//숨기기위함 const row = document.getElementById('myCoupon');
										});
									}); */
									$(document).ready(function(){
										$("#getCheckCoupon").on("click", function(){
											//버튼 누르면 html에 출력
											var discount = document.querySelector('input[name="order_coupon"]:checked').value;
											$("#result").html(discount);
											$("#coupontDiscount").html(discount);
										});
									});									
											
									</script>										
									</c:forEach>
									<button class="btn btn-outline-dark" type="button" id="getCheckCoupon">쿠폰 적용</button>	
								</div>
							</div>
						</td>
					</tr>
					<tr valign="middle">
						<td width="47%">&nbsp 포인트</td>		<!-- point_history DB에 넣어줘야함! -->
						<!-- 포인트는 getTotalPoint 이하만 사용할 수 있음! -->	<!-- javascript에서 html변화줌! -->
						<td width="35%" align="right"><input type="text" min="${getTotalpoint}" id="totalPoint" onkeyup='pointDiscount()' style="text-align:right;" name="order_point" value="0" placeholder="0" class="form-control" placeholder="0" aria-describedby="button-addon2"></td>
						<td width="3%" align="right"><b>점</b></td>
						<td width="15%" align="right"><button class="btn btn-outline-dark" type="button" id="totalPointBtn">전액 사용</button></td>
					</tr>
					<script>
						$(document).ready(function(){
							$("#totalPointBtn").on("click", function(){
								//버튼 누르면 html에 출력
								var totalPoint = ${getTotalPoint};
								$("#totalPoint").html(totalPoint);
								$("#pointDiscount").html(totalPoint);
								$("#zero").html(0);
								//value값 바꿔주기
								document.querySelector("#totalPoint").value = totalPoint;
							});
						});
						function pointDiscount(){
							const totalPoint = document.getElementById('totalPoint').value;
							document.getElementById("pointDiscount").innerText = totalPoint;
						}
						
					</script>
					<tr valign="middle" height="50">
						<td align="right" colspan="2">보유 포인트</td>
						<td align="right" id="zero">
							<c:if test="${not empty getTotalPoint}"> ${sessionScope.df.format(getTotalPoint)}</c:if>
							<c:if test="${empty getTotalPoint}">0</c:if>
						</td>
						<td align="right">점</td>
					</tr>
				</table>
				</form>
<%-- 				<table width="40%" align="right">
					<tr align="right">
						<td width="20%">총 할인 금액</td>
						<td width="15%"><b>(-)${getCoupon.sc_discount + 사용포인트}원</b></td>
					</tr>	
				</table>	 --%>		
			</div>
			
			<!-- 다음 카카오 주소 API 사용법 https://devofroad.tistory.com/m/42 -->		
 			<div class="col-9 py-3">
 				<form name="f6" id="f6" method="post">
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="left" valign="middle">
						<th colspan="3" height="50"><font size="4">&nbsp배송 정보</font></th>
					</tr>
					</thead>
					<c:if test="${empty getDelivery}">
					<tr valign="middle">
						<th class="table-light">&nbsp배송지명</th>
						<td><input type="text" class="form-control" name="del_title" placeholder="예) 집, 회사"></td>
						<td>
							<button class="btn btn-outline-dark" type="reset">직접 입력</button>
							<button class="btn btn-outline-dark" type="button" onclick="javascript:listDel()">배송지 관리</button>
						</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp받으실 분 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_name" id="order_name"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th rowspan="4" class="table-light">&nbsp받으실 곳 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_address1" id="sample6_postcode" placeholder="우편 번호"></td>
						<td><button class="btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()">우편번호검색</button></td>
					</tr>		
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" name="order_address2" id="sample6_address" placeholder="주소"></td><td style="border-top: hidden"> </td>
					</tr>
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" name="order_address3" id="sample6_detailAddress" placeholder="상세 주소"></td><td style="border-top: hidden"> </td>
					</tr>	
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고 항목"></td><td style="border-top: hidden"> </td>
					</tr>												
					<tr valign="middle">
						<th class="table-light">&nbsp전화번호 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_hp" id="order_hp" placeholder="0100000000 형식으로 작성"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th class="table-light" rowspan="2">&nbsp배송 메모</td><!-- 직접 입력 시 밑에 input펼치기 -->
						<td>
							<select name="order_memo" id="selectMemo" class="form-select">
								<option selected>배송 메모를 선택해주세요.</option>
								<option value="문 앞에 놔주세요.">문 앞에 놔주세요</option>
								<option value="택배함에 놔주세요.">택배함에 놔주세요.</option>
								<option value="경비실에 맡겨주세요.">경비실에 맡겨주세요.</option>
								<!-- 다른 옵션을 누르면 밑에 있는 input에 javascript로 입력이 되고 / 직접입력을 누르면 focus 맞춰짐 -->
								<option value="">직접 입력</option>
							</select>
						</td>
					</tr>	
					</c:if>
					<c:if test="${not empty getDelivery}">
					<tr valign="middle">
						<th class="table-light">&nbsp배송지명</th>
						<td><input type="text" class="form-control" name="del_title" value="${getDelivery.del_title}"></td>
						<td>
							<button class="btn btn-outline-dark" type="reset">직접 입력</button>
							<button class="btn btn-outline-dark" type="button" onclick="javascript:listDel()">배송지 관리</button>
						</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp받으실 분 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_name" value="getDelivery.del_name"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th rowspan="4" class="table-light">&nbsp받으실 곳 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_address1" id="sample6_postcode" value="${getDelivery.del_address1}"></td>
						<td><button class="btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()">우편번호검색</button></td>
					</tr>		
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" name="order_address2" id="sample6_address" value="${getDelivery.del_address2}"></td><td style="border-top: hidden"> </td>
					</tr>
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" name="order_address3" id="sample6_detailAddress" value="${getDelivery.del_address3}"></td><td style="border-top: hidden"> </td>
					</tr>	
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고 항목"></td><td style="border-top: hidden"> </td>
					</tr>												
					<tr valign="middle">
						<th class="table-light">&nbsp전화번호 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_hp" value="${getDelivery.del_hp}"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th class="table-light" rowspan="2">&nbsp배송 메모</td><!-- 직접 입력 시 밑에 input펼치기 -->
						<td>
							<select name="order_memo" id="selectMemo" class="form-select">
								<option selected value=" ">배송 메모를 선택해주세요.</option>
								<option value="문 앞에 놔주세요.">문 앞에 놔주세요</option>
								<option value="택배함에 놔주세요.">택배함에 놔주세요.</option>
								<option value="경비실에 맡겨주세요.">경비실에 맡겨주세요.</option>
								<!-- 다른 옵션을 누르면 밑에 있는 input에 javascript로 입력이 되고 / 직접입력을 누르면 focus 맞춰짐 -->
								<option value=" ">직접 입력</option>
							</select>
						</td>
					</tr>	
					</c:if>					
					<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>			
					<script>
					//선택 시 선택한 값을 지정된 Input Box에 값 담기 ( https://imthekingofcoding.tistory.com/18 )
			        $( "#selectMemo" ).change(function(){
			            $("#result").val( $("#selectMemo").val() );
			        });
					</script>	
					<tr>
						<td style="border-top: hidden">
							<input type="text" class="form-control" name="order_memo" value="${getDelivery.del_memo}" id="result">
						</td>
					</tr>
				</table>
				</form>
			
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
    	new daum.Postcode({
        	oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample6_postcode").value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}	    
</script>			
			</div>
 			<div class="col-9 py-3">
 				<form name="f7" id="f7" method="post">		
 				<c:if test="${mode == 'view'}">
 				<c:if test="${(getProd.prod_price * cart_qty) < 50000}">
				<input type="hidden" name="order_receiptprice" value="${(getProd.prod_price * cart_qty) + 3000}">
				</c:if>				
 				<c:if test="${(getProd.prod_price * cart_qty) >= 50000}">
				<input type="hidden" name="order_receiptprice" value="${getProd.prod_price * cart_qty}">
				</c:if>
				<table width="45%" align="center" style="font-size:120%">
					
					<tr align="right">
						<th align="center" width="20%">총 상품 금액</th>
						<th colspan="3" width="25%">${df.format(getProd.prod_price * cart_qty)}원</th>
					</tr>
					<tr align="right">
						<th align="center">배송비(조건)</th>
					<c:if test="${(getProd.prod_price * cart_qty) < 50000}">
						<th colspan="3">${df.format(3000)}원</th>
					</c:if>
					<c:if test="${(getProd.prod_price * cart_qty) >= 50000}">
						<th colspan="3">무료</th>
					</c:if>	
					</tr>
					<tr align="right">
						<th align="center">쿠폰 할인 금액</th>
						<th>(-)</th>
						<th id="coupontDiscount">0</th>
						<th>원</th>
					</tr>					
					<tr align="right">
						<th align="center">포인트 할인 금액</th>
						<th>(-)</th>
						<th id="pointDiscount"><div id="pointDiscount">0</div></th>
						<th>원</th>
					</tr>					
					<tr align="right">
						<th align="center">최종 결제 금액</th><!-- 값 가져가서 할인정보 (-) 빼줘야 함 -->
					<c:if test="${(getProd.prod_price * cart_qty) < 50000}">
						<th colspan="3" >${df.format((getProd.prod_price * cart_qty) + 3000)}원</th>
					</c:if>
					<c:if test="${(getProd.prod_price * cart_qty) >= 50000}">
						<th colspan="3" >${df.format((getProd.prod_price * cart_qty))}원</th>
					</c:if>		
					</tr>					
				</table>
				</c:if>
 				<c:if test="${mode == 'cart'}">
				<table width="45%" align="center" style="font-size:120%">
					
					<tr align="right">
						<th align="center" width="20%">총 상품 금액</th>
						<th colspan="3" width="25%">${df.format(cartTotalPrice)}원</th>
					</tr>
					<tr align="right">
						<th align="center">배송비(조건)</th>
					<c:if test="${cartTotalPrice < 50000}">
						<th colspan="3">${df.format(cartTotalDelchar)}원</th>
					</c:if>
					<c:if test="${cartTotalPrice >= 50000}">
						<th colspan="3">무료</th>
					</c:if>	
					</tr>
					<tr align="right">
						<th align="center">쿠폰 할인 금액</th>
						<th>(-)</th>
						<th id="coupontDiscount">0</th>
						<th>원</th>
					</tr>					
					<tr align="right">
						<th align="center">포인트 할인 금액</th>
						<th>(-)</th>
						<th id="pointDiscount"><div id="pointDiscount">0</div></th>
						<th>원</th>
					</tr>					
					<tr align="right">
						<th align="center">최종 결제 금액</th><!-- 값 가져가서 할인정보 (-) 빼줘야 함 -->
					<c:if test="${cartTotalPrice < 50000}">
						<th colspan="3" >${df.format(cartTotalPrice+cartTotalDelchar)}원</th>
					</c:if>
					<c:if test="${cartTotalPrice >= 50000}">
						<th colspan="3" >${df.format(cartTotalPrice)}원</th>
					</c:if>		
					</tr>					
				</table>
				</c:if>
				</form>
			</div>
			
			<div class="col-9 py-3" align="center">
				<input class="checkbox" type="checkbox" name="동의여부" id="checkbox" checked>
				<b>(필수)</b> 주문 내용 확인 및 결제 동의
				<br><br>
				<form name="f8" id="f8" method="post">
				<h4><input type="radio" name="order_payment" value="무통장결제">무통장 결제 <input type="radio" name="order_payment" value="카드결제">카드 결제</h4>
				</form>
				<br>
				<button class="btn btn-outline-dark" type="submit" onclick="finishOrder()">결제하기</button>
				<button class="btn btn-outline-dark" type="button" onclick="history.back()">돌아가기</button>
			</div>
			
		</div>
	</div>
</div>

<%@include file="shop_bottom.jsp" %>