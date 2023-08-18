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
	
	.input-file-button{
	margin-top: 0.7rem;
	padding: 0.3rem 0.5rem;
	font-size: 0.8rem;
	background-color: #6c757d;
	border-radius: 0.2rem;
	color: white;
	cursor: pointer;
	}
</style>

<script>
	window.addEventListener('DOMContentLoaded', function(){
		const fileInput = document.getElementById('profimgPicker');
		//이미지 선택하면 실행
		fileInput.onchange = function(){
			//추가한 이미지 가져오기
			let files = fileInput.files;
			let file = files[0];
			if(!file){//파일이 없다면 돌아가기
				//미리보기 원본으로
				imageZone.src = "resources/img/${target_profile.prof_img}";
				$("#imageZone").hide();
				$("#imageZone").show();
				return;
			}
			//이미지 확장자&크기 제한
			let fileName = file.name;
			let fileSize = file.size;
			let isOk = checkExtension(fileName,fileSize);
			if(!isOk){
				//미리보기 원본으로
				imageZone.src = "resources/img/${target_profile.prof_img}";
				$("#imageZone").hide();
				$("#imageZone").show();
				return;
			}
			//미리보기 현재 파일로
			updateForm.isCancle.value=0;
			updateForm.isDef.value=0;
			imageZone.src = URL.createObjectURL(file);
			$("#imageZone").hide();
			$("#imageZone").show();
		}
	});
	
	//이미지 유효성 검사
	function checkExtension(fileName,fileSize){
		let ext = fileName.toLowerCase().substring(fileName.lastIndexOf(".")+1, fileName.length);
        let maxSize = 20971520;  //20MB

        if(ext != 'jpg' && ext != 'jpeg' && ext != 'png'){
            alert("jpg, jpeg, png 파일만 업로드할 수 있습니다.");
            return false;
        }
        if(fileSize >= maxSize){
            alert('최대 20mb까지 업로드 가능합니다.');
            return false;
        }
        return true;
    }
	
	//등록
	function submitCheck(){
		if(!updateForm.mem_nickname.value){
			alert("닉네임은 비워둘 수 없습니다.");
		}
		updateForm.submit();
	}
	
	//이미지 변경 취소
	function toOldImg(){
		updateForm.isCancle.value=1;
		updateForm.isDef.value=0;
		//미리보기 원본으로
		imageZone.src = "resources/img/${target_profile.prof_img}";
		$("#imageZone").hide();
		$("#imageZone").show();
	}
	
	//기본 프로필 이미지로 되돌리기
	function toDefaultImg(){
		updateForm.isDef.value=1;
		updateForm.isCancle.value=0;
		//미리보기 원본으로
		imageZone.src = "resources/img/default_profile.png";
		$("#imageZone").hide();
		$("#imageZone").show();
	}
	
</script>
	
<%@include file="../user/user_top.jsp" %>

<body>	
	<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
		
		<!-- 개인 페이지 -->
		<div id="personalDiv" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 35rem; max-width: 45rem; display: flex;">
			
			<!-- 프로필 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">${target_profile.mem_nickname}의 타임라인</span></div>
			</div>
			
			<form name="updateForm" action="profileUpdateOK.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="mem_num" value="${target_profile.mem_num}">
				<input type="hidden" name="old_mem_nickname" value="${target_profile.mem_nickname}">
				<input type="hidden" name="old_prof_nickname_separated" value="${target_profile.prof_nickname_separated}">
				<input type="hidden" name="old_prof_img" value="${target_profile.prof_img}">
				<input type="hidden" name="isDef" value="0">
				<input type="hidden" name="isCancle" value="0">
				<input type="hidden" name="business" value="${business}"/>
				
				<!-- 프로필 -->
				<div class="container mt-5">
					<div class="row">
					
						<!-- 프로필 좌측-->
						<div class="col-5 container">
							<!-- 프사 -->
			  				<div class="row">
								<input type="file" id="profimgPicker" name="prof_img" class="mt-2 small" style="display: none;" accept=".png, .jpg, .jpeg" enctype="multipart/form-data"/>
			   					<div class="col" align="center" style="position:relative; width:14rem; height:14rem; overflow:hidden; text-align:middle;">
			   						<div style="width:14rem; height:14rem; padding:0.5rem;">
				   						<label class="input-file-button" for="profimgPicker" style="position: absolute; top: 42%; left: 38%; margin:0; opacity: 0.6;">파일 선택</label>
				   						<img id="imageZone" src="resources/img/${target_profile.prof_img}" class="tl-img">
			   						</div>
			   					</div>
			   				</div>
			   				<div class="row mb-3" align="center">
			   					<div class="col">
				   					<button type="button" class="btn btn-outline-secondary mt-2" onclick="toOldImg()">취소</button>&nbsp;
				   					<button type="button" class="btn btn-outline-secondary mt-2" onclick="toDefaultImg()">기본 이미지</button>
			   					</div>
			   				</div>
						</div>
						
						<!-- 프로필 우측 -->
						<div class="col-7 container">
			   				<!-- 닉네임 -->
				   			<div class="row mb-3">
				   				<div class="col mt-2" align="left">
				   					<div class="row">
				   						<div class="col">
				   							<strong style="padding-left: 0.5rem;">닉네임</strong>
				   						</div>
				   					</div>
				   					<div class="row">
				   						<div class="col">
				   							<input name="mem_nickname" class="form-control mt-2" type="text" placeholder="닉네임을 입력해주세요" value="${target_profile.mem_nickname}">
				   						</div>
				   						<div class="col-auto">
				   							<button type="button" class="btn btn-outline-primary mt-2" onclick="submitCheck()">수정 완료</button>			   						
				   						</div>
				   					</div>
				   				</div>
				   			</div>
							<!-- 상태 메시지 -->
				   			<div class="row mb-3">
				   				<div class="col" align="left">
				   					<strong style="padding-left: 0.5rem;">상태 메시지</strong>
				   					<input name="prof_msg" class="form-control mt-2" type="text" placeholder="상태메시지를 입력해주세요" value="${target_profile.prof_msg}">
				   				</div>
				   			</div>
				   			<!-- 계정 잠금 -->
				   			<div class="row mb-3">
				   				<div class="container col mt-2" align="left">
				   					<div class="row">
				   						<div class="col">
				   							<strong style="padding-left: 0.5rem;">계정 잠금 여부</strong>
				   						</div>
				   					</div>
				   					<div class="row">
					   					<c:if test="${target_profile.prof_open == 'open'}">
					   						<div class="col-auto mt-3" id="openText">
					   							<small style="padding-left: 0.5rem;">전체 공개</small>
					   						</div>
					   						&nbsp;
					   						<div class="col mt-3 form-check form-switch">
												<input name="prof_open" class="form-check-input" type="checkbox" role="switch" id="openSwitch">
											</div>
					   					</c:if>
										<c:if test="${target_profile.prof_open == 'secret'}">
											<div class="col-auto mt-3" id="openText">
					   							<small style="padding-left: 0.5rem;">친구 공개</small>
					   						</div>
					   						&nbsp;
					   						<div class="col mt-3 form-check form-switch">
												<input name="prof_open" class="form-check-input" type="checkbox" role="switch" id="openSwitch" checked>
											</div>
										</c:if>
				   					</div>
				   				</div>
				   			</div>
						</div>
					</div>
				</div>
			
			</form>
		</div>
		
	</main>

</body>
<%@include file="../user/user_bottom.jsp" %>