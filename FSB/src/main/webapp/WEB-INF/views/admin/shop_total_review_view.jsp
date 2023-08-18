<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- shop_total_review_view.jsp // 전체 상품 리뷰 목록 - 상세보기 -->

		<h5>리뷰 상세보기</h5>
		<div align="left">
			<h6><strong>리뷰 번호 : </strong>${getReview.sr_num}</h6>
			<h6><strong>상품 번호 : </strong>${getReview.prod_num}</h6>
			<h6><strong>작성자 : </strong>${getReview.mem_nickname}</h6>
			<h6><strong>작성일 : </strong>${getReview.sr_regdate}</h6>
			<h6><strong>별점 : </strong><img src="resources/img/star2.png" width="25" height="25">&nbsp;${getReview.sr_starrating}</h6>
		<!-- 이미지 슬라이드 -->
		<c:if
			test="${not empty getReview.sr_img1 ||not empty getReview.sr_img2||not empty getReview.sr_img3||not empty getReview.sr_img4}">
			<div id="carouselExampleIndicators" class="carousel slide p-3">
				<div class="carousel-indicators">
					<c:if test="${not empty getReview.sr_img1}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="0" class="active" aria-current="true"
							aria-label="Slide 1"></button>
					</c:if>
					<c:if test="${not empty getReview.sr_img2}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="1" aria-label="Slide 2"></button>
					</c:if>
					<c:if test="${not empty getReview.sr_img3}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="2" aria-label="Slide 3"></button>
					</c:if>
					<c:if test="${not empty getReview.sr_img4}">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="3" aria-label="Slide 4"></button>
					</c:if>
				</div>
				<!-- 이미지 여러개 -->
				<div class="carousel-inner">
					<c:if test="${not empty getReview.sr_img1}">
						<div class="carousel-item active">
							<img src="resources/img/${getReview.sr_img1}"
								class="d-block w-100 h-50">
						</div>
					</c:if>

					<c:if test="${not empty getReview.sr_img2}">
						<div class="carousel-item">
							<img src="resources/img/${getReview.sr_img2}"
								class="d-block w-100 h-50">
						</div>
					</c:if>

					<c:if test="${not empty getReview.sr_img3}">
						<div class="carousel-item">
							<img src="resources/img/${getReview.sr_img3}"
								class="d-block w-100 h-50">
						</div>
					</c:if>

					<c:if test="${not empty getReview.sr_img4}">
						<div class="carousel-item">
							<img src="resources/img/${getReview.sr_img4}"
								class="d-block w-100 h-50" >
						</div>
					</c:if>
				</div>

				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
			</c:if>
			<!-- 내용 -->
				<h6><strong>제목 : </strong>${getReview.sr_title}</h6>
				<h6><strong>리뷰 내용 : </strong>${getReview.sr_content}</h6>
	  					

			</div>