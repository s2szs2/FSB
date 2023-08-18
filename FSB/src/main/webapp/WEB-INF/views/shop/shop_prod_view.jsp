<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_prod_view.jsp 쇼핑몰 상품 상세정보 sidevar -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 좋아요 버튼에 마우스 커서 가져다 대면 바뀔 css -->
<style>
	.like {
		width: 400px;
        margin: 0px auto;
        position: relative
    }
    
    .like-3 {
    	position: absolute;
        bottom: 0px;
        right: 187px;
        display: none;
    }
	.like:hover .like-3 {
		display: block;
	}
</style>

<script type="text/javascript">
   function checkLogin() {
      alert("회원 전용 입니다. 로그인 후 이용해 주세요.")
    }
   
   function coupon() {
      alert("보유한 쿠폰입니다. 마이페이지에서 확인해 주세요.")
   }
   function prodLike(prod_num){
		$.ajax({
		    url:'shop_prodLike.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'prod_num': prod_num},  //보낼 데이터 (json 형식)
		    success: function(data) {
		   		/* alert("성공"); */
		   		location.reload();
		    },
		    error: function(err) {
		    	/* alert("ajax 게임좋아요 실패 누르지마세요");  */
		    	location.reload();
		    }
		});
	} 
	
	function deleteLike(prod_num, mode) {
		$.ajax({
		    url:'shop_deleteLike.do', //request 보낼 서버의 경로
		    type:'get', // 메소드(get, post, put 등)
		    data:{'prod_num': prod_num, 'mode' : mode},  //보낼 데이터 (json 형식)
		    success: function(data) {
		   		/* alert("성공"); */
		   		location.reload();
		    }, 
		    error: function(err) {
		    	/* alert("ajax 게임좋아요 실패 누르지마세요"); */
		    	location.reload();
		    }
		});
	}
	function goCart(){
		f.action="shop_insertCart.do;"
		f.submit();
	}
	function goOrder(){
		f.action="shop_viewOrder.do";//현재 상품만 주문
		f.submit();
	}
</script>

<!-- 쇼핑몰 상세페이지 상품정보 top ※다원이 sns_top과 timeLine 참고-->
<div class="vertical-center-line flex-shrink-0 p-3 bg-white" style="width: 100%;">
<!-- ★★★ 센터로 보내는 div class ★★★ -->
<div class="d-flex justify-content-center">
	<div class="container px-5 py-3 bg-light border-bottom" id="featured-view1">
		<div class="row justify-content-center">
			<div class="col-9 pb-2">
			<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
			  <ol class="breadcrumb">
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="user_main.do">
			    	<font color="#4D4D4D"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
					  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5Z"/>
					  <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
					</svg>
			    	Home</font>
			    </a></li>
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_main.do"><font color="#4D4D4D">쇼핑몰</font></a></li>
			    <li class="breadcrumb-item active" aria-current="page"><a class="link-body-emphasis fw-semibold text-decoration-none" href="shop_view.do?prod_num=${getProd.prod_num}"><font color="#4D4D4D">상품상세</font></a></li>
			  </ol>
			</nav>
			<hr>
			</div>
			<div class="col-4">
				<img src="resources/img/${getProd.game_img}" width="95%" height="380">
			</div>
			<div class="col-5 py-1" style="height:350px;">
				<h5><b>[${getProd.prod_company}] ${getProd.game_name}</b></h5>
				<div style="overflow: scroll; height: 60px;"><h6>${getProd.game_content}</h6></div>
				<c:if test="${reviewAvg eq null}">
				<h6>
					<c:forEach begin="1" end="5">
		           	 <img src="resources/img/star1.png" width="20" height="20">	
		            </c:forEach>				
				</h6>
				</c:if>
				<c:if test="${reviewAvg ne null}">
				<h6>
				<c:forEach var="i" begin="1" end="5">
					<c:if test="${(reviewAvg - i) >= 0}">
						<img src="resources/img/star2.png" width="25" height="25">
	  				</c:if>
	  				<c:if test="${(reviewAvg - i) <0}">
	  					<img src="resources/img/star1.png" width="25" height="25">
	  				</c:if>
	  			</c:forEach>
				</h6>
				</c:if>
				<c:if test="${getProd.prod_discount eq 0}">
				<h5><font size="3">정상가</font> <font color="red"  size="4"><b>${sessionScope.df.format(getProd.prod_price)}</b>원</font></h5>
				</c:if>
				<c:if test="${getProd.prod_discount > 0}">
				<h6><font color="red" size="3">할인가</font> <font color="red" size="4"><b>${getProd.prod_discount}% ${sessionScope.df.format(getProd.prod_price*(1-getProd.prod_discount/100))}원</b></font> <del>${sessionScope.df.format(getProd.prod_price)}</del>원</h6>
				</c:if>
				<h6><font color="blue">구매적립금 ${getProd.prod_point}원 적립</font></h6>
				<h6><font color="green">리뷰적립금 300원 적립</font></h6>
				<h6>배송비 50,000원 이상 무료배송</h6>
				<hr>
				테마별&nbsp&nbsp&nbsp&nbsp&nbsp
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(255,216,216);">#추리</button></a>
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(250,244,192);">#전략</button></a>
				<br>
				인원수&nbsp&nbsp&nbsp&nbsp&nbsp
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(217,229,255);">#1인</button></a>
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(232,217,255);">#2~4인</button></a>
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(234,234,234);">#5~6인</button></a>
				<br>
				난이도&nbsp&nbsp&nbsp&nbsp&nbsp								
				<a href="#"><button type="button" class="btn btn-sm" style="--bs-btn-padding-y: .13rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .90rem; background: rgb(250,244,192);">#<img src="resources/img/fire.png" width="20" height="20"><img src="resources/img/fire.png" width="20" height="20"></button></a>
				<hr>
			</div>
		</div>
		<div class="row justify-content-center">
         <div class="col-4">
         <br>
            <div align="center">
            <p>
                <button class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseWidthExample" aria-expanded="false" aria-controls="collapseWidthExample">
                   전체 쿠폰 다운 받기
              </button>
         </p>
            <div style="min-height: 100px;">
              <div class="collapse collapse-horizontal" id="collapseWidthExample">
                <div class="card card-body" style="width: 300px;">
                     <c:if test="${empty sessionScope.mbId }">   
                        <c:forEach var="clist" items="${couponList }">
                           ${clist.sc_name }
                           <a href="javascript:checkLogin()">
                              <button type="button" class="btn btn-outline-primary btn-sm">다운로드</button>
                           </a>
                        </c:forEach>
                     </c:if>
                     <c:if test="${not empty sessionScope.mbId }">
                        <c:forEach var="mylist" items="${myPageCoupon }">
                           ${mylist.sc_name }
                        <a href="javascript:coupon()"><button type="button" class="btn btn-outline-primary btn-sm" disabled>다운로드</button></a>
                      </c:forEach>
                        <c:forEach var="exlist" items="${exlist }">
                           ${exlist.sc_name }
                        <a href="shop_couponDownload.do?sc_num=${exlist.sc_num }&prod_num=${getProd.prod_num}"><button type="button" class="btn btn-outline-primary btn-sm">다운로드</button></a>
                      </c:forEach>
                     </c:if>
                </div>
              </div>
            </div>
            </div>
         </div>

			<div class="col-5 py-2" style="height:200px;">
				<table border="1" width="100%">
					<tr height="35" valign="middle">
						<td align="center" width="33%">주문수량</td>
						<td width="20%"> </td>
						<td align="right" width="47%" valign="middle">
                  <form name="f" method="post">
                  	<input type="number" name="cart_qty" value="1" min="0" max="100" maxLength="2" step="1">
<!--                      <div class="input-group input-group-sm">
                       <button class="btn btn-outline-secondary" type="button" onclick="javascript:updateQty()">-</button>
                       <input type="text" name="cart_qty" id="cart_qty" value="1" class="form-control" placeholder="1" aria-label="cart_qty"  aria-describedby="button-addon2">
                       <button class="btn btn-outline-secondary" type="button" onclick="javascript:updateQty()">+</button>
                     </div> -->
                     <input type="hidden" name="prod_num" value="${getProd.prod_num}">
                     <input type="hidden" name="game_num" value="${getProd.game_num}">  
                     <input type="hidden" name="mem_num" value="${mem_num}"> 
                  </form>
						</td>
					</tr>
					<!-- 이걸로 안되면 위에서 script:getTotal()메소드로 실행해주기 -->
					<c:set var="totalPrice" value="${getProd.prod_price * cart_qty}"/>
					<tr height="35">
						<td align="center" width="33%">총 금액</td>
						<td width="33%"> </td>
						<td id="totalPrice" align="right" width="33%">${sessionScope.df.format(getProd.prod_price)}원 </td>
					</tr>
				</table>
				<table border="0">
					<tr>
						<td align="center" width="21.8%">
							<c:if test="${isLogin=='true'}">
							<div class="like">
							<!-- 누르면 꽉찬 하트로 변경하고 f_shop_like에 저장 -->
							<a href="javascript:prodLike('${getProd.prod_num}')">
								<c:if test="${like eq 0}">	<!-- 해당 회원의 상품찜하기가 없다면 빈하트 -->
									<img src="resources/img/like2.png" width="24" height="25" class="like-2">
									<img src="resources/img/like3.png" width="26" height="26" class="like-3">
								</c:if>
							</a>
							</div>
							<div class="like">
							<!-- 누르면 빈 하트로 변경하고 f_shop_like에서 삭제 -->
							<a href="javascript:deleteLike('${getProd.prod_num}','view')">
								<c:if test="${like eq 1}">	<!-- 해당 회원의 상품찜하기가 있다면 꽉찬하트 -->
									<img src="resources/img/like3.png" width="25" height="25" class="like-2">
									<img src="resources/img/like2.png" width="26" height="26" class="like-3">							
								</c:if>
							</a>
							</div>
							<br>${likeCount} <a href="shop_listLike.do?mem_num=${mem_num}">찜한상품</a>
							</c:if>
							<c:if test="${isLogin=='false'}">
								<font color="gray">
									<svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
									  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
									</svg><br>${likeCount}
								</font>
							</c:if>
						</td>
						<c:set var="isLogin" value="false"/>
						<c:if test="${not empty mbId or not empty mbName or not empty kname}">
						<c:set var="isLogin" value="true"/>
						</c:if>
						<td>
						<div class="container text-center">
						<div class="row mx-auto">
						<c:if test="${isLogin=='true'}">
							<button class="btn btn-outline-dark" type="button" onclick="javascript:goCart()">장바구니</button>
						</c:if>
						<c:if test="${isLogin=='false'}">
							<button class="btn btn-outline-dark" type="button" onclick="javascript:checkLogin()">장바구니</button>
						</c:if>
						</div>
						</div>
						</td>
						<td>
						<div class="container text-center">
						<div class="row mx-auto">
						<c:if test="${isLogin=='true'}">
							<button class="btn btn-outline-dark" type="button" onclick="javascript:goOrder()">구매하기</button>
						</c:if>
						<c:if test="${isLogin=='false'}">
							<button class="btn btn-outline-dark" type="button" onclick="javascript:checkLogin()">구매하기</button>
						</c:if>
						</div>
						</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-9">
			<hr>
			   <ul class="nav nav-tabs">
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="shop_view.do?prod_num=${getProd.prod_num}">상세정보</a>
		       </li>
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="shop_view2.do?prod_num=${getProd.prod_num}">상품리뷰</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="shop_view3.do?prod_num=${getProd.prod_num}">배송/반품/교환</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="shop_view4.do?prod_num=${getProd.prod_num}">Q&A</a>
		        </li>
			   </ul>		
			</div>
		</div>
