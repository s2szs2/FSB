<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- scoupon_insert.jsp // 쇼핑몰 쿠폰 등록폼 -->
<script type="text/javascript">
	function check() {
		if (f.sc_name.value == "") {
			alert("쿠폰 이름을 입력해주세요!")
			f.sc_name.focus()
			return false
		}
		if (f.sc_type.value == "%" && f.sc_limit.value == ""){
			alert("쿠폰 타입이 %인 경우, 최대 할인 금액을 반드시 입력해주세요!")
			f.sc_limit.focus()
			return false
		}
		if (f.sc_min.value == "") {
			alert("쿠폰 사용 조건을 입력해주세요!")
			f.sc_min.focus()
			return false
		}
		if (f.sc_discount.value == "") {
			alert("할인율 또는 할인금액을 입력해주세요!")
			f.sc_discount.focus()
			return false
		}
		if (f.sc_duedate.value == "" && document.getElementById('sc_duedate2').checked == false) {
			alert("만료일을 지정 혹은 지정하지 않음을 선택 해주세요!")
			return false
		}
		return true		
	}
</script>


<%@include file="admin_top.jsp" %>

	<!-- 쇼핑몰관리 사이드바 -->
	<%@include file="shop_sidebar.jsp" %>


	<!-- 내용  // 쿠폰 등록 -->
			<div class="container text-center">
			<p>
			<p>
			<div class="row row-cols-1" style="width: 1200px;">
					<div class="col" style="overflow: scroll; height: 800px;">
						<p class="fs-5">쿠폰 등록</p>
					<form name="f" action="admin_scoupon_insert.do" method="post" onsubmit="return check()">
						<table border="0" width="60%" height="500">
							<tr align="center">
								<th>쿠폰 이름</th>
								<td><input type="text" class="form-control" name="sc_name"></td>
							</tr>
							<tr align="center">
								<th>쿠폰 타입</th>
								<td>
									<select name="sc_type" class="form-select">
										<option value="%">할인율</option>
										<option value="-">금액</option>
										<option value="delchar">배송비 무료</option>
									</select>
								</td>
							</tr>
							<tr align="center">
								<th>최대 할인 금액</th>
								<td><input type="number" class="form-control" name="sc_limit" placeholder="숫자만 입력"><font size="2">쿠폰 타입이 % 인 경우, 필수 입력 (최대 ~원 할인 가능)</font></td>
							</tr>
							<tr align="center">
								<th>쿠폰 사용 조건</th>
								<td><input type="number" class="form-control" name="sc_min" placeholder="숫자만 입력"><font size="2">쿠폰 사용을 위한, 최소 주문 금액 입력 (~원 이상 구매시 사용 가능)</font></td>
							</tr>
							<tr align="center">
								<th>할인 금액 <br>또는 할인율</th>
								<td><input type="number" class="form-control" name="sc_discount" placeholder="숫자만 입력"></td>
							</tr>
							<tr align="center">
								<th rowspan="2">만료일</th>
								<td>
									<input type="date" name="sc_duedate" class="form-control" min ="${now}">
								</td>
							</tr>
							<tr align="left">
								<td>
									<input id ="sc_duedate2" type="checkbox" class="form-check-label" name="sc_duedate2" id="flexCheckDefault">
									<label class="form-check-label" for="flexCheckDefault">만료일 지정하지 않음</label>
								</td>
							</tr>
							<tr align="center">
								<td colspan="2">
									<button type="submit" class="btn btn-secondary btn-sm">등록</button>
									<button type="reset" class="btn btn-secondary btn-sm">다시 입력</button>
									<button type="button" class="btn btn-secondary btn-sm" onclick="window.location='admin_scoupon_list.do?sc_num=0'">취소</button>
								</td>
							</tr>
						</table>
					</form>
		    		</div>
		    	</div>
		</main>
	</div>

<%@include file="admin_bottom.jsp" %>