<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPage_coupon.jsp -->
<%@include file="myPage_top.jsp" %>
	<td>
		<h5>내 쿠폰 목록 (${getCoupon })</h5>
		<hr>
	<div class="row row-cols-3">
<c:if test="${empty myPageCoupon }">
	&nbsp;&nbsp;보유한 쿠폰이 없습니다.
</c:if>
  		<c:forEach var="dto" items="${myPageCoupon }">
  		<div class="col">
	<div class="card mb-3" style="max-width: 500px;">
  		<div class="row g-0">
    		<div class="col-md-4">
    			<c:if test="${dto.sc_type eq 'delchar' }">
      			 	<img src="resources/img/coupon_1.png" class="img-fluid rounded-start" alt="배송지쿠폰" width="200px" height="200px">
      			</c:if>
      			<c:if test="${dto.sc_type eq '-' }">
      				<img src="resources/img/coupon_2.png" class="img-fluid rounded-start" alt="금액쿠폰" width="200px" height="200px">
      			</c:if>
      			<c:if test="${dto.sc_type eq '%' }">
      				<img src="resources/img/coupon_3.png" class="img-fluid rounded-start" alt="할인율쿠폰" width="200px" height="200px">
      			</c:if>
    		</div>
    	<div class="col-md-8">
     		 <div class="card-body">
        <h4 class="card-title">${dto.sc_name}</h4>
        <p class="card-text">
        <font size="3" color="red">
       		<b>${dto.sc_discount }</b>
       		<c:if test="${dto.sc_type eq 'delchar' }">
       			원
       		</c:if>
       		<c:if test="${dto.sc_type eq '-' }">
   				원
        	</c:if>
        	<c:if test="${dto.sc_type eq '%' }">
        		% 할인
        	</c:if>
        </font>
        <br>
        <c:if test="${dto.sc_limit ne 0 }">
        <font size="2">
       		${dto.sc_min }원 이상 구매 시 사용 가능
       		<br> 최대 ${dto.sc_limit }원 할인
       	</font>
       	<br>
       	</c:if>
       	<c:if test="${dto.sc_limit eq 0 }">
       	<font size="2">
       		${dto.sc_min }원 이상 구매 시 사용 가능
       		<br> -
       	</font>
       	<br>
       	</c:if>
        	<b>발행일</b> : ${dto.usc_regdate }<br>
        	<b>유효기간</b> : ${dto.usc_duedate }
        </p>
      		</div>
    	</div>
  		</div>
	</div>
	</div>
    	</c:forEach>
   </div>
	</td>
</tr>
</table>
<%@include file="myPage_bottom.jsp" %>