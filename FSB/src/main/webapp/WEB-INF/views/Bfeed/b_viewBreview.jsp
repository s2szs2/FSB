<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- b_couponView.jsp -->
<link href="resources/css/bootstrap-grid.min.css" rel="stylesheet">
<link href="resources/css/bootstrap-grid.rtl.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery-3.7.0.js"></script>
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

.no-pm {
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
//이미지 상세보기
function openImgModal(img_name){
	event.stopPropagation();
	const modal = document.getElementById('modal-img');
	const btn = document.getElementById('modal-open-btn');
	modal.src = 'resources/img/'+img_name;
	btn.click();
}

</script>

<script type="text/javascript">
function  checkDel(){
	var isDel = window.confirm("정말로 삭제하겠습니까?")
	if (isDel){
	var form = $('#f5')[0];
		console.log(form)
	var formData = new FormData(form);
	$.ajax({
		type : 'post',
		url : 'b_deleteReview.do',
		data : formData,
		dataType:'json',
	    processData:false,
	    contentType:false,
	    cache:false,
	    
		success: function(data) {
	    	alert("성공");
	    },
	    error: function(err) {
	    	//alert("리뷰 이미지, 글 삭제 성공");
	    alert("게시글을 삭제합니다");
	    	console.log(err)
	    	location.reload();
	    	/* alert("ajax 처리 중 에러 발생");
	        //서버로부터 응답이 정상적으로 처리되지 못했을 때 실행 */
	    }
	});
	}
}
</script>
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
	<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white"
		style="width: 700px;">
		<div
			class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
			<div class="col" align="left">
				<span class="link-dark text-decoration-none fs-5 fw-semibold">${getBR.bpr_title }&nbsp;&nbsp;</span>
			</div>
		</div>

		<div class="list-group list-group-flush border-bottom scrollarea" >
			<!-- 피드 본문 -->
			<div class="list-group-item py-3 lh-sm">
				<div class="d-flex w-100 align-items-center justify-content-between">
					<div class="container" 
						style="padding-top: 1.5rem; padding-left: 1.5rem; padding-right: 1.5rem;">
						<div class="row">
							<div class="col" align="left">
								<img src="resources/img/${getMem.prof_img}" width="25"
									height="25" id="mem_nickname">&nbsp; <strong>${getBR.mem_nickname}</strong>
							</div>
						</div>
						<!-- 작성 날짜 -->
						<div class= "row">
						<div class="col-6 start" align="left" style="padding-top: 0.5em;">
							<c:if test="${getBR.bpr_starrating eq 1 }">
								<img src="resources/img/star2.png" width="10" height="10">
								<c:forEach begin="1" end="4">
									<img src="resources/img/star1.png" width="10" height="10">
								</c:forEach>
								</c:if>
								<c:if test="${getBR.bpr_starrating eq 2 }">
									<c:forEach begin="1" end="2">
										<img src="resources/img/star2.png" width="10" height="10">
									</c:forEach>
									<c:forEach begin="1" end="3">
										<img src="resources/img/star1.png" width="10" height="10">
									</c:forEach>
								</c:if>
								<c:if test="${getBR.bpr_starrating eq 3 }">
									<c:forEach begin="1" end="3">
										<img src="resources/img/star2.png" width="10" height="10">
									</c:forEach>
									<c:forEach begin="1" end="2">
										<img src="resources/img/star1.png" width="10" height="10">
									</c:forEach>
								</c:if>
								<c:if test="${getBR.bpr_starrating eq 4 }">
									<c:forEach begin="1" end="4">
										<img src="resources/img/star2.png" width="10" height="10">
									</c:forEach>
									<c:forEach begin="1" end="1">
										<img src="resources/img/star1.png" width="10" height="10">
									</c:forEach>
								</c:if>
								<c:if test="${getBR.bpr_starrating eq 5 }">
									<c:forEach begin="1" end="5">
										<img src="resources/img/star2.png" width="10" height="10">
									</c:forEach>
								</c:if>
						</div>
						<div class="col-6 end" align="right" style="padding-top: 0.5em;">
							<small class="text-muted" id="bpr_regdate">${getBR.bpr_regdate }</small>
							<c:if test="${login_mem.mem_num == getBR.mem_num}">
								<small class="text-muted" style="cursor: pointer;"
									onclick="location.href='b_updateReview.do?bp_num=${bp_num }&bpr_num=${getBR.bpr_num}'">수정
								</small>
								<small class="text-muted">|</small>
								<small class="text-muted" style="cursor: pointer;"
									onclick="javascript:checkDel()">삭제</small>
									<c:if test="${getBR.bpr_hide eq 1 }" >
								<br><small class="text-muted"><font color="red">사장님이 해당 리뷰 게시를 중단했습니다.</font></small>
								</c:if>
								</c:if>
								<c:if test="${login_mem.mem_num == bpmem}">
								<c:if test="${getBR.bpr_hide eq 0 }">
								<small class="text-muted" style="cursor: pointer;"
									onclick="javascript:blockReview()"><font color="red">[리뷰 게시 중단하기]</font></small>
								</c:if>
								<c:if test="${getBR.bpr_hide eq 1 }">
								<small class="text-muted" style="cursor: pointer;"
									onclick="javascript:unblockReview()"><font color="red">[리뷰 게시 중단 해제]</font></small>
								</c:if>
								</c:if>
						</div>
						</div>
						<div class="row mt-5 mb-4 ">
							<div class="tl-content-box-view" id="bpr_content">${getBR.bpr_content}</div>
						</div>
						<div class="row">
	       						<!-- 이미지 1장 -->
	       						<c:if test="${not empty getBR.bpr_img1 and empty getBR.bpr_img2}">
	       							<div class="col-4" align="center" style="width: 100%; padding: 0 .7rem !important;">
										<img src="resources/img/${getBR.bpr_img1}" style="width: 60%;" onclick="openImgModal('${getBR.bpr_img1}')">
	       							</div>
	       						</c:if>
	       						<!-- 이미지 2장 -->
	       						<c:if test="${not empty getBR.bpr_img1 and not empty getBR.bpr_img2 and empty getBR.bpr_img3}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 100%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img1}" style="width: 100%;" onclick="openImgModal('${getBR.bpr_img1}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img2}" onclick="openImgModal('${getBR.bpr_img2}')">
											</div>
	       								</div>
	       							</div>
	       						</c:if>
	       						<!-- 이미지 3장 -->
	       						<c:if test="${not empty getBR.bpr_img1 and not empty getBR.bpr_img2 and not empty getBR.bpr_img3 and empty getBR.bpr_img4}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 100%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img1}" onclick="openImgModal('${getBR.bpr_img1}')">
											</div>
											<div class="col-6 no-pm">
												<div class="row" style="height: 50%">
													<img class="tl-img" src="resources/img/${getBR.bpr_img2}" onclick="openImgModal('${getBR.bpr_img2}')">
												</div>
												<div class="row" style="height: 50%">
													<img class="tl-img" src="resources/img/${getBR.bpr_img3}" onclick="openImgModal('${getBR.bpr_img3}')">
												</div>
											</div>
	       								</div>
	       							</div>
	       						</c:if>
	       						<!-- 이미지 4장 -->
	 	       					<c:if test="${not empty getBR.bpr_img1 and not empty getBR.bpr_img2 and not empty getBR.bpr_img3 and not empty getBR.bpr_img4}">
	       							<div class="col-4 container" style="width: 100%; height: 20rem; padding: 0 1.5rem;">
	       								<div class="row" style="height: 50%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img1}" onclick="openImgModal('${getBR.bpr_img1}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img2}" onclick="openImgModal('${getBR.bpr_img2}')">
											</div>
	       								</div>
										<div class="row" style="height: 50%">
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img3}" onclick="openImgModal('${getBR.bpr_img3}')">
											</div>
											<div class="col-6 no-pm">
												<img class="tl-img" src="resources/img/${getBR.bpr_img4}" onclick="openImgModal('${getBR.bpr_img4}')">
											</div>
										</div>
	       							</div>
	       						</c:if>      						
       						</div>
		        		</div>
	        		</div>
		      	</div>
									</div>
								</div>
<form name="f5" id="f5">
	<input type="hidden" name="bpr_num" value="${bpr_num}"> 
	<input type="hidden" name="bp_num" value="${bp_num}"> 
	<input type="hidden" name="bpr_img1" value="${getBR.bpr_img1}"> 
	<input type="hidden" name="bpr_img2" value="${getBR.bpr_img2}"> 
	<input type="hidden" name="bpr_img3" value="${getBR.bpr_img3}"> 
	<input type="hidden" name="bpr_img4" value="${getBR.bpr_img4}">
</form>
	
<form name="f3" id="f3">
	<input type="hidden" name="bp_num" value="${bp_num}">
	<input type="hidden" name="bpr_num" value="${bpr_num }"> 
</form>

	<%-- <!-- 댓글 -->
	     		<c:forEach var="i" begin="0" end="20" step="1">
					<!-- 댓글 하나 -->
					<div class="list-group-item py-3 lh-sm">
	        			<div class="d-flex w-100 align-items-center justify-content-between">
	          				<strong class="mb-1">${id}</strong>
	          				<c:if test="${login_mem.mem_num == reply.mem_num}">
	          					<small class="text-muted" onclick="#">수정 </small>
	          					<small class="text-muted">|</small>
	          					<small class="text-muted" onclick="#"> 삭제</small>
	          				</c:if>
	          				<c:if test="${login_mem.mem_num != reply.mem_num}">
	          					<small class="text-muted">| 신고</small>
	          				</c:if>
	        			</div>
	       	 			<div class="col-10 mb-1 small">어쩌구 저쩌구 이러쿵 저러쿵</div>
	      			</div>
				</c:forEach> --%>
				

