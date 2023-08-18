<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<script>
	//피드 상세보기 취소
	function cancleFeedView(){
		if($('#personalDiv')[0]){
			$('#personalDiv')[0].style.setProperty('display', 'flex', 'important');	
		}
		$("#feedView")[0].style = "width: 0%;";
		$("#feedView").children().remove();
	}
	
</script>

	<!-- 피드 상세보기 -->
		<!-- <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 600px;"> -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col-auto" align="left" style="cursor: pointer;" onclick="cancleFeedView()">
					<svg class="bi pe-none me-2" fill="#A6A6A6" width="1.5rem" height="1.5rem"><use xlink:href="#arrow-left-circle"></use></svg>&nbsp;
				</div>
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">피드 상세보기</span></div>
			</div>
			<div class="list-group list-group-flush border-bottom scrollarea">
				<!-- 피드 본문 -->
				<div class="list-group-item py-3 lh-sm">
					<div class="d-flex w-100 align-items-center justify-content-between">
		        		<div class="container" style="padding-top: 1.5rem; padding-left: 1.5rem; padding-right: 1.5rem;">
		        			<div class="row">
			        			<div class="col" align="left" onclick="javascript: goToFeed(${feed.mem_num})">
			        				<img src="resources/img/${feed.prof_img}" width="25" height="25">&nbsp
			          				<strong>${feed.mem_nickname}</strong>
									<c:if test="${feed.prof_open == 'secret'}">
										<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
		  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
										</svg>
									</c:if>
									<small class="text-muted" style="margin-left: 0.5rem;">${feed.mem_id}</small>
			          			</div>
			          			<div class="col-auto" align="right" style="padding-top: 0.3em;">
			          				<c:if test="${login_mem.mem_num == feed.mem_num}">
			          					<small class="text-muted" style="cursor: pointer;" onclick="javascript: updateFeed(${feed.feed_num})">수정 </small>
			          					<small class="text-muted">|</small>
			          					<small class="text-muted" style="cursor: pointer;" onclick="javascript: deleteFeed(${feed.feed_num})"> 삭제</small>
			          				</c:if>
			          				<c:if test="${login_mem.mem_num != feed.mem_num}">
			          					<small class="text-muted" style="cursor: pointer;" onclick="checkReport_feed(${feed.feed_num},'feed')">| 신고</small>
			          				</c:if>
			          			</div>
		          			</div>
		          			<div class="row mb-2" align="right">
		          				<div class="col-12" align="right">
		          					<c:if test="${feed.game_num != 0}">
		          						<svg fill="#A6A6A6" width="16" height="20"><use xlink:href="#controller"></use></svg>
		          						<small class="text-muted">${feed.game_name}</small>
		          					</c:if>
		          					<c:if test="${feed.game_num == 0}">
		          					&nbsp;
		          					</c:if>
	          					</div>
		          			</div>
		          			<div class="row mt-5 mb-4 ">
		          				<div class="tl-content-box-view">
       									${feed.feed_content}
       							</div>
		          			</div>
	       					<div class="row">
	       						<!-- 이미지 1장 -->
	       						<c:if test="${not empty feed.feed_img1 and empty feed.feed_img2}">
	       							<div class="col-4" style="width: 100%; padding: 0 .7rem !important;">
										<img src="resources/img/${feed.feed_img1}" style="width: 100%;" onclick="openImgModal('${feed.feed_img1}')">
	       							</div>
	       						</c:if>
	       						<!-- 이미지 2장 -->
	       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and empty feed.feed_img3}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 100%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img1}" style="width: 100%;" onclick="openImgModal('${feed.feed_img1}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img2}" onclick="openImgModal('${feed.feed_img2}')">
											</div>
	       								</div>
	       							</div>
	       						</c:if>
	       						<!-- 이미지 3장 -->
	       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and not empty feed.feed_img3 and empty feed.feed_img4}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 100%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img1}" onclick="openImgModal('${feed.feed_img1}')">
											</div>
											<div class="col-6 no-pm">
												<div class="row" style="height: 50%">
													<img class="tl-img" src="resources/img/${feed.feed_img2}" onclick="openImgModal('${feed.feed_img2}')">
												</div>
												<div class="row" style="height: 50%">
													<img class="tl-img" src="resources/img/${feed.feed_img3}" onclick="openImgModal('${feed.feed_img3}')">
												</div>
											</div>
	       								</div>
	       							</div>
	       						</c:if>
	       						<!-- 이미지 4장 -->
	 	       					<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and not empty feed.feed_img3 and not empty feed.feed_img4}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 50%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img1}" onclick="openImgModal('${feed.feed_img1}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img2}" onclick="openImgModal('${feed.feed_img2}')">
											</div>
	       								</div>
										<div class="row" style="height: 50%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img3}" onclick="openImgModal('${feed.feed_img3}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${feed.feed_img4}" onclick="openImgModal('${feed.feed_img4}')">
											</div>
										</div>
	       							</div>
	       						</c:if>      						
       						</div>
       						<div class="row mt-4" style="padding-left: 0.5rem;">
    							<c:forEach var="theme" items="${feed.feed_theme}" varStatus="status">
     								<div class="col-auto" style="padding: 0.1rem 0.15rem; display: inline-block;">
      									<button type="button" class="btn btn-outline-secondary" onclick="javascript: themeTimeLine('${theme.theme_num}');" style="--bs-btn-padding-y: .12rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .9rem;">
											#${theme.theme_name}
										</button>
									</div>
								</c:forEach>
       						</div>
       						<div name="icons_${feed.feed_num}" class="row small mt-3">
       							<div class="col-auto" align="left" style="padding:0">
	       							<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#text-quote"></use></svg>
	       						</div>
	       						<div class="col-auto" align="left" style="padding:0">
	       							<span name="rcount_${feed.feed_num}">${feed.feed_replyCount}</span>
       							</div>&nbsp;&nbsp;
	       						<c:if test="${empty feed.isLike || feed.isLike==0}">
		       						<div class="col-auto" align="left" style="padding:0" onclick="likeFeed(${feed.feed_num})">
		       							<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#heart-empty"></use></svg>
		       						</div>		       					
		       					</c:if>
		       					<c:if test="${feed.isLike==1}">
		       						<div class="col-auto" align="left" style="padding:0" onclick="likeDeleteFeed(${feed.feed_num})">
		       							<svg class="bi pe-none me-2" fill="#FF0000" width="20" height="20"><use xlink:href="#heart-fill"></use></svg>
		       						</div>
		       					</c:if>
	       						<div class="col" align="left" style="padding:0">
	       							<span>${feed.feed_likeCount}</span>		       							
       							</div>
       						</div>
		        		</div>
	        		</div>
		      	</div>
		      	<!-- 댓글 -->
		      	<!-- 댓글 작성 -->
		      	<div class="list-group-item py-3 lh-sm">
	      			<form name="feedReplyForm" action="InsertfeedReply.do" method="post">
	      				<input type="hidden" name="feed_num" value="">
	        			<div class="d-flex w-100 align-items-center justify-content-between">
	        				<div class="container">
		          				<div class="row mb-2">
				        			<div class="col" align="left">
				        				<img src="resources/img/${profile.prof_img}" width="25" height="25">&nbsp;
				          				<strong>${login_mem.mem_nickname}</strong>
										<c:if test="${profile.prof_open == 'secret'}">
											<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
			  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
											</svg>
										</c:if>
										<small class="text-muted" style="margin-left: 0.5rem;">${login_mem.mem_id}</small>
				          			</div>
			          			</div>
			          			<div class="row">
				       	 			<div class="col small">
				       	 				<input name="fr_content" class="form-control mt-2" type="text" placeholder="내용을 입력해주세요">
				       	 			</div>
				       	 			<div class="col-auto small">
				       	 				<input type="hidden" name="noEnter"/>
				       	 				<button type="button" class="btn btn-outline-primary mt-2" onclick="feedReplyCheck(${feed.feed_num})">답글하기</button>
				       	 			</div>
			          			</div>
		          			</div>
	        			</div>
     				</form>
      			</div>      			
		      	
	     		<c:forEach var="reply" items="${feed.feed_reply}" varStatus="status">
					<!-- 댓글 하나 -->
					<div id="reply_${reply.fr_num}" class="list-group-item py-3 lh-sm">
						<div class="d-flex w-100 align-items-center justify-content-between">
							<!-- 신고됨 -->
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
							</c:if>
							<!-- 정상 출력 -->
							<c:if test="${reply.fr_report<5 && reply.visible == 'ok'}">
		        				<div class="container">
			          				<div class="row mb-2">
					        			<div class="col" align="left">
					        				<img src="resources/img/${reply.prof_img}" width="25" height="25">&nbsp;
					          				<strong>${reply.mem_nickname}</strong>
											<c:if test="${reply.prof_open == 'secret'}">
												<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
				  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
												</svg>
											</c:if>
											<small class="text-muted" style="margin-left: 0.5rem;">${reply.mem_id}</small>
					          			</div>
					          			<div class="col" align="right">
					          				<c:if test="${login_mem.mem_num == reply.mem_num}">
					          					<small class="text-muted" style="cursor: pointer;" onclick="updateReply(${reply.fr_num})">수정 </small>
					          					<small class="text-muted">|</small>
					          					<small class="text-muted" style="cursor: pointer;" onclick="deleteReply(${reply.fr_num},${reply.feed_num})"> 삭제</small>
					          				</c:if>
					          				<c:if test="${login_mem.mem_num != reply.mem_num}">
					          					<small class="text-muted" style="cursor: pointer;" onclick="checkReport_feedReply(${reply.fr_num},'feedReply')">| 신고</small>
					          				</c:if>
					          			</div>					          			
				          			</div>
				          			<div class="row">
					       	 			<div class="col small tl-content-box-view">
					       	 				<span>${reply.fr_content}</span>
					       	 			</div>     
				          			</div>
			          			</div>
		          			</c:if>
	        			</div>
	      			</div>	 
				</c:forEach>
			</div>
		
		<!-- </div> -->
		    