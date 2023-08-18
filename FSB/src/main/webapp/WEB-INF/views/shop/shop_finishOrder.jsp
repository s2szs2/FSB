<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_view1.jsp 쇼핑몰 상품 상세이미지 페이지 -->
<%@include file="shop_prod_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
				결제 완료.
			</div>
		</div>

	</div>
</div>
<%@include file="shop_bottom.jsp" %>