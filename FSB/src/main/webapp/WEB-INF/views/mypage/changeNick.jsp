<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- 닉네임 변경 .jsp -->
   <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script>
 function check(){
	 if(f.nickName.value == ""){
		 alert("닉네임을 입력하세요")
		 f.nickName.focus()
		 return false
	 }
	 return true
 }

</script>
<body>

<div align="center">
<br>
<h2>닉네임 변경</h2>
 

                                    <li class="txt-black">이번달 수정 가능 횟수 <strong>4회</strong><span class="txt-default">(월 최대 4회까지만 변경 가능합니다.)</span>
                                    </li>
                                    <li>길이는 최대 15자 이내로 작성해주세요.</li>
                                    <li>중복 닉네임 불가합니다.</li>

                                   <br>
                                   <form name="f" id="f" method="post" action="changeNickCheck.do" onsubmit="return check()">
                                    <input type="hidden" id="id" name="id" value="${login_mem.getMem_id()}">
                                   <div class="input-group mb-3  w-75 p-3" style="margin:0; padding:0;">
              						<input type="text" id="nickName" name="nickName" class="form-control" placeholder="닉네임 입력(최대 15자)" maxlength="15"> 
              						 <button type="submit" class="btn btn-outline-primary" id="send-authentication-email">중복확인</button>                  
                                   </div>
                                   </form>
                                    <br>
                                    
                                        <form name="f2" id="f2" method="post" action="changeNickOk.do">
                                         <input type="hidden" id="id" name="id" value="${login_mem.getMem_id()}">
                                          <input type="hidden" id="nickname" name="nickname" value="nickName">             
                                        <button type="button" class="btn btn-outline-primary" id="change-password-cancel-btn" onclick="window.close()">취소</button>
                                        <!-- <button type="submit" class="btn btn-outline-primary" id="change-password-finish-btn"  disabled="">사용하기</button> -->
                                

           </form>
           </div>      
<script>
opner.location.reload() 
</script>        
  	
</body>
