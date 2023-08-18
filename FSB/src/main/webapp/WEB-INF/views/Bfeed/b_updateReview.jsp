<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript">

	let sorted_files = []; //이미지 배열
	
	window.addEventListener('DOMContentLoaded', function(){
		//sorted_files 설정
		if(${getReview.bpr_img1!=null}){
			sorted_files.push(1);
			if(${getReview.bpr_img2!=null}){
				sorted_files.push(2);
				if(${getReview.bpr_img3!=null}){
					sorted_files.push(3);
					if(${getReview.bpr_img4!=null}){
						sorted_files.push(4);
					}
				}
			}
		}
	});
	
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
		input.value = input.value+','+img_num;	//1,2,3,4 형식으로 저장
	}
	
	//등록
	function submitform(){
		//주소설정
		f.action = 'b_updateReviewOK.do';
		
		if(sorted_files.length !== 0){	//b1. 이미지가 있으면
			encodeImageFiles(afterReading);
		} else {	//이미지가 없으면
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
		submitFormAction();
	}
		
	//submit동작
	function submitFormAction(){
		/* f.action = 'shop_myPage_review_update.do'; */
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
							image.src = "resources/img/${getReview.bpr_img1}";
						}else if(oldImgNum===2){//기존 img2라면
							image.src = "resources/img/${getReview.bpr_img2}";
						}else if(oldImgNum===3){//기존 img3이라면
							image.src = "resources/img/${getReview.bpr_img3}";
						}else{//기존 img4라면
							image.src = "resources/img/${getReview.bpr_img4}";
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
	
	<!-- 벡터 아이콘 정의 -->
 	<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  		<symbol id="home" viewBox="0 0 16 16">
   			 <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"></path>
  		</symbol>
  		<symbol id="table" viewBox="0 0 16 16">
   	 		<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"></path>
  		</symbol>
  		<symbol id="people-circle" viewBox="0 0 16 16">
    		<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
    		<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
  		</symbol>
  		<symbol id="grid" viewBox="0 0 16 16">
    		<path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"></path>
  		</symbol>
  		<symbol id="collection" viewBox="0 0 16 16">
    		<path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"></path>
  		</symbol>
  		<symbol id="calendar3" viewBox="0 0 16 16">
    		<path d="M14 0H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM1 3.857C1 3.384 1.448 3 2 3h12c.552 0 1 .384 1 .857v10.286c0 .473-.448.857-1 .857H2c-.552 0-1-.384-1-.857V3.857z"></path>
    		<path d="M6.5 7a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
  		</symbol>
  		<symbol id="chat-quote-fill" viewBox="0 0 16 16">
    		<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM7.194 6.766a1.688 1.688 0 0 0-.227-.272 1.467 1.467 0 0 0-.469-.324l-.008-.004A1.785 1.785 0 0 0 5.734 6C4.776 6 4 6.746 4 7.667c0 .92.776 1.666 1.734 1.666.343 0 .662-.095.931-.26-.137.389-.39.804-.81 1.22a.405.405 0 0 0 .011.59c.173.16.447.155.614-.01 1.334-1.329 1.37-2.758.941-3.706a2.461 2.461 0 0 0-.227-.4zM11 9.073c-.136.389-.39.804-.81 1.22a.405.405 0 0 0 .012.59c.172.16.446.155.613-.01 1.334-1.329 1.37-2.758.942-3.706a2.466 2.466 0 0 0-.228-.4 1.686 1.686 0 0 0-.227-.273 1.466 1.466 0 0 0-.469-.324l-.008-.004A1.785 1.785 0 0 0 10.07 6c-.957 0-1.734.746-1.734 1.667 0 .92.777 1.666 1.734 1.666.343 0 .662-.095.931-.26z"></path>
  		</symbol>
  		<symbol id="gear-fill" viewBox="0 0 16 16">
    		<path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"></path>
  		</symbol>
  		<symbol id="toggles2" viewBox="0 0 16 16">
    		<path d="M9.465 10H12a2 2 0 1 1 0 4H9.465c.34-.588.535-1.271.535-2 0-.729-.195-1.412-.535-2z"></path>
    		<path d="M6 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm0 1a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm.535-10a3.975 3.975 0 0 1-.409-1H4a1 1 0 0 1 0-2h2.126c.091-.355.23-.69.41-1H4a2 2 0 1 0 0 4h2.535z"></path>
    		<path d="M14 4a4 4 0 1 1-8 0 4 4 0 0 1 8 0z"></path>
  		</symbol>
  		<symbol id="tools" viewBox="0 0 16 16">
    		<path d="M1 0L0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.356 3.356a1 1 0 0 0 1.414 0l1.586-1.586a1 1 0 0 0 0-1.414l-3.356-3.356a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0zm9.646 10.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708zM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11z"></path>
  		</symbol>
  		<symbol id="chevron-right" viewBox="0 0 16 16">
    		<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"></path>
  		</symbol>
  		<symbol id="geo-fill" viewBox="0 0 16 16">
    		<path fill-rule="evenodd" d="M4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999zm2.493 8.574a.5.5 0 0 1-.411.575c-.712.118-1.28.295-1.655.493a1.319 1.319 0 0 0-.37.265.301.301 0 0 0-.057.09V14l.002.008a.147.147 0 0 0 .016.033.617.617 0 0 0 .145.15c.165.13.435.27.813.395.751.25 1.82.414 3.024.414s2.273-.163 3.024-.414c.378-.126.648-.265.813-.395a.619.619 0 0 0 .146-.15.148.148 0 0 0 .015-.033L12 14v-.004a.301.301 0 0 0-.057-.09 1.318 1.318 0 0 0-.37-.264c-.376-.198-.943-.375-1.655-.493a.5.5 0 1 1 .164-.986c.77.127 1.452.328 1.957.594C12.5 13 13 13.4 13 14c0 .426-.26.752-.544.977-.29.228-.68.413-1.116.558-.878.293-2.059.465-3.34.465-1.281 0-2.462-.172-3.34-.465-.436-.145-.826-.33-1.116-.558C3.26 14.752 3 14.426 3 14c0-.599.5-1 .961-1.243.505-.266 1.187-.467 1.957-.594a.5.5 0 0 1 .575.411z"></path>
  		</symbol>
  		<symbol id="text-quote" viewBox="0 0 24 24">
  			<path d="M1.751 10c0-4.42 3.584-8 8.005-8h4.366c4.49 0 8.129 3.64 8.129 8.13 0 2.96-1.607 5.68-4.196 7.11l-8.054 4.46v-3.69h-.067c-4.49.1-8.183-3.51-8.183-8.01zm8.005-6c-3.317 0-6.005 2.69-6.005 6 0 3.37 2.77 6.08 6.138 6.01l.351-.01h1.761v2.3l5.087-2.81c1.951-1.08 3.163-3.13 3.163-5.36 0-3.39-2.744-6.13-6.129-6.13H9.756z"></path>
  		</symbol>
  		<symbol id="heart-empty" viewBox="0 0 24 24">
  			<path d="M16.697 5.5c-1.222-.06-2.679.51-3.89 2.16l-.805 1.09-.806-1.09C9.984 6.01 8.526 5.44 7.304 5.5c-1.243.07-2.349.78-2.91 1.91-.552 1.12-.633 2.78.479 4.82 1.074 1.97 3.257 4.27 7.129 6.61 3.87-2.34 6.052-4.64 7.126-6.61 1.111-2.04 1.03-3.7.477-4.82-.561-1.13-1.666-1.84-2.908-1.91zm4.187 7.69c-1.351 2.48-4.001 5.12-8.379 7.67l-.503.3-.504-.3c-4.379-2.55-7.029-5.19-8.382-7.67-1.36-2.5-1.41-4.86-.514-6.67.887-1.79 2.647-2.91 4.601-3.01 1.651-.09 3.368.56 4.798 2.01 1.429-1.45 3.146-2.1 4.796-2.01 1.954.1 3.714 1.22 4.601 3.01.896 1.81.846 4.17-.514 6.67z"></path>
		</symbol>
		<symbol id="location" viewBox="0 0 16 24">
			<path d="M10 0c4.4 0 7.95 3.5 7.95 7.79a7.6 7.6 0 01-1.23 4.15l-6.33 8.02a.5.5 0 01-.78 0l-6.38-8.1A7.6 7.6 0 012.05 7.8 7.89 7.89 0 0110 0zm0 1.54A6.38 6.38 0 003.55 7.8c0 1.18.34 2.33.96 3.28l5.5 6.92 5.44-6.86a6.08 6.08 0 001-3.34A6.37 6.37 0 0010 1.54zM6.75 6.92h6.5a.5.5 0 01.5.5v.54a.5.5 0 01-.5.5h-6.5a.5.5 0 01-.5-.5v-.54a.5.5 0 01.5-.5z"></path>
		</symbol>
		<symbol id="img-select" viewBox="0 0 24 24">
			<path d="M3 5.5C3 4.119 4.119 3 5.5 3h13C19.881 3 21 4.119 21 5.5v13c0 1.381-1.119 2.5-2.5 2.5h-13C4.119 21 3 19.881 3 18.5v-13zM5.5 5c-.276 0-.5.224-.5.5v9.086l3-3 3 3 5-5 3 3V5.5c0-.276-.224-.5-.5-.5h-13zM19 15.414l-3-3-5 5-3-3-3 3V18.5c0 .276.224.5.5.5h13c.276 0 .5-.224.5-.5v-3.086zM9.75 7C8.784 7 8 7.784 8 8.75s.784 1.75 1.75 1.75 1.75-.784 1.75-1.75S10.716 7 9.75 7z"></path>
		</symbol>
		<symbol id="message" viewBox="0 0 24 24">
			<path d="M1.998 5.5c0-1.381 1.119-2.5 2.5-2.5h15c1.381 0 2.5 1.119 2.5 2.5v13c0 1.381-1.119 2.5-2.5 2.5h-15c-1.381 0-2.5-1.119-2.5-2.5v-13zm2.5-.5c-.276 0-.5.224-.5.5v2.764l8 3.638 8-3.636V5.5c0-.276-.224-.5-.5-.5h-15zm15.5 5.463l-8 3.636-8-3.638V18.5c0 .276.224.5.5.5h15c.276 0 .5-.224.5-.5v-8.037z"></path>
		</symbol>
		<symbol id="lock" viewBox="0 0 16 16">
			<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z"/>
		</symbol>
		<symbol id="unlock" viewBox="0 0 16 16">
			<path d="M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2zM3 8a1 1 0 0 0-1 1v5a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V9a1 1 0 0 0-1-1H3z"/>
		</symbol>
	</svg>
<%@include file="../user/user_top.jsp" %>

	<main class="d-flex flex-nowrap">
<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
			<!--베젤-->
		<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 800px;">
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div class="col" align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">매장 리뷰 수정&nbsp;&nbsp;</span></div>
			</div>
				<form name="f" id="f" action="b_updateReview.do" method="post" enctype="multipart/form-data">
				<input name="deleted_img" id="deleted_img" type="hidden" value=""/>
				<input type="hidden" name="mem_num" value="${sessionScope.mem_num}">
				<input type="hidden" name="bp_num" value="${bp_num}">
				<input type="hidden" name="bpr_num" value="${bpr_num}">
				<input type="hidden" name="bpr_img1" value="${getReview.bpr_img1}">
				<input type="hidden" name="bpr_img2" value="${getReview.bpr_img2}">
				<input type="hidden" name="bpr_img3" value="${getReview.bpr_img3}">
				<input type="hidden" name="bpr_img4" value="${getReview.bpr_img4}">
			
			<table width="800px">
					<tr align="center" height="50">
						<th  width="20%">별 &nbsp점</th>
						<td width="80%"><!-- 내가 주문한 상품들 중 선택 가능하도록!!! <<<해야함 -->
							<select name="bpr_starrating" class="form-select">
							<c:if test="${getReview.bpr_starrating eq 1}">
									<option value="1" selected>⭐</option>
									<option value="2">⭐⭐</option>
									<option value="3">⭐⭐⭐</option>
									<option value="4">⭐⭐⭐⭐</option>
									<option value="5">⭐⭐⭐⭐⭐</option>
            					</c:if>
            					<c:if test="${getReview.bpr_starrating eq 2}">
            						<option value="1">⭐</option>
									<option value="2" selected>⭐⭐</option>
									<option value="3">⭐⭐⭐</option>
									<option value="4">⭐⭐⭐⭐</option>
									<option value="5">⭐⭐⭐⭐⭐</option>
            					</c:if>
            					<c:if test="${getReview.bpr_starrating eq 3}">
            						<option value="1">⭐</option>
									<option value="2">⭐⭐</option>
									<option value="3" selected>⭐⭐⭐</option>
									<option value="4">⭐⭐⭐⭐</option>
									<option value="5">⭐⭐⭐⭐⭐</option>
           						</c:if>
           						<c:if test="${getReview.bpr_starrating eq 4}">
           							<option value="1">⭐</option>
									<option value="2">⭐⭐</option>
									<option value="3">⭐⭐⭐</option>
									<option value="4" selected>⭐⭐⭐⭐</option>
									<option value="5">⭐⭐⭐⭐⭐</option>
           						</c:if>
           						<c:if test="${getReview.bpr_starrating eq 5}">
           							<option value="1">⭐</option>
									<option value="2">⭐⭐</option>
									<option value="3">⭐⭐⭐</option>
									<option value="4">⭐⭐⭐⭐</option>
									<option value="5" selected>⭐⭐⭐⭐⭐</option>											
           						</c:if>													
							</select>								
						</td>			
					</tr>
					<tr align="center" height="60">
						<th  width="20%">리뷰 제목</th>
						<td width="80%"><input type="text" class="form-control" name="bpr_title" placeholder="제목을 작성해주세요.(최대 50자)" value="${getReview.bpr_title }"></td>
					</tr>
					<tr align="center" height="60">
						<th  width="20%">리뷰 내용</th>
						<td width="80%"><textarea name="bpr_content" class="form-control" id="bpr_content" rows="7" placeholder="내용을 50자 이상 입력해주세요.">${getReview.bpr_content }</textarea></td>
					</tr>
					<tr align="center">
					<th width="20%" rowspan="2">사진 첨부</th>
						<td align="left" width="80%">
		   					<button type="button" class="btn btn-sm btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#image-collapse" aria-expanded="false">
			         			<svg class="bi pe-none me-2" fill="#A6A6A6" width="24" height="24"><use xlink:href="#img-select"></use></svg>
			         			최대 4장까지 사진 첨부
			        		</button>	
						</td>
					</tr>
					<tr>
						<td width="80%">
						<div class="container">
							<div class="row mb-3">
							<div class="col" align="left">
			        		<div class="collapse" id="image-collapse">
				        		<div id="image_preview">
				        		<label class="input-file-button" for="btnAtt" style="margin-left: 2rem;">파일 선택</label>
									<input type="file" id="btnAtt" multiple="multiple" class="mt-2 small" style="margin-left: 20px;" accept=".png, .jpg, .jpeg" enctype="multipart/form-data"/>
									<div id="attZone" class="row small mt-2" style="margin-left: 20px;" data-placeholder="파일을 첨부 하려면 파일 선택 버튼을 클릭하세요"></div>
 									<c:if test="${!empty getReview.bpr_img1}">
											<div class="col-auto" id="imgBox1" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${getReview.bpr_img1}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(1)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
									</c:if>
										<c:if test="${!empty getReview.bpr_img2}">
											<div class="col-auto" id="imgBox2" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${getReview.bpr_img2}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(2)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
									</c:if>
										<c:if test="${!empty getReview.bpr_img3}">
											<div class="col-auto" id="imgBox3" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${getReview.bpr_img3}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(3)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
									</c:if>
										<c:if test="${!empty getReview.bpr_img4}">
											<div class="col-auto" id="imgBox4" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
												<img src="resources/img/${getReview.bpr_img4}" class="imgPreviewCrop">
												<button class="btn-close" onclick="deleteImgDiv(4)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
											</div>
									</c:if>
								</div>
							</div>
							</div>
						</div>
						</div>		        														
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button class="btn btn-outline-dark" type="button" onclick="javascript:submitform()">리뷰수정</button>
							<button class="btn btn-outline-dark" type="button" onclick="location.href='b_review.do?bp_num=${bp_num}'">돌아가기</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
		</main>
	</body>
<%@include file="../user/user_bottom.jsp" %>				
