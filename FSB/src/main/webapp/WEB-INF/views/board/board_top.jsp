<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- board_top -->
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
	<script>
	//해당 회원 개인 피드로 이동
	function goToFeed(mem_num){
		event.stopPropagation();
		window.location='personalHome.do?num='+mem_num;
	}
	</script>

	<!-- board 사이드바 -->
	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 15%; min-width: 10rem; max-width: 18rem;">
   		<a href="feed.do" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
    		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#people-circle"></use></svg>
    		<span class="fs-5 fw-semibold">${login_mem.mem_nickname} 님</span>
 		</a>
 		
 		<!-- 버튼 -->
 		<div class="container mb-3">
 			<div class="col" align="center">
 				내가 쓴 게시글 수 :<br>
 				내가 쓴 댓글 수 :
 			</div>
 		</div>
 		
 		<div class="border-top"></div>
  			
   		<!-- 메뉴 항목 -->	
    	<ul class="list-unstyled ps-0 mt-3">
      		<li class="mb-1">
        		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#friend-collapse" aria-expanded="true">
         			게시판 목록
       			</button>
        		<div class="collapse show" id="friend-collapse">
          			<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            			<li><a href="friendRequest.do" class="link-dark d-inline-flex text-decoration-none rounded">자유게시판</a></li>
            			<li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">익명게시판</a></li>
            			<li><a href="#" class="link-dark d-inline-flex text-decoration-none rounded">중고게시판</a></li>
         			</ul>
        		</div>
      		</li>
      	</ul>
	</div>