<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- board_total_report_list.jsp // 전체 게시판 신고 내역 -->
<%@include file="admin_top.jsp" %>

	<!-- 커뮤니티관리 사이드바 -->
	<%@include file="board_sidebar.jsp" %>
	
<!-- 삭제 script -->
<script type="text/javascript">
	function viewBoard(report_target, report_mode){
		window.open("admin_board_total_report_view.do?report_target="+report_target+"&report_mode="+report_mode, "", "width=1500, height=800")
	}
</script>
	<!-- 내용  // 상품 상세보기 -->
			<div class="container text-center">
			<p>
			<p>
			<div align="left"><button class="btn btn-outline-secondary btn-sm" type="button" onclick="window.location='admin_board_total_report.do?mode=all'">전체 목록 보기</button>&nbsp;&nbsp;
								<button class="btn btn-outline-secondary btn-sm" type="button" onclick="window.location='admin_board_total_report.do?mode=report'">미처리 목록 보기</button>&nbsp;&nbsp;</div>
			<div class="row row-cols-2" style="width: 1400px;">
				<div class="col" style="overflow: scroll; width: 700px; height: 800px;">
					<p class="fs-5">게시판 신고 내역</p>
					
					<table class="table align-middle" width="80%" height="80%">
						<thead>
							<tr align="center">
								<th>#</th>
								<th>신고대상</th>
								<th>구분</th>
								<th>신고자</th>
								<th>신고내용</th>
								<th>상세내용</th>
								<th>신고일</th>
								<th>처리여부</th>
							</tr>						
						</thead>
						<tbody>
							<c:if test="${empty listBoardReport}">
								<tr align="center">
									<td colspan="8">신고된 게시글이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listBoardReport}">
								<c:forEach items="${listBoardReport}" var="dto">
									<tr align="center">
										<td>${dto.report_num}</td>
										<td>
											<c:if test="${dto.report_check eq 0 }"><a href="javascript:viewBoard('${dto.report_target}','${dto.report_mode }')">${dto.report_target}</a></c:if>
											<c:if test="${dto.report_check eq 1 }">${dto.report_target}</c:if>
										</td>
										
										<td>
											<c:if test="${dto.report_mode eq '자유,익명게시글'}"><span class="badge rounded-pill text-bg-info">자유/익명</span></c:if>
											<c:if test="${dto.report_mode eq '중고게시글'}"><span class="badge rounded-pill text-bg-warning">중고</span></c:if>
										</td>
										<td>${dto.mem_nickname}</td>
										<td>${dto.report_content}</td>
										<td>${dto.report_detail}</td>
										<td>${dto.report_regdate}</td>
										<td>
											<c:if test="${dto.report_check eq 0 }">❌</c:if>
											<c:if test="${dto.report_check eq 1 }">⭕</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
		    		</div>
		  	<div class="col" style="overflow: scroll; width:700px; height: 800px;" align="center">
				<p class="fs-5">댓글 신고 내역</p>
				<!-- <div align="right"><button class="btn btn-secondary btn-sm" type="button">전체 목록 보기</button>&nbsp;&nbsp;
								<button class="btn btn-secondary btn-sm" type="button">미처리 목록 보기</button>&nbsp;&nbsp;</div> -->
				<table class="table align-middle" width="100%" height="80%">
					<thead>
						<tr align="center">
							<th>#</th>
							<th>신고대상</th>
							<th>구분</th>
							<th>신고자</th>
							<th>신고내용</th>
							<th>상세내용</th>
							<th>신고일</th>
							<th>처리여부</th>
						</tr>						
					</thead>
					<tbody>
						<c:if test="${empty listBrReport}">
							<tr align="center">
								<td colspan="8">신고된 댓글이 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty listBrReport}">
							<c:forEach items="${listBrReport}" var="dto">
								<tr align="center">
									<td>${dto.report_num}</td>
									<td>
										<c:if test="${dto.report_check eq 0 }"><a href="javascript:viewBoard('${dto.report_target}','${dto.report_mode }')">${dto.report_target}</a></c:if>
										<c:if test="${dto.report_check eq 1 }">${dto.report_target}</c:if>
									</td>
									<td>
										<c:if test="${dto.report_mode eq '자유,익명댓글'}"><span class="badge rounded-pill text-bg-info">자유/익명</span></c:if>
										<c:if test="${dto.report_mode eq '중고댓글'}"><span class="badge rounded-pill text-bg-warning">중고</span></c:if>
									</td>
									<td>${dto.mem_nickname}</td>
									<td>${dto.report_content}</td>
									<td>${dto.report_detail}</td>
									<td>${dto.report_regdate}</td>
									<td>
										<c:if test="${dto.report_check eq 0 }">❌</c:if>
										<c:if test="${dto.report_check eq 1 }">⭕</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				</div>
			</div>
		</div>
		</main>
	</div>

<%@include file="admin_bottom.jsp" %>