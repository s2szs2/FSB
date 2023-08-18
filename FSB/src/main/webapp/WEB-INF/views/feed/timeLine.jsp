<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.vertical-right-line {
		border-right-style: solid;
	 	border-right-width: 2px;
	  	border-right-color: #dee2e6;
	}
	
	.tl-content-box-outer {
		max-height: 7rem;
		padding-left: 0.8rem; 
		text-overflow: ellipsis; 
		overflow: hidden;
	}
	
	.tl-content-box-inner {
		line-height: 142%; 
		word-break: break-all;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 5;
		overflow: hidden;
	}
	
	.tl-content-box-view {
		line-height: 150%; 
		word-break: break-all;
	}
	
	.no-pm{
		padding: 0px !important;
		margin: 0px !important;
	}
	
	.tl-img {
		object-fit: cover;
		width: 100%;
		height: 100%;
	}
</style>

<script>
	//피드 상세보기
	function viewFeed(fff){
		var feed_num = fff;
		console.log(feed_num);
		$.ajax({
		    url:'timeLine_feedView.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'feed_num': feed_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	$("#feedView")[0].style = "width: 40%; min-width: 30rem; max-width: 45rem;";
		    	$("#feedView").html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});

	}
	//피드 수정
	function updateFeed(feed_num){
		event.stopPropagation();
		window.location='updateFeedForm.do?feed_num='+feed_num;
	}
	//피드 삭제
	function deleteFeed(feed_num){
		event.stopPropagation();
		window.location='deleteFeed.do?feed_num='+feed_num;
	}
	//이미지 상세보기
	function openImgModal(img_name){
		event.stopPropagation();
		const modal = document.getElementById('modal-img');
		const btn = document.getElementById('modal-open-btn');
		modal.src = 'resources/img/'+img_name;
		btn.click();
	}
	//좋아요 등록
	function likeFeed(feed_num,status){
		event.stopPropagation();
		$.ajax({
		    url:'feedLike.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'feed_num': feed_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	const ddd = $('div[name=icons_'+feed_num+']');
		    	ddd.eq(0).html(data);
		    	ddd.eq(1).html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	//좋아요 취소
	function likeDeleteFeed(feed_num){
		event.stopPropagation();
		$.ajax({
		    url:'feedLikeDelete.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'feed_num': feed_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	const ddd = $('div[name=icons_'+feed_num+']');
		    	ddd.eq(0).html(data);
		    	ddd.eq(1).html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	
	//댓글 등록
	function feedReplyCheck(feed_num){
		if(!feedReplyForm.fr_content.value){
			alert("내용을 입력해주세요.");
		}
		insertReply(feed_num);
	}
	function insertReply(feed_num){
		const content = feedReplyForm.fr_content.value;
		$.ajax({
		    url:'insertfeedReply.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'fr_content': content, 'feed_num': feed_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	$("#feedView").html(data);
		    	//등록할때 댓글 수 올리기는 좀 더 생각해보자...
		    	const sss = $('span[name=rcount_'+feed_num+']');
		    	if(sss.eq(0).html()>sss.eq(1).html()){
		    		sss.eq(1).html(sss.eq(0).html());
		    	}else{
		    		sss.eq(0).html(sss.eq(1).html());
		    	}
		    	
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	//댓글 수정 폼 열기
	function updateReply(fr_num){
		$.ajax({
		    url:'updatefeedReply_form.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'fr_num': fr_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	$("#reply_"+fr_num).html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	//댓글 수정 등록
	function feedReplyEditCheck(fr_num){
		const content = $("#edit_content").val();
		if(!content || content===''){
			alert("내용을 작성해주세요.");
		}else{
			updateReplyOK(fr_num, content);
		}
	}
	function updateReplyOK(fr_num,content){
		$.ajax({
		    url:'updatefeedReply_OK.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'fr_num': fr_num, 'fr_content': content}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	$("#reply_"+fr_num).html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	//댓글 삭제
	function deleteReply(fr_num, feed_num){
		$.ajax({
		    url:'deletefeedReply.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'fr_num': fr_num, 'feed_num': feed_num}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	const rep = $("#reply_"+fr_num);
		    	rep.hide();

		    	const sss = $('span[name=rcount_'+feed_num+']');
		    	sss.eq(0).html(data);
		    	sss.eq(1).html(data);
		    	sss.eq(2).html(data);
		    },
		    error: function(err) {
		    	alert("ajax 처리 중 에러 발생");
		    }
		});
	}
	//태그 타임라인
	function themeTimeLine(theme_num){
		window.location='themeTimeline.do?theme_num='+theme_num;
	}
</script>
	
<%@include file="../user/user_top.jsp" %>

<body>
	<!-- 이미지 팝업창 -->
	<div class="modal" tabindex="-1" id="img-modal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body" style="position: relative;">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="position: absolute; right: 1.5rem; top: 1.5rem;"></button>
					<img class="tl-img" id="modal-img" src="resources/img/${feed.feed_img1}">
				</div>
			</div>
		</div>
	</div>
	<!-- 팝업 여는 가상버튼 -->
	<button type="button" id="modal-open-btn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#img-modal" style="display: none">
		이미지 상세 보기
	</button>

	<!-- 전체 -->
  	<main class="d-flex flex-nowrap" style="width: 100%;">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>

		<!-- 타임라인 -->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 30rem; max-width: 45rem;">
			
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">타임라인</span></div>
				<div class="col" align="right">
					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='feedForm.do'">새 글 쓰기</button>
				</div>
			</div>
			
			<div class="list-group list-group-flush border-bottom scrollarea">
				<c:if test="${empty listFeed}">
					<div class="d-flex w-100 align-items-center justify-content-between" style="height: 50rem;">
						<small class="text-muted" style="width: 100%; text-align: center;">아직 피드가 없습니다.</small>
					</div>
				</c:if>
				<c:if test="${not empty listFeed}">
					<c:forEach var="feed" items="${listFeed}" varStatus="status">
					<!-- 피드 한 개 -->
						<a class="list-group-item list-group-item-action py-3 lh-sm" onclick="viewFeed(${feed.feed_num})">
			        		<div class="d-flex w-100 align-items-center justify-content-between">
				        		<div class="container">
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
			       					<div class="row">
			       						<!-- 이미지 0장 -->
			       						<c:if test="${empty feed.feed_img1}">
			       							<div class="small tl-content-box-outer mb-3">
			       								<div class="tl-content-box-inner">
			       									${feed.feed_content}
			       								</div>
			       							</div>
			       						</c:if>
			       						<!-- 이미지 1장 -->
			       						<c:if test="${not empty feed.feed_img1 and empty feed.feed_img2}">
			       							<div class="col-8 small tl-content-box-outer" style="padding-right: 1.6rem;">
			       								${feed.feed_content}
			       							</div>
			       							<div class="col-4 container no-pm" style="height: 7rem;">
												<img class="tl-img" src="resources/img/${feed.feed_img1}" onclick="openImgModal('${feed.feed_img1}')">
			       							</div>
			       						</c:if>
			       						<!-- 이미지 2장 -->
			       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and empty feed.feed_img3}">
			       							<div class="col-8 small tl-content-box-outer" style="padding-right: 1.6rem;">
			       								<div class="tl-content-box-inner">
			       									${feed.feed_content}
			       								</div>
			       							</div>
			       							<div class="col-4 container" style="height: 7rem;">
			       								<div class="row" style="height: 100%">
													<div class="col-6 no-pm">
														<img class="tl-img" src="resources/img/${feed.feed_img1}" onclick="openImgModal('${feed.feed_img1}')">
													</div>
													<div class="col-6 no-pm">
														<img class="tl-img" src="resources/img/${feed.feed_img2}" onclick="openImgModal('${feed.feed_img2}')">
													</div>
			       								</div>
			       							</div>
			       						</c:if>
			       						<!-- 이미지 3장 -->
			       						<c:if test="${not empty feed.feed_img1 and not empty feed.feed_img2 and not empty feed.feed_img3 and empty feed.feed_img4}">
			       							<div class="col-8 small tl-content-box-outer" style="padding-right: 1.6rem;">
			       								<div class="tl-content-box-inner">
			       									${feed.feed_content}
			       								</div>
			       							</div>
			       							<div class="col-4 container" style="height: 7rem;">
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
			       							<div class="col-8 small tl-content-box-outer" style="padding-right: 1.6rem;">
			       								<div class="tl-content-box-inner mb-3">
			       									${feed.feed_content}
			       								</div>
			       							</div>
			       							<div class="col-4 container" style="height: 7rem;">
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
		       						<div class="row mt-2 mb-2" style="padding-left: 0.5rem;">
		    							<c:forEach var="theme" items="${feed.feed_theme}" varStatus="status">
		     								<div class="col-auto" style="padding: 0.1rem 0.1rem; display: inline-block;">
		      									<button type="button" class="btn btn-outline-secondary" onclick="javascript: themeTimeLine('${theme.theme_num}');" style="--bs-btn-padding-y: .05rem; --bs-btn-padding-x: .3rem; --bs-btn-font-size: .75rem;">
													#${theme.theme_name}
												</button>
											</div>
										</c:forEach>
		       						</div>
		       						<div name="icons_${feed.feed_num}" class="row small">
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
		      			</a>
		      		</c:forEach>
		      	</c:if>	
			</div>
		
		</div>
		
		<div id="feedView" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 0%;"></div>
		
	</main>

</body>
<%@include file="../user/user_bottom.jsp" %>