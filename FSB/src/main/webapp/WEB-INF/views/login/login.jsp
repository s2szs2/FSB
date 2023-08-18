<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 로그인jsp.인덱스~ -->

<!-- 부트스트랩 -->
<script src="resources/js/jquery-3.7.0.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.bundle.min.js"></script>


<link rel="stylesheet" type="text/css" href="resources/css/login.css">

<script type="text/javascript">
   function search(mode){
      window.open("find.do?mode="+mode, "", "width=500, height=600, left=800, top=250")
      
   }
   
   function signMember(){
	      window.open("agree.do", "", "width=500, height=600, left=800, top=250")
	      
	   }
   
   function modeCheck(mode){
	      document.f2.mode.value=mode
	      document.f2.submit
	   }
   
   function fn_dbCheckId(){
	   var email = f2.email.value;
	   if (email.length==0 || email==""){
	         alert("이메일 아이디를 입력해 주세요.")
	         f2.email.focus()
	         return false
	      }else {
	    	  window.open("duplication.do?email="+email, "", "width=250, height=150, left=1200, top=350")
	      }
   }
   
   function inputIdChk(){
	   var joinForm = document.f2;
	   var dbCheckId = document.f2.dbCheckId;
	   document.joinForm.idDuplication.value="idUncheck";
	   const target = document.getElementById('dbCheckId');
	   target.dsiabeld=false;
	   dbCheckId.disabled=false;
	   dbCheckId.style.opacity=1;
	   dbCehckId.style.cursor="pointer";
   }
   
   
   
   function signCheck(){
	   var joinForm = document.f2;
	   if (f2.name.value==""){
	         alert("이름을 입력해 주세요.")
	         f2.name.focus()
	         return false
	      }
	   
	   if (f2.email.value==""){
	         alert("이메일 아이디를 입력해 주세요.")
	         f2.email.focus()
	         return false
	      }
	   
	   if (f2.idDuplication.value!="idCheck"){
	         alert("아이디 중복체크를 해주세요.")
	         return false
	      }
	   
	   if (f2.passwd.value==""){
	         alert("비밀번호를 입력해 주세요.")
	         f2.passwd.focus()
	         return false
	      }
	   if (f2.passwd2.value==""){
	         alert("비밀번호 확인을 입력해 주세요.")
	         f2.passwd2.focus()
	         return false
	      }
	   
	   
	   
	   if (f2.passwd.value!=f2.passwd2.value) {
	         alert("비밀번호가 일치하지 않습니다.")
	         return false
	      }else {
	    	  if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(f2.passwd.value)){            
	              alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
	              $('#passwd').val('').focus();
	              return false
	          }              
	          	            
	    	  alert("동의서 확인이 필요합니다.")
	    	  document.f2.submit()
		}
   }
   
   function loginCheck(){
      if (f.id.value==""){
         alert("아이디를 입력해 주세요.")
         f.id.focus()
         return
      }
      if (f.passwd.value==""){
         alert("비밀번호를 입력해 주세요.")
         f.pass.focus()
         return
      }
      document.f.submit()
   }
   
   function openPop() {
	    document.getElementById("popup_layer").style.display = "block";

	}

	//팝업 닫기
	function closePop() {
	    document.getElementById("popup_layer").style.display = "none";
	}
</script>

<div class="wrapper">
  <div class="container">
    <div class="sign-up-container">
       <form name="f2" action="signMember.do" method="post" onsubmit="return signCheck()">
        <div class="row">
        	<h1 style="padding: 0;">Create Account</h1>
        </div>
        <div class="row social-links">
          <div>
            <!-- 로그인 연동 -->
            <a href="${kakao_url}"><img src="resources/img/kakao.png" width="40" height="40"></a> 
          </div>
          <div>
            <a href="#"><img src="resources/img/naver.png" width="40" height="40"></a>
          </div>
        </div>
    	<div class="row">
	        <input type="text" id="name" name="name" placeholder="이름을 입력하세요">
	        <input  type="email" id="email" name="email" onkeydown="inputIdChk()" placeholder="이메일 주소를 입력하세요" style="width: 14rem;"><button type="button" class="form_btn" style="width: 3.5rem; padding: 0;" id="dbCheckId" name ="dbCheckId" onclick="fn_dbCheckId()">중복</button>
	        <input type="password"  id="passwd" name="passwd" placeholder="숫자,영문,특수문자 조합으로 8자 이상 ">
	        <input type="password"  id="passwd2" name="passwd2" placeholder="비밀번호 확인 " class="mb-3">
	        <input type="hidden" id="idDuplication" name="idDuplication" value="idUncheck"/>
	        <input type="hidden" name="mode"/>
        </div>
        <div class="row">
        <br>
			<button class="form_btn" style="width: 7.2rem;" onclick="javascript:modeCheck('1')">개인회원가입</button>
			<button class="form_btn" style="width: 7.2rem;" onclick="javascript:modeCheck('2')">사업자회원가입</button>
       	</div>
        
      </form>
    </div>
    
    <div class="popup_layer" id="popup_layer" style="display: none;">
  			<div class="popup_box">
      		<div style="height: 30px; width: 375px; float: top;">
       	 <a href="javascript:closePop();"><img src="resources/img/x.png" width="15px" height="15px"/></a>
      		</div>
     	 <!--팝업 컨텐츠 영역-->
     	 <div class="popup_cont">
     	     <h5> 회원가입</h5>
      	    <p>
        	  flyingsuperboard로 가입하기<br>
                            카카오로 가입하기
                            네이버로 가입하기
          </p>

     	 </div>
    	  <!--팝업 버튼 영역-->
   	   <div class="popup_btn" style="float: bottom; ">
          <a href="javascript:closePop();">닫기</a>
   	   </div>
 	 </div>
	</div>
    
    <!-- 로그인 버튼 클릭시! -->
    <div class="sign-in-container">
      <form name="f" action="login_ok.do" method="post">
        <h1>Sign In</h1>
        <div class="social-links">
           <!-- 카카오 연동 로그인 -->
          <div>
       		 <a href="${kakao_url}"><i aria-hidden="true"><img src="resources/img/kakao.png" width="40" height="40"></i></a>
          </div>
          <!-- 네이버 연동 로그인 -->
          <div>
            <a href="${naver_url }"><i aria-hidden="true"><img src="resources/img/naver.png" width="40" height="40"></i></a>
          </div>
          
        </div>    
        <span>or use your account</span>
        
        <c:set var="value" value="${cookie.saveId.value}"/>
      <c:if test="${empty value}">
            <input type="email" name="id" placeholder="Email">
      </c:if>
      <c:if test="${not empty value}">
            <input type="email" name="id" tabindex="1" value="${value}">
      </c:if>   
      
        <input type="password" name="passwd" placeholder="Password">
        
        <button class="form_btn">로그인</button></a> 

		<!-- 아이디 기억하기 -->
        <div class="row" style="width:90%;">
        <div class="col">
        
        <c:if test="${empty value}"> 
               <input type="checkbox"  name="saveId" style="border-radius:0; width: 15px;">
        </c:if>
        <c:if test="${not empty value}">
               <input type="checkbox"  name="saveId" style="border-radius:0; width: 15px;" checked>
        </c:if>
        <font face="굴림" size="2">remember</font>
        </div>           
        <div class="col" style="padding-right:0; padding-left:0;">
           <a href="javascript:search('id')" style="text-decoration:none; visited; "><font face="굴림" size="2" color="gray">find id</font></a> | <a href="javascript:search('pw')" style="text-decoration:none"><font face="굴림" color="gray" size="2">find pw</font></a>
        
        </div>  
        <br>
  		</div>
  		
      </form>
    </div>
    
    <div class="overlay-container">
      <div class="overlay-left">
        <h1>Welcome Back</h1>
        <p>To keep connected with us please login with your personal info</p>
        <button id="signIn" class="overlay_btn">로그인</button>
      </div>
      <div class="overlay-right">
        <h1>Hello, Friend</h1>
        <p>Enter your personal details and start journey with us</p>
        <button id="signUp" class="overlay_btn">회원가입</button>
        <script src="resources/js/login.js"></script>
        
      </div>
    </div>
  </div>
</div>
