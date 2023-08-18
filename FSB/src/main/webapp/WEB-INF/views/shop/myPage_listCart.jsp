<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="myPage_top.jsp" %>
<!-- myPage_listCart.jsp -->

<td>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	function checkDel(cart_num, prod_num){
		var isDel = window.confirm("정말로 삭제하겠습니까?");
		if (isDel){
			//위의 dto.cart_num과 dto.prod_num을 생성된 value에 넣어준 후 보낸거임!!!
			document.deleteOne.cart_num.value = cart_num;
			document.deleteOne.prod_num.value = prod_num;
			document.deleteOne.submit();
		}
	}
	
	//선택 상품만 [선택 삭제]
	function goDelete(prod_num){
		f.action="shop_checkDeleteCart.do"; 
		f.prod_num.value = prod_num;//필요없음 controller도 mem_num으로 바꾸기
		f.submit();
	}
	
	function updateCart(prod_num, game_num, cart_num){ // 수정폼 컨트롤러로 보내서 넘겨오기
		var cart_qty = document.getElementById('cart_qty').value;
		$.ajax({
			url : 'shop_updateCart.do',
			type : 'get',
		    data:{'prod_num': prod_num, 'cart_qty' : cart_qty, 'game_num' : game_num, 'cart_num' : cart_num},  //보낼 데이터 (json 형식)
		    success: function(data) {
		   		alert("성공");
		   		location.reload();
		    }, 
		    error: function(err) {
		    	alert("장바구니 수정 에러");
		    	location.reload();
		    }
		});
	}
	
	//장바구니 상품 [주문결제]
	function goOrder(){
		f.action="shop_cartOrder.do";
		f.submit();
	}
</script>
			<div class="col-9 py-2 justify-content-center">
<form name="f" method="post">
	<!-- 선택 삭제 -->
	<input type="hidden" name="prod_num" ${prod_num}>
	<!-- 주문결제 -->
	<input type="hidden" name="cart_qty" value="0">

			<h4 class="pb-2" align="left">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-cart4" viewBox="0 0 18 18">
				  <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l.5 2H5V5H3.14zM6 5v2h2V5H6zm3 0v2h2V5H9zm3 0v2h1.36l.5-2H12zm1.11 3H12v2h.61l.5-2zM11 8H9v2h2V8zM8 8H6v2h2V8zM5 8H3.89l.5 2H5V8zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"/>
				</svg>			
			<b>장바구니 <c:if test="${not empty listCart}"><font size="4px" color="gray">(${count}개의 상품)</font></c:if></b></h4>
				<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center">
						<th width="8%" style="border-right: hidden">&nbsp<input type="checkbox" name="allCheck" id="allCheck" checked /> 번호</th>
 								<!-- 상품 전체선택  -->
                                <script>
                                    $("#allCheck").click(function () {
                                        var chk = $("#allCheck").prop("checked");
                                        if (chk) {
                                            $(".checkbox").prop("checked", true);
                                            itemSum();
                                        } else {
                                            $(".checkbox").prop("checked", false);
                                            itemSum();
                                        }
                                    });						
                                    </script>	
                        <th width="33%" style="border-right: hidden">상품명</th>
						<th width="11%" style="border-right: hidden">상품 가격</th>
						<th width="10%" style="border-right: hidden">수량</th>
						<th width="10%" style="border-right: hidden">적립</th>
						<th width="12%" style="border-right: hidden">주문 금액</th>
						<th width="5%"> </th>
					</tr>
					</thead>
				<c:if test="${empty listCart}">
					<tr align="center" class="table-light">
						<td colspan="7">등록된 상품이  없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty listCart}">
					<c:set var="cartTotalPrice" value="0"/>
					<c:set var="cartTotalPoint" value="0"/>
					<c:set var="cartTotalDelchar" value="0"/>
				<c:forEach var="dto" items="${listCart}">
					<c:set var="cartTotalPrice" value="${cartTotalPrice + (dto.prod_price * dto.cart_qty)}"/>
					<c:set var="cartTotalPoint" value="${cartTotalPoint + (dto.prod_point * dto.cart_qty)}"/>
					<c:set var="cartTotalDelchar" value="${cartTotalDelchar + dto.prod_delchar}"/>
					<tr align="center" valign="middle" class="table-light" height="110">																		<!-- input태그 data속성 (https://dololak.tistory.com/364) -->
						<td>
							&nbsp<input class="checkbox" type="checkbox" name="checkCart" id="checkbox" value="${dto.cart_num}" checked> ${dto.cart_num}
						</td>
						<td align="left"><img src="resources/img/${dto.game_img}" width="100" height="100"> [${dto.prod_company}] ${dto.game_name}</td>
						<td>${df.format(dto.prod_price)}원</td>
						<td> 
							<!-- form 겹치기때문에  Ajax로 넘길거임!!!!!!!!! -->
							<div class="input-group input-group-sm">
								<input type="text" name="cart_qty" id="cart_qty" class="form-control" placeholder="${dto.cart_qty}" aria-label="cart_qty" aria-describedby="button-addon2">
								<button class="btn btn-outline-secondary" type="button" onclick="javascript:updateCart('${dto.prod_num}','${dto.game_num}','${dto.cart_num}')" method="post">수정</button>
							</div>						
							
							
						</td>
						<td><font color="blue">${df.format(dto.prod_point * dto.cart_qty)}P</font></td>
					<c:if test="${dto.prod_discount eq 0}">
						<td>${df.format(dto.prod_price * dto.cart_qty)}원</td>
					</c:if>
					<c:if test="${dto.prod_discount ne 0}">
						<td>${df.format((dto.prod_price * dto.cart_qty)-(dto.prod_price * dto.cart_qty * dto.prod_discount * 0.1))}원</td>
					</c:if>
						<td> <!-- 장바구니에 담긴 상품 삭제버튼(X) javascript(shop_view2참고)로 바로 적용되게끔! -->
							<a href="javascript:checkDel('${dto.cart_num}','${dto.prod_num}')">
							<c:set var="cart_num" value="${dto.cart_num}"/>
							<c:set var="prod_num" value="${dto.prod_num}"/>
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
						            var total_sum = sum/sum * ${cartTotalPrice}
						            var total_point = sum/sum * ${cartTotalPoint}	
						            var s = total_sum.toLocaleString();
						            var p = total_point.toLocaleString();
						            $("#total_sum").html(s + "원");
						            $("#total_point").html(p + "P");
						            //$("#amount").val(sum);
						        }
						</script>	
				</c:forEach>
				</c:if>
				</table>
				<c:if test="${not empty listCart}">
				<table width="100%" align="right">
					<tr align="right"> <!-- 선택한 상품 금액 보기! <<< 해야함 -->
						<td align="left" rowspan="2">
							<button class="btn btn-outline-dark" type="submit" onclick="javascript:goDelete('${prod_num}')">선택 삭제</button>
						</td>
							<script>
                               /*  $("#selectDelete_btn").click(function () {
                                    var checkDel_2 = window.confirm("정말 삭제하시겠습니까?");
 
                                    if (checkDel_2) {
                                    	//checkBox를 이용해서 체크된 값들을 배열로 보낼때
                                        var checkArr = new Array();
 										//???
                                        $("input[class='chkbox']:checked").each(function () {
                                            checkArr.push($(this).attr("data-cartNum"));
                                        });
 
                                        $.ajax({
                                            url: "shop_deleteCart.do",
                                            type: "get",
                                            data: { chbox: checkArr },
                                            success: function () {
	                                            location.href = "shop_main.do";
                                            	}
                                            },
                                		    error: function(err) {
                                		    	alert("ajax 처리 중 에러 발생");
                                		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
                                		    }
                                        });
                                    }
                                }); */
						
						</script>
						
						<td align="right" width="20%">장바구니 총 금액</td>
						<td align="right" width="15%" id="total_sum" >			<!-- 선택한 상품 포인트 보기! <<< 해야함 -->
							
							<font color="red">${df.format(cartTotalPrice)}원</font><br>
						</td>
					</tr>
					<tr>
						<td align="right" width="20%">장바구니 총 적립</td>
						<td align="right" width="15%" id="total_point" >			<!-- 선택한 상품 포인트 보기! <<< 해야함 -->
							<font color="blue">${df.format(cartTotalPoint)}P</font>
						</td>
					</tr>
				</table>
				</c:if>
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="center">
						<th>판매자</th>
						<th>배송 정보</th>
						<th>총 배송비</th>
					</tr>
					</thead>
				<c:if test="${empty listCart}">
					<tr align="center" class="table-light">
						<td colspan="5">배송 정보가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty listCart}">
				<c:forEach var="dto" items="${listCart}">
					<tr align="center" class="table-light">
						<td>${dto.prod_company}</td>
						<td align="left">상품 <font color="#8000FF">50,000원 이상</font> 구매 시 배송비 <b><font color="#8000FF">무료</font></b></td>
					<!-- 체크박스로 상품 선택시 dto로 선택여부 파악해서 ~ 선택한상품가격에 대한 배송비 적용시키기! <<< 해야함!  -->
					<c:if test="${dto.prod_price*dto.cart_qty < 50000}">
						<td>${df.format(dto.prod_delchar)}원</td>
					</c:if>
					<c:if test="${dto.prod_price*dto.cart_qty >= 50000}">
						<td>무료</td>
					</c:if>
					</tr>
				</c:forEach>
				</c:if>
				</table>
				<c:if test="${not empty listCart}">
				<table width="40%" align="right">
					<tr align="right"> <!-- 선택한 상품 배송비 보기! <<< 해야함 -->
						<td>장바구니 총 배송비</td>
					<c:if test="${cartTotalPrice < 50000}">
						<td width="30%"><font color="#8000FF">3,000원</font></td>
					</c:if>
					<c:if test="${cartTotalPrice >= 50000}">
						<td width="30%"><font color="#8000FF">무료</font></td>
					</c:if>					
					</tr>	
				</table>
				</c:if>			
				<table class="table" border="1" width="100%" align="center">
					<thead>
					<tr align="left">
						<th>구매 관련 참고사항</th>
					</tr>
					</thead>
					<tr class="table-light">
						<td>
							❕주문결제 시 해당 상품의 품절로 주문이 안 될 수 있습니다.<br>
							❕결제금액의 총합계는 마일리지 적용 전의 가격입니다.<br>
							❕보유하고 계신 마일리지는 주문 상품결제 시 사용 가능합니다.<br>
							❕배송기간은 등록업체 및 배송사의 사정에 의해 다소 차이가 있을 수 있습니다.<br>
						</td>
					</tr>
				</table>
				<c:if test="${not empty listCart}">
				<table border="0" width="30%" align="center">
					<tr align="right">
						<th align="center"><h5>총 상품 금액</h5></th>
						<td><h5>${df.format(cartTotalPrice)}원</h5></td>
					</tr>
					<tr align="right">
						<th align="center"><h5>배송비(조건)</h5></th>
					<c:if test="${cartTotalPrice < 50000}">
						<td><h5>${df.format(cartTotalDelchar)}원</h5></td>
					</c:if>
					<c:if test="${cartTotalPrice >= 50000}">
						<td><h5>무료</h5></td>
					</c:if>	
					</tr>
					<tr align="right">
						<th align="center"><h5>최종 결제 금액</h5></th>
					<c:if test="${cartTotalPrice < 50000}">
						<td><h5>${df.format(cartTotalPrice+cartTotalDelchar)}원</h5></td>
					</c:if>
					<c:if test="${cartTotalPrice >= 50000}">
						<td><h5>${df.format(cartTotalPrice)}원</h5></td>
					</c:if>		
					</tr>
					
				</table>
				</c:if>
				<div align="center">
				<c:if test="${not empty listCart}"> <button class="btn btn-outline-dark" type="button" onclick="javascript:goOrder()">주문하기</button></c:if>
				<button class="btn btn-outline-dark" type="button" onclick="history.back()">돌아가기</button>
				</div>
</form>			
			</div>		
			
		</div>
	</div>
</div>

</td>
</tr>
</table>

<form name="deleteOne" action="shop_deleteCart.do" method="post">
	<input type="hidden" name="cart_num">
	<input type="hidden" name="prod_num">
</form>

<%@include file="myPage_bottom.jsp" %>