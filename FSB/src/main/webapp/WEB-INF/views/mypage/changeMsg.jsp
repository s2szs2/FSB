<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상태메세지 변경 .jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script src="resources/js/jquery-3.7.0.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.bundle.min.js"></script>

 <link rel="stylesheet" type="text/css" href="resources/css/button.css">

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상태메세지 변경</title>
</head>
<body>

<br>

<div width="80%" height="80%" align="center">


		<h2 align="center">상태메세지 등록/변경</h2>

	
 <br>	
      


<!-- 휴대폰 번호 -->

 <form name="f" action="changeMsg_ok.do" method="post">
 <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
<div class="input-group mb-3 w-75">
  <input type="text" class="form-control" id="changeMsg" name="changeMsg" title="표시하고 싶은 상태메세지 입력" placeholder="표시하고 싶은 상태메세지 입력" aria-label="Recipient's username" aria-describedby="button-addon2" >
  <button class="btn btn-light" type="submit" id="changeMsg_ok" value="입력">등록</button>
  </div>
    </form>
  <!-- 인증번호 입력칸 생성 --> 	
 	
</div>


       
 
        	
      


    
</body>
</html>