<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_report_list.jsp // 전체 회원 신고 내역 -->

<%@include file="admin_top.jsp" %>

<!-- 삭제 script -->
<script type="text/javascript">
	function checkDel(report_num, report_target){
		var isDel = window.confirm("신고취소 처리하시겠습니까?")
		if (isDel){
			document.f3.report_num.value = report_num
			document.f3.report_target.value = report_target
			document.f3.submit()
		}
	}
</script>

<%@include file="member_sidebar.jsp" %>

		<!-- 내용 // 전체 회원 신고 내역-->
		<div class="container text-center">
			<p>
			<p>
			
				<div class="row row-cols-1" style="width: 1000px;">
			    	<h5>전체 회원 신고 내역</h5>
					<div class="col" style="overflow: scroll; height: 800px;">
						<div align="right">
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_member_report_list.do'">
							전체 목록 보기</button>&nbsp;&nbsp;
							<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_member_report_list.do?mode=sort'">
							신고 미처리 목록 보기</button>&nbsp;&nbsp;
						</div>
						<p>
						<table class="table table-hover table-bordered table align-middle" width="80%">
							<thead class="table-light">
							<tr align="center">
								<th width="5%" height="40">#</th>
								<th width="15%">신고자</th>
								<th width="10%">신고일</th>
								<th width="20%">구분</th>
								<th width="20%">신고 상세내용</th>
								<th width="10%">처리 여부</th>
								<th width="10%">신고 취소</th>
								<th width="10%">신고대상<br>상세보기</th>
							</tr>
							</thead>
							<tbody>
							<c:if test="${empty listReport}">
								<tr>
									<td colspan="8">신고된 회원이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listReport}">
							<c:forEach items="${listReport}" var="dto">
								<tr align="center">
									<td>${dto.report_num}</td>
									<td>${dto.mem_nickname}</td>
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
									<td><a href="javascript:checkDel('${dto.report_num}','${dto.report_target}')">신고취소</a></td>
									<td><a href="admin_member_view.do?mem_num=${dto.report_target}&report=member">보기</a></td>
								</tr>
							</c:forEach>
							</c:if>
							</tbody>
						</table>
						<form name="f3" action="admin_report_member_delete.do" method="post">
							<input type="hidden" name="report_num"/>
							<input type="hidden" name="report_target"/>
							<input type="hidden" name="report_mode" value="회원"/>
						</form>
					</div>
				</div>
			</div>
	</main>
</div>

<%@include file="admin_bottom.jsp" %>