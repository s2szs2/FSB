<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_view1.jsp 쇼핑몰 상품 리뷰 페이지 -->
<%@include file="shop_prod_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="resources/js/sidebars.js"></script>

<!-- shop_prod_view.jsp 쇼핑몰 상품 상세정보 사이드바 -->
<%@include file="shop_prod_view.jsp" %>

      <div class="row justify-content-center">
         <div class="col-9 bg-white" align="center">
         <br>
			<h5>
			<c:if test="${empty reviewAvg}">
				<c:forEach begin="1" end="5">
		           	 <img src="resources/img/star1.png" width="20" height="20">	
		        </c:forEach>				
			</c:if>
			<c:if test="${not empty reviewAvg}">
				<c:forEach var="i" begin="1" end="5">
					<c:if test="${(reviewAvg - i) >= 0}">
						<img src="resources/img/star2.png" width="25" height="25">
	  				</c:if>
	  				<c:if test="${(reviewAvg - i) <0}">
	  					<img src="resources/img/star1.png" width="25" height="25">
	  				</c:if>
	  			</c:forEach>
			</c:if>
            <b> ${reviewAvg} / 5</b>
            </h5>
         </div>
         <div class="col-4 bg-white border-bottom py-3 pb-2">
            <font size="4.5"><b>포토리뷰</b></font>
         </div>
         <div class="col-5 bg-white border-bottom py-3 pb-2" align="right">
            <a href="#"><button class="btn btn-outline-dark btn-sm" type="button">전체보기</button></a>            
         </div>
         <div class="col-9 py-3 bg-white border-bottom">
         <table> <!-- 포토리뷰 4장만 보기(table) -->
          <tr>
			<c:if test="${empty getViewReview}">
				<h6>등록된 포토리뷰가 없습니다.</h6>
			</c:if>
			<c:if test="${not empty getViewReview}">	         
         	<c:forEach var="dto" items="${getViewReview}">
			<td>
            	<c:if test="${dto.sr_img1 eq null}">
            		 
            	</c:if>
            </td>
            	<c:if test="${dto.sr_img1 ne null}">
            <td>
               	 <a href="#"><img class="imgProviewCrop round" src="resources/img/${dto.sr_img1}" width="222" height="222"></a>
            </td>
				</c:if>
            </c:forEach>
			</c:if>
          </tr>
         </table>
         </div>
      </div>
      </div>
   </div>
</div>
<%@include file="shop_bottom.jsp" %>