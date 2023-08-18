<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- gameLikeList.jsp -->
<%@include file="../user/user_top.jsp" %>
<body>
<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
 <br>
     <br>
     <div style="margin: 0 auto;">     	
        <table class="table" style="width:1500px;" >
  	<tr>
  		<td align="center"><img src="resources/img/like3.png" width="50" height="50" class="like-2">&nbsp;&nbsp;<font size="5" color="black">좋아요 한 보드게임 목록</font></td>
  	</tr>
  <tr>
  	<td>
 <c:if test="${empty gameLikeList }">
 	찜한 보드게임이 없습니다.
 </c:if>
 
<c:if test="${not empty gameLikeList }">
	<div class="row row-cols-3">			
	<c:forEach var="dto" items="${gameLikeList}">
		<div class="col">
			<div class="card mb-3" style="max-width: 800px;">
  				<div class="row g-0">
    				<div class="col-md-4">
      					<a href="game_view.do?game_num=${dto.game_num}&sort=all"><img src="resources/img/${dto.game_img}" class="img-fluid rounded-start" alt="보드게임"></a>
    				</div>
    			<div class="col-md-8">
     		 		<div class="card-body">
        		<h4 class="card-title">${dto.game_name}</h4>
        		<p class="card-text"></p>
        		<p class="card-text"><small class="text-body-secondary">사진을 누르면 상세보기로 이동합니다.</small></p>
      				</div>
    			</div>
  				</div>
			</div>
			</div>
	</c:forEach>
	</div>
</c:if>
</td>
</tr>
</table>
  	</div>
</main>
</body>

<%@include file="../user/user_bottom.jsp" %>