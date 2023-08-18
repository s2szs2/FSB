<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
  <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	
<!-- 뱃지 설정 .jsp  -->
<html>
<head>
<meta charset="UTF-8">
<title>뱃지 설정</title>
</head>
<body>

 <form name="f2" action="changeBadgeOk.do" method="post">
 <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
<div width="80%" height="80%" align="center">

<br>
		<h2 align="center">뱃지 설정</h2>
		<hr color ="gray" width="80%">
	
	 <c:if test="${badge_king_2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault1" checked >&nbsp;<img src="resources/img/king.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_king eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault1" >&nbsp;<img src="resources/img/king.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_king eq 0}">		
	 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault1" disabled >&nbsp;<img src="resources/img/king.png" width="40" height="40">
	 </c:if>		
	 
	 
	 <c:if test="${badge_write_2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault2" checked >&nbsp;<img src="resources/img/write.png" width="40" height="40">
	 </c:if>
	 
	  <c:if test="${badge_write eq 1}">		
	 <input class="form-check-input" type="checkbox"  name="check2" value="1"  id="flexCheckDefault2" >&nbsp;<img src="resources/img/write.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_write eq 0}">		
	 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault2" disabled >&nbsp;<img src="resources/img/write.png" width="40" height="40">
	 </c:if>
	 
	 
	  <c:if test="${badge_1004_2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault3" checked >&nbsp;<img src="resources/img/1004.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_1004 eq 1}">		
	 <input class="form-check-input" type="checkbox"  name="check3" value="1"  id="flexCheckDefault3" >&nbsp;<img src="resources/img/1004.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_1004 eq 0}">		
	 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault3" disabled >&nbsp;<img src="resources/img/1004.png" width="40" height="40">
	 </c:if>	
	 
	 
	 
	 <c:if test="${badge_good_2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault4" checked >&nbsp;<img src="resources/img/good.png" width="40" height="40">
	 </c:if>
	 
	  <c:if test="${badge_good eq 1}">		
	 <input class="form-check-input" type="checkbox"  name="check4" value="1"  id="flexCheckDefault4" >&nbsp;<img src="resources/img/good.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_good eq 0}">		
	 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault4" disabled >&nbsp;<img src="resources/img/good.png" width="40" height="40">
	 </c:if>		
	 
	 
	 <c:if test="${badge_rich_2 eq 1}">		
	 <input class="form-check-input" type="checkbox" name="check1" value="1"  id="flexCheckDefault5" checked >&nbsp;<img src="resources/img/rich.png" width="40" height="40">
	 </c:if>
	 
	   <c:if test="${badge_rich eq 1}">		
	 <input class="form-check-input" type="checkbox"  name="check5" value="1"  id="flexCheckDefault5" >&nbsp;<img src="resources/img/rich.png" width="40" height="40">
	 </c:if>
	 
	 <c:if test="${badge_rich eq 0}">		
	 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault5" disabled >&nbsp;<img src="resources/img/rich.png" width="40" height="40">
	 </c:if>		
		
		
		<hr color ="gray" width="80%">
		<div align="center">
		• 출석왕 - 출석 횟수가 100회 이상일 시 획득 <br>
		• 게시글 왕 - 게시글 수가 100개 이상일 시 획득  <br>
		• 1004 - 답글 수가 100개 이상일 시 획득 <br>
		• 따봉왕 - 좋아요 수가 30개 이상일 시 획득  <br>
		• 만수르 - 보드게임 구매목록이 10개 이상일 시 획득 <br><br>
		<b>✔뱃지는 자동으로 획득되며, 원하지 않을시 비활성화 가능</b>
		</div>
		
		<br>
		<div align="center">
		<button type="button" class="btn btn-outline-primary" id="change-email-cancel-btn" onclick="window.location='close_nomessage.do'">취소</button>
        <button type="submit" class="btn btn-outline-primary" id="change-email-finish-btn">완료</button>
		</div>
</div>
</form>
</body>
</html>