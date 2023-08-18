<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_report_list.jsp // 전체 피드 신고 내역 -->

<%@include file="admin_top.jsp" %>

<!-- 삭제 script -->
<!-- <script type="text/javascript">
	function checkDel(report_num, report_target, report_mode){
		var isDel = window.confirm("신고취소 처리하시겠습니까?")
		if (isDel){
			document.f3.report_num.value = report_num
			document.f3.report_target.value = report_target
			document.f3.report_mode.value = report_mode
			document.f3.submit()
		}
	}
</script> -->
<script type="text/javascript">
	function viewFeed(report_num){
		$.ajax({
		    url:'admin_feed_report_view.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'report_num': report_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	//var test = document.getElementById("feedView"); //javascript문법
		    	//var test = $("#feedView") //jquery문법
		    	
		    	// 추가할 태그
		    	var content = data
	
		    	//Id가 feedView인 항목 하단에 content 를 삽입한다.
		    	$("#feedView").html(content) ;
	
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행
		    }
		});
	}
</script>


<%@include file="member_sidebar.jsp" %>

		<!-- 내용 // 전체 피드 신고 내역-->
		<div class="container text-center">
			<p>
			<p>
			
				<div class="row row-cols-2" style="width: 1400px;">
			    	<h5>전체 피드 신고 내역</h5>
					<div class="col" style="overflow: scroll; width: 900px; height: 800px;">
						<div align="right">
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_feed_report_list.do'">
							전체 목록 보기</button>&nbsp;&nbsp;
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_feed_report_list.do?mode=sort'">
							신고 미처리 목록 보기</button>&nbsp;&nbsp;
						</div>
						<p>
						<table class="table table-hover table-bordered table align-middle" width="80%">
							<thead class="table-light">
							<tr align="center">
								<th width="5%" height="40">#</th>
								<th width="10%">피드<br>댓글</th>
								<th width="15%">신고자</th>
								<th width="10%">신고일</th>
								<th width="20%">구분</th>
								<th width="20%">신고 상세내용</th>
								<th width="10%">처리 여부</th>
								<th width="10%">신고대상<br>상세보기</th>
							</tr>
							</thead>
							<tbody>
							<c:if test="${empty listReport}">
								<tr>
									<td colspan="8">신고된 피드가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listReport}">
							<c:forEach items="${listReport}" var="dto">
								<tr align="center">
									<td>${dto.report_num}</td>
									<td>
										<c:if test="${dto.report_mode eq '피드'}"><span class="badge rounded-pill text-bg-info">피드</span></c:if>
										<c:if test="${dto.report_mode eq '피드댓글'}"><span class="badge rounded-pill text-bg-warning">피드댓글</span></c:if>
									</td>
									<td>${dto.mem_num}</td>
									<td>${dto.report_regdate}</td>
									<td>
										<c:if test="${dto.report_content eq 1}">
											욕설 및 부적절한 언어
										</c:if>
										<c:if test="${dto.report_content eq 2}">
											광고 및 스팸성
										</c:if>
										<c:if test="${dto.report_content eq 3}">
											개인정보노출
										</c:if>
										<c:if test="${dto.report_content eq 4}">
											음란성/선정성
										</c:if>
										<c:if test="${dto.report_content eq 5}">
											도배성
										</c:if>
									</td>
									<td>${dto.report_detail}</td>
									<td>
										<c:if test="${dto.report_check eq 0 }">❌</c:if>
										<c:if test="${dto.report_check ne 0 }">⭕</c:if>
									</td>
									<td>
										<c:if test="${dto.report_check eq 0}">
											<a href="javascript:viewFeed('${dto.report_num}')">보기</a>
										</c:if>
										<c:if test="${dto.report_check ne 0}">-</c:if>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							</tbody>
						</table>
					</div>
					<div id="feedView" class="col" style="overflow: scroll; width: 500px; height: 800px;">
					</div>
				</div>
			</div>
	</main>
</div>

<%@include file="admin_bottom.jsp" %>