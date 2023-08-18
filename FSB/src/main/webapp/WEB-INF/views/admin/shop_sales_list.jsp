<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- shop_sales_list.jsp // 매출 주문 내역 -->

<%@include file="admin_top.jsp" %>

	<!-- 쇼핑몰관리 사이드바 -->
	<%@include file="shop_sidebar.jsp" %>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <!-- 차트 링크 -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


		  <div class="container" style="overflow: scroll; width: 1200px; height: 900px;">
		  		<div class="col" align="center">
		       		<h4>매출 내역</h4>
		            <div align="right">
		            	<h6>(단위 : 만 원)</h6>
		            </div>
		         </div>
		  <canvas id="barChart" style="max-height: 400px; display: block; box-sizing: border-box; height: 378px; width: 757px;" width="947" height="473"></canvas>

		
		      <!-- <div class="row my-3" >
		          <div class="col" align="center">
		              <h4>매출 내역</h4>
		              <div align="right">
		              	<h6>(단위 : 만 원)</h6>
		              </div>
		          </div>
		      </div>
		      <div class="row my-2">
		          <div class="col">
		              <div class="card">
		                  <div class="card-body">
		                      <canvas id="myChart" height="100"></canvas>
		                  </div>
		              </div>
		          </div>
		      </div> -->
		      <div class="row">
		      	<p>
		      	<h6><font color="blue">[ 판매량 순위 ]</font></h6>
		      	<c:set var="i" value="1"/>
		      	<c:set var="j" value="0"/>
		      	<div class="row row-cols-1 row-cols-md-3 g-2">	
		      		<c:forEach items="${listRank}" var="dto">
		      		<div class="col">
				      	<div class="card" style="width: 16rem;">
		  					<img src="resources/img/${dto.game_img}" width="150" height="150" class="card-img-top" alt="...">
			 					<div class="card-body">
		    						<p class="card-text"><h6><font color="red"><c:if test="${j eq dto.detail_qty}"><c:set var="i" value="${i-1}"/></c:if>${i}위</font></h6>
		    							<strong>상품명 : </strong>${dto.game_name}<br>
		    							<strong>판매가 : </strong>${df.format(dto.prod_price)} 원<br>
		    							<strong>판매량 : </strong>${df.format(dto.detail_qty)} 개
		    							<div align="right">
		    								<a href="admin_prod_view.do?prod_num=${dto.prod_num}"><button class="btn btn-secondary btn-sm" >상품보기</button></a>
		    							</div>
								</div>
							</div>
						</div>
						<c:set var="j" value="${dto.detail_qty}"/>
						<c:set var="i" value="${i+1}"/>
					</c:forEach>
					</div>

		      </div>
		  </div>
  		</main>
	</div>

  <!-- 부트스트랩 -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
    crossorigin="anonymous"></script>
  
  <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#barChart'), {
                    type: 'bar',
                    data: {
                      labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                      datasets: [{
                        label: '매출',
                        data: [${sum1}, ${sum2}, ${sum3}, ${sum4}, ${sum5}, ${sum6}, ${sum7}, ${sum8}, ${sum9}, ${sum10}, ${sum11}, ${sum12}],
                        backgroundColor: [
                          'rgba(255, 99, 132, 0.2)',
                          'rgba(255, 159, 64, 0.2)',
                          'rgba(255, 205, 86, 0.2)',
                          'rgba(75, 192, 192, 0.2)',
                          'rgba(54, 162, 235, 0.2)',
                          'rgba(153, 102, 255, 0.2)',
                          'rgba(201, 203, 207, 0.2)'
                        ],
                        borderColor: [
                          'rgb(255, 99, 132)',
                          'rgb(255, 159, 64)',
                          'rgb(255, 205, 86)',
                          'rgb(75, 192, 192)',
                          'rgb(54, 162, 235)',
                          'rgb(153, 102, 255)',
                          'rgb(201, 203, 207)'
                        ],
                        borderWidth: 1
                      }]
                    },
                    options: {
                      scales: {
                        y: {
                          beginAtZero: true
                        }
                      }
                    }
                  });
                });
              </script>
  
  <!-- 차트 -->
<!--   <script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var chart = new Chart(ctx, {
      // 챠트 종류를 선택
      type: 'line',

      // 챠트를 그릴 데이타
      data: {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [{
          label: '매출',
          backgroundColor: 'transparent',
          borderColor: 'red',
          data: [${sum1}, ${sum2}, ${sum3}, ${sum4}, ${sum5}, ${sum6}, ${sum7}, ${sum8}, ${sum9}, ${sum10}, ${sum11}, ${sum12}]
        }]
      },
      // 옵션
      options: {}
    });
  </script> -->

  <%@include file="admin_bottom.jsp" %>