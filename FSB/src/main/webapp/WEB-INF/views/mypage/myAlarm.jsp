<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- d알람리스트.jsp.jsp -->
<%@include file="../user/user_top.jsp" %>

<link rel="stylesheet" type="text/css" href="resources/css/popup.css">
<script type="text/javascript">

	
function check(alm_num){
   	   document.f3.alm_num.value=alm_num
       document.f3.submit()

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
     <form name="f2" action="alarmDel.do" method="post" >
      	
    
  		<font size="5" color="black">알림함</font>

	
	        
     <table class="table" style="width:1500px;" >
  
  
 <c:if test="${empty boardAlarmList}">
 	<tr>
  	<td>
 	새로운 알림이 없습니다.</td></tr>
 </c:if>
 
 	
<c:if test="${not empty boardAlarmList}">
	
 		
	<c:forEach var="dto" items="${boardAlarmList}">
	<input type="hidden" id="num" name="num" value="${dto.alm_num}">
        <tr>
        <td>  <c:if test="${dto.alm_read eq 0}">  <a href="alarmContent.do?sort=${dto.alm_cate}"  target='_blank'>                 
       <font size="2" color="gray">${dto.alm_cate}</font><font size="2" color="gray">. ${dto.alm_regdate}</font><br>
                            <font size="3" color="black"><strong>${dto.alm_title}</strong></font> <br>       
                      <font size="3" color="gray">${dto.alm_content}</font><br> </a>
                     <a href="alarmOk.do?num=${dto.alm_num}"><button type="button" class="btn btn-outline-primary btn-sm"  name="alm_num" id="alm_num">확인</button></a>
                     <button type="submit" class="btn btn-outline-primary btn-sm" id="del" >삭제</button>
                    </c:if>
                     
                  <c:if test="${dto.alm_read eq 1}"> <a href="alarmContent.do?sort=${dto.alm_cate}"  target='_blank'>                   
       <font size="2" color="gray">${dto.alm_cate}</font><font size="2" color="gray">. ${dto.alm_regdate}</font><br>
                            <font size="3" color="black"><strong>${dto.alm_title}</strong></font> <br>       
                      <font size="3" color="gray">${dto.alm_content}</font><br></a>
                     <button type="button" class="btn btn-outline-primary btn-sm"  disabled id="ok" >확인</button>
                     <button type="submit" class="btn btn-outline-primary btn-sm" id="del" >삭제</button>
                     </c:if>
                     
                     </td></tr>
       
	
		
	</c:forEach>
	
</c:if>

</table>
	

	</form>
	</div>
	</div>
</main>

 <form name="f3" action="alarmOk.do">
 </form>

</body>

<%@include file="../user/user_bottom.jsp" %>