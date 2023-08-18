<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<body>
 
<!-- 비밀번호 재설정.jsp -->
<div align="center">
<br>
<h2>비밀번호 변경</h2>
 <form name="f2" id="f2" method="post" action="changePwOk.do">
 <table class="table" style="width:90%; height:90%;">
 <tr style="width:400px; height:30px">
 <th>
                          <!--   <div class="input-group mb-3" style="margin-bottom:0; margin-top:0;" id="changePw"> -->
                               <!--  <div class="input-group mb-3" style="margin-bottom:0; margin-top:0;"> -->
                                    <input type="hidden" id="id" name="id" value="${login_mem.getMem_id()}">
                                  
                                    <div class="input-group mb-3 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="password" style="margin-top: 8px;">현재 비밀번호</label></th>
                                        <td><input type="password" class="form-control" id="password" name="password"></td> 
                                    </div>
                                    </tr>
                                    
                                    <tr style="width:400px; height:30px">
                                    <th>
                                    <div class="input-group mb-3  w-50 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="newPassword" style="margin-top: 8px;">신규 비밀번호</label></th>
   										<td> <input type="password" class="form-control" id="newPassword" name="newPassword" maxlength="30"> </td> 
                                        </div>
                                        </tr>
                                        
                                
                                    <tr style="width:400px; height:30px">
                                    <th>
                                    <div class="input-group mb-3  w-50 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="confirmPassword" style="margin-top: 8px;">비밀번호 재입력</label></th>       
                                           <td> <input type="password" class="form-control" id="confirmPassword"  name="confirmPassword"onkeyup="keyupFn();" maxlength="30"> </td>                                          
                                        </div>
                                        </tr>
                                       
                                     <tr align="center">
                                     <th colspan="2" >  
                                  
                                        <button type="button" class="btn btn-outline-primary" id="change-password-cancel-btn" onclick="window.location='close_nomessage.do'">취소</button>
                                        <button type="submit" class="btn btn-outline-primary" id="change-password-finish-btn"  disabled="">완료</button>
                                    </th>
                                    </tr>
                <script>
                const pwInput = document.querySelector('#confirmPassword'); // email 선택
                keyupFn = () => { // 함수 이름   
                  console.log(pwInput.value); // 키 누를때마다 f12(개발자도구) console 창에서 확인가능
                  if(pwInput.value === newPassword.value){ // 새비밀번호&재입력 값이 같으면
                    document.querySelector('#change-password-finish-btn').removeAttribute('disabled'); // botton 에 disabled 속성을 지워라
                  }
                  if(pwInput.value !== newPassword.value){ // 새비밀번호&재입력 값이다르면
                    document.querySelector('#change-password-finish-btn').setAttribute('disabled', ''); // botton 에 disabled 속성을 생성해라
                  }
                };
                
                function changePwOk(mem_num){ // 비밀번호 변경폼
         		   window.open("changePw.do?num="+mem_num, "", "width=530, height=350, left=800, top=250")
         	} 
                
                </script>
                
                                  
                                    </table>
                 </form>
                    </div>
                 
                    
  	
</body>
