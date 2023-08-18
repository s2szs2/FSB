<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_view1.jsp 쇼핑몰 상품 상세이미지 페이지 -->
<%@include file="shop_prod_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="resources/js/sidebars.js"></script>

<!-- shop_prod_view.jsp 쇼핑몰 상품 상세정보 사이드바 -->
<%@include file="shop_prod_view.jsp" %>

		<div class="row justify-content-center">
			<div class="col-9 bg-white" align="center">
				<img alt="${getProd.game_num}" src="resources/img/${getProd.prod_img}">
			</div>
		</div>

	</div>
</div>
</div>
<%@include file="shop_bottom.jsp" %>