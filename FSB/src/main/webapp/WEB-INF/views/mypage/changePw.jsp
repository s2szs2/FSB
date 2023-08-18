<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<body>
<!-- 비밀번호 재설정.jsp -->

  		  <!-- 비밀번호 수정 -->
    <tr id="change-password-area" style="">
                        <th scope="row"></th>
                        <td colspan="2">
                            <div class="input-group mb-3" style="margin-bottom:0; margin-top:0;" id="changePw">
                                <div class="input-group mb-3" style="margin-bottom:0; margin-top:0;">
                                    <input type="hidden" id="encryptPassword">
                                    <input type="hidden" id="encryptNewPassword">
                                    <input type="hidden" id="encryptConfirmPassword">
                                    <div class="input-group mb-3 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="password" style="margin-top: 8px;">현재 비밀번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" class="form-control" id="password"> 
                                    </div>
                                    <div class="input-group mb-3  w-50 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="newPassword" style="margin-top: 8px;">신규 비밀번호</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   										 <input type="password" class="form-control" id="newPassword" maxlength="30">  
                                        </div>
                                        <span id="new-password-invalid" class="validate danger" style="display: none;"></span>
                                        <span id="valid-newPassword" class="validate" style="display: none">사용 가능한 비밀번호입니다.</span>
                                    </div>
                                    
                                    <div class="input-group mb-3  w-50 w-75" style="margin-bottom:0; margin-top:0;">
                                        <label for="confirmPassword" style="margin-top: 8px;">비밀번호 재입력</label>&nbsp;&nbsp;          
                                            <input type="password" class="form-control" id="confirmPassword" onkeyup="keyupFn();" maxlength="30">                                           
                                        </div>
                                        <span id="confirm-password-invalid" class="validate danger"></span>
                                        <span id="valid-confirmPassword" class="form-control" style="display: none">사용 가능한 비밀번호입니다.</span>
                                    </div>
                                    
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-outline-primary" id="change-password-cancel-btn" onclick="javascript:cancel('${dto.br_num}')">취소</button>
                                        <button type="button" class="btn btn-outline-primary" id="change-password-finish-btn" onclick="javascript:changePwOk('${login_mem.getMem_passwd()}')"  disabled="">완료</button>
                                        
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
                
                
            	function cancel(){ 
            		history.back()
            	}
            	
              	function changePwOk("${login_mem.getMem_passwd()}"){ 
        			var passwd = "${login_mem.getMem_passwd()}";
        		   if (passwd!=password.value){
        		         alert("현재 비밀번호가 틀립니다.")
        		         history.back()
        		  		//어디로 이동해라
        		  		
        		    }else {
        		    	history.back()
        		    	  //window.open("duplication.do?"", "width=250, height=150, left=1200, top=350")
        		      }
        		}
                </script>
                
                                    </div>
                                </div>
                        </div></td>
                    </tr>
                    
  	
</body>
