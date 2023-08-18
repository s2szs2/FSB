<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_listOrder.jsp 주문결제 페이지 -->
<%@include file="shop_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <script type="text/javascript">
	
	//배송지 관리 페이지 새창열기!
	function listDel(){
		window.open("shop_listDel.do", "", "width=800, height=400")
	}			

	//넘겨야 할 데이터 작성했는지 체크!
	function check() {
		if (f1.del_name.value == "") {
			alert("받으실 분의 이름을 입력해주세요.")
			f1.del_name.focus()
			return false
		}	
		if (f1.del_address1.value == "") {
			alert("받으실 분의 주소를 입력해주세요.")
			f1.del_address1.focus()
			return false
		}	
		if (f1.del_hp.value == "") {
			alert("받으실 분의 이름을 입력해주세요.")
			f1.del_hp.focus()
			return false
		}	
		return true
	}

	function payOrder(){
		var okPay = window.confirm("정말로 결제하겠습니까?")
		if (okPay){//확인 누르면 결제완료페이지
			document.f1.submit();
		}else{//취소 누르면 어디???
			
		}
	}


	
</script>

<form name="f1" action="shop_payOrder.do?mode=view" method="post" onsubmit="return check()">
<!-- 바로구매 : insertOrder 위해서 보냄 -->
<input type="hidden" name="cart_num" value="0"/>
<!-- 바로구매 상세 : insertOrderDetail 위해서 보냄 -->
<input type="hidden" name="game_name" value="${getProd.game_name}"/>
<input type="hidden" name="cart_qty" value="${cart_qty}"/>

<!-- 장바구니구매 : insertOrder 위해서 보냄 -->
<input type="hidden" name="cart_num" value=""/>
<!-- 장바구니구매 상세 : insertOrderDetail 위해서 보냄 -->

				
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
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_view.do?prod_num=${prod_num}"><font color="black">상품상세</font></a></li>
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
			<b>주문결제 <font size="4px" color="gray"><c:if test="${mode!='view'}">(${count}개의 상품)</c:if></font></b></h4>
				<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center" class="table-light">
						<th width="48%" style="border-right: hidden">상품명</th>
						<th width="14%" style="border-right: hidden">상품 가격</th>
						<th width="8%" style="border-right: hidden">수량</th>
						<th width="11%" style="border-right: hidden">적립</th>
						<th width="14%">주문 금액</th>
					</tr>
					</thead>

				<!-- 상품상세페이지에서 주문하기를 눌렀을 때 !!!수량 수정 가능하도록 추가!!! -->
				<c:if test="${mode == 'view'}" >
					<tr align="center" valign="middle">
						<td align="left"><img src="resources/img/${getProd.game_img}" width="100" height="100"> [${getProd.prod_company}] ${getProd.game_name}</td>
						<td>${sessionScope.df.format(getProd.prod_price)}원</td>
						<td>${cart_qty}개</td>
						<td>${sessionScope.df.format(cart_qty * getProd.prod_point)}P</td>
						<td>${sessionScope.df.format(cart_qty * getProd.prod_price)}원</td>
					</tr>
				</c:if>
				<!-- 장바구니에서 주문결제를 눌렀을 때 -->
				<c:if test="${mode == 'cart'}">
					<c:set var="cartTotalPrice" value="0"/>
					<c:set var="cartTotalPoint" value="0"/>
					<c:set var="cartTotalDelchar" value="0"/>
				<c:forEach var="dto" items="${listCart}">
					<c:set var="cartTotalPrice" value="${cartTotalPrice + (dto.prod_price * dto.cart_qty)}"/>
					<c:set var="cartTotalPoint" value="${cartTotalPoint + (dto.prod_point * dto.cart_qty)}"/>
					<c:set var="cartTotalDelchar" value="${cartTotalDelchar + dto.prod_delchar}"/>
					<tr align="center" class="table-light" height="110">																		<!-- input태그 data속성 (https://dololak.tistory.com/364) -->
						<td align="center">
							&nbsp<input class="checkbox" type="checkbox" name="checkCart" id="checkbox" value="${dto.cart_num}" checked> ${dto.cart_num}
						</td>
						<td align="left"><img src="resources/img/${dto.game_img}" width="100" height="100"> [${dto.prod_company}] ${dto.game_name}</td>
						<td>${df.format(dto.prod_price)}원</td>
						<td> 
							<!-- 이거말고 Ajax로 넘길거임!!!!!!!!! -->
							<form name="f" action="shop_updateCart.do" method="post">
								<div class="input-group input-group-sm">
								  <input type="text" name="cart_qty" class="form-control" placeholder="${dto.cart_qty}" aria-label="cart_qty" aria-describedby="button-addon2">
								  <button class="btn btn-outline-secondary" type="submit">수정</button>
								</div>
								<input type="hidden" name="prod_num" value="${dto.prod_num}"/>
								<input type="hidden" name="game_num" value="${dto.game_num}"/>
								<input type="hidden" name="cart_num" value="${dto.cart_num}"/>								
							</form>
						</td>
						<td><font color="blue">${df.format(dto.prod_point * dto.cart_qty)}P</font></td>
					<c:if test="${dto.prod_discount eq 0}">
						<td>${df.format(dto.prod_price * dto.cart_qty)}원</td>
					</c:if>
					<c:if test="${dto.prod_discount ne 0}">
						<td>${df.format((dto.prod_price * dto.cart_qty)-(dto.prod_price * dto.cart_qty * dto.prod_discount * 0.1))}원</td>
					</c:if>
						<td> <!-- 장바구니에 담긴 상품 삭제버튼(X) javascript(shop_view2참고)로 바로 적용되게끔! -->
							<a href="javascript:checkDel('${dto.cart_num},${dto.prod_num}')">
							<c:set var="cart_num" value="${cart_num}"/>
							<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-x-lg" viewBox="0 -4 20 20">
							  <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
							</svg>
							</a>
						</td>
					</tr>
					<script>
								//금액 총 합계
						        function itemSum() {
						            var str = "";
						            var sum = 0;
						            var count = $(".checkbox").length;
						            for (var i = 0; i < count; i++) {
						                if ($(".checkbox")[i].checked == true) {
						                    sum += parseInt($(".checkbox")[i].value);
						                }else{
						                	sum = 0;
						                }
						            }
						            $("#total_sum").html(sum/sum * ${cartTotalPrice} + " 원");
						            $("#total_point").html(sum/sum * ${cartTotalPoint} + "P");
						            //$("#amount").val(sum);
						        }
						</script>	
				</c:forEach>
				</c:if>
				</table>
				<table width="40%" align="right">
					<tr align="right">
						<td align="right">장바구니 총 금액</td>
						<td align="right">
							<font color="red">${df.format(cart_qty * getProd.prod_price)}원</font>
						</td>
					</tr>
					<tr>
						<td align="right">장바구니 총 적립</td>
						<td align="right">			
							<font color="blue">${df.format(cart_qty * getProd.prod_point)}P</font>
						</td>
					</tr>
				</table>
			</div>

 			<div class="col-9 py-3">
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr class="table-light" align="left" valign="middle">
						<th colspan="4" height="50"><font size="4">&nbsp 할인 정보</font></th>
					</tr>
					</thead>
					<tr valign="middle">
						<td width="47%">&nbsp 쿠폰</td>			
						<td width="35%" align="right" id="getCouponDiscount">0</td>
						<td width="3%" align="right"><b>원</b></td>
						<td width="15%" align="right">
							<c:if test="${empty myCoupon}">
								<button class="btn btn-outline-dark disabled" type="button">쿠폰</button>
							</c:if>
							<c:if test="${not empty myCoupon}">
								<button class="btn btn-outline-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-controls="collapseExample">쿠폰 적용</button>
							</c:if>
						</td>
					</tr>
					<tr id="myCoupon">
					<!-- td 행 숨기기/행 보이기 해야함!!! https://hianna.tistory.com/501 -->
						<td colspan="4">
							<div class="collapse" id="collapseExample">
								<div class="card card-body">
									<div class="border-bottom"><b>보유 쿠폰 (${myCouponCount})</b></div>
									<c:forEach var="clist" items="${myCoupon}">
										<c:if test="${clist.sc_type eq '%'}"><!-- 할인율 쿠폰의 경우 -->
											<input type="radio" name="coupon" id="coupon" value="${getProd.prod_price * clist.sc_discount * 0.1}">
											<label for="coupon">
											<b>${getProd.prod_price * clist.sc_discount * 0.1}원</b> 
											${clist.sc_discount}% ${clist.sc_name} 
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>
											</label>
										</c:if>
										<c:if test="${clist.sc_type eq '-'}"><!-- 금액 쿠폰의 경우 -->
											<input type="radio" name="coupon" id="coupon" value="${getProd.prod_price * clist.sc_discount * 0.1}">
											<label for="coupon">												
											<b>${clist.sc_discount}원</b> ${clist.sc_name} 
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>																								</label>
										</c:if>
										<c:if test="${clist.sc_type eq 'delchar'}"><!-- 배송비 쿠폰의 경우 -->
											<input type="radio" name="coupon" id="coupon" value="${getProd.prod_price * clist.sc_discount * 0.1}">
											<label for="coupon">
											<b>${clist.sc_discount}원</b> ${clist.sc_name} 
											<c:if test="${not empty clist.usc_duedate}"><font color="#4D4D4D">${clist.usc_duedate}까지</font></c:if>																							
											</label>
										</c:if>
									<script>
										$(document).ready(function(){
											$("#getCheckCoupon").on("click", function(){
												//버튼 누르면 html에 출력
												$("#getCouponDiscount").html(${clist.sc_discount});
												const row = document.getElementById('myCoupon');
												row.style.display = 'none';
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
						<!-- 포인트는 getTotalPoint 이하만 사용할 수 있음! -->								<!-- javascript에서 html변화줌! -->
						<td width="35%" align="right"><input type="text" style="text-align:right;" id="totalPoint" placeholder="0" name="point_amount" class="form-control" placeholder="0" aria-label="point_amount" aria-describedby="button-addon2"></td>
						<td width="3%" align="right"><b>점</b></td>
						<td width="15%" align="right"><button class="btn btn-outline-dark" type="button" id="totalPointBtn">전액 사용</button></td>
					</tr>
					<script>
						$(document).ready(function(){
							$("#totalPointBtn").on("click", function(){
								//버튼 누르면 html에 출력
								var totalPoint = ${getTotalPoint};
								$("#totalPoint").html(totalPoint);
								$("#zero").html(0);
								//value값 바꿔주기
								document.querySelector("#totalPoint").value = totalPoint;
							});
						});
					</script>
					<tr valign="middle" height="50">
						<td align="right" width="10%">보유 포인트</td>
						<td align="right" width="20%" colspan="2" id="zero">${sessionScope.df.format(getTotalPoint)}</td>
						<td align="right" width="15%">점</td>
					</tr>
				</table>
				<table width="40%" align="right">
					<tr align="right">
						<td width="20%">총 할인 금액</td>
						<td width="15%"><b>(-)${getCoupon.sc_discount + 사용포인트}원</b></td>
					</tr>	
				</table>			
			</div>
			
			<!-- 다음 카카오 주소 API 사용법 https://devofroad.tistory.com/m/42 -->		
 			<div class="col-9 py-3">
 			<form name="f2" action="shop_insertDel.do" method="post">
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="left" valign="middle">
						<th colspan="3" height="50"><font size="4">&nbsp배송 정보</font></th>
					</tr>
					</thead>
					<tr valign="middle">
						<th class="table-light">&nbsp배송지명</th>
						<td><input type="text" class="form-control" name="del_name" placeholder="예) 집, 회사"></td>
						<td>
							<button class="btn btn-outline-dark" type="reset">직접 입력</button>
							<button class="btn btn-outline-dark" type="button" onclick="javascript:listDel()">배송지 관리</button>
						</td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp받으실 분 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="del_name"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th rowspan="4" class="table-light">&nbsp받으실 곳 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_address1" id="sample6_postcode" placeholder="우편 번호"></td>
						<td><button class="btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()">우편번호검색</button></td>
					</tr>		
					<tr valign="middle">
						<td><input type="text" class="form-control" name="order_address2" id="sample6_address" placeholder="주소"></td>
					</tr>
					<tr valign="middle">
						<td><input type="text" class="form-control" name="order_address3" id="sample6_detailAddress" placeholder="상세 주소"></td>
					</tr>	
					<tr valign="middle">
						<td style="border-top: hidden"><input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고 항목"></td>
					</tr>												
					<tr valign="middle">
						<th class="table-light">&nbsp전화번호 <font color="blue"><b>*</b></font></th>
						<td><input type="text" class="form-control" name="order_hp"></td><td> </td>
					</tr>
					<tr valign="middle">
						<th class="table-light">&nbsp배송 메모</td><!-- 직접 입력 시 밑에 input펼치기 -->
						<td>
							<select name="order_msg" id="order_memo" class="form-select">
								<option selected>배송 메모를 선택해주세요.</option>
								<option value="문 앞에 놔주세요.">문 앞에 놔주세요</option>
								<option value="택배함에 놔주세요.">택배함에 놔주세요.</option>
								<option value="경비실에 맡겨주세요.">경비실에 맡겨주세요.</option>
								<!-- 다른 옵션을 누르면 밑에 있는 input에 javascript로 입력이 되고 / 직접입력을 누르면 focus 맞춰짐 -->
								<option value="직접 입력" id="input">직접 입력</option>
							</select>
							<input type="text" class="form-control" id="msg" name="order_memo">
						</td><td> </td>
					</tr>					
				</table>
			</form>
			</div>
			<div class="col-9">
				<table width="25%" align="center">
					<tr>
						<td><b>총 결제 금액<br>배송비(조건)<br><h5>최종결제금액</h5></b></td>
						<td align="right"><b>${df.format(cartTotalPrice)}원<br>${df.format(cartTotalDelchar)}원<h5>${df.format(cartTotalPrice+cartTotalDelchar)}원</h5></b></td>
					</tr>
				</table>
				<div align="center">위 테이블 맞춰야함... 보기 불편...</div>
			</div>
			<div class="col-9 py-3" align="center">
				<input class="checkbox" type="checkbox" name="동의여부" id="checkbox" checked>
				<b>(필수)</b> 주문 내용 확인 및 결제 동의
				<br><br>
				
				<a href="shop_insertOrderDetail.do">주문상세 등록</a>	
				<a href="shop_savePoint">포인트 적립</a>							
				<a href="shop_deleteCoupon.do">쿠폰 삭제</a>
				<a href="shop_usePoint">포인트 사용</a>
				<a href="shop_insertDel">배송지 등록</a>
				<a href="shop_insertOrder">주문결제 완료</a>
								
				
				<br><br>
				<button class="btn btn-outline-dark" type="submit">결제하기</button>
				<button class="btn btn-outline-dark" type="button" onclick="location.href='shop_listOrder.do?prod_num=${prod_num}'">돌아가기</button>
			</div>
		</div>
	</div>
</div>
</form> --%>

<%@include file="shop_bottom.jsp" %>