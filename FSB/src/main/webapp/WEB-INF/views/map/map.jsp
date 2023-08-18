	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<%@include file="../user/user_top.jsp"%>
<style>
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}
</style>
<div class="row row-cols-2">
	<div class="col vertical-right-line flex-shrink-0 p-3 bg-white"
		style="width: 20%; height: 500px;">
		<%@include file="../map/mapListBox.jsp"%>
	</div>

	<div class="col" style="width: 80%; height: 800px;" align="center">

		<div id="map" style="width: 95%; height: 90%;"></div>
	</div>
</div>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=265d925f04bd6bf7c74e0ca951641be9&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도의 중심좌표
	mapOption = {
		center : new kakao.maps.LatLng(37.655798132203394, 127.06228085698994), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	//주소-좌표 변환 객체를 생성합니다 라이브러리 src 필요함!
	var geocoder = new kakao.maps.services.Geocoder();

	//주소로 좌표를 검색합니다 검색어를 주소 api 에서 받아서 디비에 저장하고 리스트로 뽑아서 불러옴
	geocoder.addressSearch('${bdto.bp_location}',function(result, status) {
						var x= null;
						var y= null;
						
						
						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(result[0].y,result[0].x); // 위도 경도
							y = result[0].y
							x= result[0].x
							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : coords
							// 위에서 받은 위도경도 좌표 담김
							});
							//인포 윈도우에 담을 내용 
							var content = '<div class="wrap">'
									+ '    <div class="info">'
									+ '        <div class="title">'
									+ '            ${bdto.bp_store_name}'
									+ '        </div>'
									+ '        <div class="body">'
									+ '            <div class="img">'
									+ '                <img src="resources/img/${pimage}" width="73" height="70">'
									+ '           </div>'
									+ '            <div class="desc">'
									+ '                <div class="ellipsis">🚩${bdto.bp_location}&nbsp;${bdto.bp_d_location}</div>'
									+ '                <div class="ellipsis">📞${bdto.bp_tel}&nbsp;&nbsp;⭐${bdto.bp_starrating}/5.0</div>'
									+ '                <div>🗺️<a href="https://map.kakao.com/link/map/${bdto.bp_store_name},'+y+','+x+'," style="color:blue" target="_blank">큰지도보기</a></div>'
									+ '            </div>' + '</div>'
									+ '    </div>' + '</div>';

									
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							var overlay = new kakao.maps.CustomOverlay({
								content : content, // 위에 적은 내용 담기
								map : map,
								position : marker.getPosition()
							});
							 // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
							kakao.maps.event.addListener(marker, 'click', function() {
								overlay.setMap(map);
							});
						}
						
						//지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
					});
		
</script>
