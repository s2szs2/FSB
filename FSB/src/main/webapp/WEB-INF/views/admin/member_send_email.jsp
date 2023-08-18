<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- member_send_email.jsp // 안내 메일 발송 -->

<!-- css, js 연결 -->
	<script src="resources/js/jquery-3.7.0.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<!-- 	<script src="resources/js/bootstrap.min.js"></script> -->
	<script src="resources/js/bootstrap.bundle.min.js"></script>


<script type="text/javascript">
	function check() {
		if (f.title.value == "") {
			alert("제목을 입력해주세요!")
			f.title.focus()
			return false
		}
		if (f.content.value == "") {
			alert("내용을 입력해주세요")
			f.content.focus()
			return false
		}
		return true		
	}
</script>
<div align="center">
	<p>
	<p>
	<h5>메일 내용 작성</h5>
	
	<form name="f" action="admin_member_sendEmail.do" method="post" onsubmit="return check()">
		<table border="0">
			<tr align="center">
				<th>제목</th>
				<td><input type="text" name="title" class="form-control"></td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="hidden" name="mem_num" value="${mem_num}"/>
					<textarea name="content" class="form-control" rows="5" cols="50"></textarea>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<button type="submit" class="btn btn-secondary btn-sm">메일 발송</button>
					<button type="reset" class="btn btn-secondary btn-sm">다시 입력</button>
				</td>
			</tr>
		</table>
	</form>
</div>