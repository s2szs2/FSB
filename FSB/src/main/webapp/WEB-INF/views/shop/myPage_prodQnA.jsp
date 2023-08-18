<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="myPage_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- myPage_prodQnA.jsp -->
<script type="text/javascript">
	function checkDel(sq_num, mem_num, sq_img1, sq_img2, sq_img3, sq_img4) {
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			document.f2.sq_num.value = sq_num
			document.f2.mem_num.value = mem_num
			document.f2.sq_img1.value = sq_img1
			document.f2.sq_img2.value = sq_img2
			document.f2.sq_img3.value = sq_img3
			document.f2.sq_img4.value = sq_img4
			document.f2.submit()
		}
	}
</script>
<td>
   <div class="row justify-content-center">
         <div class="col-9 bg-white">
            <h6 class="py-3 pb-2 border-bottom"><b>문의내역</b> (${count })</h6>
            <table class="table">
            <c:if test="${empty myPageQnA }">
            	작성한 상품 문의 내역이 없습니다.
            </c:if>
               <c:forEach var="dto" items="${myPageQnA }">
               <div class="accordion" id="accordionExample">
  				<div class="accordion-item">
    			<h2 class="accordion-header">
      			<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${dto.sq_num }" aria-expanded="true" aria-controls="collapse${dto.sq_num }">
        			<c:if test="${dto.sq_secret eq 0 && dto.sq_check eq 0}">
						[${dto.sq_type}]<b>${dto.sq_title}</b>&nbsp;${dto.sq_regdate }<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis"></span>
					</c:if>
					<c:if test="${dto.sq_secret eq 0 && dto.sq_check eq 1}">
						[${dto.sq_type}]<b>${dto.sq_title}</b>&nbsp;${dto.sq_regdate }<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis"><font color="black">답변 완료</font></span>
					</c:if>
					<c:if test="${dto.sq_secret eq 1 && dto.sq_check eq 0}">
						🔒 [${dto.sq_type}]<b>${dto.sq_title}</b>&nbsp;${dto.sq_regdate }<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis"></span>
					</c:if>
					<c:if test="${dto.sq_secret eq 1 && dto.sq_check eq 1}">
						🔒[${dto.sq_type}]<b>${dto.sq_title}</b>&nbsp;${dto.sq_regdate }<span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis"><font color="black">답변 완료</font></span>
					</c:if>
      			</button>
    			</h2>
    			<div id="collapse${dto.sq_num }" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
      			<div class="accordion-body">
      				<div align="right">
      					<a href="shop_myPage_ProdQnA_updateForm.do?sq_num=${dto.sq_num }"><button type="button" class="btn btn-outline-secondary">수정</button></a>
      					<a href="javascript:checkDel('${dto.sq_num}','${getMemNum }','${dto.sq_img1 }','${dto.sq_img2 }','${dto.sq_img3 }','${dto.sq_img4 }')"><button type="button" class="btn btn-outline-secondary">삭제</button></a>
      				</div>
        		<strong>❔ 문의 내역 </strong><br>
        		<c:if test="${!empty dto.sq_img1 }">
					<img src="resources/img/${dto.sq_img1 }" width="100" height="100">
				</c:if>
				<c:if test="${!empty dto.sq_img2 }">
					<img src="resources/img/${dto.sq_img2 }" width="100" height="100">
				</c:if>
				<c:if test="${!empty dto.sq_img3 }">
					<img src="resources/img/${dto.sq_img3 }" width="100" height="100">
				</c:if>
				<c:if test="${!empty dto.sq_img4 }">
					<img src="resources/img/${dto.sq_img4 }" width="100" height="100">
				</c:if>
				<br><br><br>
				${dto.sq_content }
				<br>
				<br>
				<br>
        		<code>❓ <b>관리자 답변 </b></code>
        		<br>
        		  <c:if test="${dto.sq_check eq 0}">
                 답변을 기다리고 있습니다.
              </c:if>
              <c:if test="${dto.sq_check eq 1}">
                 ${dto.sq_reply}
              </c:if>
      			</div>
    			</div>
  				</div>
  				</div>
             </c:forEach>
            </table>
         </div>
      </div>
     </td>
   </tr>
</table>
<div align="center">
<form name="f" action="shop_myPage_prodQnA.do" method="post">
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
   <c:if test="${count > 0}">
	         <c:if test="${startPage > pageBlock}">
	             <li class="page-item">
	            <a class="page-link" href="shop_myPage_prodQnA.do?mem_num=${getMemNum }&pageNum=${startPage - pageBlock}" aria-label="Previous">
	              <span aria-hidden="true">&laquo;</span>
	            </a>
	            </li>
	         </c:if>
	         
	         <c:forEach var="i" begin="${startPage}" end="${endPage}">
	             <li class="page-item">
	              <a class="page-link" href="shop_myPage_prodQnA.do?mem_num=${getMemNum }&pageNum=${i}">${i}</a></li>
	       </c:forEach>
	    
	   <c:if test="${endPage < pageCount}">
	             <li class="page-item">
	               <a class="page-link" href="shop_myPage_prodQnA.do?mem_num=${getMemNum }&pageNum=${startPage + pageBlock}" aria-label="Next">
	                 <span aria-hidden="true">&raquo;</span>
	              </a>
	          </li>
	        </c:if>  
    </c:if>
     </ul>
</nav>
</form>
</div>
<form name="f2" action="shop_myPage_qna_delete.do" method="post">
	<input type="hidden" name="sq_num">
	<input type="hidden" name="mem_num">
	<input type="hidden" name="sq_img1" value="${dto.sq_img1 }">
	<input type="hidden" name="sq_img2" value="${dto.sq_img2 }">
	<input type="hidden" name="sq_img3" value="${dto.sq_img3 }">
	<input type="hidden" name="sq_img4" value="${dto.sq_img4 }">
</form>
<%@include file="myPage_bottom.jsp" %>