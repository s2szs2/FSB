<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   

<!-- shop_top.jsp -->
<script type="text/javascript">
   function checkLogin(){
      alert("회원 전용 입니다. 로그인 후 이용해 주세요.")
      
    }
</script>

<html>
<head>
<title>FSB 쇼핑몰(사용자)</title>
   <!-- css 파일 연결하기 -->
   <script src="resources/js/jquery-3.7.0.js"></script>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="resources/css/bootstrap.min.css" rel="stylesheet">
   <link href="resources/css/utilities.min.css" rel="stylesheet">
   <script src="resources/js/bootstrap.bundle.min.js"></script>
<!--<script src="resources/js/bootstrap.min.js"></script>-->
</head>
<body>
<nav class="navbar bg-body-tertiary fixed-top bg-white border-bottom" style="height: 85;">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
	<div class="position-absolute start-50"><a href="shop_main.do"><img src="resources/img/logo1.png" alt="로고사진" width="80" height="80"></a></div>
		<!-- 오른쪽 끝으로 네비게이션바 - 회원가입|로그인|장바구니|메인페이지 -->
   <ul class="nav justify-content-end">	

		<!-- 로그인됐을 때 로그아웃으로 변경 -->
        <c:set var="isLogin" value="false"/>
		<c:if test="${not empty mbId or not empty mbName or not empty kname}">
		<c:set var="isLogin" value="true"/>
		</c:if>
	
	   <c:if test="${isLogin=='true' and not empty loginMode and empty naverLogin}">
	     <li class="nav-item">            
	      <a class="nav-link" href="logout.do">로그아웃</a>
	      </li>
	   </c:if>

	   <c:if test="${isLogin=='true' and empty loginMode and empty naverLogin}">
	     <li class="nav-item">            
	      <a class="nav-link" href="kakaologout.do?access_Token=${sessionScope.access_Token}">로그아웃</a>
	      </li>
	   </c:if>
	   
	   <c:if test="${isLogin=='true' and empty loginMode and not empty naverLogin}">
	   	<li class="nav-item">            
	      <a class="nav-link" href="naverLogout.do">로그아웃</a>
	     </li>
	   </c:if>
	   
	   <c:if test="${isLogin=='false'}">
	        <li class="nav-item">
	      <a class="nav-link" href="login.do">로그인</a>
	      </li>
	   </c:if> 

		<c:if test="${isLogin=='true'}">
        	<li class="nav-item"><a class="nav-link active" aria-current="page" href="shop_listCart.do?mem_num=${mem_num}">장바구니</a></li>
        </c:if>
        <c:if test="${isLogin=='false'}"> </c:if>
        <li class="nav-item"><a class="nav-link" href="user_main.do">사용자페이지</a></li>        
   </ul>
    <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel"><a href="shop_main.do"><img src="resources/img/logo1.png" alt="로고사진" width="70" height="70"></a></h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
	    <form class="d-flex" role="search" action="prod_find.do" method="post">
	      <input class="form-control me-2" name="searchString" type="search" placeholder="검색" aria-label="Search">
			<button name="search" value="search" type="submit" class="btn btn-secondary">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			 	 <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
				</svg>
			</button>
        </form>
        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
          <li class="nav-item">
            <h5><a class="nav-link active" aria-current="page" href="shop_main_best.do">인기 보드게임</a></h5>
          </li>
          <li class="nav-item dropdown">
            <h5><a class="nav-link active dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              	전체 카테고리
            </a></h5>
            <ul class="dropdown-menu show">
            <c:forEach var="tdto" items="${listTheme}">
				<li><a class="dropdown-item" href="shop_cateFind.do?theme_num=${tdto.theme_num }" >${tdto.theme_name }></a></li>
			</c:forEach>
                          
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="shop_cateFind2.do?game_player=1">1인</a></li>
              <li><a class="dropdown-item" href="shop_cateFind2.do?game_player=2">2~4인</a></li>              
              <li><a class="dropdown-item" href="shop_cateFind2.do?game_player=3">5~6인</a></li>
              <li><a class="dropdown-item" href="shop_cateFind2.do?game_player=4">7인 이상</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="shop_cateFind3.do?game_level=1">
              	<img src="resources/img/fire.png" width="20" height="20">
              </a></li>
              <li>
              	<a class="dropdown-item" href="shop_cateFind3.do?game_level=2">
              		<c:forEach begin="1" end="2">
              			<img src="resources/img/fire.png" width="20" height="20">
              		</c:forEach>
              	</a>
              </li>              
              <li>
              	<a class="dropdown-item" href="shop_cateFind3.do?game_level=3">
              		<c:forEach begin="1" end="3">
              			<img src="resources/img/fire.png" width="20" height="20">
              		</c:forEach>              
              	</a>
              </li>
              <li>
              	<a class="dropdown-item" href="shop_cateFind3.do?game_level=4">
              		<c:forEach begin="1" end="4">
              			<img src="resources/img/fire.png" width="20" height="20">
              		</c:forEach>              
              	</a>
              </li>
              <li>
              	<a class="dropdown-item" href="shop_cateFind3.do?game_level=5">
              		<c:forEach begin="1" end="5">
              			<img src="resources/img/fire.png" width="20" height="20">
              		</c:forEach>              
              	</a>
              </li>
            </ul>
          </li>
        <c:if test="${empty sessionScope.mbId }">
           <li class="nav-item"><h5><a class="nav-link active" aria-current="page" href="javascript:checkLogin()">마이페이지</a></h5></li>
        </c:if>
        <c:if test="${not empty sessionScope.mbId }">
           <li class="nav-item"><h5><a class="nav-link active" aria-current="page" href="user_shop_myPage.do">마이페이지</a></h5></li>
        </c:if>
        </ul>
		<br><br><br><br><br>
      </div>
    </div>
  </div>
</nav>
<br><br><br><br><br>
</body>
</html>