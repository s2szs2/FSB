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
		$('#personalDiv')[0].style.setProperty('display', 'none', 'important');
	}
	
	//팔로우 버튼 클릭
	function follow(mem_num,mode,prof_open,where){
		event.stopPropagation();
		$.ajax({
		    url:'follow.do', //request 보낼 서버의 경로
		    type:'post', // 메소드(get, post, put 등)
		    data:{'mem_num': ${login_mem.mem_num}, 'friend_num': mem_num, 'mode': mode, 'where': where}, //보낼 데이터 (json 형식)
		    success: function(data) {
		    	$('#followZone').children().remove();
		    	$('#followZone').html(data);
		    	
		    	if(mode==='block' || mode==='unblock'){//차단이나 차단해제면 아예 새로 고침을 하자
		    		window.location.reload()
		    	}
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
			alert(content);
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
	<!-- 프로필 수정용 폼 -->
	<form name="profUpdate" action="profileUpdateForm.do" style="display: none;">
		<input type="hidden" name="mem_num" value="${target_profile.mem_num}">
		<input type="hidden" name="mem_nickname" value="${target_profile.mem_nickname}">
		<input type="hidden" name="prof_nickname_separated" value="${target_profile.prof_nickname_separated}">
		<input type="hidden" name="prof_img" value="${target_profile.prof_img}">
		<input type="hidden" name="prof_msg" value="${target_profile.prof_msg}">
		<input type="hidden" name="prof_open" value="${target_profile.prof_open}">
	</form>
	
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
		
		<!-- 개인 페이지 -->
		<div id="personalDiv" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 35rem; max-width: 45rem; display: flex;">
			
			<!-- 프로필 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">${target_profile.mem_nickname}의 타임라인</span></div>
			</div>
			
			<!-- 프로필 -->
			<div class="container mt-5">
				<div class="row">
				
					<!-- 프로필 좌측-->
					<div class="col-5 container">
						<!-- 프사 -->
		  				<div class="row mb-3" align="center">
		   					<div class="col" align="center">
		   						<div style="width:14rem; height:14rem; padding:0.5rem;">
			   						<img src="resources/img/${target_profile.prof_img}" class="tl-img">
		   						</div>
		   					</div>
		   				</div>
			   			<!-- 팔로잉 팔로워 -->
			   			<div class="row">
			   				<div class="col" align="right" style="padding-right:1.5rem;">
			   					<span class="small fw-semibold">팔로잉</span>&nbsp;&nbsp;
			   					<span class="small">${target_profile.prof_following}</span>
			   				</div>
			   				<div class="col" align="left" style="padding-left:1.5rem;">
			   					<span class="small fw-semibold">팔로우</span>&nbsp;&nbsp;
			   					<span class="small">${target_profile.prof_follower}</span>
			   				</div>
			   			</div>
					</div>
					
					<!-- 프로필 우측 -->
					<div class="col-7 container">
			   			<div class="row mb-3">
			   				<!-- 닉네임 -->
			   				<div class="col mt-2" align="left">
			   					<strong>${target_profile.mem_nickname}</strong>
								<c:if test="${target_profile.prof_open == 'secret'}">
									<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
	  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
									</svg>
								</c:if>
			   					<br><small class="text-muted">${target_profile.mem_id}</small>
			   				</div>
			   				<!-- 버튼과 더보기 -->
			   				<div class="col mt-2" id="followZone" align="right">
			   					<!-- 본인일 때 -->
			   					<c:if test="${login_mem.mem_num == target_profile.mem_num}">
			   						<button type="button" class="btn btn-outline-primary" onclick="javascript: profUpdate.submit()">프로필 수정</button>
			   					</c:if>
			   					<!-- 남일 때 -->
			   					<c:if test="${login_mem.mem_num != target_profile.mem_num}">
			   						<c:if test="${target_profile.m_friend_accept == 'none'}">
										<!-- 상대가 전체공개일 때 -->
										<c:if test="${target_profile.prof_open == 'open'}">
											<button type="button" class="btn btn-outline-primary" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'follow','${target_profile.prof_open}','personalHome')">팔로우</button>
										</c:if>
										<!-- 상대가 친구공개일 때 -->
										<c:if test="${target_profile.prof_open == 'secret'}">
											<button type="button" class="btn btn-outline-secondary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'request','${target_profile.prof_open}','personalHome')">팔로우 요청</button>
										</c:if>
									</c:if>
									<!-- 팔로우 중일 때 -->
									<c:if test="${target_profile.m_friend_accept == 'follow'}">
										<button type="button" class="btn btn-primary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unfollow','${target_profile.prof_open}','personalHome')">언팔로우</button>
									</c:if>
									<!-- 요청 중일 때 -->
									<c:if test="${target_profile.m_friend_accept == 'request'}">
										<button type="button" class="btn btn-secondary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unrequest','${target_profile.prof_open}','personalHome')">요청 취소</button>
									</c:if>
									<!-- (내가) 차단 중일 때 -->
									<c:if test="${target_profile.m_friend_accept == 'block'}">
										<button type="button" class="btn btn-danger btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unblock','${target_profile.prof_open}','personalHome')">차단 해제</button>
									</c:if>
									<!-- 차단 당했을 때 -->
									<c:if test="${target_profile.f_friend_accept == 'block'}">
										<button type="button" class="btn btn-danger btn-sm" style="width:70%;" disabled>차단됨</button>
									</c:if>
									
					   				<svg class="dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-expanded="false" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
		  								<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
									</svg>
									<ul class="dropdown-menu">
										<li><small class="dropdown-item text-muted" onclass onclick="checkReport_member(${target_profile.mem_num})">신고</small></li>
										<c:if test="${target_profile.m_friend_accept != 'block'}">
											<li><small class="dropdown-item text-muted" onclass onclick="javascript: follow(${target_profile.mem_num},'block','${target_profile.prof_open}','personalHome')">차단</small></li>
										</c:if>
									</ul>
			   					</c:if>
			   				</div>
			   			</div>
						<!-- 상태 메시지 -->
			   			<div class="row mb-3">
			   				<div class="col" align="left">
			   				<span class="small">${target_profile.prof_msg}</span></div>
			   			</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 개인타임라인 -->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 30rem; max-width: 45rem;">
			<!-- 개인 타임라인 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">&nbsp;</span></div>
				<div class="col" align="right">
					<c:if test="${login_mem.mem_num == target_profile.mem_num}">
						<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='feedForm.do'">새 글 쓰기</button>
					</c:if>
				</div>
			</div>
			
			<!-- 개인 타임라인 스크롤에리어 -->
			<div class="list-group list-group-flush border-bottom scrollarea">
				<c:if test="${empty target_listFeed}">
					<div class="d-flex w-100 align-items-center justify-content-between" style="height: 30rem;">
						<small class="text-muted" style="width: 100%; text-align: center;">아직 피드가 없습니다.</small>
					</div>
				</c:if>
				<c:if test="${target_profile.m_friend_accept == 'block'}">
					<div class="d-flex w-100 align-items-center justify-content-between" style="height: 30rem;">
						<small class="text-muted" style="width: 100%; text-align: center;">내가 차단한 계정입니다.</small>
					</div>
				</c:if>
				<c:if test="${target_profile.f_friend_accept == 'block'}">
					<div class="d-flex w-100 align-items-center justify-content-between" style="height: 30rem;">
						<small class="text-muted" style="width: 100%; text-align: center;">나를 차단한 계정의 피드를 볼 수 없습니다.</small>
					</div>
				</c:if>
				<c:if test="${not empty target_listFeed}">
					<c:forEach var="feed" items="${target_listFeed}" varStatus="status">
						<!-- 피드 한 개 -->
						<a class="list-group-item list-group-item-action py-3 lh-sm" onclick="viewFeed(${feed.feed_num})">
			        		<div class="d-flex w-100 align-items-center justify-content-between">
				        		<div class="container">
				        			<div class="row">
					        			<div class="col" align="left">
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