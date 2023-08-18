<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script src="resources/js/jquery-3.7.0.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.bundle.min.js"></script>

 <link rel="stylesheet" type="text/css" href="resources/css/button.css">
<!-- 핸드폰 번호 변경 .jsp  -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
</head>
<body>


<script type="text/javascript">
	function check(){
		alert("인증번호발송.")
		return true
	}
	
	
</script>

<br>

<div width="80%" height="80%" align="center">


		<h2 align="center">핸드폰 번호 등록/변경</h2>

	
 <br>	
      


<!-- 휴대폰 번호 -->

 <form name="f" action="changePhoneSMS.do" method="post" onsubmit="return check()">
 <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
<div class="input-group mb-3 w-75">
  <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" title="전화번호 입력(-생략)" placeholder="휴대폰번호" aria-label="Recipient's username" aria-describedby="button-addon2" >
  <button class="btn btn-light" type="submit" id="phoneChk" value="입력">인증 요청</button>
  </div>
    </form>
  <!-- 인증번호 입력칸 생성 --> 	
 	
 	<form name="f2" action="sendSMS_ok.do" method="post" onsubmit="return numCheck('${numStr}')">
 	  <input type="hidden" name="phoneNumber" value="${phoneNumber}"/>
 	  <input type="hidden" name="name" value="${name}"/>
 	  
 	<div class="input-group mb-3 w-75">
 	
 		<input type="hidden" name="numStr" value="${numStr}"/>
            <input  class="form-control" id="phone2" type="text" name="numberok" title="인증번호 입력" value="${numberok}" placeholder="인증번호 입력해주세요" aria-label="Recipient's username2" aria-describedby="button-addon2">
            <button type="submit" class="btn btn-light"  value="인증확인" id="phoneChk2" disabled>인증 확인</button> 
        </div>     
   </form>

             <button type="button" class="btn btn-outline-primary" id="change-email-cancel-btn">취소</button>
                                <button type="button" class="btn btn-outline-primary" disabled id="change-email-finish-btn" disabled="">완료</button>
    
      <!-- 폼 끝 -->
       
</div>


       
 
        	
      


    
</body>
</html>