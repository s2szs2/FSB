<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


<body>
    
  <!--이메일 인증-->
             <!--    <tr id="change-email-area" style="display: none;">
                    <th scope="row">이메일</th> -->
                    <td colspan="2">
                        <div class="input-group mb-3">
                            <ul class="n-info-txt">
                                <li>메일주소 입력 후 인증하기 버튼을 누르시면, <br>회원님의 이메일로 인증 번호가 적힌메일이 발송됩니다.</li>
                                <li>아래에 인증 번호를 입력하시면 인증이 완료됩니다.</li>
                            </ul>
                        </div>
                                </td>
                             <td colspan="2">
                            <div class="input-group mb-3  w-75 p-3" style="margin:0; padding:0;">
                                <input type="text" class="form-control" style="width: 50px;"placeholder="이메일 주소 입력" id="email"  onkeyup="keydownFn();" maxlength="50">
                                 <button type="button" class="btn btn-outline-primary" id="send-authentication-email"  disabled="">인증</button> 
                            </div>
                           </td>
                             <td colspan="2">
                            <div class="input-group mb-3 w-75 p-3">
                                <input type="text" class="form-control" id="email-authTempKey" maxlength="6" placeholder="인증번호 입력" onkeyup="keyupFn();">
                            <button type="button" class="btn btn-outline-primary" id="change-email-cancel-btn">취소</button>
                                <button type="button" class="btn btn-outline-primary" disabled id="change-email-finish-btn" disabled="">완료</button>
                                </div>
                    </td>
                </tr>

                <script>
                const emailInput = document.querySelector('#email'); // email 선택
                keydownFn = () => { // 함수 이름   
                  console.log(emailInput.value.length); // 키 누를때마다 f12(개발자도구) console 창에서 확인가능
                  if(emailInput.value.length >= 6){ // 인증번호가 6자리이면
                    document.querySelector('#send-authentication-email').removeAttribute('disabled'); // botton 에 disabled 속성을 지워라
                  }
                  if(emailInput.value.length <= 6){ // 인증번호가 6자리 아니면
                    document.querySelector('#send-authentication-email').setAttribute('disabled', ''); // botton 에 disabled 속성을 생성해라
                  }
                };
                
                  const numberInput = document.querySelector('#email-authTempKey'); // email 선택
                  keyupFn = () => { // 함수 이름   
                    console.log(numberInput.value.length); // 키 누를때마다 f12(개발자도구) console 창에서 확인가능
                    if(numberInput.value.length === 6){ // 인증번호가 6자리이면
                      document.querySelector('#change-email-finish-btn').removeAttribute('disabled'); // botton 에 disabled 속성을 지워라
                    }
                    if(numberInput.value.length !== 6){ // 인증번호가 6자리 아니면
                      document.querySelector('#change-email-finish-btn').setAttribute('disabled', ''); // botton 에 disabled 속성을 생성해라
                    }
                  };
                </script>
  	
</body>
