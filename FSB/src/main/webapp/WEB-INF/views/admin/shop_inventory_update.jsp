<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_inventory_update.jsp // 재고 수정 -->

<script type="text/javascript">
	function check() {
		if(f5.prod_qty.value==""){
			alert("수정 수량을 입력해주세요")
			return false
		}
		return true
	}
</script>


	<div align="left">
		<p>
		<h6>재고 수정</h6>

		<form name="f5" action="admin_shop_inventory_update.do" method="post" onsubmit="return check()">
		<table border="0">
			<tr align="center">
				<th>상품 번호</th>
				<th>기존 재고</th>
				<th>수정 재고</th>
			</tr>
			
				<tr align="center">
					<td>${getProd.prod_num}
					<input type="hidden" name="prod_num" value="${getProd.prod_num}"></td>
					<td style="width: 150;">${getProd.prod_qty}</td>
					<td><input type="number" name="prod_qty" style="width: 150;"></td>
				</tr>
			<tr align="right">
				<td colspan="3">
					<button class="btn btn-secondary btn-sm" type="submit">수정</button>
					<button class="btn btn-secondary btn-sm" type="button" onclick="window.location='admin_shop_inventory_list.do'">취소</button>
				</td>
			</tr>
		</table>
		</form>
	</div>