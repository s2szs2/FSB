<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_main.jsp 상세검색/인기상품/전체결과 메인페이지 -->
<%@include file="shop_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ★★★ 센터로 보내는 div class ★★★ -->
<div class="d-flex justify-content-center">
	<!-- https://getbootstrap.com/docs/5.3/components/navbar/ 네비게이션바 검색창 -->
	<nav class="navbar bg-body-tertiary">
	  <div class="container-fluid" align="center">
	    <form class="d-flex" role="search" action="prod_find.do" method="post">
	      <input class="form-control me-2" name="searchString" type="search" placeholder="검색" aria-label="Search">
	      <!-- https://icons.getbootstrap.com/icons/search/ 아이콘 검색돋보기버튼 -->
			<button name="search" value="search" type="submit" class="btn btn-secondary">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			 	 <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
				</svg>
			</button>
	    </form>
	  </div>
	</nav>
</div>
<div align="center">
   <p>
      <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseWidthExample" aria-expanded="false" aria-controls="collapseWidthExample">
          	상세보기
      </button>
   </p>
   <div class="collapse collapse-horizontal" id="collapseWidthExample">
    <div class="card card-body" style="width: 1000px;">
      <form name="f" action="shop_checkFind.do" method="post">
	   <table width="100%">
	      <tr height="50" align="center">
	         <th>테마별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
				<c:forEach var="tdto" items="${listTheme}">
					<td><input type="checkbox" name="theme" value="${tdto.theme_num }">${tdto.theme_name }</td>
				</c:forEach>
	      </tr>
	      <tr height="50" align="center">
	         <th>인원별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
				<td align="center" colspan="2"><input type="checkbox" name="game_player" value="1"> 1인</td>
				<td align="center" colspan="2"><input type="checkbox" name="game_player" value="2"> 2~4인</td>
				<td align="center" colspan="2" ><input type="checkbox" name="game_player" value="3"> 5~6인</td>
				<td align="center" colspan="2"><input type="checkbox" name="game_player" value="4"> 7인 이상</td>
	      </tr>
	      <tr height="50" align="center">
	         <th>난이도별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
				<td colspan="2">
					<input type="checkbox" name="prod_starrating" value="1">
  						<c:forEach begin="1" end="1">
    						<img src="resources/img/fire.png" width="15" height="15">
    					</c:forEach>			
    			</td>
				<td>
					<input type="checkbox" name="prod_starrating" value="2">
    					<c:forEach begin="1" end="2">
							<img src="resources/img/fire.png" width="15" height="15">
						</c:forEach>
				</td>
				<td>
					<input type="checkbox" name="prod_starrating" value="3">
    					<c:forEach begin="1" end="3">
							<img src="resources/img/fire.png" width="15" height="15">
					</c:forEach>
				</td>
				<td>
					<input type="checkbox" name="prod_starrating" value="4">
    					<c:forEach begin="1" end="4">
							<img src="resources/img/fire.png" width="15" height="15">
					</c:forEach>
				</td>
				<td>
					<input type="checkbox" name="prod_starrating" value="5">
    					<c:forEach begin="1" end="5">
							<img src="resources/img/fire.png" width="15" height="15">
						</c:forEach>
				</td>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-outline-dark">검색하기</button>
				</td>
	      </tr>
	   </table>
      </form>
     </div>
   </div>
</div>
<br>
<c:if test="${not empty listRank}">
<div class="d-flex justify-content-center pb-5">
					<!-- padding x,y축 여백 -->
	<div class="container px-3 py-3 bg-light" id="featured-best">
		<h4 class="pb-2 border-bottom">인기 보드게임</h4>
		<div class="row row-cols-4">
			<c:forEach var="dto" items="${listRank}">
			<div class="feature col">
				<div class="pb-2"><a href="shop_view.do?prod_num=${dto.prod_num}"><img src="resources/img/${dto.game_img}" width="310" height="310" class="img-responsive img-rounded img-thumbnail"></a></div>
				<c:if test="${empty dto.prod_starratingAvg}">
					<c:forEach begin="1" end="5">
		           	 	<img src="resources/img/star1.png" width="17" height="17">	
		        	</c:forEach>				
				</c:if>
				<c:if test="${not empty dto.prod_starratingAvg}">
					<c:forEach var="i" begin="1" end="5">
						<c:if test="${(dto.prod_starratingAvg - i) >= 0}">
							<img src="resources/img/star2.png" width="17" height="17">
	  					</c:if>
	  					<c:if test="${(dto.prod_starratingAvg - i) <0}">
	  						<img src="resources/img/star1.png" width="17" height="17">
	  					</c:if>
	  				</c:forEach>
				</c:if>
				<br>
				<h5><a href="shop_view.do?prod_num=${dto.prod_num}" class="link-dark text-decoration-none">[${dto.prod_company}] ${dto.game_name}</a></h5>
				<h5><b>${df.format(dto.prod_price)}원</b></h5>
				<font color="orange">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-square-dots-fill" viewBox="0 0 16 16">
		             <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-2.5a1 1 0 0 0-.8.4l-1.9 2.533a1 1 0 0 1-1.6 0L5.3 12.4a1 1 0 0 0-.8-.4H2a2 2 0 0 1-2-2V2zm5 4a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
					</svg>
				</font>
				<font color="gray">리뷰 ${dto.sr_count }</font>&nbsp
				<font color="red">				
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
					 <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
					</svg>	
				</font>
				<font color="gray">찜 ${dto.sl_count }</font>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
</c:if>
<br>
<%@include file="shop_bottom.jsp" %>