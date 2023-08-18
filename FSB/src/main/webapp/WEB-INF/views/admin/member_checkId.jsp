<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_checkId.jsp // 아이디 중복체크 -->

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="user_id" value="${id}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 확인</title>
<script type="text/javascript">
	function sendCheckValue() {
		var openJoinfrm = opener.document.f;
		
		if (document.checkIdForm.chResult.value=="N") {
			alert("다른 아이디를 입력해주세요.");
			openJoinfrm.mem_id.focus();
			
			window.close();
		}else {
			// 중복체크 결과인 idCheck 값을 전달
			openJoinfrm.idDuplication.value="idCheck";
			openJoinfrm.dbCheckId.disabled=true;
			openJoinfrm.mem_id.readOnly = true;
			window.close();
		}
		
	}
</script>
</head>
<body>
<div align="center">
	<b><font size="4" color="gray">ID 중복 확인</font></b>
	<br>
	
	<form name="checkIdForm">
		<input type="text" name="id" value="${id}" id="userId" disabled>
			
		<c:choose>
		<c:when test="${result==1}">
			<p style="color: red">이미 사용 중인 아이디입니다.</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:when>
		<c:when test="${result==0 }">
			<p style="color: red">사용가능한 아이디입니다.</p>
			<input type="hidden" name="chResult" value="Y"/>
		</c:when>
		<c:otherwise>
			<p>오류 발생(-1)</p>
			<input type="hidden" name="chResult" value="N"/>
		</c:otherwise>
		</c:choose>

		<input type="button" onclick="sendCheckValue()" style="width: 4.5rem;" value="사용하기"/>&nbsp;<input type="button" onclick="window.close()" style="width: 4.5rem;" value="취소"/><br>
		

	</form>
</div>
</body>
</html>