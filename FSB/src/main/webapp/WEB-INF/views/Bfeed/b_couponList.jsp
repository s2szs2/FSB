<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/bootstrap-grid.min.css" rel="stylesheet">
<link href="resources/css/bootstrap-grid.rtl.min.css" rel="stylesheet">
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="resources/js/sidebars.js"></script>

<style>
	.vertical-right-line {
		border-right-style: solid;
	 	border-right-width: 2px;
	  	border-right-color: #dee2e6;
	}
</style>

<script>
	function viewCoupon(bc_num,mem_num,bc_using){
		var bc_num = bc_num;
		var mem_num = mem_num;
		var bc_using = bc_using;
		console.log(bc_num);
		$.ajax({
		    url:'b_couponView.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'bc_num': bc_num,'mem_num': mem_num,'bc_using':bc_using}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
		    	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#bcouponView").html(content) ;

		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
		    }
		});

	}
	
	function useBcoupon(){
		var isUse = window.confirm("사용 처리 하시겠습니까?")
		
		if(isUse){
		var form = $('#f')[0];
		console.log(form);
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'b_useBcoupon.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("성공");
	
		    },
		    error: function(err) {
		    	alert("쿠폰 사용 완료");
		    	location.reload();
		    	/* alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
		    }
		});
		}
	}
	
</script>
<script>
function insertCoupon(bp_num) {
	if(${count >= 3}){
		alert("비즈니스 쿠폰은 한 번에 최대 3장만 발행 가능합니다.")
	}else{
		window.open("insert_bcoupon.do?bp_num="+bp_num,"",  "width=550, height=350, left=450, top=200")
	}
}

function cancelUsing(){
	var isCancel= window.confirm("쿠폰 사용을 취소하시겠습니까?")
	
	if(isCancel){
		document.f1.submit();
	}
}

function deleteC(bc_num,bp_num){
	var isDel = window.confirm("정말로 삭제하겠습니까?")
	
	if (isDel) {
		window.location ="delete_bcoupon.do?bc_num="+bc_num+"&bp_num="+bp_num;
	}
	
}	
</script>
	
<%@include file="../user/user_top.jsp" %>

<body>
	<main class="d-flex flex-nowrap">
<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>

		<!--베젤-->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 800px;">
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">비즈니스 쿠폰 관리</span></div>
			</div>
		<!-- 쿠폰 발급 버튼 -->
		<div class="col  vertical-right-line">
		<div align="right">
			<a href="javascript:insertCoupon('${bp_num }')" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2">쿠폰 발행</a>
		<div>
		</div>
		
		<!-- 테이블로 리스트 뽑기 (사장님)-->
		<table class="table table-hover">
		 <thead >
    <tr align = center>
      <th scope="col">쿠폰명</th>
      <th scope="col">쿠폰내용</th>
      <th scope="col">쿠폰수량</th>
      <th scope="col">발급날짜</th>
      <th scope="col">유효기간</th>
      <th scope="col">삭제</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
  <c:if test="${empty bcouponlist }">
  <tr>
  		<td colspan="5" align="center">발급하신 쿠폰이 없습니다.</td>
  </tr>
  </c:if>
  <c:forEach var="bc" items="${bcouponlist }">
  <tr align = "center">
  	<td>${bc.bc_title }</td>
  	<td>${bc.bc_content }</td>
  	<td>${bc.bc_qty }</td>
  	<td>${bc.bc_regdate }</td>
  	<c:if test="${bc.bc_duedate eq null }">
  		<td>-</td>
  	</c:if>
  	<c:if test="${bc.bc_duedate ne null }">
  	<td>${bc.bc_duedate }</td>
  	</c:if>
  	<td><a href="javascript:deleteC('${bc.bc_num }','${bc.bp_num }')" class="btn btn-primary btn-sm">삭제</a></td>
  </tr>
  </c:forEach>
  </tbody>
  </table>
  <div class="border-top my-3"></div>
		<!-- 테이블로 리스트 뽑기 (사용자)-->
		<table class="table table-hover">
		 <thead >
    <tr align = center>
      <th scope="col">쿠폰명</th>
      <th scope="col">받은 회원</th>
      <th scope="col">전화번호 뒷자리</th>
      <th scope="col">유효기간</th>
      <th scope="col">사용확인</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
  <c:if test="${empty couponListUser }">
  <tr>
  		<td colspan="5" align="center">쿠폰을 받은 회원이 없습니다.</td>
  </tr>
  </c:if>
  <c:forEach var="dto" items="${couponListUser}">
  <tr align = center>
      <td>${dto.bc_title}</td>
      <td>${dto.mem_nickname}</td>
      <td>${dto.mem_hp3}</td>
      <c:if test="${dto.bc_duedate eq null }">
      <td>만료일 없음</td>
      </c:if>
      <c:if test="${dto.bc_duedate ne null }">
      <td>${dto.bc_duedate }</td>
        </c:if>
      <c:if test="${dto.bc_using eq 0 or dto.bc_using eq null}">
      <td><a href="javascript:viewCoupon('${dto.bc_num }','${dto.mem_num }','${dto.bc_using }')" class="btn btn-primary">사용하기</a></td>
     </c:if>
     <c:if test="${dto.bc_using eq 1}">
      <td><a href="javascript:viewCoupon('${dto.bc_num }','${dto.mem_num }','${dto.bc_using }')"><button class="btn btn-primary" disabled>사용완료</button></a></td>
      </c:if>
    </tr>
   
    </c:forEach>
  </tbody>
		</table>
		</div>
		<!-- 게시글 페이지 수-->
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
   <c:if test="${count>0}">
   		<c:if test="${startPage > pageBlock}">
   			 <li class="page-item">
     		 <a class="page-link" href="b_couponList.do?bp_num=${bp_num}&pageNum=${startPage-pageBlock}" aria-label="Previous">
       		 <span aria-hidden="true">&laquo;</span>
      		</a>
   			</li>
   		</c:if>
   		
   		<c:forEach var="i" begin="${startPage}" end="${endPage}">
   			 <li class="page-item">
   			  <a class="page-link" href="b_couponList.do?bp_num=${bp_num}&pageNum=${i}">${i}</a></li>
    	</c:forEach>
    
   <c:if test="${endPage < pageCount}">
   			 <li class="page-item">
      			<a class="page-link" href="b_couponList.do?bp_num=${bp_num}&pageNum=${startPage+pageBlock}" aria-label="Next">
        			<span aria-hidden="true">&raquo;</span>
     			</a>
    		</li>
  		</c:if>  
	 </c:if>
  	</ul>
	</nav>
	</div>
	</div>
			<div id="bcouponView" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 400px;"></div>
	</main>
</body>
<%@include file="../user/user_bottom.jsp" %>