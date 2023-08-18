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
function checkLogin() {
    alert("회원 전용 입니다. 로그인 후 이용해 주세요.")
  }
  
function viewBreview(bpr_num){
	var bpr_num = bpr_num;
	$.ajax({
	    url:'b_viewBreview.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{'bpr_num': bpr_num,'bp_num':${bp_num} }, //보낼 데이터 (json 형식)
	    success: function(data) {
	    	var content = data
	    	$("#viewBreview").html(content) ;
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	    }
	});

}
	function blockReview(){
		var block = window.confirm("리뷰 게시를 중단 하시겠습니까?")
		if(block){
		var form = $('#f3')[0];
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'b_blockBreview.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("성공");

		    },
		    error: function(err) {
		    	alert("숨김 처리 완료");
		    	location.reload();
		    	/* alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
		    }
		});
		}
	}
	
	function unblockReview(){
		var block = window.confirm("리뷰를 다시 게시 하시겠습니까?")
		if(block){
		var form = $('#f3')[0];
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'b_unblockBreview.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("성공");

		    },
		    error: function(err) {
		    	alert("숨김 해제 완료");
		    	location.reload();
		    	/* alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
		    }
		});
		}
	}
		
function useBcoupon(){
	var isUse = window.confirm("사용 처리 하시겠습니까?")
	
	if(isUse){
	var form = $('#f')[0];
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
<body>
<%@include file="../user/user_top.jsp" %>
	<main class="d-flex flex-nowrap">
<!-- 사이드 바 -->
<c:if test="${login_mem eq null }">
<!-- 비회원 사이드바 -->
	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 15%; min-width: 10rem; max-width: 18rem;">
   		<a href="login.do" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
    		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#people-circle"></use></svg>
    		<span class="fs-5 fw-semibold">로그인을 해주세요.</span>
 		</a>
	</div>
</c:if>
<c:if test="${login_mem ne null }">
  		<%@include file="../user/sns_top.jsp" %>
 </c:if>
  		<!--베젤-->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 700px;">
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">${bp.bp_store_name}의 리뷰[${bp.bp_starrating}/5.0]&nbsp;&nbsp;</span></div>
			</div>
		<!--  별점 리스트 -->
		<div class="container mt-1 overflow-auto">
		  <div class="row justify-content-center">
	         <div class="col-9 bg-white" align="center">
	         <br>
				<h5>
				<c:if test="${empty reviewAvg}">
						<c:forEach begin="1" end="5">
			           	 <img src="resources/img/star1.png" width="20" height="20">	
			            </c:forEach>				
				</c:if>
				<c:if test="${not empty reviewAvg}">
						<c:if test="${reviewAvg eq 1}">
	       					<c:forEach begin="1" end="${reviewAvg}">
	       						<img src="resources/img/star2.png" width="20" height="20">
	       					</c:forEach>
	       					<c:forEach begin="1" end="${5-reviewAvg}">
	       						<img src="resources/img/star1.png" width="20" height="20">
	       					</c:forEach>
						</c:if>
						<c:if test="${reviewAvg eq 2}">
	       					<c:forEach begin="1" end="${reviewAvg}">
	       						<img src="resources/img/star2.png" width="20" height="20">
	       					</c:forEach>
	       					<c:forEach begin="1" end="${5-reviewAvg}">
	       						<img src="resources/img/star1.png" width="20" height="20">
	       					</c:forEach>
						</c:if>
						<c:if test="${reviewAvg eq 3}">
	       					<c:forEach begin="1" end="${reviewAvg}">
	       						<img src="resources/img/star2.png" width="20" height="20">
	       					</c:forEach>
	       					<c:forEach begin="1" end="${5-reviewAvg}">
	       						<img src="resources/img/star1.png" width="20" height="20">
	       					</c:forEach>
						</c:if>
						<c:if test="${reviewAvg eq 4}">
	       					<c:forEach begin="1" end="${reviewAvg}">
	       						<img src="resources/img/star2.png" width="20" height="20">
	       					</c:forEach>
	       					<c:forEach begin="1" end="${5-reviewAvg}">
	       						<img src="resources/img/star1.png" width="20" height="20">
	       					</c:forEach>
						</c:if>
						<c:if test="${reviewAvg eq 5}">
	       					<c:forEach begin="1" end="${reviewAvg}">
	       						<img src="resources/img/star2.png" width="20" height="20">
	       					</c:forEach>
	       					<c:forEach begin="1" end="${5-reviewAvg}">
	       						<img src="resources/img/star1.png" width="20" height="20">
	       					</c:forEach>
						</c:if>
					</c:if>
	            <b> ${reviewAvg} / 5.0</b>  
	            <!--리뷰 작성 버튼 -->
			   <c:if test="${isLogin=='true' and login_mem.mem_num ne bp.mem_num }">
			<a href="bp_insertReview.do?bp_num=${bp_num }" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2 btn-sm">리뷰 작성</a>
			</c:if>
	          <c:if test="${isLogin=='false'}">
	           <a href="javascript:checkLogin()" class="d-inline-flex focus-ring py-1 px-2 text-decoration-none border rounded-2 btn-sm">리뷰 작성</a>
	           </c:if></h5>
	            </div>
			</div>
			<div class="row">
	         <div class="col-3 bg-white border-bottom py-3 pb-1">
	            <font size="4.5"><b>포토리뷰</b></font>
	         </div>
	         <div class="col-9 bg-white border-bottom py-3 pb-1" align="right">
	         </div>
	         <div class="col-12 py-3 bg-white">
	         <table> <!-- 포토리뷰 4장만 보기(table) -->
	          <tr>
				<c:if test="${empty getViewReview}">
					<h6>등록된 포토리뷰가 없습니다.</h6>
				</c:if>
				<c:if test="${not empty getViewReview}">	         
	         	<c:forEach var="dto" items="${getViewReview}">
				<td>
	            	<c:if test="${dto.bpr_img1 eq null }">
	            	</c:if>
	            </td>
	            	<c:if test="${dto.bpr_img1 ne null and dto.bpr_hide eq 0}">
	            <td height="230">
	               	 <a href="javascript:viewBreview('${dto.bpr_num }')"><img class="imgProviewCrop round" src="resources/img/${dto.bpr_img1}" width="170" height="170"></a>
	            </td>
					</c:if>
	            </c:forEach>
				</c:if>
	          </tr>
	         </table>
	         </div>
	      </div>
	     <!-- 매장 리뷰 테이블  --> 
	    		  <div class="row justify-content-center overflow-auto">
	    		  <div class="col-12  border-bottom ">
	            <font size="4.5"><b>리뷰 (${count})</b></font> 
	         </div>
	         </div>
	      <div class="row justify-content-center">
	             <table class="table table-borderless">
	              <thead align="center">
	              <tr>
	              <th>#</th>
	              <th>별점</th>
	              <th>이미지</th>
	              <th>리뷰 제목</th>
	              <th>작성자</th>
	              <tbody>
	         <!-- 리뷰가 없을 때 -->
	             <c:if test="${empty getViewReview}">
	              <tr align="center">
	             <td colspan="7">
					등록된 리뷰가 없습니다.
				</tr>
				</c:if>
				<c:if test="${not empty getViewReview}">
				<c:forEach var="dto" items="${getViewReview}">
		<!-- 사장님이 숨김처리한 리뷰 (타 사용자) -->
				<c:if test="${dto.bpr_hide eq 1 and login_mem.mem_num ne bp_mem and login_mem.mem_num ne dto.mem_num}">
				<tr align="center"> 
				<td>${dto.bpr_num }</td>
				<td colspan="6">요청에 의해 리뷰 게시가 중단 되었습니다.</td>
				</tr>
				</c:if>
			<!--사장님이 숨김 처리한 리뷰 (사장님, 당사자) -->	
				<c:if test="${dto.bpr_hide eq 1 }">
				<c:if test="${login_mem.mem_num eq bp_mem or login_mem.mem_num eq dto.mem_num}">
				<tr align="center">
				<td>${dto.bpr_num}</td>
			<!-- 상품 리뷰에 사진이 있을때 -->
				<td>
	            <c:if test="${dto.bpr_starrating eq 1 }">
	               <img src="resources/img/star2.png" width="10" height="10">
	            <c:forEach begin="1" end="4">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>               
	             </c:if>
	            <c:if test="${dto.bpr_starrating eq 2 }">
	            <c:forEach begin="1" end="2">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="3">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>            
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 3 }">
	            <c:forEach begin="1" end="3">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="2">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 4 }">
	            <c:forEach begin="1" end="4">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="1">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 5 }">
	            <c:forEach begin="1" end="5">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            </td>
	            <c:if test="${dto.bpr_img1 eq null }">
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')"><img src="resources/img/noimage.gif" width="100" height="100" class="img-responsive img-rounded img-thumbnail"></a></td>
	            </c:if>
	            <c:if test="${dto.bpr_img1 ne null }">
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')"><img src="resources/img/${dto.bpr_img1}" width="100" height="100" class="img-responsive img-rounded img-thumbnail"></a></td>
	          	</c:if>
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')"><font color="gray">[숨김]${dto.bpr_title}</font></a></td>
	       	    <td>${dto.mem_nickname}</td>
	       	    <td>${dto.bpr_regdate}</td>
	         	</tr>
				</c:if>
				</c:if>
		<!-- 숨김처리 X 일반 리뷰 -->
				<c:if test="${dto.bpr_hide eq 0 }">
				<tr align="center">
				<td>${dto.bpr_num}</td>
			<!-- 상품 리뷰에 사진이 있을때 -->
				<td>
	            <c:if test="${dto.bpr_starrating eq 1 }">
	               <img src="resources/img/star2.png" width="10" height="10">
	            <c:forEach begin="1" end="4">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>               
	             </c:if>
	            <c:if test="${dto.bpr_starrating eq 2 }">
	            <c:forEach begin="1" end="2">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="3">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>            
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 3 }">
	            <c:forEach begin="1" end="3">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="2">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 4 }">
	            <c:forEach begin="1" end="4">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            <c:forEach begin="1" end="1">
	               <img src="resources/img/star1.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            <c:if test="${dto.bpr_starrating eq 5 }">
	            <c:forEach begin="1" end="5">
	               <img src="resources/img/star2.png" width="10" height="10">
	            </c:forEach>
	            </c:if>
	            </td>
	            <c:if test="${dto.bpr_img1 eq null }">
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')"><img src="resources/img/noimage.gif" width="100" height="100" class="img-responsive img-rounded img-thumbnail"></a></td>
	            </c:if>
	            <c:if test="${dto.bpr_img1 ne null }">
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')"><img src="resources/img/${dto.bpr_img1}" width="100" height="100" class="img-responsive img-rounded img-thumbnail"></a></td>
	          	</c:if>
	            <td><a href="javascript:viewBreview('${dto.bpr_num }')">${dto.bpr_title}</a></td>
	       	    <td>${dto.mem_nickname}</td>
	       	    <td>${dto.bpr_regdate}</td>
	         	</tr>
	         	</c:if>
	         </c:forEach>
	         	</c:if>
	              </tbody>
	              </table>
	
		<form name="f" action="b_review.do" method="post">
			<div class="row justify-content-center">
	         <div class="col-9 py-3 bg-white">
	            <nav aria-label="Page navigation example">
	              <ul class="pagination justify-content-center">
	               <c:if test="${count > 0}">
	               <c:if test="${startPage > pageBlock}">             
	                <li class="page-item">
	                  <a class="page-link" href="b_review.do?bp_num=${bp_num}&pageNum=${startPage - pageBlock}" aria-label="Previous">
	                    <span aria-hidden="true">&laquo;</span>
	                  </a>
	                </li> 
	               </c:if>                       
	               <c:forEach var="i" begin="${startPage}" end="${endPage}">
	                <li class="page-item"><a class="page-link" href="b_review.do?bp_num=${bp_num}&pageNum=${i}">${i}</a></li>
	               </c:forEach>
	               <c:if test="${endPage < pageCount}">
	                <li class="page-item">
	                  <a class="page-link" href="b_review.do?bp_num=${bp_num}&pageNum=${startPage + pageBlock}" aria-label="Next">
	                    <span aria-hidden="true">&raquo;</span>
	                  </a>
	                </li>
	               </c:if>
	               </c:if>
	              </ul>
	            </nav>
	         </div>
		</div>
	</form>  
	      </div>
	      </div>
	      </div>
	     	<div id="viewBreview" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 600px;"></div>
	</main>
