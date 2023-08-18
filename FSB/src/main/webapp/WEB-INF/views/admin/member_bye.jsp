<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_list.jsp // 회원 탈퇴 내용-->

<%@include file="admin_top.jsp" %>


<%@include file="member_sidebar.jsp" %>

		<!-- 내용 // 일반 회원 목록-->
		<div class="container text-center">
			<p>
			<p>
				<div class="row row-cols-1" style="width: 800px;">
			    	<div class="col">
			    		<p class="fs-5">회원 탈퇴 내역</p>
			    	</div>
			    	<p>
					<div class="col" style="overflow: scroll; height: 800px;">
						<table class="table table-hover table-bordered table align-middle" width="80%" height="100">
							<thead class="table-light">
							<tr align="center">
								<th width="15%">닉네임</th>
								<th width="15%">탈퇴일</th>
								<th width="70%">탈퇴사유</th>
							</tr>
							</thead>
							<tbody>
							<c:if test="${empty listBye}">
								<tr>
									<td colspan="3">탈퇴 내역이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty listBye}">
							<c:forEach items="${listBye}" var="dto">
								<tr align="center">
									<td>${dto.nickname}</td>
									<td>${dto.regdate}</td>
									<td>
										<c:if test="${dto.reason eq 1}">상품 탐색이 어려움</c:if>
										<c:if test="${dto.reason eq 2}">관심있는 보드게임이 없음</c:if>
										<c:if test="${dto.reason eq 3}">개인정보 유출 우려</c:if>
										<c:if test="${dto.reason eq 4}">다른 계정이 있음</c:if>
										<c:if test="${dto.reason eq 5}">재가입 예정</c:if>
										<c:if test="${dto.reason eq 6}">광고가 많음</c:if>
										<c:if test="${dto.reason eq 7}">상품 가격이 비쌈</c:if>
										<c:if test="${dto.reason eq 8}">상품 배송이 느림</c:if>
										<c:if test="${dto.reason eq 9}">기타</c:if>
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
