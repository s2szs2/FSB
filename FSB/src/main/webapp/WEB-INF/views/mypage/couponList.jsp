<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- gameLikeList.jsp -->
<%@include file="../user/user_top.jsp" %>
<script type="text/javascript">

	
function check(){
    var isDel = window.confirm("정말로 삭제하겠습니까?")
    if (isDel){
       document.f2.submit()
    } return false
 }
</script>

<body>
<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
  		<div class="list-group list-group-flush border-bottom scrollarea">
 <br>
     <br>
     <div style="margin: 0 auto;">   
     <form name="f2" action="couponDel.do" method="post" onsubmit="return check()">
      	
        <table class="table" style="width:1500px;" >
  	<tr>
  		<td align="center"><font size="5" color="black">🎴 발급받은 쿠폰 목록</font></td>
  	</tr>
  	
  <tr>
  	<td>
 <c:if test="${empty CouponList}">
 	발급 받은 쿠폰이 없습니다.
 </c:if>
 
<c:if test="${not empty CouponList}">
				
	<c:forEach var="dto" items="${CouponList}">
				
  				<div class="card-group">
                             <div class="card text-center mb-3" style="max-width: 40rem; max-height: 15rem;">
                             <div class="card-body">
                             <div align="right"> <button type="submit" class="btn btn-outline-primary" id="change-password-cancel-btn" >삭제</button></div>
                            <h5 class="card-title">${dto.bc_title}</h5>
                            <p class="card-text"><font color="blue"><strong>${dto.bc_content}</strong></font></p>
                            <p class="card-text"><font color="red">${dto.bc_duedate}에 만료</font></p>
                      <div class="card-footer">
                    <!-- 만약 쿠폰 수량이 0보다 작거나 같다면 쿠폰 소진 -->
                 <%--      <div align="center"><strong>${dto.bp_store_name}</strong></div> --%>
                </div>
			</div>
			</div>
			</div>
			<input type="hidden" name="num" value="${dto.mem_num}"/>
			<input type="hidden" name="bc_num" value="${dto.bc_num}"/>
	</c:forEach>
	
</c:if>
</td>
</tr>
</table>

</form>
  	</div>
  	</div>
</main>
</body>

<%@include file="../user/user_bottom.jsp" %>