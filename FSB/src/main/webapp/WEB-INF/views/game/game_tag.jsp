<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- game_tag.jsp -->
<%@include file="../user/user_top.jsp" %>
<html>
<head>
	<title>보드게임 태그</title>
</head>
<body>
<div align="center">
<div class="text-bg-danger p-3" style="--bs-bg-opacity: .15;"><font color="#000000">[${getGame.game_name }] 게임 관련 피드</font></div>
	<br>
	<br>
<div class="container text-center">
<c:if test="${empty listFeed }">
	등록된 피드가 없습니다.
</c:if>
<c:if test="${not empty listFeed }">
  <div class="row row-cols-3">
  	<c:forEach var="dto" items="${listFeed}">
    <div class="col">
	    <div class="card" style="width: 20rem;">
	 			<img src="resources/img/${dto.feed_img1 }" class="card-img-top" alt="피드대표사진">
	  		<div class="card-body">
	  		<c:forEach var="theme" items="${dto.feed_theme }">
	    		<span class="badge rounded-pill text-bg-dark">#${theme.theme_name }</span>	
	    	</c:forEach>
	    	<br><br>
	    <p class="card-text">${dto.feed_content }</p>
	    <p class="card-text">
	    	<small class="text-body-secondary">
	    		<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#text-quote"></use></svg>
	    			${dto.feed_replyCount }
	    			 &nbsp;&nbsp;
	    		<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#heart-empty"></use></svg>
					 ${dto.feed_likeCount }
			</small>
		</p>
	    <a href="feedView_only.do?feed_num=${dto.feed_num }" class="btn btn-primary">피드로 이동</a>
			</div>
		</div>
	</div>
	</c:forEach>
  </div>
</c:if>
</div>
</div>
</body>
</html>
<%@include file="../user/user_bottom.jsp" %>
    