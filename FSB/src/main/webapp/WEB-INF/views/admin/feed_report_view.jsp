<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_refund_view.jsp // 쇼핑몰 환불내역 상세보기 -->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	
<script type="text/javascript">
	function checkDel(view, feed_num){
		var isDel = window.confirm("피드를 삭제하시겠습니까?")
		if (isDel){
			document.f3.feed_num.value = feed_num
			document.f3.view.value = view
			document.f3.submit()
		}
	}
	function checkReport(view, feed_num) {
		window.open("admin_get_feed_report_list.do?view="+view+"&feed_num="+feed_num,"",  "width=700, height=470, left=680, top=270")
	}
	function reportDel(view, feed_num){
		var isDel = window.confirm("신고 취소 처리 하겠습니까?")
		if (isDel){
			document.f2.feed_num.value = feed_num
			document.f2.view.value = view
			document.f2.submit()
		}
	}
</script>	
	
	<p>
	<p>
	<div align="left">
		<span class="link-dark text-decoration-none fs-5 fw-semibold">피드 상세보기</span></div>
			<div align="right">
				<a href="javascript:checkReport('피드','${feed.feed_num}')" class="link-secondary"><font size="2" color="gray">신고 내역</font></a>&nbsp;&nbsp;
				<c:if test="${feed.feed_report > 0 }"><a href="javascript:reportDel('피드','${feed.feed_num}')" class="link-secondary"><font size="2" color="gray">신고 취소</font></a>&nbsp;&nbsp;</c:if>
				<a href="javascript:checkDel('피드','${feed.feed_num}')" class="link-secondary"><font size="2" color="gray">피드 삭제</font></a>&nbsp;&nbsp;
			</div>
			<div class="list-group list-group-flush border-bottom scrollarea">
				<!-- 피드 본문 -->
				<div class="list-group-item py-3 lh-sm">
					<div class="d-flex w-100 align-items-center justify-content-between">
		        		<div class="container" style="padding-top: 1.5rem; padding-left: 1.5rem; padding-right: 1.5rem;">
		        			<div class="row">
			        			<div class="col" align="left">
			        				<img src="resources/img/${feed.prof_img}" width="25" height="25">&nbsp
			          				<strong>${feed.mem_nickname}</strong>
									<small class="text-muted" style="margin-left: 0.5rem;">${feed.mem_id} 피드 신고수🚨 ${feed.feed_report}</small>
			          			</div>
		          			</div>
		          			<!-- <div class="row mb-2" align="right">
	          					<div class="col-12" align="right">
	          						<svg fill="#A6A6A6" width="16" height="20"><use xlink:href="#location"></use></svg>
	          						<small class="text-muted">아직 위치정보못함</small>
	          					</div>
		          			</div> -->
		          			<div class="row mt-5 mb-4 ">
		          				<div class="tl-content-box-view">
       									${feed.feed_content}
       							</div>
		          			</div>
	       					<div class="row">
	       						<!-- 이미지 1장 -->
	       						<c:if test="${not empty feed.feed_img1 and empty feed.feed_img2}">
										<img class="tl-img" src="resources/img/${feed.feed_img1}">
	       						</c:if>
	       						<!-- 이미지 2장 -->
	       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and empty feed.feed_img3}">
	       							<img class="tl-img" src="resources/img/${feed.feed_img1}">
									<img class="tl-img" src="resources/img/${feed.feed_img2}">
								</c:if>
	       						<!-- 이미지 3장 -->
	       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and not empty feed.feed_img3 and empty feed.feed_img4}">
	       							<img class="tl-img" src="resources/img/${feed.feed_img1}" >
									<img class="tl-img" src="resources/img/${feed.feed_img2}" >
									<img class="tl-img" src="resources/img/${feed.feed_img3}" >
								</c:if>
	       						<!-- 이미지 4장 -->
	 	       					<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and not empty feed.feed_img3 and not empty feed.feed_img4}">
	       							<img class="tl-img" src="resources/img/${feed.feed_img1}">
									<img class="tl-img" src="resources/img/${feed.feed_img2}">
									<img class="tl-img" src="resources/img/${feed.feed_img3}">
									<img class="tl-img" src="resources/img/${feed.feed_img4}">
								</c:if>      						
       						</div>
       						<div class="row mt-4" style="padding-left: 0.5rem;">
    							<c:forEach var="theme" items="${feed.feed_theme}" varStatus="status">
     								<div class="col-auto" style="padding: 0.1rem 0.15rem; display: inline-block;">
      									<button type="button" class="btn btn-outline-secondary" style="--bs-btn-padding-y: .12rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .9rem;">
											#${theme.theme_name}
										</button>
									</div>
								</c:forEach>
       						</div>
       						<div class="row small">
       							<div class="col mt-3" align="left" style="padding:0">
	       							🗨️ 댓글 수 ${feed.feed_replyCount}  ❤️ 좋아요 ${feed.feed_likeCount}	       						
       							</div>
       						</div>
		        		</div>
	        		</div>
	        		<c:forEach var="reply" items="${feed.feed_reply}" varStatus="status">
					<!-- 댓글 하나 -->
					<div id="reply_${status}" class="list-group-item py-3 lh-sm">
						<div class="d-flex w-100 align-items-center justify-content-between">
							<%-- <!-- 신고됨 -->
							<c:if test="${reply.fr_report>=5}">
								<div align="center">
									<span>신고된 댓글입니다.</span>
								</div>
							</c:if>
							<!-- 볼 수 없음 -->
							<c:if test="${reply.fr_report<5 && reply.visible == 'no'}">
								<div align="center">
									<span>볼 수 없는 댓글입니다.</span>
								</div>
							</c:if> --%>
							<!-- 정상 출력 -->
							
		        				<div class="container">
			          				<div class="row mb-2">
					        			<div class="col" align="left">
					        				<img src="resources/img/${reply.prof_img}" width="25" height="25">&nbsp;
					          				<strong>${reply.mem_nickname}</strong><small class="text-muted">🚨${reply.fr_report}</small>
											<%-- <c:if test="${reply.prof_open == 'secret'}">
												<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
				  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
												</svg>
											</c:if> --%>
											<small class="text-muted" style="margin-left: 0.5rem;">${reply.mem_id}</small>
					          			</div>
					          			<%-- <div class="col" align="right">
					          				<c:if test="${login_mem.mem_num == reply.mem_num}">
					          					<small class="text-muted" onclick="updateReply(${reply.fr_num},${status})">수정 </small>
					          					<small class="text-muted">|</small>
					          					<small class="text-muted" onclick="deleteReply(${reply.fr_num})"> 삭제</small>
					          				</c:if>
					          				<c:if test="${login_mem.mem_num != reply.mem_num}">
					          					<small class="text-muted" style="cursor: pointer;" onclick="checkReport_feedReply(${reply.fr_num},'feedReply')">| 신고</small>
					          				</c:if>
					          			</div> --%>
					          			<div class="col" align="right">
					          				
					          				<small class="text-muted"><a href="javascript:checkReport('피드댓글','${reply.fr_num}')" class="link-secondary">신고내역</a> </small>
					          				<small class="text-muted">|</small>
					          				<c:if test="${reply.fr_report >0 }"><small class="text-muted"><a href="javascript:reportDel('피드댓글','${reply.fr_num}')" class="link-secondary"> 신고취소 </a></small>
					          					<small class="text-muted">|</small>
					          				</c:if>
					          				<small class="text-muted"><a href="javascript:checkDel('피드삭제','${reply.fr_num}')" class="link-secondary"> 삭제 </a></small>
					          			</div>					          			
				          			</div>
				          			<div class="row" align="left">
					       	 			<div class="col small tl-content-box-view">
					       	 				<span>${reply.fr_content}</span>
					       	 			</div>     
				          			</div>
			          			</div>
	        			</div>
	      			</div>	 
				</c:forEach>
		      	</div>
		      	<form name="f2" action="admin_feed_report_del.do" method="post">
		      		<input type="hidden" name="view"/>
		      		<input type="hidden" name="feed_num"/>
		      	</form>
		      	<form name="f3" action="admin_feed_del.do" method="post">
		      		<input type="hidden" name="view"/>
		      		<input type="hidden" name="feed_num"/>
		      	</form>
	</div>