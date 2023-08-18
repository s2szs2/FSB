<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../user/user_top.jsp"%>
<!-- content.jsp -->
<html>
<style>
.box {
    width: 50px;
    height: 50px; 
    border-radius: 70%;
    overflow: hidden;
}
.box1 {
    width: 20px;
    height: 20px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<head>
<script type="text/javascript">
	function checkDel(board_num, board_img1, board_img2, board_img3, board_img4) {
		var isDel = window.confirm("정말로 삭제하겠습니까?")
		if (isDel) {
			document.f.board_num.value = board_num
			document.f.board_img1.value = board_img1
			document.f.board_img2.value = board_img2
			document.f.board_img3.value = board_img3
			document.f.board_img4.value = board_img4
			document.f.submit()
		}
	}
		function check() {
			if (f1.br_content.value == "") {
				alert("내용을 입력해주세요")
				f1.br_content.focus()
				return
			}
			document.f1.submit()
		}
		
		function checkReport(board_num) {
			window.open("report_board.do?mode=sh_board&board_num="+board_num,"", "width=550, height=470, left=680, top=270")
		}
		function checkReport_br(br_num){
			window.open("report_board.do?mode=sh_reply&br_num="+br_num,"", "width=550, height=470, left=680, top=270")
		}
		function memReport(mem_num){
			window.open("mem_report.do?mem_num="+mem_num,"", "width=550, height=470, left=680, top=270")
		}
		
		function back(){
		window.location="board_secondhand.do?mode=all"
		}
</script>
<script type="text/javascript">
	function updateReply(br_num){ // 댓글 에이젝스 수정 폼 끌어오기
		$.ajax({
	    url:'update_reply_sh.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{'br_num' : br_num , 'pageNum' : ${pageNum}}, //보낼 데이터 (json 형식)
	    success: function(data) { // 컨트롤러 리턴값

	    	$("#updateReply"+br_num).html(data);
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
	    }
	});
	}
	
	function updateReplyOk(){ // 수정폼 컨트롤러로 보내서 넘겨오기
		var form = $('#f2')[0];
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'update_replyOk_sh.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("실패");
	
		    },
		    error: function(err) {
		    	alert("댓글 수정 성공");
		    	location.reload();
		    	/* alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
		    }
		});
	}
	function re_reply(br_num){ // 대댓글 수정폼 끌어오기
		$.ajax({
	    url:'re_reply_sh.do', //request 보낼 서버의 경로
	    type:'get', // 메소드(get, post, put 등)
	    data:{'br_num' : br_num , 'pageNum' :${pageNum} }, //보낼 데이터 (json 형식)
	    success: function(data) { // 컨트롤러 리턴값

	    	$("#re_reply"+br_num).html(data);
	    },
	    error: function(err) {
	    	alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
	    }
	});
	}
	
	function re_replyOk(){ //대댓글 수정폼 넘겨서 처리하고 넘억오기
		var form = $('#f3')[0];
		var formData = new FormData(form);
		$.ajax({
			type : 'post',
			url : 'write_reply_sh.do',
			data : formData,
			dataType:'json',
		    processData:false,
		    contentType:false,
		    cache:false,
		    
			success: function(data) {
		    	alert("실패");
	
		    },
		    error: function(err) {
		    	alert("대댓글 달기 성공");
		    	location.reload();
		    	/* alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
		    }
		});
	}
	
	function cancel(board_num){
		window.location='content_board_sh.do?board_num='+board_num+'&pageNum='+${pageNum}
		}
	
</script>
<title>중고게시판</title>
</head>
<body>
	<div align="center">
		<!-- 게싯글 제목 -->
			<p class="h1">${getBoard.board_title}</p>
		<!--작성자 조회수 -->
		<div align="center">
			<!-- 프로필 사진(게시판용) -->
			<!-- 작성자 닉네임 표시 -->
  			<div><c:if test="${getBoard.mem_img eq null }">
						<div class="box" style="background: #BDBDBD;">
						<img class="profile" src="resources/img/default_profile.png"></div></c:if>&nbsp;
						<c:if test="${getBoard.mem_img ne null }">
						<div class="box" style="background: #BDBDBD;">
						<img class="profile" src="resources/img/${getBoard.mem_img}"></div></c:if>&nbsp;
  						작성자 :
						<div class="btn-group dropend">
  					<button type="button" class="btn btn-light dropdown-toggle btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
 					 ${getBoard.mem_nickname}
  					</button>
  					<c:if test="${login_mem.mem_num ne getBoard.mem_num }">
 					 <ul class="dropdown-menu">
   						  <c:if test="${login_mem eq null }">
 					  <li><a class="dropdown-item" href="javascript:checkLogin()">회원 신고</a></li>
 					 </c:if>
 					  <c:if test="${login_mem ne null }">
   						 <li><a class="dropdown-item" href="javascript:memReport('${getBoard.mem_num }')">회원 신고</a></li>
  						</c:if>
  					</ul>
  					</c:if>
				</div>
			<div>조회수 : ${getBoard.board_readcount} 작성일 : ${getBoard.board_regdate }</div>
			<!-- 버튼 : 수정, 글삭제는 해당 아이디 글만 노출-->
				<c:if test="${login_mem.mem_num eq getBoard.mem_num}">
			<input type="button" class="btn btn-outline-secondary" value="글수정"
				onclick="window.location='update_board_sh.do?board_num=${getBoard.board_num}'">
			<a href="javascript:checkDel('${getBoard.board_num}','${getBoard.board_img1}','${getBoard.board_img2}','${getBoard.board_img3}','${getBoard.board_img4}')"><input
				type="button" class="btn btn-outline-secondary" value="삭제"></a>
				</c:if>
			<input type="button" value="글목록" class="btn btn-outline-secondary" onclick="javascript:back('${mode}')">
			<!-- 중고게시판은 답글쓰기 막아 놓았음 -->
			<%-- <c:if test="${getBoard.board_re_step == 0}">
				<input type="button" class="btn btn-outline-secondary" value="답글쓰기"
					onclick="window.location='write_board_sh.do?board_num=${getBoard.board_num}&board_re_group=${getBoard.board_re_group}&board_re_step=${getBoard.board_re_step}&board_re_level=${getBoard.board_re_level}'">
			</c:if> --%>
			<!-- 중고게시판 신고  -->
		<a href="javascript:checkReport('${getBoard.board_num}')"><input type="button" value="🚨" class="btn btn-outline-secondary"></a>
		</div>
	</div>
		<!-- 이미지 슬라이드 -->
		<c:if
			test="${not empty getBoard.board_img1 ||not empty getBoard.board_img2||not empty getBoard.board_img3||not empty getBoard.board_img4}">
			<div id="carouselExampleIndicators"
				class="carousel slide w-50 p-3">
				<div class="carousel-indicators ">
					<c:if test="${not empty getBoard.board_img1}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="0" class="active" aria-current="true"
							aria-label="Slide 1"></button>
					</c:if>
					<c:if test="${not empty getBoard.board_img2}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="1" aria-label="Slide 2"></button>
					</c:if>
					<c:if test="${not empty getBoard.board_img3}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="2" aria-label="Slide 3"></button>
					</c:if>
					<c:if test="${not empty getBoard.board_img4}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="3" aria-label="Slide 4"></button>
					</c:if>
				</div>
				<!-- 이미지 여러개 -->
				<div class="carousel-inner ">
					<c:if test="${not empty getBoard.board_img1}">
						<div class="carousel-item active">
							<img src="resources/img/${getBoard.board_img1}"
								class="d-block w-50 h-75">
						</div>
					</c:if>

					<c:if test="${not empty getBoard.board_img2}">
						<div class="carousel-item">
							<img src="resources/img/${getBoard.board_img2}"
								class="d-block w-50 h-75">
						</div>
					</c:if>

					<c:if test="${not empty getBoard.board_img3}">
						<div class="carousel-item">
							<img src="resources/img/${getBoard.board_img3}"
								class="d-block w-50 h-75">
						</div>
					</c:if>

					<c:if test="${not empty getBoard.board_img4}">
						<div class="carousel-item">
							<img src="resources/img/${getBoard.board_img4}"
								class="d-block w-50 h-75">
						</div>
					</c:if>
				</div>

				<button class="carousel-control-prev w-50 p-3 h-auto" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next w-50 p-3 h-auto" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</c:if>
		<br>
		<!-- 중고거래 폼 -->
		<table class="table mb-3 w-50 p-3 mx-auto p-2">
				<tr>
				<td class="table-active" width = 10%>거래종류</td>
				<td align=center>${getBoard.board_condition}</td>
				<td class="table-active" width = 10%>주소</td>
				<td align=center>${getBoard.board_location}</td>
				</tr>
				<tr>
					<td class="table-active" width = 10%>거래 방법</td>
					<td align=center>${getBoard.board_package }</td>
					<td class="table-active" width = 10%>가격</td>
					<td align=center><img src="resources/img/won.png" width ="20">${getBoard.board_price}</td>
				</tr>
		</table>
		<!-- 내용 -->
		<div class="mb-3 w-50 p-3 mx-auto p-2">
			<textarea class="form-control" id="exampleFormControlTextarea1"
				name="board_content" rows="15" readonly>${getBoard.board_content}</textarea>
		</div>
		<!-- 댓글 -->
		<div class="container text-center mb-3 w-50 mx-auto p-2">
			<c:if test="${empty listReply_sh}">
				 <div class="row justify-content-md-center">등록된 댓글이 없습니다. </div>
			</c:if>
			<c:forEach var="dto" items="${listReply_sh}">
				<!-- 작성사 댓글 삭제시 -->
				<c:if test="${dto.br_content eq '-'}">
				 <div class="row">
				 	<div class="col-2"></div>
					<div class="col-7" align="left">
						<c:if test="${dto.br_re_step>0}"><img src="resources/img/re.png" height="10"></c:if><font color="gray"><small>작성자에 의해 삭제된 글입니다.</small></font>
					<div class="col-2"></div>
					<div class="col-1"></div>
				 </div>
				 </div>
				</c:if>
		<c:if test="${dto.br_content ne '-'}">
			<!-- 댓글 신고 5회 이상 먹을시 규제 -->
				<c:if test="${dto.br_report > 4}">
				 <div class="row">
					<div class="col-2"><c:if test="${dto.br_re_step>0}"><img src="resources/img/re.png" height="10"></c:if></div>
					<div class="col-7" align="left"><font color="gray"><small>관리자에 의해 규제된 댓글입니다.</small></font></div>
					<div class="col-2"></div>
					<div class="col-1"></div>
				 </div>
				</c:if>
				<c:if test="${dto.br_report <5}">
	<!-- 수정 버튼 누르면 대체 --> 
			<div class="row"  id="updateReply${dto.br_num}">
						<div class="col-2">
			<!-- 댓글 프사 -->
						<div class="btn-group dropend">
						<c:if test="${dto.br_re_step>0}">
						<img src="resources/img/re.png" height="20">
						</c:if>
						<c:if test="${dto.mem_img eq null }">
						<div class="box1" style="background: #BDBDBD;">
						<img class="profile" src="resources/img/default_profile.png"></div></c:if>
						<c:if test="${dto.mem_img ne null }">
						<div class="box1" style="background: #BDBDBD;">
						<img class="profile" src="resources/img/${dto.mem_img}"></div></c:if>&nbsp;
  						<button type="button" class="btn btn-light dropdown-toggle btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
  						${dto.mem_nickname}
  					</button>
  						<c:if test="${login_mem.mem_num ne dto.mem_num }">
 					 <ul class="dropdown-menu">
   						 <li><a class="dropdown-item" href="javascript:memReport('${dto.mem_num }')">회원 신고</a></li>
  					</ul>
  					</c:if>
				</div></div>
						<div class="col-7" align = "left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${dto.br_content}</div>
						<div class="col-2">${dto.br_regdate}</div>
					<!-- 댓글 드롭다운 본인 댓글만  수정 삭제 가능 -->
						<div class="col-1">
						<div class="btn-group">
							<button class="btn btn-secondary btn-sm dropdown-toggle"
								type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
							<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="javascript:re_reply('${dto.br_num }')" method="post">대댓글</a></li>
									<c:if test="${login_mem.mem_num eq dto.mem_num}">
	 <!-- 에이젝스 여기야 여기 -->		<li><a class="dropdown-item" href="javascript:updateReply('${dto.br_num}')" method="post">수정</a></li>
								<li><a class="dropdown-item" href="delete_reply_sh.do?br_num=${dto.br_num}&board_num=${getBoard.board_num}&pageNum=${pageNum}">삭제</a></li>
										</c:if>
										<c:if test="${dto.mem_num ne login_mem.mem_num}">
								<li><a class="dropdown-item" href="javascript:checkReport_br('${dto.br_num}')">신고</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
					</c:if>
					</c:if>
	<!-- 대댓글 누르면 폼 생성 -->	<div class= "row" id="re_reply${dto.br_num}">
							</div>
					</c:forEach>
			</div>
		<!-- 댓글입력창 -->
		<form name="f1" action="write_reply_sh.do" method="post">
			<input type="hidden" name="board_num" value="${getBoard.board_num}" />
			<input type="hidden" name="br_num" value="${params.br_num}" /> <input
				type="hidden" name="br_re_group" value="${params.br_re_group}" /> <input
				type="hidden" name="br_re_step" value="${params.br_re_step}" /> <input
				type="hidden" name="br_re_level" value="${params.br_re_level}" />
			<div class="input-group mb-3 w-50 p-3 mx-auto p-2">
			<input hidden="hidden"><!-- 엔터키 서브밋 방지 -->
				<input type="text" class="form-control" placeholder="댓글을 입력하세요"
					aria-label="Recipient's username" aria-describedby="button-addon2"
					name="br_content"> <a href="javascript:check()">
					<input type="button" class="btn btn-outline-secondary" id="button-addon2"
					value="작성"></a>
			</div>
		</form>
		<!-- 댓글 리스트 쪽수 -->
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${count>0}">
					<c:if test="${startPage > pageBlock}">
						<li class="page-item"><a class="page-link"
							href="content_board_sh.do?board_num=${getBoard.board_num}&pageNum=${startPage-pageBlock}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>

					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<li class="page-item"><a class="page-link"
							href="content_board_sh.do?board_num=${getBoard.board_num}&pageNum=${i}">${i}</a></li>
					</c:forEach>

					<c:if test="${endPage < pageCount}">
						<li class="page-item"><a class="page-link"
							href="content_board_sh.do?board_num=${getBoard.board_num}&pageNum=${startPage+pageBlock}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</c:if>
			</ul>
		</nav>
	</div>
	<!-- 삭제시 게시글 번호 ,이미지 넘기기 -->
	<form name="f" action="delete_board_sh.do" method="post">
		<input type="hidden" name="board_num" /> 
		<input type="hidden" name="board_img1" /> 
		<input type="hidden" name="board_img2" /> 
		<input type="hidden" name="board_img3" /> 
		<input type="hidden" name="board_img4" />
	</form>
</body>
<%@include file="../user/user_bottom.jsp"%>
</html>
