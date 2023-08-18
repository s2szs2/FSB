<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- member_sidebar.jsp // 회원 사이드바 -->

<!-- 벡터 아이콘 정의 -->
 	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  		<symbol id="people-circle" viewBox="0 0 16 16">
    		<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
    		<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
  		</symbol>
  		<symbol id="grid" viewBox="0 0 16 16">
    		<path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"></path>
  		</symbol>
  		<symbol id="toggles2" viewBox="0 0 16 16">
    		<path d="M9.465 10H12a2 2 0 1 1 0 4H9.465c.34-.588.535-1.271.535-2 0-.729-.195-1.412-.535-2z"></path>
    		<path d="M6 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm0 1a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm.535-10a3.975 3.975 0 0 1-.409-1H4a1 1 0 0 1 0-2h2.126c.091-.355.23-.69.41-1H4a2 2 0 1 0 0 4h2.535z"></path>
    		<path d="M14 4a4 4 0 1 1-8 0 4 4 0 0 1 8 0z"></path>
  		</symbol>
  		<symbol id="collection" viewBox="0 0 16 16">
    		<path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"></path>
  		</symbol>
	</svg>

    	<!-- 회원 아이콘 -->
    	<main class="d-flex flex-nowrap">
	    	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 280px;">
	      		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#people-circle"></use></svg>
	      		<span class="fs-5 fw-semibold">회원</span>
	   		<ul class="list-unstyled ps-0">
	   		<!-- 구분선 -->
	        <li class="border-top my-3"></li>
	   		<!-- 일반 회원 -->
	   		<li class="mb-1">
		   		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
		         			일반 회원
		       	</button>
		        <div class="collapse show" id="home-collapse">
		          	<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            	<li><a href="admin_member_insert.do" class="link-dark d-inline-flex text-decoration-none rounded">일반 회원 등록</a></li>
		            	<li><a href="admin_member_list.do" class="link-dark d-inline-flex text-decoration-none rounded">일반 회원 목록</a></li>
		         	</ul>
		        </div>
	        </li>
	        <!-- 구분선 -->
	        <li class="border-top my-3"></li>
	        <!-- 사업자 회원 -->
	   		<li class="mb-1">
		   		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="true">
		         			비즈니스 회원
		       	</button>
		        <div class="collapse show" id="dashboard-collapse">
		          	<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		          		<li><a href="admin_member_join_list.do" class="link-dark d-inline-flex text-decoration-none rounded">비즈니스 회원 가입 신청 내역
		          			<c:if test="${joinMember ne 0}"><span class="badge bg-danger">${joinMember}</span></c:if></a></li>
		            	<li><a href="admin_member_b_insert.do" class="link-dark d-inline-flex text-decoration-none rounded">비즈니스 회원 등록</a></li>
		            	<li><a href="admin_member_list.do?view=b" class="link-dark d-inline-flex text-decoration-none rounded">비즈니스 회원 목록</a></li>
		         	</ul>
		        </div>
	        </li>
	         <!-- 구분선 -->
	        <li class="border-top my-3"></li>
	        <li class="mb-1">
		   		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse2" aria-expanded="true">
		         			회원 공통
		       	</button>
		        <div class="collapse show" id="dashboard-collapse2">
		          	<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		          		<li><a href="admin_member_report_list.do" class="link-dark d-inline-flex text-decoration-none rounded">전체 회원 신고 내역
		          			<c:if test="${memReport ne 0 }"><span class="badge bg-danger">${memReport}</span></c:if>
		          		</a></li>
		          		<li><a href="admin_feed_report_list.do" class="link-dark d-inline-flex text-decoration-none rounded">전체 피드 신고 내역
		          			<c:if test="${feedReport ne 0 }"><span class="badge bg-danger">${feedReport}</span></c:if>
		          		</a></li>
		          		<li><a href="admin_member_by.do" class="link-dark d-inline-flex text-decoration-none rounded">회원 탈퇴 내역</a></li>
		         	</ul>
		        </div>
	        </li>
			</ul>
			</div>