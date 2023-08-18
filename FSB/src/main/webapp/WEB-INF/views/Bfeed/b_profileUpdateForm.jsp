<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@include file="../user/user_top.jsp" %>
<!-- bpupdate.jsp -->
<script type="text/javascript">
function check() {
	if (f5.bp_location.value =="") {
		alert("주소를 입력해주세요!")
		f5.bp_location.focus()
		return
	}
	if (f5.bp_info.value == "") {
		alert("매장 정보를 입력해주세요!")
		f5.bp_info.focus()
		return
	}
	document.f5.submit()
}
</script> 
<body>
	<!-- 전체 -->
  	<main class="d-flex flex-nowrap">
  	
  		<!-- 사이드 바 -->
  		<%@include file="../user/sns_top.jsp" %>
<!-- 개인 페이지 -->
		<div id="personalDiv" class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 40%; min-width: 35rem; max-width: 45rem; display: flex;">
<!-- 프로필 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">비즈니스 프로필 관리</span></div>
			</div>
			
			
	<div class="card border-light mb-3"  style="max-width: 800x;" >
  <div class="row g-0">
      <div class="card-body">
        <h5 class="card-title">[${mem_nickname}]님의 비즈니스 프로필 수정</h5>
		<br>
		<form name="f5" action="b_profile_update.do" method="post">
		<input type="hidden" name="bp_num" value="${dto.bp_num}">
  	 
  	 <div class="input-group mb-3">
  		<input type="text" class="form-control" id="sample5_address" placeholder="주소를 입력하세요." name="bp_location" aria-label="Recipient's username" aria-describedby="button-addon2" value="${dto.bp_location }" readonly>
  		<button class="btn btn-outline-secondary" type="button" id="button-addon2"  onclick="sample5_execDaumPostcode()">주소검색</button>
	</div>
	<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">상세 주소</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" placeholder="상세 주소를 입력하세요." value="${dto.bp_d_location }" name="bp_d_location">
		</div>
	<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">매장명</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" placeholder="매장명을 입력해주세요." value="${dto.bp_store_name }" name="bp_store_name">
	</div>
	<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">매장 전화번호</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" placeholder="000-0000-0000 양식으로 입력하세요." value="${dto.bp_tel }" name="bp_tel">
	</div>
 	<div id="map" style="width:400px;height:200px;margin-top:10px;display:none"></div>
   			<br>
   	<div class="input-group">
 	 <span class="input-group-text">매장 설명란</span>
 	 <textarea class="form-control" aria-label="With textarea" placeholder="매장 정보,운영시간 등을 입력해주세요" name="bp_info">${dto.bp_info }</textarea>
	</div>
		</form>
    </div>
    </div>
    	
    <div class="card-footer text-body-secondary">
<!--   	 		<button type="submit">수정</button> -->
<div align = "center">
	<a href="javascript:check()" class="btn btn-primary" >수정</a> 
  	 		<a href="b_personalHome.do?num=${login_mem.mem_num }" class="btn btn-primary">취소</a>
    </div>
  </div>
    </div>
  </div>
	</main>
</body>	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=265d925f04bd6bf7c74e0ca951641be9&libraries=services"></script>
<div id="map" style="width:500px;height:300px;margin-top:10px;display:none"></div>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수
                type:'post';
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>

<%@include file="../user/user_bottom.jsp" %>