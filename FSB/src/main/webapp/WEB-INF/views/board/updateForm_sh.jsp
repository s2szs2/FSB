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
   
   window.addEventListener('DOMContentLoaded', function(){
      //sorted_files 설정
      if(${getBoard.board_img1!=null}){
         sorted_files.push(1);
         if(${getBoard.board_img2!=null}){
            sorted_files.push(2);
            if(${getBoard.board_img3!=null}){
               sorted_files.push(3);
               if(${getBoard.board_img4!=null}){
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
      input.value = input.value+','+img_num;   //1,2,3,4 형식으로 저장
   }
   
   //등록
   function submitform(){
      //주소설정
      f.action = 'update_board_sh.do';
      
      if(sorted_files.length !== 0){   //b1. 이미지가 있으면
         encodeImageFiles(afterReading);
      } else {   //이미지가 없으면
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
	   check()
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
                     image.src = "resources/img/${getBoard.board_img1}";
                  }else if(oldImgNum===2){//기존 img2라면
                     image.src = "resources/img/${getBoard.board_img2}";
                  }else if(oldImgNum===3){//기존 img3이라면
                     image.src = "resources/img/${getBoard.board_img3}";
                  }else{//기존 img4라면
                     image.src = "resources/img/${getBoard.board_img4}";
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
</head>
<body>
   <div align="center">
      <form name="f" action="update_board_sh.do" method="post" enctype="multipart/form-data">
         <input name="deleted_img" id="deleted_img" type="hidden" value=""/>
         <input type="hidden" name="board_num" value="${getBoard.board_num}" />
         <input type="hidden" name="board_img1" value="${getBoard.board_img1}">
         <input type="hidden" name="board_img2" value="${getBoard.board_img2}">
         <input type="hidden" name="board_img3" value="${getBoard.board_img3}">
         <input type="hidden" name="board_img4" value="${getBoard.board_img4}">
         <input type="hidden" name="pageNum" value="${pageNum}">
         
         <table class="table table-borderless">
            <tr>
               <td>
                  <div class="mb-3 w-50 p-3 mx-auto p-2">
                     <!--  테이블 센터랑 사이즈 조절하기  -->
                     <!-- 수정시 제목, 내용 끌고오기 -->
                     <label for="exampleFormControlInput1" class="form-label">제목</label>
                     <input type="text" class="form-control"
                        id="exampleFormControlInput1" value="${getBoard.board_title}"
                        name="board_title">
                  </div>
               </td>
            </tr>
                  <tr>
               <td>
                     <div class="mb-3 w-50 p-3 mx-auto p-2">
                     <table class="table table-borderless">
                     <tr>
                     <td>
                  <div class="input-group mb-3">
                  <label class="input-group-text" for="inputGroupSelect01">거래 종류</label>
                        <select class="form-select" id="inputGroupSelect01" name ="board_condition" >
                           <c:if test="${getBoard.board_condition eq '팝니다'}">
                           <option value="0" selected>팝니다</option>
                           </c:if>
                           <c:if test="${getBoard.board_condition ne '팝니다'}">
                             <option value="0">팝니다</option>
                             </c:if>
                                <c:if test="${getBoard.board_condition eq '삽니다'}">
                           <option value="1" selected>삽니다</option>
                           </c:if>
                           <c:if test="${getBoard.board_condition ne '삽니다'}">
                             <option value="1">삽니다</option>
                             </c:if>
                                <c:if test="${getBoard.board_condition eq '교환'}">
                           <option value="2" selected>교환</option>
                           </c:if>
                           <c:if test="${getBoard.board_condition ne '교환'}">
                             <option value="2">교환</option>
                             </c:if>
                                <c:if test="${getBoard.board_condition eq '거래완료(내정)'}">
                           <option value="3" selected>거래완료(내정)</option>
                           </c:if>
                           <c:if test="${getBoard.board_condition ne '거래완료(내정)'}">
                             <option value="3">거래완료(내정)</option>
                             </c:if>
                        </select>
                     </div>
                     </td>
                     </tr>
                        <tr>
                        <td>
                     <div class="input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect01">지역</label>
                        <select class="form-select" id="inputGroupSelect01" name = "board_location">
                           <c:if test="${getBoard.board_location eq '서울'}">
                              <option value="0" selected>서울</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '서울'}">
                              <option value="0">서울</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '경기'}">
                              <option value="1" selected>경기</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '경기'}">
                              <option value="1">경기</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '강원도'}">
                              <option value="2" selected>강원도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '강원도'}">
                              <option value="2">강원도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '충청북도'}">
                              <option value="3" selected>충청북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '충청북도'}">
                              <option value="3">충청북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '충청남도'}">
                              <option value="4" selected>충청남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '충청남도'}">
                              <option value="4">충청남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '경상북도'}">
                              <option value="5" selected>경상북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '경상북도'}">
                              <option value="5">경상북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '경상남도'}">
                              <option value="6" selected>경상남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '경상남도'}">
                              <option value="6">경상남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '전라북도'}">
                              <option value="7" selected>전라북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '전라북도'}">
                              <option value="7">전라북도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '전라남도'}">
                              <option value="8" selected>전라남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '전라남도'}">
                              <option value="8">전라남도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location eq '제주도'}">
                              <option value="8" selected>제주도</option>
                           </c:if>
                           <c:if test="${getBoard.board_location ne '제주도'}">
                              <option value="8">제주도</option>
                           </c:if>
                        </select>
                        </div>
                     </td>
                        </tr>
                        <tr>
                        <td>
                        <div class="input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect01">거래 방법</label>
                        <select class="form-select" id="inputGroupSelect01" name="board_package">
                           <c:if test="${getBoard.board_package eq '택배만'}">
                           <option value="1" selected>택배만</option>
                           </c:if>
                           <c:if test ="${getBoard.board_package ne '택배만'}">
                             <option value="1">택배만</option>
                             </c:if>
                                <c:if test="${getBoard.board_package eq '직거래만'}">
                           <option value="2" selected>직거래만</option>
                           </c:if>
                           <c:if test ="${getBoard.board_package ne '직거래만'}">
                             <option value="2">직거래만</option>
                             </c:if>
                                <c:if test="${getBoard.board_package eq '택배/직거래'}">
                           <option value="3" selected>택배/직거래</option>
                           </c:if>
                           <c:if test ="${getBoard.board_package ne '택배/직거래'}">
                             <option value="3">택배/직거래</option>
                             </c:if>
                        </select>
                     </div>
                     </td>
                     </tr>
                     <tr>
                     <td>   
                     <!-- 금액수 11자리 제한 , 천원 단위로 컴마찍기 -->
                     <div class="input-group">
                        <span class="input-group-text">가격</span>
                        <input type="text" class="form-control" name="board_price" value="${getBoard.board_price}" maxlength='11' onkeyup="inputNumberFormat(this)" >
                        <span class="input-group-text">원</span>
                     </div>
                     </td>
                     </tr>
                     <tr>
               <td>
               </table>
               </div>
                  <div class="mb-3 w-50 p-3 mx-auto p-2">
                     <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                     <p>
                        <textarea class="form-control" id="exampleFormControlTextarea1"
                           name="board_content" rows="10">${getBoard.board_content}</textarea>
                  </div>
               </td>
            </tr>
            <tr>
               <td align="center">
               <!-- 이미지 첨부 -->
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
                          <label class="input-file-button" for="btnAtt" style="margin-left: 2rem;">파일 선택</label>
                           <input type="file" id="btnAtt" multiple="multiple" class="mt-2 small" style="margin-left: 20px;" accept=".png, .jpg, .jpeg" enctype="multipart/form-data"/>
                           <div id="attZone" class="row small mt-2" style="margin-left: 20px;" data-placeholder="파일을 첨부 하려면 파일 선택 버튼을 클릭하세요"></div>
                            <c:if test="${!empty getBoard.board_img1}">
                                 <div class="col-auto" id="imgBox1" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
                                    <img src="resources/img/${getBoard.board_img1}" class="imgPreviewCrop">
                                    <button class="btn-close" onclick="deleteImgDiv(1)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
                                 </div>
                           </c:if>
                              <c:if test="${!empty getBoard.board_img2}">
                                 <div class="col-auto" id="imgBox2" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
                                    <img src="resources/img/${getBoard.board_img2}" class="imgPreviewCrop">
                                    <button class="btn-close" onclick="deleteImgDiv(2)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
                                 </div>
                           </c:if>
                              <c:if test="${!empty getBoard.board_img3}">
                                 <div class="col-auto" id="imgBox3" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
                                    <img src="resources/img/${getBoard.board_img3}" class="imgPreviewCrop">
                                    <button class="btn-close" onclick="deleteImgDiv(3)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
                                 </div>
                           </c:if>
                              <c:if test="${!empty getBoard.board_img4}">
                                 <div class="col-auto" id="imgBox4" style="display: inline-block; position: relative; width: 120px; height: 120px; margin-right: 10px;">
                                    <img src="resources/img/${getBoard.board_img4}" class="imgPreviewCrop">
                                    <button class="btn-close" onclick="deleteImgDiv(4)" type="button" style="position: absolute; right: 0px; top: 0px;"></button>
                                 </div>
                           </c:if>
                        </div>
                     </div>
                     </div>
                     <div class="col-4"></div>
                     </div>
                  </div>   
               </td>
            </tr>
            <!-- 수정 버튼 -->
            <tr>
               <td>
                  <div class="d-grid gap-2 w-50 mx-auto p-2">
                     <button class="btn btn-primary " type="button" onclick="javascript:submitform()">글수정</button>
                     <button class="btn btn-primary" type="reset">다시작성</button>
                     <button class="btn btn-primary" type="button"
                        onclick="window.location='board_secondhand.do?mode=all'">목록보기</button>
                  </div>
               </td>
            </tr>


         </table>
      </form>
   </div>
</body>
<%@include file="../user/user_bottom.jsp"%>
</html>