<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 마이페이지설정.jsp -->
<%@include file="../user/user_top.jsp" %>
<link rel="stylesheet" type="text/css" href="resources/css/file.css">
<script type="text/javascript">
/* 	function changePw(){ // 비밀번호 변경폼
		$.ajax({
	    url:'changePw.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{},  //보낼 데이터 (json 형식)
	    success: function(data) { // 컨트롤러 리턴값

	    	$("#changePw").html(data);
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
	    }
	});
	} */
	
	function changePw(mem_num){ // 비밀번호 변경폼
		   window.open("changePw.do?num="+mem_num, "", "width=530, height=350, left=800, top=250")
	} 
	
	function changeNick(mem_num){ // 닉네임 변경폼
		   window.open("changeNick.do?num="+mem_num, "", "width=530, height=350, left=800, top=250")
	} 
	
	function changePhone(mem_num){ // 핸드폰번호 변경폼
		   window.open("changePhone.do?num="+mem_num, "", "width=530, height=350, left=800, top=250")
	} 
	
	function changeMsg(mem_num){ // 상태메세지 변경폼
		   window.open("changeMsg.do?num="+mem_num, "", "width=530, height=170, left=800, top=250")
	} 
	
	function changeBadge(id){ // 뱃지 변경폼
		   window.open("changeBadge.do?id="+id, "", "width=530, height=430, left=800, top=250")
	} 
	
	function changeTag(mem_num){ // 뱃지 변경폼
		   window.open("changeTag.do?num="+mem_num, "", "width=530, height=300, left=800, top=250")
	} 
	
	function changeBirth() {
		         document.f3.submit()
		   }



	
	function changeId(){ // 이메일
		$.ajax({
	    url:'changeId.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{},  //보낼 데이터 (json 형식)
	    success: function(data) { // 컨트롤러 리턴값

	    	$("#changeId").html(data);
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
	    }
	});
	}
	
	function NormalImg(){ // 기본이미지로 변경
		$.ajax({
	    url:'ImgNormal.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{},  //보낼 데이터 (json 형식)
	    success: function(data) { // 컨트롤러 리턴값

	    	$("#normalImg").html(data);
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
	    }
	});
	}
	
/* 	function SaveImg(){
		var form = $('#f2')[0];
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'SaveImg.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("이미지가 변경되었습니다.");
	
		    },
		    error: function(err) {
		    	alert("실패");
		    
		    }
		});
	} */
	

	function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('preview').src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('preview').src = "";
		  }
		}
</script>
	
<body>
	
  <main class="d-flex flex-nowrap">
     
        <!-- 사이드 바 -->
        <%@include file="../user/sns_top.jsp" %>
        
     <br>
     <br>
     <div style="margin: 0 auto;">
     <form name="f2" id="f2" enctype="multipart/form-data" method="post" action="saveImg.do">
     	
        <table class="table" style="width:1000px;" >
  <thead>
 
  
    <tr>
      <th colspan="3" scope="col"><font size="12" color=black>기본 회원정보</font><font size="5" color=gray> 필수</font></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row" width="20%">프로필 사진</th>
      
      <c:if test="${empty login_mem.getMem_img()}">
      <td id=normalImg width="50%"><img  id="preview" src="resources/img/default_profile.png" width="50" height="50" align="left" class="rounded mx-auto d-block" alt="..."></td>
      </c:if>
      
       <c:if test="${not empty login_mem.getMem_img()}">
      <td id=normalImg width="50%"><img  id="preview" src="resources/img/${login_mem.getMem_img()}" width="50" height="50" align="left" class="rounded mx-auto d-block" alt="..."></td>
       </c:if>
       

       <td>
      
      <input type="hidden" id="mem_num" name="mem_num" value="${login_mem.getMem_num()}"/>
       <div class="filebox">
    <label for="file">파일찾기</label> 
    <input type="file" width="30%" onchange="readURL(this);" name="file" id="file"><button type="button" class="btn btn-light" style="width:60px; height:30px;" id="change-email-btn" onclick="javascript:NormalImg('${dto.br_num}')">기본</button><button type="submit" class="btn btn-light" style="width:60px; height:30px;" id="change-email-btn">저장</button></td> 
	</div>

    </tr>
    
    <tr>
      <th scope="row">아이디</th>
      <td id="changeId">${login_mem.getMem_id()}</td>
       <td ><!--  <button type="button" class="btn btn-outline-dark" style="width:130px" onclick="javascript:changeId('${dto.br_num}')" id="change-email-btn">이메일 변경</button>--></td>
    </tr>
    
    
    <tr>
      <th scope="row">비밀번호</th>
      <td id="changePw">안알랴줌</td>
      <td><button type="button" class="btn btn-outline-dark" style="width:130px" id="change-password-btn" onclick="javascript:changePw('${login_mem.getMem_num()}')">비밀번호 변경</button></td>
    </tr>
    <!-- 비밀번호 수정 -->
   <!--  <tr id="change-password-area" style="">
                        <th scope="row">비밀번호</th>
                        <td colspan="2">
                            <div class="my-info-modify" >
                              
                                  
                             
                        </div></td>
                    </tr> -->
 
    
        <tr>
      <th scope="row">이름(실명)</th>
      <td>${login_mem.mem_name}</td>
      <td><!--  <button type="button" id="certNameBtn" class="btn btn-outline-dark" style="width:130px">이름수정</button>--></td>
    </tr>
    
        <tr>
      <th scope="row">닉네임</th>
      <td>${login_mem.mem_nickname}</td>
      <td><button type="button" class="btn btn-outline-dark" style="width:130px" id="change-nickName-btn" onclick="javascript:changeNick('${login_mem.getMem_num()}')">닉네임 변경</button></td>
    </tr>
    
    
      <tr>
      <th scope="row">휴대전화</th>
      <td>${login_mem.getMem_hp1()}-${login_mem.getMem_hp2()}-${login_mem.getMem_hp3()}</td>
      <td> <button type="button" class="btn btn-outline-dark" style="width:130px" id="change-mobile-btn" onclick="javascript:changePhone('${login_mem.getMem_num()}')">등록/변경</button></td>
    </tr>
    
   <tr>
  <th colspan="3" rowspan="4"></th>
  </tr>
  
   <tr>
  <th colspan="3"></th>
  </tr>
  
   <tr>
  <th colspan="3"></th>
  </tr>
  
   <tr>
  <th colspan="3"></th>
  </tr>

     
    <!-- 추가회원정보 --> 
    <tr>
      <th colspan="3" scope="col"><font size="12" color=black>추가 회원정보</font><font size="5" color=gray> 선택</font></th>
    </tr>

 
    <%-- <tr>
      <th scope="row">상태메세지</th>
      <td>${login_mem.mem_msg}</td>
      <td><button type="button" class="btn btn-outline-dark" style="width:130px" id="change-profile-image-btn" onclick="javascript:changeMsg('${login_mem.getMem_num()}')">상태메세지</button></td> 
   
    </tr> --%>
    
    <tr>
      <th scope="row">획득한 뱃지</th>
      	<td>
      <c:if test="${login_mem.badge_king_2 eq 1}"><img src="resources/img/king.png" width="40" height="40"></c:if>
      <c:if test="${login_mem.badge_write_2 eq 1}"><img src="resources/img/write.png" width="40" height="40"></c:if>
      <c:if test="${login_mem.badge_1004_2 eq 1}"><img src="resources/img/1004.png" width="40" height="40"></c:if>
      <c:if test="${login_mem.badge_good_2 eq 1}"><img src="resources/img/good.png" width="40" height="40"></c:if>
      <c:if test="${login_mem.badge_rich_2 eq 1}"><img src="resources/img/rich.png" width="40" height="40"></c:if>
      	</td>
       <td><button type="button" class="btn btn-outline-dark" style="width:130px" id="change-profile-image-btn" onclick="javascript:changeBadge('${login_mem.mem_id}')">뱃지설정</button></td> 
 
    </tr>
    <tr>
      <th scope="row">방문횟수</th>
      <td >${login_mem.mem_count} 회</td>
      <td></td>
      
    </tr>
   
    
        <tr>
      <th scope="row">해시태그</th>
      <td><c:if test="${login_mem.tag_1 eq 1}"> #추리 </c:if>
      	<c:if test="${login_mem.tag_2 eq 1}"> #전략</c:if>
      	<c:if test="${login_mem.tag_3 eq 1}"> #카드</c:if>
      	<c:if test="${login_mem.tag_4 eq 1}"> #공포/스릴러</c:if>
      	<c:if test="${login_mem.tag_5 eq 1}"> #판타지</c:if>
      	<c:if test="${login_mem.tag_6 eq 1}"> #역사</c:if>
      	<c:if test="${login_mem.tag_7 eq 1}"> #공상과학</c:if>
      	<c:if test="${login_mem.tag_8 eq 1}"> #스포츠</c:if> </td>
      <td><button type="button" id="certNameBtn" class="btn btn-outline-dark" style="width:130px" onclick="javascript:changeTag('${login_mem.getMem_num()}')">해시태그 추가</button></td>
    </tr>
    
       <!--  <tr>
      <th scope="row">생년월일</th>
      <td>1994.05.09</td>
      <td><input type=date name="birthday" size=20><button type="button" class="btn btn-outline-dark" style="width:130px" id="change-nickName-btn" onclick="javascript:changeBirth()">입력</button></td>
    </tr> -->
    
<!-- 
      <tr>
      <th scope="row">성별</th>
      <td>여자</td>
     <td></td>
    </tr> -->
    
   <!--    <tr>
      <th scope="row">환불계좌</th>
      <td>신한110~~</td>
      <td> <button type="button" class="btn btn-outline-dark" style="width:130px" id="change-mobile-btn">환불계좌관리</button></td>
    </tr>
    
         <tr>
      <th scope="row">배송지 관리</th>
      <td>상봉동</td>
      <td> <button type="button" class="btn btn-outline-dark" style="width:130px" id="change-mobile-btn">배송지 선택</button></td>
    </tr> -->
    
  </tbody>
</table>
<div align="right">
<font size="2" color="gray">탈퇴를 원하시면 회원탈퇴 버튼을 눌러주세요</font>&nbsp;<button type="button" class="btn btn-outline-dark rounded-0" style="width:60px; height:30px;" id="change-profile-image-btn" onclick="window.location='dontgo.do'">탈퇴</button>
</div>
</form>

<form name="f3" action="changeBirth.do" method="post">
   <input type="hidden" name="birthday">
   <input type="hidden" id="id" name="id" value="${login_mem.mem_id}">
</form>
</div>
</main>   
 	
  		
</body>
<%@include file="../user/user_bottom.jsp" %>


