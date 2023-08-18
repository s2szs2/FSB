<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script>
	//해당 회원 개인 피드로 이동
	function goToFeed(mem_num){
		event.stopPropagation();
		window.location='personalHome.do?num='+mem_num;
	}
	//회원 신고
	function checkReport_member(mem_num) {
		window.open("mem_report.do?mem_num="+mem_num, "", "width=550, height=470, left=680, top=270")
	}
	//피드 신고
	function checkReport_feed(feed_num,mode) {
		event.stopPropagation();
		window.open("feed_report.do?feed_num="+feed_num+"&mode="+mode, "", "width=550, height=470, left=680, top=270")
	}
	//피드 댓글 신고
	function checkReport_feedReply(fr_num,mode) {
		alert(fr_num+'그리고'+mode);
		event.stopPropagation();
		window.open("feed_report.do?fr_num="+fr_num+"&mode="+mode, "", "width=550, height=470, left=680, top=270")
	}
</script>

	<!-- sns 사이드바 -->
	<div class="vertical-right-line flex-shrink-0 p-3 bg-white" style="width: 15%; min-width: 10rem; max-width: 18rem;">
   		<a href="feed.do" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
    		<svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#people-circle"></use></svg>
    		<span class="fs-5 fw-semibold">${login_mem.mem_nickname} 님</span>
 		</a>
 		
 		<!-- 버튼 -->
 		<div class="container mb-3">
 			<div class="col" align="center">
 				<c:if test ="${login_mem.mem_mode eq '사업자'}">
 					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='b_personalHome.do?num=${login_mem.mem_num}'">내 피드</button>&nbsp;&nbsp;
 				</c:if>
 				<c:if test="${login_mem.mem_mode eq '일반' }">
 					<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript: goToFeed(${login_mem.mem_num})">내 피드</button>&nbsp;&nbsp;
 					<button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='feed.do'">메인홈</button>
 				</c:if>
 			</div>
 		</div>
 		
 		<div class="border-top"></div>
  			
   		<!-- 메뉴 항목 -->	
    	<ul class="list-unstyled ps-0 mt-3">
      		<li class="mb-1">
        		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#friend-collapse" aria-expanded="true">
         			친구 관리
       			</button>
        		<div class="collapse show" id="friend-collapse">
          			<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            			<li><a href="friendRequest.do" class="link-dark d-inline-flex text-decoration-none rounded">친구 요청</a></li>
         			</ul>
        		</div>
      		</li>
      	 <li class="mb-1">
            <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#mypage-collapse" aria-expanded="false">
               내 정보수정
            </button>
            <div class="collapse" id="mypage-collapse">
               <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                  <li><a href="myPageChange.do" class="link-dark d-inline-flex text-decoration-none rounded">내 계정</a></li>
                        <li><a href="myBoard.do" class="link-dark d-inline-flex text-decoration-none rounded">내가 쓴글 확인</a></li>
               </ul>
            </div>
         </li>
            <li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#alarm-collapse" aria-expanded="false">
					알림함
				</button>
				<div class="collapse" id="alarm-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="myAlarm.do" class="link-dark d-inline-flex text-decoration-none rounded">알림함</a></li>
					</ul>
				</div>
			</li>
            <li class="mb-1">
              <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#storage-collapse" aria-expanded="false">
                  	보관함
              </button>
        		<div class="collapse" id="storage-collapse">
          			<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            			<li><a href="myCoupon.do" class="link-dark d-inline-flex text-decoration-none rounded">쿠폰함</a></li>
            			<li><a href="game_like_list.do" class="link-dark d-inline-flex text-decoration-none rounded">찜한 보드게임</a></li>
          			</ul>
        		</div>
    		</li>
   		<c:if test="${login_mem.getMem_mode() eq '사업자'}">
   		<li class="mb-1">
        		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#business-collapse" aria-expanded="false">
          			비즈니스 관리
        		</button>
        		<div class="collapse" id="business-collapse">
          			<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
          				<li><a href="b_profile_update.do?bp_num=${bp_num}" class="link-dark d-inline-flex text-decoration-none rounded">비즈니스 프로필 수정</a></li>
          				<li><a href="b_couponList.do?bp_num=${sessionScope.bp_num }" class="link-dark d-inline-flex text-decoration-none rounded">비즈니스 쿠폰 관리</a></li>
          			</ul>
        		</div>
        	</li>
          		</c:if>
    		<!--구분선 -->
       		<li class="border-top my-3"></li>
      		<li class="mb-1">
        		<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#inquiry-collapse" aria-expanded="false">
          			문의 사항
        		</button>
        		<div class="collapse" id="inquiry-collapse">
          			<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
        			    <li><a href="myPage_notice.do?n_mode=notice" class="link-dark d-inline-flex text-decoration-none rounded">공지사항</a></li>
            			<li><a href="mypage_FAQ.do" class="link-dark d-inline-flex text-decoration-none rounded">자주 묻는 질문</a></li>
          			</ul>
        		</div>
			</li>

		</ul>
	</div>