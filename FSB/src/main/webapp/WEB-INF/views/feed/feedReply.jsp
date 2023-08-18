<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<!-- 댓글 하나 -->
	<div id="reply_${status}" class="list-group-item py-3 lh-sm">
		<div class="d-flex w-100 align-items-center justify-content-between">
			<!-- 정상 출력 -->
  			<div class="container">
     			<div class="row mb-2">
        			<div class="col" align="left">
        				<img src="resources/img/${reply.prof_img}" width="25" height="25">&nbsp;
          				<strong>${reply.mem_nickname}</strong>
						<c:if test="${reply.prof_open == 'secret'}">
							<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
 								<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
							</svg>
						</c:if>
						<small class="text-muted" style="margin-left: 0.5rem;">${reply.mem_id}</small>
          			</div>
          			<div class="col" align="right">
          				<c:if test="${login_mem.mem_num == reply.mem_num}">
          					<small class="text-muted" onclick="updateReply(${reply.fr_num},${status})">수정 </small>
          					<small class="text-muted">|</small>
          					<small class="text-muted" onclick="deleteReply(${reply.fr_num})"> 삭제</small>
          				</c:if>
          				<c:if test="${login_mem.mem_num != reply.mem_num}">
          					<small class="text-muted" style="cursor: pointer;" onclick="checkReport_feedReply(${reply.fr_num},'feedReply')">| 신고</small>
          				</c:if>
          			</div>					          			
         		</div>
         		<div class="row">
       	 			<div class="col small tl-content-box-view">
       	 				<span>${reply.fr_content}</span>
       	 			</div>     
         		</div>
        	</div>
	    </div>
	</div>	