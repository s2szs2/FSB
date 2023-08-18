<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!-- b_couponView.jsp -->
<link href="resources/css/bootstrap-grid.min.css" rel="stylesheet">
<link href="resources/css/bootstrap-grid.rtl.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery-3.7.0.js"></script>


<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white"
	style="width: 500px;">
	<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
		<div class="col" align="left">
			<span class="link-dark text-decoration-none fs-5 fw-semibold">&nbsp;&nbsp;</span>
		</div>    
	</div>
	<c:forEach var="dto" items="${dto}">
	<c:forEach var="mdto" items="${mdto}">
	<form id="f" name="f" action="javascript:useBcoupon()">
		<input type="hidden" name="bp_num" value="${dto.bp_num }">
		<input type="hidden" name="bc_num" value="${dto.bc_num }">
		<input type="hidden" name="mem_num" value="${mdto.mem_num }">
		<input type="hidden" name="bc_duedate" value="${dto.bc_duedate }">
		<input type="hidden" name="bc_using" value="${bc_using}">
		
	<table class="table table-borderless" >
	
		<thead>
			<tr align="center">
				<td colspan="6"><strong>쿠폰 정보</strong></td>
			</tr>
		</thead>
	<tr>
	<td>
		<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">쿠폰명</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" name="bc_title"value="${dto.bc_title }" readonly>
		</div>
		</td>
		</tr>
		<tr>
		<td>
		<div class="input-group">
			<span class="input-group-text">쿠폰내용</span>
			<textarea class="form-control" aria-label="With textarea" name="bc_content" readonly>${dto.bc_content}</textarea>
		</div>
	</td>
	</tr>
	<tr>
	<td>
		<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">발급/유효 날짜</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" value="${dto.bc_regdate}-${dto.bc_duedate}" readonly>
		</div>
</td>
	</tr>
	<tr>
	<td>
		<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">받은 회원 닉네임</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" value="${mdto.mem_nickname }" readonly>
		</div>
</td>
	</tr>
	<tr>
	<td>
		<div class="input-group mb-3">
			<span class="input-group-text" id="inputGroup-sizing-default">받은 회원 전화번호</span>
			<input type="text" class="form-control"
				aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-default" value="${mdto.mem_hp1 }-${mdto.mem_hp2}-${mdto.mem_hp3}" readonly>
		</div>
		</td>
	</tr>
	<tr>
	<td>
	<!-- 쿠폰 사용 완료시 취소만 활성화 -->
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
  	<c:if test="${bc_using eq null or bc_using eq 0 }">
  	 <button class="btn btn-primary me-md-2" type="submit">쿠폰 사용하기</button>
     <button class="btn btn-primary" type="button" disabled>사용 취소하기</button>
  	</c:if>
  	
  	<c:if test="${bc_using eq 1 }">
  	<button class="btn btn-primary me-md-2" type="button" disabled>쿠폰 사용하기</button>
	
   	<button class="btn btn-primary" type="button" onclick="javascript:cancelUsing()">사용 취소하기</button>
	</c:if>
	</div>
	</td>
	</tr>
	</table>
		</form>
   	<form id="f1" name= "f1" action="b_cancelUsingBcoupon.do">
	<input type="hidden" name="mem_num" value="${mdto.mem_num }">
	<input type="hidden" name="bp_num" value="${dto.bp_num}">
	<input type="hidden" name="bc_num" value="${dto.bc_num}">
	</form>
	</c:forEach>
	</c:forEach>
</div>
