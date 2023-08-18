<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- game_list.jsp -->

<%@include file="admin_top.jsp" %>

<!-- 삭제 script -->
<script type="text/javascript">
	function checkDel(game_num, game_img){
		var isDel = window.confirm("정말로 삭제하겠습니까?")
		if (isDel){
			document.f.game_num.value = game_num
			document.f.game_img.value = game_img
			document.f.submit()
		}
	}
</script>

	<!-- 보드게임 사이드바 -->
	<%@include file="game_sidebar.jsp" %>

		<!-- 내용  // 보드게임 목록-->
			<div class="container text-center">
			<p>
			<p>
				<div class="row row-cols-1" style="width: 800px;">
			    	<div class="col">
			    		<p class="fs-5">보드게임 목록</p>
			    	</div>
			    	<p>
		    		<div class="col">
		    			<form name="f2" action="admin_game_list.do" method="post">
					<input type="hidden" name="mode" value="find">
					<select name="search">
						<option value="game_name">게임 이름</option>
					</select>
					<input type="text" name="searchString">
					<button class="btn btn-secondary btn-sm" type="submit">찾기</button>
						</form>
						<div align="right"><font size="2" color="red">📢게임 이미지를 누르면, 상세보기로 이동합니다</font>&nbsp;&nbsp;<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_game_list.do'">
							전체 목록 보기</button>
						</div>
					</div>
					<div class="col" style="overflow: scroll; height: 800px;">
					<table class="table table-hover table-bordered table align-middle" width="60%" height="80%">
					<thead class="table-light">
					<tr align="center">
						<th width="10%" height="50">#</th>
						<th width="35%">이름</th>
						<th width="35%">이미지</th>
						<th width="10%">수정</th>
						<th width="10%">삭제</th>
					</tr>
					</thead>
					<tbody>
					<c:if test="${empty listGame}">
						<tr>
							<td colspan="5">등록된 보드게임이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty listGame}">
					<c:forEach items="${listGame}" var="dto">
						<tr align="center">
							<td  height="200">${dto.game_num}</td>
							<td>${dto.game_name}</td>
							<td><a href="admin_game_view.do?mode=all&game_num=${dto.game_num}"><img src="resources/img/${dto.game_img}" width="150" height="150"></a></td>
							<td><a href="admin_game_update.do?game_num=${dto.game_num}">수정</a></td>
							<td><a href="javascript:checkDel('${dto.game_num}','${dto.game_img}')">삭제</a></td>
						</tr>
					</c:forEach>
					</c:if>
					</tbody>
				</table>
				<form name="f" action="admin_game_delete.do" method="post">
					<input type="hidden" name="game_num"/>
					<input type="hidden" name="game_img"/>
				</form>
		    		</div>
		    	</div>
		    </div>
		</main>
	</div>

<%@include file="admin_bottom.jsp" %>