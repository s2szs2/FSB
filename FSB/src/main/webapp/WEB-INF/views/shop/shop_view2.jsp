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
      </div>
      <div class="row justify-content-center">
         <div class="col-9 bg-white border-bottom py-3 pb-2">
            <font size="4.5"><b>리뷰 (${count})</b></font> 
         </div>
      </div>
      
      <div class="row justify-content-center">
<c:if test="${empty getViewReview}">
	<div class="col-9 bg-white border-bottom py-3 pb-2" height="300">
		<h6>등록된 리뷰가 없습니다.</h6>
	</div>
</c:if>
<c:if test="${not empty getViewReview}">	
		<c:forEach var="dto" items="${getViewReview}">
		<!-- 상품 리뷰에 사진이 있을때 -->
		<c:if test="${dto.sr_img1 ne null}">
         <div class="col-7 bg-white border-bottom py-3 pb-2" height="300">
            <h6>
            <c:if test="${dto.sr_starrating eq 1 }">
               <img src="resources/img/star2.png" width="20" height="20">
            <c:forEach begin="1" end="4">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>               
             </c:if>
            <c:if test="${dto.sr_starrating eq 2 }">
            <c:forEach begin="1" end="2">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="3">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>            
            </c:if>
            <c:if test="${dto.sr_starrating eq 3 }">
            <c:forEach begin="1" end="3">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="2">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>
            </c:if>
            <c:if test="${dto.sr_starrating eq 4 }">
            <c:forEach begin="1" end="4">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="1">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>
            </c:if>
            <c:if test="${dto.sr_starrating eq 5 }">
            <c:forEach begin="1" end="5">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            </c:if>
            </h6>
            <h6><b>${dto.sr_title}</b></h6>
            <h6>${dto.sr_content}</h6>
            <c:if test="${dto.sr_img1 ne null}">
              <img src="resources/img/${dto.sr_img1}" width="222" height="222" class="img-responsive img-rounded img-thumbnail">
            </c:if>
            <c:if test="${dto.sr_img2 ne null}">
              <img src="resources/img/${dto.sr_img2}" width="222" height="222" class="img-responsive img-rounded img-thumbnail">
            </c:if>
            <c:if test="${dto.sr_img3 ne null}">            
              <img src="resources/img/${dto.sr_img3}" width="222" height="222" class="img-responsive img-rounded img-thumbnail">
            </c:if>
            <c:if test="${dto.sr_img4 ne null}">            
              <img src="resources/img/${dto.sr_img4}" width="222" height="222" class="img-responsive img-rounded img-thumbnail">
         	</c:if>
         </div>
         <div class="col-1 bg-white border-bottom py-3 pb-2" height="300" align="right">
            <h6><font color="gray">작성자</font></h6>
            <h6><font color="gray">작성일</font></h6>      
         </div>
         <div class="col-1 bg-white border-bottom py-3" height="300" align="left">
            <h6>${dto.mem_nickname}</h6>
            <h6>${dto.sr_regdate}</h6>   
         </div>
         </c:if>
         <!-- 상품 리뷰에 사진이 없을때 -->
		 <c:if test="${dto.sr_img1 eq null}">
         <div class="col-7 bg-white border-bottom py-3 pb-2" height="130">
            <h6>
            <c:if test="${dto.sr_starrating eq 1 }">
               <img src="resources/img/star2.png" width="20" height="20">
            <c:forEach begin="1" end="4">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>               
             </c:if>
            <c:if test="${dto.sr_starrating eq 2 }">
            <c:forEach begin="1" end="2">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="3">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>            
            </c:if>
            <c:if test="${dto.sr_starrating eq 3 }">
            <c:forEach begin="1" end="3">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="2">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>
            </c:if>
            <c:if test="${dto.sr_starrating eq 4 }">
            <c:forEach begin="1" end="4">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            <c:forEach begin="1" end="1">
               <img src="resources/img/star1.png" width="20" height="20">
            </c:forEach>
            </c:if>
            <c:if test="${dto.sr_starrating eq 5 }">
            <c:forEach begin="1" end="5">
               <img src="resources/img/star2.png" width="20" height="20">
            </c:forEach>
            </c:if>
            </h6>
            <h6><b>${dto.sr_title}</b></h6>
            <h6>${dto.sr_content}</h6>
         </div>
         <div class="col-1 bg-white border-bottom py-3 pb-2" height="300" align="right">
            <h6><font color="gray">작성자</font></h6>
            <h6><font color="gray">작성일</font></h6>      
         </div>
         <div class="col-1 bg-white border-bottom py-3" height="300" align="left">
            <h6>${dto.mem_nickname}</h6>
            <h6>${dto.sr_regdate}</h6>   
         </div>
         </c:if>
        </c:forEach>
</c:if>
<form name="f" action="shop_view2.do" method="post">
	<div class="row justify-content-center">
         <div class="col-9 py-3 bg-white">
            <nav aria-label="Page navigation example">
              <ul class="pagination justify-content-center">
               <c:if test="${count > 0}">
               <c:if test="${startPage > pageBlock}">             
                <li class="page-item">
                  <a class="page-link" href="shop_view2.do?prod_num=${prod_num}&pageNum=${startPage - pageBlock}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li> 
               </c:if>                       
               <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item"><a class="page-link" href="shop_view2.do?prod_num=${prod_num}&pageNum=${i}">${i}</a></li>
               </c:forEach>
               <c:if test="${endPage < pageCount}">
                <li class="page-item">
                  <a class="page-link" href="shop_view2.do?prod_num=${prod_num}&pageNum=${startPage + pageBlock}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
               </c:if>
               </c:if>
              </ul>
            </nav>
         </div>
	</div>
</form>  
      </div>
   </div>
</div>
<%@include file="shop_bottom.jsp" %>