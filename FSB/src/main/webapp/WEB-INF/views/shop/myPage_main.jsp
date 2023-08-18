<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPage_main.jsp -->
<%@include file="myPage_top.jsp" %>
   <!-- 사이드 바 css, js -->
   <link href="resources/css/sidebars.css" rel="stylesheet">
   <script src="resources/js/sidebars.js"></script>
   <script>
	function checkDel(order_num, order_point){
		var isDel = window.confirm("정말로 취소하시겠습니까?");
		if (isDel){
			document.deleteOne.order_num.value = order_num;
			document.deleteOne.order_point.value = order_point;
			document.deleteOne.submit();
		}
	}
	function refundOrder(order_num){
		var isRefund = window.confirm("환불하시겠습니까?");
		if (isRefund){
			document.refund.order_num.value = order_num;
			document.refund.submit();
		}
	}	
	function refunResetdOrder(order_num){
		var isRefund = window.confirm("환불요청을 취소 하시겠습니까?");
		if (isRefund){
			document.refundReset.order_num.value = order_num;
			document.refundReset.submit();
		}
	}		
   </script>
   <style>
   		caption{
   			caption-side : top
   		}
   </style>
   
   		<td width="90%" style="overflow: scroll; width: 900px; height: 400px;">
   		<div class="col-9 py-2 justify-content-center">
    		<table width="100%" class="table table-striped" >
    			<caption><font size="5" color="#000000"><b>전체 주문 목록</b></font></caption>
        		<tr align="center" valign="top">
        			<th><font size="4">주문 일자</font></th>
        			<th><font size="4">주문 번호</font></th>
        			<th><font size="4">주문 상품</font></th>
        			<th><font size="4">총 주문 금액</font></th>
        			<th><font size="4">결제 방식</font></th>
        			<th><font size="4">주문 처리 상태</font></th>
        			<th><font size="4">취소/환불</font></th>
        		</tr>
        		<c:if test="${empty listOrder}">
        			<tr>
        				<td colspan="7" align="center">주문 내역이 없습니다.</td>
        			</tr>
        		</c:if>
        		<c:if test="${not empty listOrder}">
        		<c:forEach var="dto" items="${listOrder}">
        		<tr align="center" valign="middle">
        			<td>${dto.order_date}</td>
        			<td>${dto.order_date}${dto.order_num}</td>
        			<td align="left"><a href="shop_orderDetail.do?order_num=${dto.order_num}&mem_num=${mem_num}">
        				<img src="resources/img/${dto.prod_img}" width="100" height="100">
        				[${dto.prod_company}] ${dto.prod_name} <c:if test="${(dto.prod_count-1) > 0}">외 ${dto.prod_count-1}건</c:if>
        			</a></td>
        			<td>${sessionScope.df.format(dto.order_receiptprice)}원</td>
        			<td>${dto.order_payment}</td>
        			<td>
        				<c:if test="${dto.order_progress == 1}">결제완료</c:if>
        				<c:if test="${dto.order_progress == 2}">배송준비</c:if>        				
        				<c:if test="${dto.order_progress == 3}">배송중</c:if>        				
        				<c:if test="${dto.order_progress == 4}">구매확정</c:if>
        				<c:if test="${dto.order_progress == 0}">환불요청중</c:if>        				
        				<c:if test="${dto.order_progress == -1}">환불완료</c:if>
        			</td>
        			<td>
           				<c:if test="${dto.order_progress == 0}">
          					<button class="btn btn-outline-dark" type="button" onclick="javascript:refunResetdOrder('${dto.order_num}')">환불 취소</button>
          				</c:if>       				
          				<c:if test="${dto.order_progress == 1 || dto.order_progress == 2}">
          					<button class="btn btn-outline-dark" type="button" onclick="javascript:checkDel('${dto.order_num}','${dto.order_point}')">주문 취소</button>
          				</c:if>
          				<c:if test="${dto.order_progress == 3}">
          					<button class="btn btn-outline-dark disabled" type="button" >주문 취소</button>
          				</c:if>
        				<c:if test="${dto.order_progress == 4}">
        					<button class="btn btn-outline-dark" type="button" onclick="javascript:refundOrder('${dto.order_num}')">환불요청</button>
        				</c:if>        				
        			</td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			</div>
		</td>
	</tr>
</table>
<form name="deleteOne" action="shop_deleteOrder.do" method="post">
	<input type="hidden" name="order_num">
	<input type="hidden" name="order_point">
</form>
<form name="refund" action="shop_refund.do" method="post">
	<input type="hidden" name="order_num">
</form>
<form name="refundReset" action="shop_refundReset.do" method="post">
	<input type="hidden" name="order_num">
</form>
<%@include file="myPage_bottom.jsp" %>