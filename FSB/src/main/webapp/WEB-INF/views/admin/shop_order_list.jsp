<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_order_list.jsp // 쇼핑몰 주문 내역 -->

<script type="text/javascript">
	function viewOrder(order_num){
		$.ajax({
		    url:'admin_shop_order_view.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'order_num': order_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#ShopOrderView").html(content) ;
	
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
	
	<!-- 내용  // 상품 목록 -->
			<div class="container text-center">

			<div class="row row-cols-2" style="height: 800px; width: 1400px;">
				<div class="col" style="overflow: scroll; width: 900px; height: 800px;">
				<p>
				<h6>주문 내역</h6>
				
					<div align="center">
					<h6>
					<button class="btn btn-secondary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample3" aria-expanded="false" aria-controls="collapseExample3">
						주문 내역 찾기</button></h6>
						<div class="collapse show" id="collapseExample3">
				 			<div class="card card-body">
							<form name="f3" id="f3" action="admin_shop_order_find.do" method="post">
								<select name="search">
									<option value="mem_name">주문자 이름</option>
									<option value="mem_id">주문자 ID</option>
								</select>
								<input type="text" name="searchString">
								<a href="javascript:findOrder()"><button class="btn btn-secondary btn-sm">찾기</button></a>
							</form>
							<br>
							<br>
							<table border="0">
								<tr align="center">
									<th>주문#</th>
									<th>주문자ID</th>
									<th>주문자 이름</th>
									<th>상세보기</th>
								</tr>
								<tr align="center">
									<c:if test="${empty findOrder}">
										<td colspan="4">찾으시는 주문내역이 없습니다.</td>
									</c:if>
									<c:if test="${not empty findOrder}">
										<c:forEach items="${findOrder}" var="odto">
											<td>${odto.order_num}</td>
											<td>${odto.mem_id}</td>
											<td>${odto.mem_name}</td>
											<td><a href="javascript:viewOrder('${odto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">보기</button></a></td>
										</c:forEach>
									</c:if>
								</tr>
							</table>
							</div>
						</div>
					</div>
					
					<!-- <div align="right">
						<a href="javascript:findForm()"><button type="button" class="btn btn-secondary btn-sm">검색</button></a>
					</div> -->
						<div class="accordion accordion-flush" id="accordionFlushExample">
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingOne">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
						        	🚨구매 요청&nbsp;<span class="badge rounded-pill text-bg-warning">${count1}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne">
						      <div class="accordion-body">
						      	<div style="overflow: scroll; width: 820px; height: 400px;" align="center">
						      		<table width="80%" height="80%">
						      			<tr align="center">
						      				<th>#</th>
						      				<th>구매자</th>
						      				<th>구매일</th>
						      				<th>최종 금액</th>
						      				<th>처리단계</th>
						      				<th>상세보기</th>
						      			</tr>
						      			<c:if test="${empty list1}">
						      				<tr align="center">
						      					<td colspan="6">구매요청단계의 주문내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty list1}">
						      				<c:forEach items="${list1}" var="dto">
						      				<tr align="center">
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.order_date}</td>
						      					<td>${df.format(dto.order_receiptprice)}</td>
						      					<td>
						      						<%-- <c:if test="${dto.order_progress eq 0 }">입금 대기</c:if> --%>
						      						<c:if test="${dto.order_progress eq 1 }">구매 요청</c:if>
						      						<c:if test="${dto.order_progress eq 2 }">배송 준비</c:if>
						      						<c:if test="${dto.order_progress eq 3 }">배송중</c:if>
						      						<c:if test="${dto.order_progress eq 4 }">구매 확정</c:if>
						      					</td>
						      					<td><a href="javascript:viewOrder('${dto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
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
						      		🎁배송 준비&nbsp;<span class="badge rounded-pill text-bg-warning">${count2}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>구매자</th>
							      				<th>구매일</th>
							      				<th>최종 금액</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty list2}">
						      				<tr align="center">
						      					<td colspan="6">배송 준비 단계의 주문내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty list2}">
						      				<c:forEach items="${list2}" var="dto">
						      				<tr align="center">
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.order_date}</td>
						      					<td>${df.format(dto.order_receiptprice)}</td>
						      					<td>
						      						<%-- <c:if test="${dto.order_progress eq 0 }">입금 대기</c:if> --%>
						      						<c:if test="${dto.order_progress eq 1 }">구매 요청</c:if>
						      						<c:if test="${dto.order_progress eq 2 }">배송 준비</c:if>
						      						<c:if test="${dto.order_progress eq 3 }">배송중</c:if>
						      						<c:if test="${dto.order_progress eq 4 }">구매 확정</c:if>
						      					</td>
						      					<td><a href="javascript:viewOrder('${dto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
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
						       		🚗배송중&nbsp;<span class="badge rounded-pill text-bg-warning">${count3}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree">
						      <div class="accordion-body">
						      	<div style="overflow: scroll; width: 820px; height: 400px;" align="center">
						      		<table width="80%" height="80%">
						      			<tr align="center">
						      				<th>#</th>
						      				<th>구매자</th>
						      				<th>구매일</th>
						      				<th>최종 금액</th>
						      				<th>처리단계</th>
						      				<th>상세보기</th>
						      			</tr>
						      			<c:if test="${empty list3}">
						      				<tr align="center">
						      					<td colspan="6">배송중 단계의 주문내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty list3}">
						      				<c:forEach items="${list3}" var="dto">
						      				<tr align="center">
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.order_date}</td>
						      					<td>${df.format(dto.order_receiptprice)}</td>
						      					<td>
						      						<%-- <c:if test="${dto.order_progress eq 0 }">입금 대기</c:if> --%>
						      						<c:if test="${dto.order_progress eq 1 }">구매 요청</c:if>
						      						<c:if test="${dto.order_progress eq 2 }">배송 준비</c:if>
						      						<c:if test="${dto.order_progress eq 3 }">배송중</c:if>
						      						<c:if test="${dto.order_progress eq 4 }">구매 확정</c:if>
						      					</td>
						      					<td><a href="javascript:viewOrder('${dto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
						      				</tr>
						      				</c:forEach>
						      			</c:if>
						      		</table>
						      	</div>
						      </div>
						    </div>
						  </div>
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="flush-headingFour">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
						     		⭕구매확정&nbsp;<span class="badge rounded-pill text-bg-warning">${count4}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>구매자</th>
							      				<th>구매일</th>
							      				<th>최종 금액</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty list4}">
						      				<tr align="center">
						      					<td colspan="6">구매확정 단계의 주문내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty list4}">
						      				<c:forEach items="${list4}" var="dto">
						      				<tr align="center">
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.order_date}</td>
						      					<td>${df.format(dto.order_receiptprice)}</td>
						      					<td>
						      						<%-- <c:if test="${dto.order_progress eq 0 }">입금 대기</c:if> --%>
						      						<c:if test="${dto.order_progress eq 1 }">구매 요청</c:if>
						      						<c:if test="${dto.order_progress eq 2 }">배송 준비</c:if>
						      						<c:if test="${dto.order_progress eq 3 }">배송중</c:if>
						      						<c:if test="${dto.order_progress eq 4 }">구매 확정</c:if>
						      					</td>
						      					<td><a href="javascript:viewOrder('${dto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
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
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseZero" aria-expanded="false" aria-controls="flush-collapseZero">
						      		💴환불 요청&nbsp;<span class="badge rounded-pill text-bg-warning">${count0}</span>
						      </button>
						    </h2>
						    <div id="flush-collapseZero" class="accordion-collapse collapse" aria-labelledby="flush-headingZero">
						      <div class="accordion-body">
							      <div style="overflow: scroll; width: 820px; height: 400px;" align="center">
							      		<table width="80%" height="80%">
							      			<tr align="center">
							      				<th>#</th>
							      				<th>구매자</th>
							      				<th>구매일</th>
							      				<th>최종 금액</th>
							      				<th>처리단계</th>
							      				<th>상세보기</th>
							      			</tr>
							      			<c:if test="${empty list0}">
						      				<tr align="center">
						      					<td colspan="6">환불 요청 단계의 주문내역이 없습니다.</td>
						      				</tr>
						      			</c:if>
						      			<c:if test="${not empty list0}">
						      				<c:forEach items="${list0}" var="dto">
						      				<tr align="center">
						      					<td>${dto.order_num}</td>
						      					<td>${dto.mem_num}</td>
						      					<td>${dto.order_date}</td>
						      					<td>${df.format(dto.order_receiptprice)}</td>
						      					<td>
						      						<c:if test="${dto.order_progress eq 0 }">환불 요청</c:if>
						      						<c:if test="${dto.order_progress eq 1 }">구매 요청</c:if>
						      						<c:if test="${dto.order_progress eq 2 }">배송 준비</c:if>
						      						<c:if test="${dto.order_progress eq 3 }">배송중</c:if>
						      						<c:if test="${dto.order_progress eq 4 }">구매 확정</c:if>
						      					</td>
						      					<td><a href="javascript:viewOrder('${dto.order_num}')"><button type="button" class="btn btn-secondary btn-sm">상세보기</button></a></td>
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
					<div id="ShopOrderView" class="col" style="overflow: scroll; width: 500px; height: 800px;">
					</div>
		    	</div>
		</main>
	</div>