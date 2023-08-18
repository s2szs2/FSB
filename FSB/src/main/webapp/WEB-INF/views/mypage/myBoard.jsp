<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 내가쓴글 목록 .jsp -->
<%@include file="../user/user_top.jsp" %>
<link rel="stylesheet" type="text/css" href="resources/css/file.css">
<script type="text/javascript">

	function changePw(mem_num){ // 비밀번호 변경폼
		   window.open("changePw.do?num="+mem_num, "", "width=530, height=350, left=800, top=250")
	} 
	
	
	
	function changeBirth() {
		         document.f3.submit()
		   }
</script>
	
<body>	
  <main class="d-flex flex-nowrap">
     
        <!-- 사이드 바 -->
        <%@include file="../user/sns_top.jsp" %>
        <div style="margin: 0 auto;">
         <table class="table" style="width:1000px;" >
      <br>
          <tr>
      <th colspan="2" scope="col"><font size="12" color=black>글목록</font><font size="5" color=gray></font></th>
    </tr>

  
  
  
    <tr>
      <th scope="row" width="50%" align="center"><font size="5" color=black>내가 쓴 글</font></th>
      <th scope="row" width="50%" align="center"><font size="5" color=black>내가 쓴 댓글</font></th>
    </tr>
    
    <tr>
    <td height="80%">
    <font size="4" color=black>🤍전체게시판(${allboard}개)</font><br><br>
    <a href="myFreeBoard.do?num=${login_mem.mem_num}" class="link-secondary" ><font size="3" color=gray>▪ 자유게시판(${freeboard}개)</font></a><br><br>
    <a href="myShBoard.do?num=${login_mem.mem_num}" class="link-secondary" ><font size="3" color=gray>▪ 중고게시판(${shboard}개)</font></a><br><br>
    <a href="mySecretBoard.do?num=${login_mem.mem_num}" class="link-secondary" ><font size="3" color=gray>▪ 익명게시판(${secretboard}개)</font></a><br><br>
    </td>
    
     
    <td height="80%">
    <font size="4" color=black>🤍전체게시판(${allReply}개)</font><br><br>
    <a href="myFreeReply.do?num=${login_mem.mem_num}" class="link-secondary"><font size="3" color=gray>▪ 자유게시판(${f_list}개)</font></a><br><br>
    <a href="myShReply.do?num=${login_mem.mem_num}" class="link-secondary" ><font size="3" color=gray>▪ 중고게시판(${sh_list}개)</font></a><br><br>
    <a href="mySecretReply.do?num=${login_mem.mem_num}" class="link-secondary"><font size="3" color=gray>▪ 익명게시판(${sc_list}개)</font></a><br><br>
    </td>
    
   </tr>
   
    </table>
   </div>
</main>   
 	
  		
</body>
<%@include file="../user/user_bottom.jsp" %>


