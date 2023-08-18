<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- admin_top.jsp -->
<html>
<head>
	<!-- title -->
	<title>보드게임 커뮤니티 프로젝트(관리자)</title>
	<!-- css, js 연결 -->
	<script src="resources/js/jquery-3.7.0.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<script src="resources/js/bootstrap.bundle.min.js"></script>
	
	<!-- 사이드 바 css, js -->
	<link href="resources/css/sidebars.css" rel="stylesheet">
	<script src="resources/js/sidebars.js"></script>
	
	<style>
		.vertical-right-line {
			border-right-style: solid;
		 	border-right-width: 2px;
		  	border-right-color: #dee2e6;
		}
	</style>
	
</head>
<body>
<!-- tab -->
<p>
	<ul class="nav nav-tabs justify-content-center">
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">회원</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="admin_member_insert.do">일반 회원 등록</a></li>
				<li><a class="dropdown-item" href="admin_member_list.do">일반 회원 목록</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_member_join_list.do">비즈니스 회원 신청 내역
					<c:if test="${joinMember ne 0 }">
						<span class="badge bg-danger">${joinMember}</span>
					</c:if>
				</a></li>
				<li><a class="dropdown-item" href="admin_member_b_insert.do">비즈니스 회원 등록</a></li>
				<li><a class="dropdown-item" href="admin_member_list.do?view=b">비즈니스 회원 목록</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_member_report_list.do">전체 회원 신고 내역
					<c:if test="${memReport ne 0 }">
						<span class="badge bg-danger">${memReport}</span>
					</c:if>
				</a></li>
				<li><a class="dropdown-item" href="admin_feed_report_list.do">전체 피드 신고 내역
					<c:if test="${feedReport ne 0 }">
						<span class="badge bg-danger">${feedReport}</span>
					</c:if>
				</a></li>
				<li><a class="dropdown-item" href="admin_member_by.do">회원 탈퇴 내역</a></li>
			</ul>
		</li>
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">보드게임</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="admin_game_insert.do">보드게임 등록</a></li>
				<li><a class="dropdown-item" href="admin_game_list.do">보드게임 목록</a></li>
				<li><a class="dropdown-item" href="admin_game_reportList.do?mode=all&sort=all">보드게임 한줄평 신고 내역
						<c:if test="${gameReport ne 0}"><span class="badge bg-danger">${gameReport}</span></c:if>
					</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_theme_insert.do">보드게임 테마 등록</a></li>
				<li><a class="dropdown-item" href="admin_theme_list.do?theme_num=0">보드게임 테마 목록</a></li>
			</ul>
		</li>
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">커뮤니티 관리</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="admin_board_list.do?view=secondhand">중고게시판 목록</a></li>
				<li><a class="dropdown-item" href="admin_board_list.do?view=free">자유게시판 목록</a></li>
				<li><a class="dropdown-item" href="admin_board_list.do?view=anony">익명게시판 목록</a></li>
				<li><a class="dropdown-item" href="admin_board_total_report.do?mode=all">전체 게시판 신고 내역
						<c:if test="${boardReport ne 0}"><span class="badge bg-danger">${boardReport}</span></c:if>
					</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_board_notice_insert.do">게시판 공지글 등록</a></li>
				<li><a class="dropdown-item" href="admin_board_notice_list.do?mode=all&sort=all">게시판 공지글 목록</a></li>
			</ul>
		</li>
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">쇼핑몰 관리</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="admin_prod_insert.do">상품 등록</a></li>
				<li><a class="dropdown-item" href="admin_prod_list.do?mode=all&sort=all">상품 목록</a></li>
				<li><a class="dropdown-item" href="admin_shop_inventory_list.do">재고 관리
					<c:if test="${inventory ne 0 }"><span class="badge bg-danger">${inventory}</span></c:if>
				</a></li>
				<li><a class="dropdown-item" href="admin_shop_total_review.do?sort=all">전체 상품 리뷰 목록</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_shop_qna_list.do?mode=all">문의 내역
					<c:if test="${shopQnA ne 0 }"><span class="badge bg-danger">${shopQnA}</span></c:if>
					</a></li>
				<li><a class="dropdown-item" href="admin_shop_order_list.do">주문 내역
					<c:if test="${shopOrder ne 0 }"><span class="badge bg-danger">${shopOrder}</span></c:if>
				</a></li>
			<%-- 	<li><a class="dropdown-item" href="admin_shop_refund_list.do">환불 내역
					<c:if test="${shopRefund ne 0 }"><span class="badge bg-danger">${shopRefund}</span></c:if>
				</a></li> --%>
				<li><a class="dropdown-item" href="admin_shop_sales_list.do">매출 관리</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="admin_scoupon_insert.do">쿠폰 등록</a></li>
				<li><a class="dropdown-item" href="admin_scoupon_list.do?sc_num=0">쿠폰 목록</a></li>
			</ul>
		</li>
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">페이지 관리</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="admin_notice_insert.do">관리자 작성글 등록</a></li>
				<li><a class="dropdown-item" href="admin_notice_list.do?mode=all&sort=all">관리자 작성글 목록</a></li>
				<!-- <li><hr class="dropdown-divider"></li>
				<li><a class="dropdown-item" href="#">뱃지 등록</a></li>
				<li><a class="dropdown-item" href="#">뱃지 목록</a></li> -->
			</ul>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="admin_main.do">메인 홈</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="user_main.do">사용자 페이지</a>
		</li>
		<c:set var="totalCount" value="${gameReport + boardReport + shopQnA + joinMember + memReport + inventory + shopOrder + shopRefund + feedReport}"/>
		<c:if test="${totalCount eq 0 }">
			<li class="nav-item">
				<a class="nav-link" href="#">
					<button type="button" class="btn btn-outline-danger position-relative">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
	  				<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"></path>
					</svg>
					</button>
				</a>
			</li>
		</c:if>
		<c:if test="${totalCount ne 0 }">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#"><button type="button" class="btn btn-outline-danger position-relative">
	                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
	  				<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"></path>
					</svg>
					<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill text-bg-danger">${totalCount}<span class="visually-hidden">unread messages</span></span>
					</button>
				</a>
				<ul class="dropdown-menu">
					<c:if test="${gameReport ne 0}">
						<li><a class="dropdown-item" href="admin_game_reportList.do?mode=all&sort=all">보드게임 한줄평 신고 내역
							<span class="badge bg-danger">${gameReport}</span></a>
						</li>
					</c:if>
					<c:if test="${boardReport ne 0}">
						<li><a class="dropdown-item" href="admin_board_total_report.do?mode=all">전체 게시판 신고 내역
								<span class="badge bg-danger">${boardReport}</span></a>
						</li>
					</c:if>
					<c:if test="${shopQnA ne 0 }">
						<li><a class="dropdown-item" href="admin_shop_qna_list.do?mode=all">문의 내역
							<span class="badge bg-danger">${shopQnA}</span></a>
						</li>
					</c:if>
					<c:if test="${joinMember ne 0 }">
						<li><a class="dropdown-item" href="admin_member_join_list.do">비즈니스 회원 신청 내역
							<span class="badge bg-danger">${joinMember}</span></a>
						</li>
					</c:if>
					<c:if test="${memReport ne 0 }">
						<li><a class="dropdown-item" href="admin_member_report_list.do">전체 회원 신고 내역
							<span class="badge bg-danger">${memReport}</span></a></li>
					</c:if>
					<c:if test="${feedReport ne 0}">
						<li><a class="dropdown-item" href="admin_feed_report_list.do">전체 피드 신고 내역
							<span class="badge bg-danger">${feedReport}</span></a>
						</li>
					</c:if>
					<c:if test="${inventory ne 0 }">
						<li><a class="dropdown-item" href="admin_shop_inventory_list.do">재고 관리
							<span class="badge bg-danger">${inventory}</span></a>
						</li>
					</c:if>
					<c:if test="${shopOrder ne 0 }">
						<li><a class="dropdown-item" href="admin_shop_order_list.do">주문 내역
							<span class="badge bg-danger">${shopOrder}</span></a>
						</li>
					</c:if>
				<%-- 	<c:if test="${shopRefund ne 0 }">
						<li><a class="dropdown-item" href="admin_shop_refund_list.do">환불 내역
							<span class="badge bg-danger">${shopRefund}</span></a>
						</li>
					</c:if>
 --%>				</ul>
			</li>
		</c:if>
	</ul>
	
	<!-- 내용 -->
