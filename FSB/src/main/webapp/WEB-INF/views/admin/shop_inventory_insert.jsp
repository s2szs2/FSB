<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- shop_inventory_insert.jsp // 재고 등록 폼 -->
<script type="text/javascript">
	function check() {
		if(f5.prod_num1.value == "" && f5.prod_qty1.value =="" && f5.prod_num2.value == "" && f5.prod_qty2.value =="" && f5.prod_num3.value == "" && f5.prod_qty3.value =="" && f5.prod_num4.value == "" && f5.prod_qty4.value =="" && f5.prod_num5.value == "" && f5.prod_qty5.value ==""){
			alert("내용을 입력해주세요")
			return false
		}
		if (f5.prod_num1.value != "" && f5.prod_qty1.value == "") {
			alert("추가 수량을 입력해주세요")
			return false
		}else{
			if(f5.prod_num1.value == "" && f5.prod_qty1.value != ""){
				alert("상품 번호를 입력해주세요")
				return false
			}
		}
		if (f5.prod_num2.value != "" && f5.prod_qty2.value == "") {
			alert("추가 수량을 입력해주세요")
			return false
		}else{
			if(f5.prod_num2.value == "" && f5.prod_qty2.value != ""){
				alert("상품 번호를 입력해주세요")
				return false
			}
		}
		if (f5.prod_num3.value != "" && f5.prod_qty3.value == "") {
			alert("추가 수량을 입력해주세요")
			return false
		}else{
			if(f5.prod_num3.value == "" && f5.prod_qty3.value != ""){
				alert("상품 번호를 입력해주세요")
				return false
			}
		}
		if (f5.prod_num4.value != "" && f5.prod_qty4.value == "") {
			alert("추가 수량을 입력해주세요")
			return false
		}else{
			if(f5.prod_num4.value == "" && f5.prod_qty4.value != ""){
				alert("상품 번호를 입력해주세요")
				return false
			}
		}
		if (f5.prod_num5.value != "" && f5.prod_qty5.value == "") {
			alert("추가 수량을 입력해주세요")
			return false
		}else{
			if(f5.prod_num5.value == "" && f5.prod_qty5.value != ""){
				alert("상품 번호를 입력해주세요")
				return false
			}
		}
		return true
	}
</script>


	<div align="left">
		<p>
		<h6>재고 등록</h6>
		<font size="2" color="red">최대 5개씩 등록 가능합니다.</font>
		<br>
		<form name="f5" action="admin_shop_inventory_insert.do" method="post" onsubmit="return check()">
		<table border="0">
			<tr align="center">
				<th>#</th>
				<th>상품 번호</th>
				<th>추가재고</th>
			</tr>
			<c:set var="i" value="1"/>
			<c:forEach begin="1" end="5">
				<tr align="center">
					<td>${i}</td>
					<td>
						<select name="prod_num${i}" style="width: 200;">
							<option value="">선택</option>
							<c:forEach items="${listProd}" var="dto">
								<option value="${dto.prod_num}">${dto.prod_num}</option>
							</c:forEach>
						</select>
					</td>
					<td><input type="number" name="prod_qty${i}" style="width: 200;"></td>
				</tr>
				<c:set var="i" value="${i+1}"/>
			</c:forEach>
			<tr align="right">
				<td colspan="3">
					<button class="btn btn-secondary btn-sm" type="submit">등록</button>
					<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_shop_inventory_list.do'">취소</button>
				</td>
			</tr>
		</table>
		</form>
	</div>