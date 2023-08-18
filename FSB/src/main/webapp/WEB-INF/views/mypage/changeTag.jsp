<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--  해시태그 설정.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
  <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<html>
<head>
<meta charset="UTF-8">
<title>태그 설정</title>
</head>
<body>

<div width="80%" height="80%" align="center">
 <form name="f2" action="changeTagOk.do" method="post">
 <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
<br>
		<h2 align="center">해쉬태그 설정</h2>
		<hr color ="gray" width="80%">
		
	 <c:if test="${tag1 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1" id="flexCheckDefault1" checked >
	 </c:if>
	 <c:if test="${tag1 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="0" id="flexCheckDefault1">
	 </c:if>
	 &nbsp;추리&nbsp;
	 
	 <c:if test="${tag2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check2" value="1" id="flexCheckDefault2" checked >
	 </c:if>
	 <c:if test="${tag2 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check2" value="0" id="flexCheckDefault2">
	 </c:if>
	 &nbsp;전략&nbsp;
	 
	 <c:if test="${tag3 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check3" value="1" id="flexCheckDefault3" checked >
	 </c:if>
	 <c:if test="${tag3 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check3" value="0" id="flexCheckDefault3">
	 </c:if>
	 &nbsp;카드&nbsp;
	 
	 <c:if test="${tag4 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check4" value="1" id="flexCheckDefault4" checked >
	 </c:if>
	 <c:if test="${tag4 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check4" value="0" id="flexCheckDefault4">
	 </c:if>
	 &nbsp;공포/스릴러&nbsp;
	 <br>
	 <c:if test="${tag5 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check5" value="1" id="flexCheckDefault5" checked >
	 </c:if>
	 <c:if test="${tag5 eq 0}">		
	 <input class="form-check-input" type="checkbox"name="check5"  value="0" id="flexCheckDefault5">
	 </c:if>
	 &nbsp;판타지&nbsp;
	 
	 <c:if test="${tag6 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check6" value="1" id="flexCheckDefault6" checked >
	 </c:if>
	 <c:if test="${tag6 eq 0}">		
	 <input class="form-check-input" type="checkbox"  name="check6" value="0" id="flexCheckDefault6">
	 </c:if>
	 &nbsp;역사&nbsp;
	 
	 <c:if test="${tag7 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check7" value="1" id="flexCheckDefault7" checked >
	 </c:if>
	 <c:if test="${tag7 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check7"  value="0" id="flexCheckDefault7">
	 </c:if>
	 &nbsp;공상과학&nbsp;
	 
	 <c:if test="${tag8 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check8" value="1" id="flexCheckDefault8" checked >
	 </c:if>
	 <c:if test="${tag8 eq 0}">		
	 <input class="form-check-input" type="checkbox" name="check8" value="0" id="flexCheckDefault8">
	 </c:if>
	 &nbsp;스포츠&nbsp;
	

		<hr color ="gray" width="80%">
		<div align="center">
		<b>✔본인의 보드게임 취향을 설정해주세요</b>		
		</div>
		
		<br>
		<div align="center">
		<button type="button" class="btn btn-outline-primary" id="change-email-cancel-btn" onclick="window.location='close_nomessage.do'">취소</button>
        <button type="submit" class="btn btn-outline-primary" id="change-email-finish-btn">완료</button>
		</div>
		</form>
</div>
</body>
</html>