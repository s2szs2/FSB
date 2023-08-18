<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<!-- shop_view1.jsp 쇼핑몰 상품 문의 페이지 -->
<%@include file="shop_prod_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="resources/js/sidebars.js"></script>

<!-- shop_prod_view.jsp 쇼핑몰 상품 상세정보 사이드바 -->
<%@include file="shop_prod_view.jsp" %>		

		<div class="row justify-content-center">
			<div class="col-9 bg-white">
				<h6 class="py-3 pb-2 border-bottom"><b>문의내역</b></h6>
				<table class="table">
					<thead>
					<tr align="center">
						<th class="table-light">번호</th>
						<th class="table-light">제목</th>
						<th class="table-light">작성자</th>
						<th class="table-light">작성일</th>
					</tr>
					</thead>
<c:if test="${empty getViewQnA}">
	<tr align="center">
		<td colspan="4">등록된 문의 글이 없습니다.</td>
	</tr>				
</c:if>
<c:if test="${not empty getViewQnA}">
					<c:forEach var="dto" items="${getViewQnA}">
					<tr align="center">
						<td>${dto.sq_num}</td>
						<td align="left">
							<c:if test="${dto.sq_secret eq 0 && dto.sq_check eq 0}">
								<a href="#collapseExample${dto.sq_num}" role="button" aria-expanded="false"  class="link-body-emphasis text-decoration-none" data-bs-toggle="collapse" data-bs-target="#collapseExample${dto.sq_num}" aria-controls="collapseExample${dto.sq_num}">
								[${dto.sq_type}]${dto.sq_title} <span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis">
								<c:if test="${dto.sq_check == 1}"><font color="black">답변 완료</font></c:if></span></a>
							</c:if>
							<c:if test="${dto.sq_secret eq 0 && dto.sq_check eq 1}">
								<a href="#collapseExample${dto.sq_num}" role="button" aria-expanded="false"  class="link-body-emphasis text-decoration-none" data-bs-toggle="collapse" data-bs-target="#collapseExample${dto.sq_num}" aria-controls="collapseExample${dto.sq_num}">
								[${dto.sq_type}]${dto.sq_title} <span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis">
								<c:if test="${dto.sq_check == 1}"><font color="black">답변 완료</font></c:if></span></a>
							</c:if>
							<c:if test="${dto.sq_secret eq 1 && dto.sq_check eq 0}">
								<a href="#collapseExample${dto.sq_num}" role="button" aria-expanded="false"  class="link-body-emphasis text-decoration-none" data-bs-toggle="collapse" data-bs-target="#collapseExample${dto.sq_num}" aria-controls="collapseExample${dto.sq_num}">
								🔒 [${dto.sq_type}]${dto.sq_title} <span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis">
								<c:if test="${dto.sq_check == 1}"><font color="black">답변 완료</font></c:if></span></a>
							</c:if>
							<c:if test="${dto.sq_secret eq 1 && dto.sq_check eq 1}">
								<a href="#collapseExample${dto.sq_num}" role="button" aria-expanded="false"  class="link-body-emphasis text-decoration-none" data-bs-toggle="collapse" data-bs-target="#collapseExample${dto.sq_num}" aria-controls="collapseExample${dto.sq_num}">
								🔒[${dto.sq_type}]${dto.sq_title} <span class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis">
								<c:if test="${dto.sq_check == 1}"><font color="black">답변 완료</font></c:if></span></a>
							</c:if>
						</td>		
						<td>${dto.mem_nickname}</td>
						<td>${dto.sq_regdate}</td>
					</tr>
					<tr>
					<!-- td 행 숨기기/행 보이기 해야함!!! https://hianna.tistory.com/501 -->
						<td colspan="4" style="border-top: hidden">
							<div class="collapse" id="collapseExample${dto.sq_num}">
								<div class="card card-body">
									<b>${dto.sq_title}</b>
									${dto.sq_content}
									<table>
										<tr>
											<td>
											<c:if test="${dto.sq_img1 ne null}">
												<img src="resources/img/${dto.sq_img1}" width="90" height="90">
											</c:if>
											<c:if test="${dto.sq_img2 ne null}">											
												<img src="resources/img/${dto.sq_img2}" width="90" height="90">
											</c:if>
											<c:if test="${dto.sq_img3 ne null}">
												<img src="resources/img/${dto.sq_img3}" width="90" height="90">
											</c:if>
											<c:if test="${dto.sq_img4 ne null}">
												<img src="resources/img/${dto.sq_img4}" width="90" height="90">
											</c:if>
											</td>
										</tr>
									</table>
									<hr>
									<code>❓ <b>관리자 답변 </b></code>
									<c:if test="${dto.sq_reply eq null}">
        							답변을 기다리고 있습니다.
					        		</c:if>
					        		<c:if test="${dto.sq_reply ne null}">
					        			${dto.sq_reply}
					        		</c:if>
								</div>
							</div>
						</td>
					</tr>					
					</c:forEach>
</c:if>
				</table>
				<div align="right">
					<a href="shop_insertQnA.do?prod_num=${prod_num}"><button class="btn btn-outline-dark" type="button">문의하기</button></a>
				</div>
			</div>
<form name="f" action="shop_view4.do" method="post">
	<div class="row justify-content-center">
         <div class="col-9 py-3 bg-white">
            <nav aria-label="Page navigation example">
              <ul class="pagination justify-content-center">
               <c:if test="${count > 0}">
               <c:if test="${startPage > pageBlock}">             
                <li class="page-item">
                  <a class="page-link" href="shop_view4.do?prod_num=${prod_num}&pageNum=${startPage - pageBlock}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li> 
               </c:if>                       
               <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li class="page-item"><a class="page-link" href="shop_view4.do?prod_num=${prod_num}&pageNum=${i}">${i}</a></li>
               </c:forEach>
               <c:if test="${endPage < pageCount}">
                <li class="page-item">
                  <a class="page-link" href="shop_view4.do?prod_num=${prod_num}&pageNum=${startPage + pageBlock}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
               </c:if>
               </c:if>
              </ul>
            </nav>
         </div>
	</div>
</form>  
		</div>
	</div>
</div>

<%@include file="shop_bottom.jsp" %>