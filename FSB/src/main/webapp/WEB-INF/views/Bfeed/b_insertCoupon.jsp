<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- css 파일 연결하기 -->
<script src="resources/js/jquery-3.7.0.js">
</script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<!-- 	<script src="resources/js/bootstrap.min.js"></script> -->
<script src="resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- insert_coupon.jsp -->
<script type="text/javascript">
	function check(){
	if(f.bc_title.value ==""){
		alert("쿠폰 이름을 입력해주세요!")
		f.bc_title.focus()
		return
	}
	if(f.bc_content.value==""){
		alert("쿠폰 내용을 입력해주세요!")
		f.bc_content.focus()
		return
	}
	if(f.bc_qty.value==""){
		alert("수량을 입력해주세요!")
		f.bc_qty.focus()
		return
	}
	if (f.bc_duedate.value == "" && f.bc_duedate2.value !== "1") {
        alert("만료일을 지정해주세요!")
        return
     }
		document.f.submit()
	}
</script>
<!-- 내용  // 쿠폰 등록 -->
<div class="container text-center">
	<form name="f" action="insert_bcoupon.do" method="post">
	<input type="hidden" name="bp_num" value="${bp_num }">
	<input type="hidden" name= "mem_num" value="${mem_num }">
		<table class="table">
			<thead>
				<tr align="center">
					<th scope="col" colspan="3">🏷️비즈니스 쿠폰 발행🏷️</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">쿠폰 이름</th>
					<td colspan="2"><input type="text" class="form-control"	name="bc_title" placeholder="쿠폰의 이름을 불러주세요"></td>
				</tr>
				<tr>
					<th scope="row">쿠폰 설명</th>
					<td colspan="2"><textarea class="form-control" placeholder="ex) 보드게임 1시간 무료 150자 이내" aria-label="With textarea" name="bc_content" maxlength='150'></textarea></td>
				</tr>
				<tr>
					<th scope="row">쿠폰 수량</th>
					<td colspan="2"><input type="number" class="form-control" name="bc_qty" min="0" step="5"></td>
				</tr>
				<tr>
					<th scope="row" rowspan="2">만료일</th>
					<td><input type="date" name="bc_duedate" class="form-control" min="${now}"></td>
					<td><input type="checkbox" value="1" class="form-check-label"	name="bc_duedate2" id="flexCheckDefault"> 
					<label class="form-check-label" for="flexCheckDefault">만료일 지정하지 않음</label></td>
				</tr>
				<tr>
					<th scope="row"></th>
					<td colspan="2">
						<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:check()">등록</button>
						<button type="reset" class="btn btn-secondary btn-sm">다시 입력</button>
						<button type="button" class="btn btn-secondary btn-sm"
							onclick="javascript:self.close()">취소</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>


