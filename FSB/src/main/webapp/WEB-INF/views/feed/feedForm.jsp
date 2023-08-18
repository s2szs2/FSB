<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<link href="resources/css/bootstrap-grid.min.css" rel="stylesheet">
<link href="resources/css/bootstrap-grid.rtl.min.css" rel="stylesheet">
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="resources/js/sidebars.js"></script>

<%@include file="../user/user_top.jsp" %>

<style>
	.vertical-right-line {
		border-right-style: solid;
	 	border-right-width: 2px;
	  	border-right-color: #dee2e6;
	}
	.img-pick-box {
		border: 0 solid black;
		background-color: #ffffff;
        background-color: rgba(255,255,255,0.5);
	}
	
	#attZone{
		width: 660px;
		min-height:150px;
		padding:10px;
		border:1px #000;
	}
	#attZone:empty:before{
		content : attr(data-placeholder);
		color : #999;
		font-size:.9em;
	}
	
	.imgPreviewCrop{
		position: absolute;
    	top: 0;
    	left: 0;
    	transform: translate(50, 50);
    	width: 100%;
    	height: 100%;
    	object-fit: cover;
    	margin: auto;
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

<script type="text/javascript">
	let sorted_files = []; //이미지 배열
	let isOpen = '${feed.feed_open}'; //c1 피드의 공개정보 받아오기
	
	window.addEventListener('DOMContentLoaded', function(){
		//isOpen 설정
		if(!isOpen){
			isOpen = '${profile.prof_open}'; //c2 프로필의 공개정보 받아오기
		}
		lock_btn_set(isOpen);
		//sorted_files 설정
		if(${feed.feed_img1!=null}){
			sorted_files.push(1);
			if(${feed.feed_img2!=null}){
				sorted_files.push(2);
				if(${feed.feed_img3!=null}){
					sorted_files.push(3);
					if(${feed.feed_img4!=null}){
						sorted_files.push(4);
					}
				}
			}
		}
	});
	
	//잠금버튼 설정
	function lock_btn_set(open){
		let lock_svg = document.getElementById('lock_svg');
		let lock_span = document.getElementById('lock_span');
		
		if(open === 'open'){
			lock_svg.innerHTML='<use xlink:href="#unlock"></use>';
			lock_span.innerHTML='전체공개';
		}else{
			lock_svg.innerHTML='<use xlink:href="#lock"></use>';
			lock_span.innerHTML='친구공개';
		}
	}
	//공개여부 변경
	function lockUnlock(){
		if(isOpen === 'open'){
			isOpen = 'secret';
			lock_btn_set(isOpen);
		}else{
			isOpen = 'open';
			lock_btn_set(isOpen);
		}
	}
	//기존 이미지 삭제
	function deleteImgDiv(img_num){
		//div 삭제
		let deleteBox = document.getElementById('imgBox'+img_num);
		let parent = deleteBox.parentElement;
		parent.removeChild(deleteBox);
		
		//sorted_files에서 삭제
		for(let i=0; i<sorted_files.length; i++){
			if(sorted_files[i] === img_num){
				sorted_files.splice(i, 1);
			}
		}
		
		//삭제된 이미지 목록 갱신
		let input = document.getElementById('deleted_img');
		input.value = input.value+','+img_num;//1,2,3,4 형식으로 저장
	}
	//게임 창 열기
	function openGame(){
		var popupX = (document.body.offsetWidth /2) - (600 /2);
		var popupY= (window.screen.height /2) - (800 /2);
		window.open('feed_game_list.do', '게임찾기', 'status=no, width=600, height=800, left='+popupX+', top='+popupY);
	}
	//게임 선택
	function selectGameOK(gameNum, gameName){
		f.game_num.value = gameNum;
		$("#gameText").html(gameName);
		$("#gameZone").show();
	}
	//게임 삭제
	function deleteGame(){
		f.game_num.value = 0;
		$("#gameText").html('');
		$("#gameZone").hide();
	}	
	
	//등록
	function submitform(){
		//주소설정
		if(${feedForm_mode=='insert'}){
			f.action = 'feedFormOk.do';
		}else{
			f.action = 'feedUpdateOk.do';
		}
		
		if(sorted_files.length !== 0){//b1. 이미지가 있으면
			encodeImageFiles(afterReading);
		}else{//이미지가 없으면
			inputOpen();
			submitFormAction();
		}
		//b3. imgs 담긴 input 생성
		function afterReading(encodedImages){
			for (let i=0; i<encodedImages.length; ++i){
				let input = document.createElement('input');
				input.type = 'hidden';
				input.name = 'imgs'+i;
				input.value = encodedImages[i];
				f.appendChild(input);
				document.body.appendChild(f);
				if(i===encodedImages.length-1){
					break;
				}
			}
			inputOpen();
			submitFormAction();
		}
		//b4. 공개여부 input에 넣기
		function inputOpen(){
			let input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'feed_open';
			input.value = isOpen;
			f.appendChild(input);
			document.body.appendChild(f);
		}
		//b5. submit동작
		function submitFormAction(){
			f.submit();
		}
	}
	
	//b2. 이미지 Base64로 전환
	function encodeImageFiles(callback) {
		let encodedImages = []; //b2-1. base64로 변환된 이미지 배열
		
		for (let i = 0; i < sorted_files.length; i++) {
			//file 형태라면
			if(sorted_files[i]!==1 && sorted_files[i]!==2 && sorted_files[i]!==3 && sorted_files[i]!==4){
		        let reader = new FileReader();
		        //b2-3. 하단의 reader.readAsDataURL이 완료되면 실행됨
		        reader.onload = function () {
		            //let base64Data = reader.result.split(",")[1];
		            let base64 = reader.result;
		            console.log("처음 base64: "+base64);
		            
					//b2-4. 용량검사, 줄이기
		            const image = new Image();
		            image.src = base64;
	
		            image.onload = function () {
		            	let imgSize = base64.length;
		            	let mag = 1;
		            	
			            if(imgSize > 524288){
			            	//축소율 구하기
			            	while(imgSize > 2000000){
			            		imgSize = imgSize/4;
			            		mag = mag/4;
			            	}
			            	
			            	const tempCanvas = document.createElement('canvas');
			            	const ctx = tempCanvas.getContext('2d');
			             
			            	tempCanvas.width = image.width;
			            	tempCanvas.height = image.height;
			            	
			            	ctx.drawImage(image, 0, 0);
			            	
			            	base64 = tempCanvas.toDataURL('image/jpeg', mag);
			            	console.log("변환율: "+mag);
			            	console.log("변환 후 base64: "+base64);
			            }
			            
			            let base64Data = base64.split(",")[1];
			            console.log("base64Data: "+base64Data);
			            
						encodedImages.push(base64Data); //b2-5. 배열에 추가
			            console.log("배열에 추가함");
			            if(sorted_files.length === encodedImages.length){
					        callback(encodedImages);//b2-6. 이미지 전부 변환하면 콜백으로 afterReading 실행
			            }
		            }		
		        };
		        reader.readAsDataURL(sorted_files[i]);//b2-2. 다 읽어오면 onload실행	
			//file이 아니라면
			}else{
				encodedImages.push(sorted_files[i]);
				if(sorted_files.length === encodedImages.length){
			        callback(encodedImages);//전부 변환하면 콜백으로 afterReading 실행
	            }
			}
	    }
	}
	
	//a1-2. 이미지 유효성 검사
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
	
	//이미지 업로드
	window.onload = function(){
		let btnAtt = document.getElementById('btnAtt');
		let attZone = document.getElementById('attZone');
		
		btnAtt.onchange = function(){
			//a1. 추가한 이미지 가져오기
			let files = btnAtt.files;
			if(files.length = 0){//변화가 없었다면 돌아가기
				return;
			}
			//a1-1. 이미지 4개 제한
			if(sorted_files.length + files.length > 4){
				alert('이미지는 4개까지 업로드 가능합니다.');
				return;
			}
			//a1-2. 이미지 확장자&크기 제한
			for(file of files){
				let fileName = file.name;
				let fileSize = file.size;
				let isOk = checkExtension(fileName,fileSize);
				if(!isOk){
					return;
				}
			}
			
			//a2. 추가한 이미지 목록에 추가
			for(file of files){
				sorted_files.push(file);
			}
			
			function setPriview(){
				//a3. 기존 미리보기 지우기
				attZone.replaceChildren();
				let index = 0; //미리보기 중 몇번째인지
				//a4. 이미지 미리보기 추가
				for(file of sorted_files){
					const imgBox = document.createElement('div');
					const image = document.createElement('img');
					const delBtn = document.createElement('button');
					imgBox.className = 'col-auto';
					imgBox.id = 'imgBox'+index;
					imgBox.style = 'display:inline-block; position:relative; width:120px; height:120px; margin-right: 10px;';
					image.className = 'imgPreviewCrop';
					delBtn.className = 'btn-close';
					delBtn.type='button';
					delBtn.style='position: absolute; right: 0px; top: 0px;'
									
					//이미지 src & delBtn 세팅
					if(file!==1 && file!==2 && file!==3 && file!==4){//새 이미지라면
						image.src = URL.createObjectURL(file);
						delBtn.onclick= function(event){
							let indexNow = event.target.parentNode.getAttribute('id').substring(6,7);//클릭한 버튼이 소속된 imgBox의 번호
							sorted_files.splice(indexNow, 1);//해당 번호의 file을 배열에서 제거
							setPriview();//미리보기 세팅
						}
					}else{//기존 이미지라면
						const oldImgNum = file;
						if(oldImgNum===1){//기존 img1이라면
							image.src = "resources/img/${feed.feed_img1}";
						}else if(oldImgNum===2){//기존 img2라면
							image.src = "resources/img/${feed.feed_img2}";
						}else if(oldImgNum===3){//기존 img3이라면
							image.src = "resources/img/${feed.feed_img3}";
						}else{//기존 img4라면
							image.src = "resources/img/${feed.feed_img4}";
						}
					
						delBtn.onclick= function(event){
							let indexNow = event.target.parentNode.getAttribute('id').substring(6,7);//클릭한 버튼이 소속된 imgBox의 번호
							sorted_files.splice(indexNow, 1);//해당 번호의 file을 배열에서 제거
							setPriview();//미리보기 세팅					
							
							let input = document.getElementById('deleted_img');
							input.value = input.value+','+oldImgNum;//1,2,3,4 형식으로 저장
						}
					}
					
					imgBox.appendChild(image);
					imgBox.appendChild(delBtn);
					attZone.appendChild(imgBox);
					
					index += 1;
				}
			}
			setPriview();
		};
	};	
</script>



<body>
	<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
		
		<!-- 상단 배젤 -->
		<div class="flex-shrink-0 p-3 bg-white" style="width: 70%; min-width: 30rem; max-width: 60rem;">
			<div class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
				<span class="fs-5 fw-semibold">새 글 쓰기</span>
			</div>
			
			<!-- 글쓰기 폼 -->
			<form name="f" id="feedForm" method="POST" action="" enctype="multipart/form-data"><!-- 그냥 위에 if문 때문에 div 꼬여서 이러는 거임 문제 없습니다 -->
				<input name="feed_num" type="hidden" value="${feed.feed_num}"/><!-- feed_num 임시저장 불러올 경우 덮어씌워짐. 아니면 null -->
				<input name="mem_num" type="hidden" value="${login_mem.mem_num}"/><!-- mem_num 지금은 데이터 1 하나만 존재-->
				<input name="deleted_img" id="deleted_img" type="hidden" value=""/>
				<input name="old_feed_img1" type="hidden" value="${feed.feed_img1}"/>
				<input name="old_feed_img2" type="hidden" value="${feed.feed_img2}"/>
				<input name="old_feed_img3" type="hidden" value="${feed.feed_img3}"/>
				<input name="old_feed_img4" type="hidden" value="${feed.feed_img4}"/>
				<input name="game_num" type="hidden"/>
				
				<div class="container">
					<!-- 글 상자 -->
	   				<div class="row mb-3">
		   				<div class="col" align="center">
		   					<textarea class="form-control" name="feed_content" id="textarea" rows="10">${feed.feed_content}</textarea>
		   				</div>
		   			</div>
		   			<!-- 태그 버튼 -->
		   			<div class="row mb-1" style="padding: 10px">
			   			<c:forEach var="theme" items="${listTheme}" varStatus="status"><!-- 테마 리스트 listTheme로 넘겨받기 -->
		   					<div class="col-auto" align="left" style="margin: 5px -5px;">
						   		<c:if test="${theme.feed_checked == 1}">
						   			<input type="checkbox" class="btn-check h-75" id="btn-check-${status.count}" name="theme" value="${theme.theme_num}" checked>							
								</c:if>
								<c:if test="${empty theme.feed_checked || theme.feed_checked == 0}">
						   			<input type="checkbox" class="btn-check h-75" id="btn-check-${status.count}" name="theme" value="${theme.theme_num}">
								</c:if>
								<label class="btn btn-outline-secondary" for="btn-check-${status.count}">#${theme.theme_name}</label>
							</div>
						</c:forEach>
					</div>
		   			<!-- 이미지업로드, 임시목록, 보드게임 카페 선택, 잠금설정 줄 -->
		   			<div class="row mb-3">
		   				<div class="col" align="left">
		   					<button type="button" class="btn btn-sm btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#image-collapse" aria-expanded="false">
			         			<svg class="bi pe-none me-2" fill="#A6A6A6" width="24" height="24"><use xlink:href="#img-select"></use></svg>
			         			사진 첨부
			        		</button>
			        		<button type="button" class="btn btn-sm rounded border-0" onclick="javascript:openGame()">
			         			<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#controller"></use></svg>
			         			게임 추가
			        		</button>
			        		<button id="lock_btn" type="button" class="btn btn-sm rounded border-0" onclick="javascript:lockUnlock()">
			         			<svg id="lock_svg" class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"></svg>
			         			<span id="lock_span"></span>
			        		</button>
			        		<!-- 이미지 선택 박스 -->
			        		<c:if test="${empty feed.feed_img1}">
			        		<div class="collapse" id="image-collapse"><!-- 그냥 위에 if문 때문에... -->
			        		</c:if>
			        		<c:if test="${!empty feed.feed_img1}">
			        		<div class="collapse.show" id="image-collapse"><!-- 그냥 위에 if문 때문에... -->
			        		</c:if>
				        		<div id="image_preview">
				        			<label class="input-file-button" for="btnAtt" style="margin-left: 2rem;">파일 선택</label>
									<input type="file" id="btnAtt" multiple="multiple" class="mt-2 small" style="margin-left: 20px; display: none;" accept=".png, .jpg, .jpeg" enctype="multipart/form-data"/>
									<div id="attZone" class="row small mt-2" style="margin-left: 20px;" data-placeholder="파일을 첨부 하려면 파일 선택 버튼을 클릭하세요">
										<c:if test="${!empty feed.feed_img1}">
											<div class="col-auto" id="imgBox1" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${feed.feed_img1}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(1)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
										</c:if>
										<c:if test="${!empty feed.feed_img2}">
											<div class="col-auto" id="imgBox2" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${feed.feed_img2}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(2)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
										</c:if>
										<c:if test="${!empty feed.feed_img3}">
											<div class="col-auto" id="imgBox3" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${feed.feed_img3}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(3)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
										</c:if>
										<c:if test="${!empty feed.feed_img4}">
											<div class="col-auto" id="imgBox4" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${feed.feed_img4}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(4)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
										</c:if>
									</div>
								</div>
							</div>
							<c:if test="${!empty feed.game_num && feed.game_num!=0}">
								<div id="gameZone" class="col-auto" align="right">
									<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#controller"></use></svg>
									<span id="gameText">${feed.game_name}</span>
									<button class="btn-close" onclick="deleteGame()" type="button"></button>
								</div>
							</c:if>
							<c:if test="${empty feed.game_num || feed.game_num==0}">
								<div id="gameZone" class="col-auto" align="right" style="display: none;">
									<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#controller"></use></svg>
									<span id="gameText">${feed.game_name}</span>
									<button class="btn-close" onclick="deleteGame()" type="button"></button>
								</div>
							</c:if>
						</div>
	   				</div>
	   				<div class="row">
	   					<div class="col" align="right">
		   					<button type="button" class="btn btn-outline-primary btn-sm" onclick="history.back()">취소</button>&nbsp;&nbsp;
		   					<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:submitform()">피드 작성</button>
		   				</div>
	   				</div>
	   			</div>
   			</form><!-- 그냥 위에 if문 때문에... -->
		</div><!-- 그냥 위에 if문 때문에... -->
	
	</main>

</body>
<%@include file="../user/user_bottom.jsp" %>