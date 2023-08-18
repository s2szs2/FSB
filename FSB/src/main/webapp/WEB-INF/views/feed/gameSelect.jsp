<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<head>
	<script src="resources/js/jquery-3.7.0.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/css/sidebars.css" rel="stylesheet">
	
	<script>
	function selectGame(game_num,game_name){
		opener.selectGameOK(game_num,game_name);
		self.close();
	}
	</script>
</head>
<body>
	<div align="center">
		<div align="center" class="text-bg-warning p-3"
			style="-bs-bg-opacity: .15;">보드게임 찾기</div>
		<br><br>
		<div class="d-flex justify-content-center">
			<nav class="navbar bg-body-tertiary">
				<div class="container-fluid">
					<form class="d-flex" role="search" action="feed_game_find.do"
						method="post">
						<input class="form-control me-2" type="search" name="searchString" placeholder="검색어 입력" aria-label="searchString">
						<button class="btn btn-outline-warning" name="search" type="submit">Search</button>
					</form>
				</div>
			</nav>
		</div>
		<br>
		<p>
			<button class="btn btn-outline-primary" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapseWidthExample"
				aria-expanded="false" aria-controls="collapseWidthExample">
				상세보기
			</button>
		</p>
		<div style="min-height: 300px;">
			<div class="collapse collapse-horizontal" id="collapseWidthExample">
				<div class="card card-body" style="width: 90%;">
					<form name="f" action="feed_game_checkFind.do" method="post">
						<table width="100%">
							<tr height="70" align="center">
								<th>테마별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
								<c:forEach var="tdto" items="${listTheme}">
									<td><input type="checkbox" name="theme"	value="${tdto.theme_num}"> ${tdto.theme_name}</td>
								</c:forEach>
							</tr>
							<tr height="70" align="center">
								<th>인원별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
								<td align="center" colspan="2"><input type="checkbox" name="game_player" value="1"> 1인</td>
								<td align="center" colspan="2"><input type="checkbox" name="game_player" value="2"> 2~4인</td>
								<td align="center" colspan="2"><input type="checkbox" name="game_player" value="3"> 5~6인</td>
								<td align="center" colspan="2"><input type="checkbox" name="game_player" value="4"> 7인 이상</td>
							</tr>
							<tr height="70" align="center">
								<th>난이도별&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="vr"></div></th>
								<td colspan="2">
									<input type="checkbox" name="game_level" value="1"> 
									<c:forEach begin="1" end="1">
										<img src="resources/img/fire.png" width="15" height="15">
									</c:forEach>
								</td>
								<td>
									<input type="checkbox" name="game_level" value="2">
									<c:forEach begin="1" end="2">
										<img src="resources/img/fire.png" width="15" height="15">
									</c:forEach>
								</td>
								<td><input type="checkbox" name="game_level" value="3">
									<c:forEach begin="1" end="3">
										<img src="resources/img/fire.png" width="15" height="15">
									</c:forEach></td>
								<td><input type="checkbox" name="game_level" value="4">
									<c:forEach begin="1" end="4">
										<img src="resources/img/fire.png" width="15" height="15">
									</c:forEach></td>
								<td><input type="checkbox" name="game_level" value="5">
									<c:forEach begin="1" end="5">
										<img src="resources/img/fire.png" width="15" height="15">
									</c:forEach></td>
								<td colspan="2" align="center">
									<button type="submit" class="btn btn-outline-dark">검색하기</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<br>
			<ul class="nav nav-pills nav-fill">
				<li class="nav-item"><a id="nav" class="nav-link d-block-flex focus-ring py-3 px-4 text-decoration-none border rounded-2" aria-current="page" href="feed_game_sort.do?sort=game_name">이름 순</a></li>
				<li class="nav-item"><a id="nav" class="nav-link d-block-flex focus-ring py-3 px-4 text-decoration-none border rounded-2" href="feed_game_sort.do?sort=game_player">인원 순</a></li>
				<li class="nav-item"><a id="nav" class="nav-link d-block-flex focus-ring py-3 px-4 text-decoration-none border rounded-2" href="feed_game_sort.do?sort=game_starrating">별점 순</a></li>
				<li class="nav-item"><a id="nav" class="nav-link d-block-flex focus-ring py-3 px-4 text-decoration-none border rounded-2" href="feed_game_sort.do?sort=game_likeCount">좋아요 순</a></li>
			</ul>
			<br>

			<c:if test="${empty listGame}">
				등록된 게임이 없습니다.
			</c:if>
			<c:if test="${not empty listGame}">
				<div class="row row-cols-3">
					<c:forEach var="dto" items="${listGame}">

						<div class="col">
							<div class="card mb-3" style="max-width: 500px;">
								<div class="row g-0">
									<div class="col-md-4">
										<img src="resources/img/${dto.game_img}" class="img-fluid rounded-start" onclick="selectGame(${dto.game_num},'${dto.game_name}')">
									</div>
									<div class="col-md-8">
										<div class="card-body">
											<h4 class="card-title">${dto.game_name}</h4>
											<p class="card-text"></p>
											<p class="card-text">
												<small class="text-body-secondary">사진을 누르면 게임을 태그합니다.</small>
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>

					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>

	<script src="resources/js/bootstrap.bundle.min.js"></script>
	<script src="resources/js/sidebars.js"></script>
</body>
