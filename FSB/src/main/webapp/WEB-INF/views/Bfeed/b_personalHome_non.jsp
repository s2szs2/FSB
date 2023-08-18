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
function checkMember(){
	alert("회원 전용입니다. 로그인이나 회원가입을 먼저 해주세요")
	return
	}
</script>

<script>
	//이미지 상세보기
	function openImgModal(img_name){
		event.stopPropagation();
		const modal = document.getElementById('modal-img');
		const btn = document.getElementById('modal-open-btn');
		modal.src = 'resources/img/'+img_name;
		btn.click();
	}

</script>
	
<%@include file="../user/user_top.jsp" %>

<body>
	<!-- 전체 -->
  	<main class="d-flex flex-nowrap">

	<!-- sns 사이드바 -->
	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 15%; min-width: 10rem; max-width: 18rem;">
   		<a href="login.do" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
    		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#people-circle"></use></svg>
    		<span class="fs-5 fw-semibold">로그인을 해주세요.</span>
 		</a>
	</div>
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
		<!-- 개인 페이지 -->
		<div id="personalDiv" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 35rem; max-width: 45rem; display: flex;">
			
			<!-- 프로필 베젤 -->`
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">${target_profile.mem_nickname}의 타임라인</span></div>
			</div>
			
			<!-- 프로필 -->
			<div class="container mt-1 overflow-auto">
				<div class="row">
				
					<!-- 프로필 좌측-->
					<div class="col-5 container">
						<!-- 프사 -->
		  				<div class="row mb-3">
		   					<div class="col" align="center"><img src="resources/img/${target_profile.prof_img}" class="img-thumbnail"></div>
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
			   					<strong>${b_profile.bp_store_name}</strong>
								<c:if test="${target_profile.prof_open == 'secret'}">
									<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
	  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
									</svg>
								</c:if>
			   					<br><small class="text-muted">${target_profile.mem_id}</small>
			   				</div>
			   				<!-- 버튼과 더보기 -->
			   				
						<!-- 상태 메시지 -->
			   			<div class="row mb-3">
			   				<div class="col" align="left">
			   				<span class="small">${target_profile.prof_msg}</span></div>
			   			</div>
			   			<!-- 비즈니스 인포 -->	
			   				<div class="row mb-3">
			   					<strong>매장안내</strong>
			   					<br>
			   					<small>${b_profile.bp_info }</small>
			   					<br>
			   					<small>📞${b_profile.bp_tel}</small>
			   					<br>
			   					<small>${b_profile.bp_location}&nbsp;${b_profile.bp_d_location}</small>
			   					<br>
			   					<small class="text-body-secondary">
        						<c:if test="${b_profile.bp_starrating ne 0 }">
        							<strong>매장 별점 : </strong>
        						<c:if test="${b_profile.bp_starrating eq 1 }">
									<img src="resources/img/star.png" width="20" height="20">
								</c:if>
								<c:if test="${b_profile.bp_starrating eq 2 }">
									<c:forEach begin="1" end="2">
										<img src="resources/img/star.png" width="20" height="20">
									</c:forEach>
								</c:if>
								<c:if test="${b_profile.bp_starrating eq 3 }">
									<c:forEach begin="1" end="3">
										<img src="resources/img/star.png" width="20" height="20">
									</c:forEach>
								</c:if>
								<c:if test="${b_profile.bp_starrating eq 4 }">
									<c:forEach begin="1" end="4">
										<img src="resources/img/star.png" width="20" height="20">
								</c:forEach>
								</c:if>
								<c:if test="${b_profile.bp_starrating eq 5 }">
									<c:forEach begin="1" end="5">
										<img src="resources/img/star.png" width="20" height="20">
									</c:forEach>
								</c:if>
								</c:if>
								<br>
								</small>&nbsp;&nbsp;
					<!--리뷰 버튼-->
						<div>
							<button type="button" class="btn btn-outline-warning w-75 btn-sm" onclick="javascript:location.href='b_review.do?bp_num=${b_profile.bp_num}'">리	뷰</button>
				   		</div>
				   		</div>
					</div>
				</div>
			<div>
			<div class="border-top my-2 p-3">
			<a href="map_click_search.do?bp_num=${b_profile.bp_num}&searchString=${b_profile.bp_store_name}">
			 <div id="map" style="width:600px;height:150px;"></div>
		 		<div id="clickLatlng"></div> 
			</a>
			</div>
			<div class="border-top my-2"></div>
<!-- 쿠폰 리스트 접기 -->
	<div class="col mb-3 mx-auto p-2" align="left">
               <button type="button" class="btn btn-sm btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#coupon-collapse" aria-expanded="false">
                        <svg class="bi pe-none me-2" fill="#A6A6A6" width="24" height="24">
                        <use xlink:href="#coupon-select"></use></svg>
                       		매장 쿠폰 🔽</button>
                </div>
                    <div class="collapse mb-3 mx-auto p-2" id="coupon-collapse">
                    <table align="center" width="50%">
							<c:if test="${empty couponlist }">
							<tr>
							<td>등록된 쿠폰이 없습니다.<td>
							</tr>
							</c:if>
							<c:if test="${not empty couponlist}">
							<c:forEach var="cdto" items="${couponlist }">
								<tr>
								<td>
							<div class="card-group">
  									<div class="card text-center mb-3" style="max-width: 40rem; max-height: 15rem;">
  									<div class="card-body">
    								<h5 class="card-title">${cdto.bc_title}</h5>
    								<p class="card-text">${cdto.bc_content }</p>
    								<p class="card-text"><font color="red">${cdto.bc_qty}매</font></p>
   						
    			 <!-- 만약 쿠폰 수량이 0보다 작거나 같다면 쿠폰 소진 -->
    						<div class="card-footer">
      						<small class="text-body-secondary"><c:if test="${cdto.bc_qty<=0}">
    						<div align="center"><strong>쿠폰이 모두 소진 되었습니다.</strong></div>
    					 </c:if>
    					  <!-- 비회원일 때 띄우는 쿠폰받기 버튼(로그인안내) -->
    						<c:if test="${login_mem eq null }">
    						<a href="javascript:checkMember()" class="btn btn-primary">쿠폰받기</a>
    						</c:if> 
    					<!-- 쿠폰받기 끝나면 주석 풀기 -->
    						<c:if test="${login_mem ne null and b_profile.mem_num ne login_mem.mem_num}">
    					<!-- 쿠폰 수량이 0 이상일때만 버튼 활성화 -->
    						<c:if test="${cdto.bc_qty > 0}">
    					<!-- 만약 내 쿠폰리스트와 매장 쿠폰리스트의 번호가 같다면 발급 완료 -->
  							<c:forEach var="mylist" items="${userCoupon }">
  							<c:if test="${cdto.bc_num eq mylist.bc_num }">
             		          <button class="btn btn-primary" disabled>발급 완료</button>
               		        </c:if>
               		       </c:forEach>
                		 <!-- 만약 내가 없는 쿠폰과 매장 쿠폰 번호가 일치하면 다운로드 -->
                		        <c:forEach var="exlist" items="${exlist }">
                			     <c:if test="${cdto.bc_num eq exlist.bc_num }">
                 			      <a href="get_bcoupon.do?bp_num=${bp_num}&bc_num=${cdto.bc_num}" class="btn btn-primary">쿠폰받기</a>
                			      </c:if>
               				       </c:forEach>
    						 </c:if>
    				 </c:if>
    						<c:if test="${cdto.mem_num eq login_mem.mem_num}">
    						<a href="javascript:deleteC('${cdto.bc_num }')" class="btn btn-primary btn-sm">쿠폰삭제</a>
    						</c:if></small>
  							</div>
  						</div>
  					</div> 
  					</div>
   				</td>
  			</tr>
  		</c:forEach> 
  	</c:if>
</table>
 </div>
			<!-- services 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=265d925f04bd6bf7c74e0ca951641be9&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = {
        center: new kakao.maps.LatLng(37.655798132203394, 127.06228085698994), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
   		 };  

	// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${b_profile.bp_location}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     	if(status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
      	 var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:5px 0;"><strong>${b_profile.bp_store_name}</strong></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});   
</script>
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
					          					<small class="text-muted">| 신고</small>
					          				</c:if>
					          			</div>
				          			</div>
				          			<div class="row mb-2" align="right">
			          					<div class="col-12" align="right">
			          						<svg fill="#A6A6A6" width="16" height="20"><use xlink:href="#location"></use></svg>
			          						<small class="text-muted">아직 위치정보못함</small>
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
		      									<button type="button" class="btn btn-outline-secondary" onclick="javascript: alert('${theme.theme_num}');" style="--bs-btn-padding-y: .05rem; --bs-btn-padding-x: .3rem; --bs-btn-font-size: .75rem;">
													#${theme.theme_name}
												</button>
											</div>
										</c:forEach>
		       						</div>
		       						<div class="row small">
		       							<div class="col" align="left" style="padding:0">
			       							<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#text-quote"></use></svg>
			       							${feed.feed_replyCount}
			       							<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#heart-empty"></use></svg>
			       							${feed.feed_likeCount}			       							
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