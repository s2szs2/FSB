<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../user/user_top.jsp" %>
<!-- 탈퇴시안내사항.jsp -->
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
        
 <form name="f3" action="dontgoplzOk.do" method="post">
        <div style="margin: 0 auto; width:1000px;">
        <br>
      <font size="12" color=black>회원탈퇴</font>
      <hr color="black">
     비밀번호 <input type="password" name="passwd" placeholder="비밀번호 확인">
     <br>
     <br>
     <font size="2" color=black><strong>회원정보/서비스 이용기록 삭제</strong></font><br>
     <font size="2" color=gray>빼찌, 적립금, 포인트, 관심브랜드, 쪽지, 친구등의 데이터가 영구히 삭제되며 복구가 불가능합니다.</font><br>
     <br>
    <font size="2" color=black><strong>등록 게시물 삭제</strong></font><br>
    <font size="2" color=gray>등록된 게시글, 댓글, 후기 등의 데이터도 모두 삭제 됩니다.</font><br>
     <br>
    <font size="2" color=black><strong> 회원 탈퇴 후 재가입이 가능합니다.</strong></font><br> 
    <font size="2" color=gray>동일한 아이디로 재가입 가능합니다.</font><br>
     <br>
     <font size="2" color=black><strong>탈퇴 후 재가입 시 가입 혜택 제한</strong></font><br>
    <font size="2" color=gray>탈퇴 후 재가입 시 신규 가입 헤택에 제한이 있을 수 있습니다.</font><br>
  <br>
     

    
      <div class="btn-group">
 <button type="button" class="btn btn-dark rounded-0" id="change-password-cancel-btn" onclick="window.location='user_main.do'">탈퇴그만두기</button>
 <button type="submit" class="btn btn-light rounded-0" id="change-password-finish-btn" >다음</button>
   </div>
   </div>
   </form>
</main>   
 	
  		
</body>
<%@include file="../user/user_bottom.jsp" %>


