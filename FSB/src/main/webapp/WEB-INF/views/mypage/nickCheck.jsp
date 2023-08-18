<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"
    %>
<!-- s닉네임 중복확인.jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	Integer result = (Integer) session.getAttribute("result");
%>

   <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="user_id" value="${nickname}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복 확인</title>
<script type="text/javascript">
	function sendCheckValue() {
		var openJoinfrm = opener.document.f2;
		if (document.checkIdForm.chResult.value=="N") {
			alert("다른 아이디를 입력해주세요.");
			openJoinfrm.id.focus();
			
			window.close();
		}else {
			// 중복체크 결과인 idCheck 값을 전달
			openJoinfrm.idDuplication.value="idCheck";
			openJoinfrm.dbCheckId.disabled=true;
			openJoinfrm.dbCheckId.style.opacity=0.6;
			openJoinfrm.dbCheckId.style.cursor="default";
			openJoinfrm.email.readOnly = true;
			window.close();
		}
		
	}
</script>
</head>
<body>
<div align="center">
<br>
<br>
	<b><font size="4" color="gray">ID 중복 확인</font></b>
	<br>
	
	<form name="checkIdForm" action="nickChangeOK.do">
		 <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
		<input type="text" name="nickname" value="${nickname}" id="userId" >
			
		<c:choose>
		<c:when test="${result==1}">
			<p style="color: red">이미 사용 중인 닉네임입니다.</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:when>
		<c:when test="${result==0 }">
			<p style="color: red">사용가능한 닉네임입니다.</p>
			<input type="hidden" name="chResult" value="Y"/>
		</c:when>
		<c:otherwise>
			<p>오류 발생(-1)</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:otherwise>
		</c:choose>
	<c:if test="${result==1}">
		<input type="submit" class="btn btn-outline-primary" onclick="sendCheckValue()" style="width: 5rem;" value="사용하기" disabled/>&nbsp;<input type="button" onclick="window.close()" class="btn btn-outline-primary" style="width: 5rem;" value="취소"/><br>
		</c:if>
		<c:if test="${result==0 }">
<input type="submit" class="btn btn-outline-primary" onclick="sendCheckValue()" style="width: 5rem;" value="사용하기"/>&nbsp;<input type="button" onclick="window.close()" class="btn btn-outline-primary" style="width: 5rem;" value="취소"/><br>
	</c:if>
	</form>
</div>
</body>
</html>