<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_inventory_list.jsp // 재고 목록 -->

<script type="text/javascript">
	function viewProd(prod_num){
		window.open("admin_prod_view.do?prod_num="+prod_num, "", "width=1500, height=800")
	}
</script>

<script type="text/javascript">
	function inventoryInsert(){
		$.ajax({
		    url:'admin_shop_inventory_insert.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#ShopInventoryInsert").html(content) ;
	
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
		    }
		});
	}
</script>
<script type="text/javascript">
	function inventoryUpdate(prod_num){
		$.ajax({
		    url:'admin_shop_inventory_update.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'prod_num': prod_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#ShopInventoryInsert").html(content) ;
	
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
					<h6>재고 관리</h6>
						
			    	<p>
		    		
		    		<form name="f2" action="admin_shop_inventory_list.do" method="post">
						<input type="hidden" name="mode" value="find">
							<select name="search">
								<option value="prod_name">상품명</option>
							</select>
						<input type="text" name="searchString">
						<button class="btn btn-secondary btn-sm" type="submit">찾기</button>
					</form>
						<div align="center">
							<h6><font color="red"><strong>🚨재고량 5개 미만 상품이 ${count}개 있습니다🚨</strong></font></h6>
						</div>
						<div align="right">
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_shop_inventory_list.do'">
							전체 목록 보기</button>&nbsp;&nbsp;
							<a href="javascript:inventoryInsert()"><button class="btn btn-secondary btn-sm" type="button">
							재고 입력 하기</button></a>
						</div>
					
					<table class="table table-hover table-bordered table align-middle" width="60%" height="80%">
						<thead class="table-light">
							<tr align="center">
								<th width="10%" height="50">상품 #</th>
								<th width="20%">상품명</th>
								<th width="25%">이미지</th>
								<th width="15%">제조사</th>
								<th width="15%">재고량</th>
								<th width="15%">수정</th>
						</tr>
						</thead>
						<tbody>
							<c:if test="${empty listProd}">
								<tr align="center">
									<td colspan="6">등록된 상품이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listProd}">
								<c:forEach items="${listProd}" var="dto">
									<tr align="center">
										<td><a href="javascript:viewProd('${dto.prod_num}')">${dto.prod_num}</a></td>
										<td>${dto.game_name}</td>
										<td><img src="resources/img/${dto.game_img}" width="150" height="150"></td>
										<td>${dto.prod_company}</td>
										<td>
											<c:if test="${dto.prod_qty < 5}"><font color="red"><strong>${dto.prod_qty}</strong></font></c:if>
											<c:if test="${dto.prod_qty >= 5}">${dto.prod_qty}</c:if>
										</td>
										<td><a href="javascript:inventoryUpdate('${dto.prod_num}')">수정</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					</div>
					<div id="ShopInventoryInsert" class="col" style="overflow: scroll; width: 500px; height: 800px;">
					</div>
			    </div>
		    </div>
		</main>
	</div>
<%@include file="admin_bottom.jsp" %>