<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../user/user_top.jsp" %>

<style>
	.vertical-right-line {
		border-right-style: solid;
	 	border-right-width: 2px;
	  	border-right-color: #dee2e6;
	}
	
	.tl-content-box-outer {
		max-height: 7rem;
		padding-left: 0.8rem; 
		text-overflow: ellipsis; 
		overflow: hidden;
	}
	
	.tl-content-box-inner {
		line-height: 142%; 
		word-break: break-all;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 5;
		overflow: hidden;
	}
	
	.tl-content-box-view {
		line-height: 150%; 
		word-break: break-all;
	}
	
	.no-pm{
		padding: 0px !important;
		margin: 0px !important;
	}
	
	.tl-img {
		object-fit: cover;
		width: 100%;
		height: 100%;
	}
</style>

<body>
<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
  	
  	
  	<!-- 개인 페이지 -->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 80%; min-width: 35rem; max-width: 100rem;">
			
			<!-- 프로필 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">My Page</span></div>
			</div>
			
			<!-- 프로필 -->
			<div class="container mt-5">
				<div class="row">
				
					<!-- 프로필 좌측-->
					<div class="col-5 container">
						<!-- 프사 -->
		  				<div class="row mb-3">
		   					<div class="col" align="center"><img src="resources/img/${target_profile.prof_img}" class="img-thumbnail">
		   					<font size=5 color=black style=bold>ddd 님 </font><font size=2 color=gray>회원정보변경</font>
		   					<font size=5 color=black>보유뱃지</font><font size=5 color=black>보유뱃지</font><font size=5 color=black>보유뱃지</font>
		   					</div>
		   					&nbsp;&nbsp;<font size=2 color=gray>가입일: </font>
		   				</div>
			   			</div>
			   			<br>
			   			
			   			<!-- 해시태그 단어들  -->
			   			<br>
			   			<br>
			   			<br>
			   			<br>
			   			
			  <!-- 좋아요 한 보드게임 --> 			
			  <div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold"></span></div>
			</div> 	
			
			<div class="row mb-5">
		   					
		   					<font size=5 color=black style=bold>관심있는보드게임 </font><font size=2 color=gray>회원정보변경</font>
		   					
		   				</div>
			   			</div>
					
  		</main>
</body>
<%@include file="../user/user_bottom.jsp" %>