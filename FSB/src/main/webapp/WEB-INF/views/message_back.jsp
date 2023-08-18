<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- message.jsp -->

<%
	String msg = (String)request.getAttribute("msg");
%>
<script type="text/javascript">
	alert("<%=msg%>")
	var referrer = document.referrer;
	location.href=referrer
</script>