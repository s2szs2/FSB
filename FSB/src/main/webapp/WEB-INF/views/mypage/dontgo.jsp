<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--  회원 탈퇴 선택 제이에스피.jsp -->
<%@include file="../user/user_top.jsp" %>
<link rel="stylesheet" type="text/css" href="resources/css/file.css">
<script type="text/javascript">


	
	
	function changeBirth() {
		         document.f3.submit()
		   }
</script>
	
<body>	
  <main class="d-flex flex-nowrap">
     
        <!-- 사이드 바 -->
        <%@include file="../user/sns_top.jsp" %>
        
 <form name="f3" action="dontgoplz.do" method="post">
 <input type="hidden" name="nickname" value="${login_mem.mem_nickname}"/>
        <div align="center" style="margin: 0 auto;">
         <table class="table" style="width:1000px;">
      <br>

          <tr>
      <th scope="col"><font size="12" color=black>탈퇴사유선택</font></th>
    </tr>

  
  
  
    <tr>
      <th scope="row"  align="center">
      <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="1" id="flexRadioDefault1" checked>
 		 <label class="form-check-label" for="flexRadioDefault1">상품탐색이 어려워요 </label>
 		 </div>
  </th>
    </tr>
    
       <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="2" id="flexRadioDefault2">
 		 <label class="form-check-label" for="flexRadioDefault2">관심있는 보드게임이 없어요</label>
 		 </div>
  </th>
    </tr>
    
           <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="3" id="flexRadioDefault3">
 		 <label class="form-check-label" for="flexRadioDefault3">개인정보 유출이 우려돼요</label>
 		 </div>
  </th>
    </tr>
    
             <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="4" id="flexRadioDefault4">
 		 <label class="form-check-label" for="flexRadioDefault4">다른 계정이 있어요</label>
 		 </div>
  </th>
    </tr>
    
              <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason"  value="5" id="flexRadioDefault5">
 		 <label class="form-check-label" for="flexRadioDefault5">재가입 예정이에요</label>
 		 </div>
  </th>
    </tr>
   
                <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="6" id="flexRadioDefault6">
 		 <label class="form-check-label" for="flexRadioDefault6">광고 알람이 너무 많이와요</label>
 		 </div>
  </th>
    </tr>
    
                    <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="7" id="flexRadioDefault7">
 		 <label class="form-check-label" for="flexRadioDefault7">상품의 가격이 비싸요</label>
 		 </div>
  </th>
    </tr>
    
                        <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="8"  id="flexRadioDefault8">
 		 <label class="form-check-label" for="flexRadioDefault8">상품의 배송이 느려요</label>
 		 </div>
  </th>
    </tr>
    
                            <tr>
      <th scope="row" align="center">
       <div class="form-check">
 		<input class="form-check-input" type="radio" name="reason" value="9" id="flexRadioDefault9">
 		 <label class="form-check-label" for="flexRadioDefault9">기타</label>
 		<input type="text" style="width:300px;" placeholder="탈퇴사유를 입력해 주세요.">
 		</div>
  </th>
    </tr>
 
    </table>
    
      <div class="btn-group">
 <button type="button" class="btn btn-dark rounded-0" id="change-password-cancel-btn" onclick="window.location='user_main.do'">탈퇴그만두기</button>
 <button type="submit" class="btn btn-light rounded-0" id="change-password-finish-btn">다음</button>
   </div>
   
   </div>
   </form>
</main>   
 	
  		
</body>
<%@include file="../user/user_bottom.jsp" %>


