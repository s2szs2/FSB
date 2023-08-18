<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-{SDK-최신버전}.js"></script>

    <script>
    var IMP = window.IMP; // 생략 가능
	IMP.init("imp15848178"); 

    function requestPay() {
        // IMP.request_pay(param, callback) 결제창 호출
        IMP.request_pay({ // param
            pg: "html5_inicis",
            pay_method: "card",
            merchant_uid: "ORD20180131-0000011",
            name: "노르웨이 회전 의자",
            amount: 64900,
            buyer_email: "gildong@gmail.com",
            buyer_name: "홍길동",
            buyer_tel: "010-4242-4242",
            buyer_addr: "서울특별시 강남구 신사동",
            buyer_postcode: "01181"
        }, function (rsp) { // callback
            if (rsp.success) {
                // 결제 성공 시 로직,
            } else {
                // 결제 실패 시 로직,
            }
        });
      }
        </script>
    <button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->
