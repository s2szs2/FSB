<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_total_review_list.jsp // 전체 상품 리뷰 목록 -->

<%@include file="admin_top.jsp" %>

	<!-- 쇼핑몰관리 사이드바 -->
	<%@include file="shop_sidebar.jsp" %>
	
<!-- script -->
<script type="text/javascript">
	function viewProd(prod_num){
		window.open("admin_prod_view.do?prod_num="+prod_num, "", "width=1500, height=800")
	}
</script>
<!-- 삭제 script -->
<script type="text/javascript">
	function checkDel(sr_num, sr_img1, sr_img2, sr_img3, sr_img4){
		var isDel = window.confirm("정말로 삭제하겠습니까?")
		if (isDel){
			document.f3.sr_num.value = sr_num
			document.f3.sr_img1.value = sr_img1
			document.f3.sr_img2.value = sr_img2
			document.f3.sr_img3.value = sr_img3
			document.f3.sr_img4.value = sr_img4
			document.f3.submit()
		}
	}
</script>

	<script type="text/javascript">
	function viewReview(sr_num){
		$.ajax({
		    url:'admin_total_shop_review_view.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'sr_num': sr_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#ShopReviewView").html(content) ;
	
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
		    }
		});
	}
</script>


	<!-- 내용  // 상품 목록 -->
			<div class="container text-center">
			<p>
			<p>
			<div class="row row-cols-2" style="height: 800px; width: 1400px;">
			    	<div class="col" style="overflow: scroll; width: 700px; height: 800px;">
			    		<p class="fs-5">전체 상품 리뷰 목록</p>
						<div align="right">
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_shop_total_review.do?sort=starrating_asc'">
							별점 낮은순</button>&nbsp;&nbsp;
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_shop_total_review.do?sort=starrating_desc'">
							별점 높은순
							</button>
						</div>
					<table class="table table-hover table-bordered table align-middle" width="60%" height="80%">
						<thead class="table-light">
							<tr align="center">
								<th width="5%" height="50">#</th>
								<th width="15%">상품 번호</th>
								<th width="25%">작성자</th>
								<th width="15%">별점</th>
								<th width="10%">작성일</th>
								<th width="10%">보기</th>
								<th width="10%">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty listShopReview}">
								<tr>
									<td colspan="7">등록된 리뷰가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listShopReview}">
							<c:forEach items="${listShopReview}" var="dto">
								<tr align="center">
									<td  height="170">${dto.sr_num}</td>
									<td><a href="javascript:viewProd('${dto.prod_num}')">${dto.prod_num}</a></td>
									<td>${dto.mem_nickname}</td>
									<td><img src="resources/img/star2.png" width="25" height="25">&nbsp;${dto.sr_starrating}</td>
									<td>${dto.sr_regdate}</td>
									<td><a href="javascript:viewReview('${dto.sr_num}')">보기</a></td>
									<td><a href="javascript:checkDel('${dto.sr_num}','${dto.sr_img1}','${dto.sr_img2}','${dto.sr_img3}','${dto.sr_img4}')">삭제</a></td>
								</tr>
							</c:forEach>
							</c:if>
						</tbody>
					</table>
		    		</div>
		    		<div id="ShopReviewView" class="col" style="overflow: scroll; width: 700px; height: 800px;" align="center"></div>
		    	</div>
		</main>
	</div>

<%@include file="admin_bottom.jsp" %>