<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPage_review.jsp -->
<%@include file="myPage_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	function checkDel(sr_num, mem_num, sr_img1, sr_img2, sr_img3, sr_img4) {
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			document.f2.sr_num.value = sr_num
			document.f2.mem_num.value = mem_num
			document.f2.sr_img1.value = sr_img1
			document.f2.sr_img2.value = sr_img2
			document.f2.sr_img3.value = sr_img3
			document.f2.sr_img4.value = sr_img4
			document.f2.submit()
		}
	}
</script>
<td>
      <div class="row justify-content-center">
         <div class="col-4 bg-white border-bottom py-3 pb-2">
            <b>리뷰</b> (${count })
         </div>
         <div class="col-5 bg-white border-bottom py-3 pb-2" align="right">
         </div>
      </div>
      <div class="row justify-content-center">
	<c:if test="${empty myPageReview }">
		<br>
		작성한 리뷰가 없습니다.
	</c:if>
      	 <c:forEach var="dto" items="${myPageReview }">
         <div class="col-7 bg-white border-bottom py-3 pb-2" height="300">
            <h6>
            	<c:if test="${dto.sr_starrating eq 1}">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            	</c:if>
            	<c:if test="${dto.sr_starrating eq 2}">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            	</c:if>
            	<c:if test="${dto.sr_starrating eq 3}">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
           		</c:if>
           		<c:if test="${dto.sr_starrating eq 4}">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star1.png" width="20" height="20">
           		</c:if>
           		<c:if test="${dto.sr_starrating eq 5}">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
            		<img src="resources/img/star2.png" width="20" height="20">
           		</c:if>
            </h6>
            <h6><b>${dto.sr_title }</b></h6>
            <h6>${dto.sr_content }</h6>
            <c:if test="${!empty dto.sr_img1}">
				<img src="resources/img/${dto.sr_img1 }" width="150" height="150">
			</c:if>
			<c:if test="${!empty dto.sr_img2}">
				<img src="resources/img/${dto.sr_img2 }" width="150" height="150">
			</c:if>
			<c:if test="${!empty dto.sr_img3}">
				<img src="resources/img/${dto.sr_img3 }" width="150" height="150">
			</c:if>
			<c:if test="${!empty dto.sr_img4}">
				<img src="resources/img/${dto.sr_img4 }" width="150" height="150">
			</c:if>
         </div>
         <div class="col-1 bg-white border-bottom py-3 pb-2" height="500" align="right">
		   <a href="shop_myPage_review_updateForm.do?sr_num=${dto.sr_num }&mem_num=${getMemNum}"><button type="button" class="btn btn-outline-secondary">수정</button></a>
		   <br><br>
           <h6><font color="gray">작성자</font></h6>
           <h6><font color="gray">작성일</font></h6>            
         </div>
         <div class="col-1 bg-white border-bottom py-3" height="300" align="left">
			<a href="javascript:checkDel('${dto.sr_num}','${getMemNum }','${dto.sr_img1 }','${dto.sr_img2 }','${dto.sr_img3 }','${dto.sr_img4 }')"><button type="button" class="btn btn-outline-secondary">삭제</button></a>
         	<br><br>
            <h6>${login_mem.mem_nickname }</h6>
            <h6>${dto.sr_regdate }</h6>  
         </div>
         </c:forEach>
         </div>
     </td>
   </tr>
</table>
<div align="center">
<form name="f" action="shop_myPage_review.do" method="post">
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
   <c:if test="${count > 0}">
	         <c:if test="${startPage > pageBlock}">
	             <li class="page-item">
	            <a class="page-link" href="shop_myPage_review.do?mem_num=${getMemNum }&pageNum=${startPage - pageBlock}" aria-label="Previous">
	              <span aria-hidden="true">&laquo;</span>
	            </a>
	            </li>
	         </c:if>
	         
	         <c:forEach var="i" begin="${startPage}" end="${endPage}">
	             <li class="page-item">
	              <a class="page-link" href="shop_myPage_review.do?mem_num=${getMemNum }&pageNum=${i}">${i}</a></li>
	       </c:forEach>
	    
	   <c:if test="${endPage < pageCount}">
	             <li class="page-item">
	               <a class="page-link" href="shop_myPage_review.do?mem_num=${getMemNum }&pageNum=${startPage + pageBlock}" aria-label="Next">
	                 <span aria-hidden="true">&raquo;</span>
	              </a>
	          </li>
	        </c:if>  
    </c:if>
     </ul>
</nav>
</form>
</div>
<form name="f2" action="shop_myPage_review_delete.do" method="post">
	<input type="hidden" name="sr_num">
	<input type="hidden" name="mem_num">
	<input type="hidden" name="sr_img1" value="${dto.sr_img1 }">
	<input type="hidden" name="sr_img2" value="${dto.sr_img2 }">
	<input type="hidden" name="sr_img3" value="${dto.sr_img3 }">
	<input type="hidden" name="sr_img4" value="${dto.sr_img4 }">
</form>
<%@include file="myPage_bottom.jsp" %>