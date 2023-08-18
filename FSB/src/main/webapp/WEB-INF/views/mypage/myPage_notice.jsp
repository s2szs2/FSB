<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPage_notice.jsp -->
<%@include file="../user/user_top.jsp" %>
<body>
<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
<c:if test="${empty noticeList }">
<div style="margin: 0 auto;">     	
        <table class="table" style="width:1500px;" >
  	<tr>
  		<td align="center"><font size="5" color="black">공지사항</font></td>
  	</tr>
  	</table>
</div>
	등록된 공지사항이 없습니다.
</c:if>
<c:if test="${not empty noticeList }">
<div style="margin: 0 auto;">     	
        <table class="table" style="width:1500px;" >
  	<tr>
  		<td align="center"><font size="5" color="black">공지사항</font></td>
  	</tr>
  	</table>
<div class="row row-cols-2">
	<c:forEach var="dto" items="${noticeList }">
 	<div class="col">
		<div class="accordion accordion-flush" id="accordionFlushExample" style= "width:600px; margin: 100px 100px" >
  			<div class="accordion-item">
    			<h2 class="accordion-header">
      				<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne${dto.n_num }" aria-expanded="false" aria-controls="flush-collapseOne${dto.n_num }">
        				${dto.n_title }
      				</button>
    				</h2>
    			<div id="flush-collapseOne${dto.n_num }" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
      				<div class="accordion-body">${dto.n_regdate }<br>${dto.n_content }</div>
    			</div>
  			</div>
		</div>
	</div>
	</c:forEach>
</div>
</div>
</c:if>
	</main>
</body>
<%@include file="../user/user_bottom.jsp" %>