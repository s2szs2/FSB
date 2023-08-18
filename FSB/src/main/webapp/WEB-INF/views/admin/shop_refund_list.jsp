<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_refund_list.jsp // 쇼핑몰 환불 내역 -->

<script type="text/javascript">
	function viewRefund(refund_num){
		$.ajax({
		    url:'admin_shop_refund_view.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'refund_num': refund_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#ShopRefundView").html(content) ;
	
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
		    }
		});
	}
</script>


<%@include file="admin_top.jsp" %>

	<!-- 쇼핑몰관리 사이드바 -->
	<%@include file="shop_sidebar.jsp" %>
	
	<!-- 내용  // 환불 내역 -->
			<div class="container text-center">

			<div class="row row-cols-2" style="height: 800px; width: 1400px;">
				<div class="col" style="overflow: scroll; width: 900px; height: 800px;">
				<p>
				<h6>환불 내역</h6>
					<div align="center">
					<h6>
					<button class="btn btn-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample3" aria-expanded="false" aria-controls="collapseExample3">
						환불 내역 찾기</button></h6>
						<div class="collapse show" id="collapseExample3">
				 			<div class="card card-body">
							<form name="f3" id="f3" action="admin_shop_refund_find.do" method="post">
								<select name="search">
									<option value="mem_name">신청자 이름</option>
									<option value="mem_id">신청자 ID</option>
								</select>
								<input type="text" name="searchString">
								<a href="javascript:findOrder()"><button class="btn btn-secondary btn-sm">찾기</button></a>
							</form>
							<br>
							<br>
							<table border="0">
								<tr align="center">
									<th>환불#</th>
									<th>신청자ID</th>
									<th>신청자 이름</th>
									<th>상세보기</th>
								</tr>
								<tr align="center">
									<c:if test="${empty findRefund}">
										<td colspan="4">찾으시는 환불내역이 없습니다.</td>
									</c:if>
									<c:if test="${not empty findRefund}">
										<c:forEach items="${findRefund}" var="rdto">
											<td>${rdto.order_num}</td>
											<td>${rdto.mem_id}</td>
											<td>${rdto.mem_name}</td>
											<td><a href="javascript:viewRefund('${rdto.refund_num}')"><button type="button" class="btn btn-secondary btn-sm">보기</button></a></td>
										</c:forEach>
									</c:if>
								</tr>
							</table>
							</div>
						</div>
					</div>
				
						<div class="accordion accordion-flush" id="accordionFlushExample">
						<div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingZero">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseZero" aria-expanded="false" aria-controls="flush-collapseZero">
						      		💴환불 요청&nbsp;<span class="badge rounded-pill text-bg-warning">${count1}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseZero" class="accordion-collapse collapse" aria-labelledby="flush-headingZero">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>주문#</th>
							      				<th>신청자</th>
							      				<th>요청일</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty listRefund1}">
						      				<tr align="center">
						      					<td colspan="6">환불 요청 단계의 환불내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty listRefund1}">
						      				<c:forEach items="${listRefund1}" var="dto">
						      				<tr align="center">
						      					<td>${dto.refund_num}</td>
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.refund_date}</td>
						      					<td>
						      						<c:if test="${dto.refund_progress eq 1 }">환불 요청</c:if>
						      						<c:if test="${dto.refund_progress eq 2 }">접수 완료</c:if>
						      						<c:if test="${dto.refund_progress eq 3 }">처리중</c:if>
						      						<c:if test="${dto.refund_progress eq 4 }">환불 완료</c:if>
						      					</td>
						      					<td><a href="javascript:viewRefund('${dto.refund_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
						      				</tr>
						      				</c:forEach>
						      			</c:if>
							      		</table>
							      	</div>
						      </div>
						    </div>
						  </div>
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingOne">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
						      		⭕접수 완료&nbsp;<span class="badge rounded-pill text-bg-warning">${count2}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>주문#</th>
							      				<th>신청자</th>
							      				<th>요청일</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty listRefund2}">
						      				<tr align="center">
						      					<td colspan="6">접수 완료 단계의 환불내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty listRefund2}">
						      				<c:forEach items="${listRefund2}" var="dto">
						      				<tr align="center">
						      					<td>${dto.refund_num}</td>
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.refund_date}</td>
						      					<td>
						      						<c:if test="${dto.refund_progress eq 1 }">환불 요청</c:if>
						      						<c:if test="${dto.refund_progress eq 2 }">접수 완료</c:if>
						      						<c:if test="${dto.refund_progress eq 3 }">처리중</c:if>
						      						<c:if test="${dto.refund_progress eq 4 }">환불 완료</c:if>
						      					</td>
						      					<td><a href="javascript:viewRefund('${dto.refund_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
						      				</tr>
						      				</c:forEach>
						      			</c:if>
							      		</table>
							      	</div>
						      </div>
						    </div>
						  </div>
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingTwo">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
						      		🚗처리중&nbsp;<span class="badge rounded-pill text-bg-warning">${count3}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>주문#</th>
							      				<th>신청자</th>
							      				<th>요청일</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty listRefund3}">
						      				<tr align="center">
						      					<td colspan="6">처리중 단계의 환불내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty listRefund3}">
						      				<c:forEach items="${listRefund3}" var="dto">
						      				<tr align="center">
						      					<td>${dto.refund_num}</td>
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.refund_date}</td>
						      					<td>
						      						<c:if test="${dto.refund_progress eq 1 }">환불 요청</c:if>
						      						<c:if test="${dto.refund_progress eq 2 }">접수 완료</c:if>
						      						<c:if test="${dto.refund_progress eq 3 }">처리중</c:if>
						      						<c:if test="${dto.refund_progress eq 4 }">환불 완료</c:if>
						      					</td>
						      					<td><a href="javascript:viewRefund('${dto.refund_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
						      				</tr>
						      				</c:forEach>
						      			</c:if>
							      		</table>
							      	</div>
						      </div>
						    </div>
						  </div>
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingThree">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
						      		🎁환불 완료&nbsp;<span class="badge rounded-pill text-bg-warning">${count4}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>주문#</th>
							      				<th>신청자</th>
							      				<th>요청일</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty listRefund4}">
						      				<tr align="center">
						      					<td colspan="6">환불 완료 단계의 환불내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty listRefund4}">
						      				<c:forEach items="${listRefund4}" var="dto">
						      				<tr align="center">
						      					<td>${dto.refund_num}</td>
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.refund_date}</td>
						      					<td>
						      						<c:if test="${dto.refund_progress eq 1 }">환불 요청</c:if>
						      						<c:if test="${dto.refund_progress eq 2 }">접수 완료</c:if>
						      						<c:if test="${dto.refund_progress eq 3 }">처리중</c:if>
						      						<c:if test="${dto.refund_progress eq 4 }">환불 완료</c:if>
						      					</td>
						      					<td><a href="javascript:viewRefund('${dto.refund_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
						      				</tr>
						      				</c:forEach>
						      			</c:if>
							      		</table>
							      	</div>
						      </div>
						    </div>
						  </div>
						</div>
					</div>
					<div id="ShopRefundView" class="col" style="overflow: scroll; width: 500px; height: 800px;">
					</div>
		    	</div>
		</main>
	</div>