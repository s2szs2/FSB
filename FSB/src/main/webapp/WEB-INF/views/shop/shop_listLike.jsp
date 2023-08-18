<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_listLike.jsp 마이페이지 찜한 상품페이지 -->
<%@include file="shop_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	function checkDel(prod_num){
		var isDel = window.confirm("정말로 삭제하겠습니까?");
		if (isDel){
			//위의 dto.cart_num과 dto.prod_num을 생성된 value에 넣어준 후 보낸거임!!!
			document.deleteOne.prod_num.value = prod_num;
			document.deleteOne.submit();
		}
	}
	
	function goCart(){
		f.action="shop_insertCart.do";//장바구니 상품 [주문결제]
		f.submit();
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
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_listLike.do?mem_num=${mem_num}"><font color="black">찜한 상품</font></a></li>
			  </ol>
			</nav>
			<hr>
			</div>
			
			<div class="col-9 py-2 justify-content-center">
			<form name="f" method="post">
			<h4 class="pb-2" align="left">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bag-heart-fill" viewBox="0 0 16 16">
				  <path d="M11.5 4v-.5a3.5 3.5 0 1 0-7 0V4H1v10a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V4h-3.5ZM8 1a2.5 2.5 0 0 1 2.5 2.5V4h-5v-.5A2.5 2.5 0 0 1 8 1Zm0 6.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z"/>
				</svg>	
			<b>찜한 상품 <c:if test="${not empty listLike}"><font size="4px" color="gray">(${count}개의 상품)</font></c:if></b></h4>
				<table class="table table-bordered" border="1" width="100%" align="center">
					<thead>
					<tr align="center">
						<th width="10%" style="border-right: hidden">번호</th>
                        <th width="40%" style="border-right: hidden">상품명</th>
						<th width="12%" style="border-right: hidden">상품 가격</th>
						<th width="10%" style="border-right: hidden">적립</th>
						<th width="18%"> </th>
					</tr>
					</thead>
				<c:if test="${empty listLike}">
					<tr align="center" class="table-light">
						<td colspan="7">등록된 상품이  없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty listLike}">
				<c:forEach var="dto" items="${listLike}">
				<input type="hidden" name="prod_num" value="${dto.prod_num}">
				<input type="hidden" name="cart_qty" value="1">
					<tr align="center" valign="middle" class="table-light" height="110">																		<!-- input태그 data속성 (https://dololak.tistory.com/364) -->
						<td>${dto.sl_num}</td>
						<td align="left"><img src="resources/img/${dto.game_img}" width="100" height="100"> [${dto.prod_company}] ${dto.game_name}</td>
						<td>${df.format(dto.prod_price)}원</td>
						<td><font color="blue">${df.format(dto.prod_point)}P</font></td>
						<td> 
							<button class="btn btn-outline-dark" type="button" onclick="javascript:goCart()">장바구니</button>
							<button class="btn btn-outline-dark" type="button" onclick="javascript:checkDel('${dto.prod_num}')">삭제하기</button>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				</table>
				<div align="center">
				<button class="btn btn-outline-dark" type="button" onclick="history.back()">돌아가기</button>
				</div>
			</form>			
			</div>
		</div>
	</div>
</div>
<form name="deleteOne" action="shop_deleteLike.do?mode=listLike" method="post">
	<input type="hidden" name="prod_num">
</form>
<%@include file="shop_bottom.jsp" %>