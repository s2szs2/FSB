<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myPageFAQ.jsp -->
<%@include file="../user/user_top.jsp" %>

<main class="d-flex flex-nowrap">
     
        <!-- 사이드 바 -->
        <%@include file="../user/sns_top.jsp" %>
         <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width:1000px; min-width: 30rem;">
  
			<!-- 프로필 베젤 -->
			<div class="d-flex align-items-center flex-shrink-0 p-3 border-bottom container">
				<div align="left"><span class="link-dark text-decoration-none fs-5 fw-semibold">자주 묻는 질문 (FAQ) </span></div>
			</div>
		<c:forEach var="nlist" items="${nlist }">
         <div class="accordion accordion-flush" id="accordionFlushExample">
  		<div class="accordion-item">
   		 <h2 class="accordion-header">
    	  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${nlist.n_num }" aria-expanded="false" aria-controls="flush-collapse${nlist.n_num }">
       ❓ ${nlist.n_title }
      </button>
    </h2>
    <div id="flush-collapse${nlist.n_num }" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">
      <div class="accordion-body">
      <div class="row">
       <div class="col-11"></div>
      <div class="col-1"><font color="gray"><small>${nlist.n_regdate}</small></font></div>
      </div>
      <div class="row">
      <div class="col">❕ ${nlist.n_content }</div>
     </div>
      </div>
    </div>
  </div>
	</div>
</c:forEach>
         </div>
         </main>
         	<div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width:100px; min-width: 10rem;">
	</div>
	<div class = "container text-center">
	 <div class = "row">
         <div class="col">
         	<MARQUEE><h6><font color="gray">✉️자세한 문의는 관리자에게 메일을 보내주세요 admin@a.a✉️</font></h6></MARQUEE>
         </div>
         </div>
         </div>
         <%@include file="../user/user_bottom.jsp" %>