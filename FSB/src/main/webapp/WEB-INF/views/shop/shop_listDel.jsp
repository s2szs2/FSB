<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_listDel.jsp 주문페이지에서 배송지관리 -->

  <!-- css 파일 연결하기 -->
   <script src="resources/js/jquery-3.7.0.js"></script>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="resources/css/bootstrap.min.css" rel="stylesheet">
   <link href="resources/css/utilities.min.css" rel="stylesheet">
   <script src="resources/js/bootstrap.bundle.min.js"></script>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	function deleteDel(del_num){
		var isDel = window.confirm("정말로 삭제하겠습니까?");
		if (isDel){
			//위의 dto.del_num을 생성된 value에 넣어준 후 보낸거임!!!
			document.deleteOne.del_num.value = del_num;
			document.deleteOne.submit();
		}		
	}
	function insertDel(){
		window.open("shop_insertDel.do", "", "width=850, height=500")
	}	
	function sendDel() {
       window.location='shop_listDel.do';
    }
    function OkDel(del_title, del_name, del_address1, del_address2, del_address3, del_hp) {
		var openJoinfrm = opener.document.f6;
			openJoinfrm.del_title.value = del_title
			openJoinfrm.order_name.value = del_name
			openJoinfrm.sample6_postcode.value = del_address1
			openJoinfrm.sample6_address.value = del_address2
			openJoinfrm.sample6_detailAddress.value = del_address3
			openJoinfrm.order_hp.value = del_hp
			window.close();
		
	}
	</script>

<div class="d-flex justify-content-center">
	<div class="container px-1 py-4">
	<h5 class="border-bottom"><b>배송지 목록 (${myDelCount})</b></h5><br>
	
	<table class="table" style="font-size:10pt">
  		<thead class="table-light">
    		<tr align="center">
    			<th width="10%"> </th>
    			<th width="">배송지명</th>
    			<th width="">받으실 분</th>
    			<th width="">받으실 곳</th>
    			<th width="">연락처</th>
    			<th width="15%">수정/삭제</th>
    		</tr>
  		</thead>
  		<tbody>
  		<c:if test="${empty myDel}">
  			<tr>
  				<td colspan="6" align="center">등록된 배송지가 없습니다.</td>
  			</tr>
  		</c:if>
  			
  			<c:forEach var="dto" items="${myDel}">
    		<tr align="center" valign="middle">
    			<td><a href="javascript:OkDel('${dto.del_title}','${dto.del_name}','${dto.del_address1}','${dto.del_address2}','${dto.del_address3}','${dto.del_hp}')">
    			<button class="btn btn-outline-dark btn-sm" type="button">선택</button></a></td>
    			<td id="del_title">${dto.del_title}</td>
    			<td id="del_name">${dto.del_name}</td>
    			<td id="">
    				(${dto.del_address1}) ${dto.del_address2}<br>${dto.del_address3}
    			</td>
    			<td id="del_hp">${dto.del_hp}</td>
    			<td>
    				<button class="btn btn-outline-dark btn-sm" type="button" onclick="javascript:updateDel('${dto.del_num}')">수정</button>
    				<button class="btn btn-outline-dark btn-sm" type="button" onclick="javascript:deleteDel('${dto.del_num}')">삭제</button>
    				<script type="text/javascript">
						function updateDel(del_num){
							window.open("shop_updateDel.do?del_num="+del_num, "", "width=850, height=500")
							//부모창에서 자식창으로 데이터 바로 넘기기
							//openWindow.document.querySelector("del_title").value = document.getElementById("del_title").value;
						}
					</script>
    			</td>
    		</tr>
    		</c:forEach>
    		
  		</tbody>
	</table>
	
	<div align="right">
		<button class="btn btn-outline-dark btn-sm" type="button" onclick="javascript:insertDel()">+ 새 배송지 추가</button>
	</div>
	</div>
</div>

<form name="deleteOne" action="shop_deleteDel.do" method="post">
	<input type="hidden" name="del_num">
</form>