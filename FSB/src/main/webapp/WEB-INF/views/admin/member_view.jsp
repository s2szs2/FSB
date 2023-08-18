<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- member_view.jsp // 일반 회원 상세보기 -->

<%@include file="admin_top.jsp" %>

<!-- 수정 새 창 -->
<script type="text/javascript">
	function updateForm(mem_num){
		window.open("admin_member_update.do?mem_num="+mem_num, "", "width=640, height=400")
	}
	function reportList(mem_num) {
		window.open("admin_getmember_report_list.do?mem_num="+mem_num,"",  "width=700, height=470, left=680, top=270")
	}
	function viewFeed(mem_num){
		window.open("personalHome.do?num="+mem_num, "", "width=1000, height=800, left=680, top=270")
	}
	function updateProfForm(mem_num){
		window.open("admin_member_prof_update.do?mem_num="+mem_num,"", "width=640, height=400")
	}
</script>
	
<%@include file="member_sidebar.jsp" %>

		<!-- 내용 // 일반 회원 상세보기 -->
			<div class="container text-center">
			<p>
			<p>
				<div class="row row-cols-2" style="height: 800px; width: 1400px;">
			    	<div class="col" style="overflow: scroll; height: 800px; width: 700px;">
			    	<p class="fs-5">회원 상세 보기</p>
				    	<div align="right">
				    		<a href="javascript:reportList('${getMember.mem_num}')"><button type="button" class="btn btn-secondary btn-sm">신고내역 보기</button></a>
				    	</div>
						<table class="table align-middle" width="80%" height="80%">
								<tr align="center">
									<th width="15%">번호</th><td width="35%">${getMember.mem_num}</td>
									<th width="15%">회원구분</th><td width="35%">${getMember.mem_mode}</td>
								</tr>
								<tr align="center">
									<th>아이디</th><td>${getMember.mem_id}</td>
									<th>이름</th><td>${getMember.mem_name}</td>	
								</tr>
								<tr align="center">
									<th>닉네임</th><td>${getMember.mem_nickname}</td>
									<th>프로필</th><td>
									<c:if test="${not empty getMember.mem_img}"><img src="resources/img/${getMember.mem_img}" width="150" height="150"></c:if>
									<c:if test="${empty getMember.mem_img}"><img src="resources/img/basic_profile.jpg" width="150" height="150"></c:if></td>
								</tr>
								<tr align="center">
									<th>HP</th><td colspan="3">${getMember.mem_hp1} - ${getMember.mem_hp2} - ${getMember.mem_hp3}</td>
								</tr>
								<tr align="center">
									<th>신고횟수</th><td colspan="3">${getMember.mem_report}</td>	
								</tr>
								<tr align="center">
									<th>뱃지</th>
									<td colspan="3">
										<c:if test="${getMember.badge_king eq '1'}"><img src="resources/img/king.png" width="40" height="40"></c:if>
										<c:if test="${getMember.badge_write eq '1'}"><img src="resources/img/write.png" width="40" height="40"></c:if>
										<c:if test="${getMember.badge_1004 eq '1'}"><img src="resources/img/1004.png" width="40" height="40"></c:if>
										<c:if test="${getMember.badge_good eq '1'}"><img src="resources/img/good.png" width="40" height="40"></c:if>
										<c:if test="${getMember.badge_rich eq '1'}"><img src="resources/img/rich.png" width="40" height="40"></c:if>
									</td>
								</tr>
								<tr align="center">
									<th>해시태그</th>
									<td colspan="3">
									<font size="2" color="gray">
										<c:if test="${getMember.tag_1 eq 1 }"># 추리&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_2 eq 1 }"># 전략&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_3 eq 1 }"># 카드&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_4 eq 1 }"># 공포/스릴러&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_5 eq 1 }"># 판타지&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_6 eq 1 }"># 역사&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_7 eq 1 }"># 공상과학&nbsp;&nbsp;</c:if>
										<c:if test="${getMember.tag_8 eq 1 }"># 스포츠&nbsp;&nbsp;</c:if>
									</font>
									</td>
								</tr>
								<%-- <tr align="center">
									<th>상태메세지</th>
									<td colspan="3">${getMember.mem_msg}</td>	
								</tr> --%>
								<tr align="right">
									<td colspan="4">
									<a href="javascript:updateForm('${getMember.mem_num}')"><button type="button" class="btn btn-secondary btn-sm">수정하기</button></a>
									<button type="button" class="btn btn-secondary btn-sm" onclick="window.location='admin_member_list.do'">돌아가기</button>
									</td>	
								</tr>
						</table>
					</div>
					<div class="col" style="overflow: scroll; width: 500px;">
						<h5>피드 프로필</h5>
						<br>
						<div align="left">
							<h6><strong>프로필 이미지</strong></h6>
							<img src="resources/img/${getProf.prof_img}" width="150" height="150">
							<h6><strong>프로필 상태메세지 : </strong>${getProf.prof_msg}</h6>
							<br>
							<br>
							<a href="javascript:updateProfForm('${getMember.mem_num}')"><button type="button" class="btn btn-secondary btn-sm">프로필 수정</button></a>
							<a href="javascript:viewFeed('${getMember.mem_num}')"><button type="button" class="btn btn-secondary btn-sm">피드 보기</button></a>
						</div>
					</div>
				</div>
			</div>
	</main>
</div>


<%@include file="admin_bottom.jsp" %>