<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- game_sidebar.jsp // 보드게임 사이드바 -->

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
	
	<!-- 보드게임 아이콘 -->
    	<main class="d-flex flex-nowrap">
	    	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 280px; height: 800px;">
	      		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#collection"></use></svg>
	      		<span class="fs-5 fw-semibold">보드게임</span>
	   		<ul class="list-unstyled ps-0">
	   		<!-- 구분선 -->
	        <li class="border-top my-3"></li>
	        <!-- 보드게임 -->
	   		<li class="mb-1">
		   		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
		         			보드게임
		       	</button>
		        <div class="collapse show" id="home-collapse">
		          	<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		            	<li><a href="admin_game_insert.do" class="link-dark d-inline-flex text-decoration-none rounded">보드게임 등록</a></li>
						<li><a href="admin_game_list.do" class="link-dark d-inline-flex text-decoration-none rounded">보드게임 목록</a></li>
						<li><a href="admin_game_reportList.do?mode=all&sort=all" class="link-dark d-inline-flex text-decoration-none rounded">보드게임 한줄평 신고 내역 
								<c:if test="${gameReport ne 0}"><span class="badge bg-danger">${gameReport}</span></c:if>
							</a></li>
		         	</ul>
		        </div>
	        </li>
	        <!-- 구분선 -->
	        <li class="border-top my-3"></li>
	        <!-- 테마 -->
	   		<li class="mb-1">
		   		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="true">
		         			테마
		       	</button>
		        <div class="collapse show" id="dashboard-collapse">
		          	<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
		          		<li><a class="link-dark d-inline-flex text-decoration-none rounded" href="admin_theme_insert.do">보드게임 테마 등록</a></li>
						<li><a class="link-dark d-inline-flex text-decoration-none rounded" href="admin_theme_list.do?theme_num=0">보드게임 테마 목록</a></li>
		         	</ul>
		        </div>
	        </li>
	        </ul>
			</div>