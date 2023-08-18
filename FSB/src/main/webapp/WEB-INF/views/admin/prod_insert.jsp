<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- prod_insert.jsp // 상품 등록 -->
<script type="text/javascript">
	function check() {
		if (f.game_num.value == "") {
			alert("판매할 게임을 선택해주세요!")
			return false
		}
		if (f.prod_price.value == "") {
			alert("상품 가격을 입력해주세요!")
			f.prod_price.focus()
			return false
		}
		if (f.prod_qty.value == "") {
			alert("상품 재고를 입력해주세요")
			f.prod_qty.focus()
			return false
		}
		if (f.prod_delchar.value == "") {
			alert("배송비를 입력해주세요")
			f.prod_delchar.focus()
			return false
		}
		if (f.prod_company.value == "") {
			alert("판매사를 입력해주세요")
			f.prod_company.focus()
			return false
		}
		if (f.prod_img.value == "") {
			alert("상세이미지를 선택해주세요")
			f.prod_img.focus()
			return false
		}
		return true		
	}
</script>

<%@include file="admin_top.jsp" %>

	<!-- 쇼핑몰관리 사이드바 -->
	<%@include file="shop_sidebar.jsp" %>
	
	<!-- 내용  // 상품 등록 -->
			<div class="container text-center">
			<p>
			<p>
			<div class="row row-cols-1" style="width: 800px;">
			    	<div class="col">
			    		<p class="fs-5">상품 등록</p>
			    		<font size="2" color="red">📢보드게임 등록 후, 상품 등록 가능</font>
			    	</div>
			    	<p>
					<div class="col" style="overflow: scroll; height: 800px;">
						<form name="f" action="admin_prod_insert.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
						<table border="0" width="60%" height="80%" align="center">
							<tr>
								<th width="30%" align="center">게임 선택</th>
								<td width="70%">
									<select name="game_num" class="form-select">
										<c:forEach items="${listNotProdGame}" var="dto">
											<option value="${dto.game_num}">${dto.game_name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th align="center">상품 가격</th>
								<td><input type="number" class="form-control" name="prod_price" placeholder="숫자만 입력 (단위 : 원)"><font size="2" color="red">가격의 10%로 포인트 적용</font></td>
							</tr>
							<tr>
								<th align="center">상품 재고</th>
								<td><input type="number" class="form-control" name="prod_qty" placeholder="숫자만 입력 " ></td>
							</tr>
							<tr>
								<th align="center">상품 배송비</th>
								<td><input type="number" class="form-control" name="prod_delchar" placeholder="숫자만 입력 (단위 : 원)"></td>
							</tr>
							<tr>
								<th align="center">상품 판매사</th>
								<td><input type="text" class="form-control" name="prod_company"></td>
							</tr>
							<tr>
								<th align="center">상품 상세 이미지</th>
								<td><input type="file" class="form-control" name="prod_img"></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<button type="submit" class="btn btn-secondary btn-sm">등록</button>
									<button type="reset" class="btn btn-secondary btn-sm">다시 입력</button>
									<button type="button" class="btn btn-secondary btn-sm" onclick="window.location='admin_prod_list.do?mode=all&sort=all'">취소</button>
								</td>	
							</tr>
						</table>
						</form>
					</div>
		    	</div>
		</main>
	</div>

<%@include file="admin_bottom.jsp" %>