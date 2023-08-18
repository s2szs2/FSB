<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- writeForm.jsp -->
<%@include file="../user/user_top.jsp"%>
<html>
<head>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
<symbol id="img-select" viewBox="0 0 24 24">
 <path d="M3 5.5C3 4.119 4.119 3 5.5 3h13C19.881 3 21 4.119 21 5.5v13c0 1.381-1.119 2.5-2.5 2.5h-13C4.119 21 3 19.881 3 18.5v-13zM5.5 5c-.276 0-.5.224-.5.5v9.086l3-3 3 3 5-5 3 3V5.5c0-.276-.224-.5-.5-.5h-13zM19 15.414l-3-3-5 5-3-3-3 3V18.5c0 .276.224.5.5.5h13c.276 0 .5-.224.5-.5v-3.086zM9.75 7C8.784 7 8 7.784 8 8.75s.784 1.75 1.75 1.75 1.75-.784 1.75-1.75S10.716 7 9.75 7z"></path>
 </symbol>
</svg>
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
</style>

<title>중고게시판</title>
<script type="text/javascript">
	function check() {
		if (f.board_title.value == "") {
			alert("제목을 입력해주세요!")
			f.board_title.focus()
			return false
		}
		if (f.board_condition.value == "10") {
			alert("거래종류를 선택해주세요")
			f.board_condition.focus()
			return false
		}
		if (f.board_location.value == "10") {
			alert("지역을 선택해 주세요")
			f.board_location.focus()
			return false
		}
	
		if (f.board_package.value == "10") {
			alert("거래내용을 선택해주세요")
			f.board_package.focus()
			return false
		}
		if (f.board_price.value == "") {
			alert("가격을 입력해주세요")
			f.board_price.focus()
			return false
		}
		if (f.board_content.value == "") {
			alert("내용을 입력해주세요")
			f.board_content.focus()
			return false
		}
		if(f)
		f.action = 'write_board_sh.do';
		f.submit();
		return true
	}
	//중고금액 컴마단위
	 function inputNumberFormat(obj) {
	     obj.value = comma(uncomma(obj.value));
	 }

	 function comma(str) {
	     str = String(str);
	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	 }

	 function uncomma(str) {
	     str = String(str);
	     return str.replace(/[^\d]+/g, '');
	 }
</script>

<script type="text/javascript">
	let sorted_files = []; //이미지 배열
	
	//등록
	function submitform(){
		if(sorted_files.length !== 0){//이미지가 있으면
			encodeImageFiles(afterReading);
		}else{//이미지가 없으면
			submitFormAction();
		}
		//imgs 담긴 input 생성
		function afterReading(encodedImages){
			for (let i=0; i<encodedImages.length; ++i){
				let input = document.createElement('input');
				input.type = 'hidden';
				input.name = 'imgs'+i;
				input.value = encodedImages[i];
				//alert(encodedImages[i]); //이미지 제대로 가는지 확인 가능!
				f.appendChild(input);
				document.body.appendChild(f);
				if(i===encodedImages.length-1){
					break;
				}
			}
			submitFormAction();
		}
		//submit동작
		function submitFormAction(){
			check();
		}	
	}
	
	//이미지 Base64로 전환
	function encodeImageFiles(callback) {
		let encodedImages = []; //base64로 변환된 이미지 배열
		
		for (let i = 0; i < sorted_files.length; i++) {
	        let reader = new FileReader();
	        //하단의 reader.readAsDataURL이 완료되면 실행됨
	        reader.onload = function () {
	            let base64Data = reader.result.split(",")[1];
	            encodedImages.push(base64Data);
	            if(sorted_files.length === encodedImages.length){
			        callback(encodedImages);//이미지 전부 변환하면 콜백으로 afterReading 실행
	            }
	        };
	        reader.readAsDataURL(sorted_files[i]);//다 읽어오면 onload실행
	    }
	}
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
	
	//이미지 업로드
	window.onload = function(){
		let btnAtt = document.getElementById('btnAtt');
		let attZone = document.getElementById('attZone');
		
		btnAtt.onchange = function(){
			//추가한 이미지 가져오기
			let files = btnAtt.files;
			//이미지 4개 제한
			if(sorted_files.length + files.length > 4){
				alert('이미지는 4개까지 업로드 가능합니다.');
				return;
			}
			
			for(file of files){
				let fileName = file.name;
				let fileSize = file.size;
				let isOk = checkExtension(fileName,fileSize);
				if(!isOk){
					return;
				}
			}
			
			//추가한 이미지 목록에 추가
			for(file of files){
				sorted_files.push(file);
			}
			
			function setPriview(){
				//기존 미리보기 지우기
				attZone.replaceChildren();
				let index = 0;
				//이미지 미리보기 추가
				for(file of sorted_files){
					const imgBox = document.createElement('div');
					const image = document.createElement('img');
					const delBtn = document.createElement('button');
					imgBox.className = 'col-auto';
					imgBox.id = 'imgBox'+index;
					imgBox.style = 'display:inline-block; position:relative; width:120px; height:120px; margin-right: 10px;';
					image.src = URL.createObjectURL(file);
					image.className = 'imgPreviewCrop';
					delBtn.className = 'btn-close';
					delBtn.type='button';
					delBtn.style='position: absolute; right: 0px; top: 0px;'
					
					delBtn.onclick= function(event){
						let indexNow = event.target.parentNode.getAttribute('id').substring(6,7);
						sorted_files.splice(indexNow, 1);
						setPriview();
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
</head>
<body>
	<div align="center">
		<form name="f" action="write_board_sh.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="board_num" value="${param.board_num}"/>
			<input type="hidden" name="board_re_group" value="${param.board_re_group}"/>
			<input type="hidden" name="board_re_step" value="${param.board_re_step}"/>
			<input type="hidden" name="board_re_level" value="${param.board_re_level}"/>
<%-- 		<input type="hidden" name="pageNum" value="${params.pageNum}">	
 --%>			<table class="table table-borderless">
				<tr>
					<td>
						<div class="mb-3 w-50 p-3 mx-auto p-2">
							<!--  테이블 센터랑 사이즈 조절하기  -->
							<label for="exampleFormControlInput1" class="form-label">제목</label>
							<input type="text" class="form-control"
								id="exampleFormControlInput1" placeholder="제목을 입력하세요."
								name="board_title">
						</div>
					</td>
				</tr>
				<tr>
					<td>
							<div class="mb-3 w-50 p-3 mx-auto p-2">
							<table class="table table-borderless">
						<!-- 중고게시판 입력 폼  -->
						<tr>
						<td>
						<div class="input-group mb-3">
						<label class="input-group-text" for="inputGroupSelect01">거래 종류</label>
								<select class="form-select" id="inputGroupSelect01" name ="board_condition">
									<option selected value="10">거래 종류를 선택하세요</option>
									<option value="0">팝니다</option>
									<option value="1">삽니다</option>
									<option value="2">교환</option>
									<option value="3">거래완료(내정)</option>
								</select>
							</div>
							</td>
							</tr>
							<tr>
								<td>
							<div class="input-group mb-3">
								<label class="input-group-text" for="inputGroupSelect01">지역</label>
								<select class="form-select" id="inputGroupSelect01" name = "board_location">
									<option selected value="10">지역을 선택하세요</option>
									<option value="0">서울</option>
									<option value="1">경기</option>
									<option value="2">강원도</option>
									<option value="3">충청북도</option>
									<option value="4">충청남도</option>
									<option value="5">경상북도</option>
									<option value="6">경상남도</option>
									<option value="7">전라북도</option>
									<option value="8">전라남도</option>
									<option value="9">제주도</option>
								</select>
								</div>
							</td>
								</tr>
								<tr>
								<tr>
								<td>
								<div class="input-group mb-3">
								<label class="input-group-text" for="inputGroupSelect01">거래 방법</label>
								<select class="form-select" id="inputGroupSelect01" name="board_package">
									<option selected value="10">거래 방법을 선택하세요</option>
									<option value="1">택배만</option>
									<option value="2">직거래만</option>
									<option value="3">택배/직거래</option>
								</select>
							</div>
							</td>
							</tr>
							<tr>
							<td>
							<!-- 금액수 11자리 제한 , 천원 단위로 컴마찍기 -->
							<div class="input-group">
								<span class="input-group-text">가격</span>
								<input type="text" class="form-control" name="board_price" maxlength='11' placeholder="숫자만 입력하세요." onkeyup="inputNumberFormat(this)">
								<span class="input-group-text">원</span>
							</div>
							</td>
							</tr>
							</table>
							</div>
							</td>
							</tr>
							
							<tr>
							<td>
							<div class="mb-3 w-50 p-3 mx-auto p-2">
							<label for="exampleFormControlTextarea1" class="form-label">내용</label>
							<textarea class="form-control" id="exampleFormControlTextarea1"	name="board_content" placeholder="내용을 입력하세요" rows="10"></textarea>
							</div>
					</td>
				</tr>
				<tr>
					<td align="center">
						<button type="button" class="btn btn-sm btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#image-collapse" aria-expanded="false">
			         			<svg class="bi pe-none me-2" fill="#A6A6A6" width="24" height="24"><use xlink:href="#img-select"></use></svg>
			         			최대 4장까지 사진 첨부
			        		</button>
			       		<div class="container">
							<div class="row mb-3">
							<div class="col-4"></div>
							<div class="col-4">
			        		<div class="collapse" id="image-collapse">
				        		<div id="image_preview">
									<input type="file" id="btnAtt" multiple="multiple" class="mt-2 small" style="margin-left: 20px;" accept=".png, .jpg, .jpeg" enctype="multipart/form-data"/>
									<div id="attZone" class="row small mt-2" style="margin-left: 20px;" data-placeholder="파일을 첨부 하려면 파일 선택 버튼을 클릭하세요"></div>
								</div>
							</div>
							</div>
							<div class="col-4"></div>
							</div>
						</div>
			       	</td>
				</tr>
				<tr>
					<td>
					<!-- 게시글 등록 버튼  -->
						<div class="d-grid gap-2 w-50 mx-auto p-2">
							<button class="btn btn-primary d-grid gap-2 w-100 mx-auto p-2" type="button" onclick="javascript:submitform()">글쓰기</button>
							<button class="btn btn-primary" type="reset">다시작성</button>
							<button class="btn btn-primary" type="button"
								onclick="window.location='board_secondhand.do?mode=all'">목록보기</button>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
<%-- 	<form name="f" action="write_board_sh.do" method="post">
		<input type="hidden" name="board_num" value="${param.board_num}" /> <input
			type="hidden" name="board_re_group" value="${param.board_re_group}" />
		<input type="hidden" name="board_re_step"
			value="${param.board_re_step}" /> <input type="hidden"
			name="board_re_level" value="${param.board_re_level}" /> <input
			type="hidden" name="pageNum" value="${params.pageNum}">
	</form> --%>
</body>
<%@include file="../user/user_bottom.jsp"%>
</html>







