<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- naverLogout.jsp -->
<script type="text/javascript">
	if('${loginMode }'=='naverLogin'){
		location.href="${url}"
		alert("${msg}")
		location.href="user_main.do"
	}
	
	if('${loginMode }'!='naverLogin'){
		alert("${msg}")
		location.href="user_main.do"
	}
</script>