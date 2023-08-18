<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_list.jsp // 일반 회원 등록 -->
<script type="text/javascript">

	function inputIdChk() {
		var joinForm = document.f;
		var dbCheckId = document.f.dbCheckId;
		document.joinForm.idDuplication.value = "idUncheck";
		const target = document.getElementById('dbCheckId');
		target.dsiabeld = false;
		dbCheckId.disabled = false;
	}
	
	function fn_dbCheckId(){
		   var email = f.mem_id.value;
		   if (email.length==0 || email==""){
		         alert("이메일 아이디를 입력해 주세요.")
		         f.mem_id.focus()
		         return false
		      }else {
		    	  window.open("admin_member_dbcheckd.do?email="+email, "", "width=250, height=150, left=1200, top=350")
		      }
	   }
	
	
	function check() {
		if (f.mem_id.value == "") {
			alert("아이디를 입력해주세요!")
			f.mem_id.focus()
			return false
		}
		if (f.idDuplication.value!="idCheck"){
	        alert("아이디 중복체크를 해주세요")
	        return false
	    }
		
		if (f.mem_passwd.value == "") {
			alert("비밀번호를 입력해주세요")
			f.mem_passwd.focus()
			return false
		}
		if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(f.mem_passwd.value)){            
	        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
	        $('#mem_passwd').val('').focus();
	        return false
	   	}
		if (f.mem_name.value == "") {
			alert("이름을 입력해주세요")
			f.mem_name.focus()
			return false
		}
		if (f.mem_hp2.value == "" || f.mem_hp3.value == "") {
			alert("핸드폰 번호를 입력해주세요")
			return false
		}
	    
	    
		return true
	}
</script>


<%@include file="admin_top.jsp" %>
	
<%@include file="member_sidebar.jsp" %>
			
		<!-- 내용 // 일반 회원 등록 (관리자가 직접 일반 회원을 임의 가입 시켜야 하는 경우) -->
			<div class="grid gap-3 flex-shrink-0 p-3 bg-white overflow-auto" style="width: 800px; height: 800px;">
			<br>
			<div align="center">
				<p class="fs-5">일반 회원 등록</p>
			</div>
				<form name="f" action="admin_member_insert.do" method="post" onsubmit="return check()">
				<table border="0" width="80%" height="80%" align="center">
						<tr>
							<th width="30%" align="center">아이디</th>
							<td width="40%"><input type="email" class="form-control" name="mem_id" placeholder="Email 형식" onkeydown="inputIdChk()">
							<input type="hidden" name="mem_mode" value="일반"></td>
							<td width="30%" align="left"><button type="button" class="btn btn-secondary btn-sm" id="dbCheckId" name ="dbCheckId" onclick="fn_dbCheckId()">중복검사</button></td>
						</tr>
						<tr>
							<th align="center">비밀번호</th>
							<td><input type="password" id= "mem_passwd" name="mem_passwd" class="form-control"></td>
							<td><font size="2">&nbsp;&nbsp;영문+숫자+특수문자</font></td>
						</tr>
						<tr>
							<th align="center">이름</th>
							<td colspan="2"><input type="text" class="form-control" name="mem_name">
							 <input type="hidden" id="idDuplication" name="idDuplication" value="idUncheck"/></td>
						</tr>
						<tr>
							<th align="center">HP</th>
							<td colspan="2">
								<div class="container text-center">
  									<div class="row row-cols-3">
  										<div class="col">
  											<select name="mem_hp1" class="form-select">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="017">017</option>
												<option value="019">019</option>
											</select>
  										</div>
	    								<div class="col"><input type="text" name="mem_hp2" class="form-control" size="5" maxlength='4'></div>
	    								<div class="col"><input type="text" name="mem_hp3" class="form-control" size="5" maxlength='4'></div>
    								</div>
    							</div>
							</td>
						</tr>
						<tr>
							<td colspan="4"><font size="2" color="red">📢닉네임은 랜덤 생성 됩니다.</font></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
							<button type="submit" class="btn btn-secondary btn-sm">등록</button>
							<button type="button" class="btn btn-secondary btn-sm" onclick="window.location='admin_member_list.do'">취소</button>
							</td>	
						</tr>
				</table>
				</form>
			</div>
	</main>



<%@include file="admin_bottom.jsp" %>
