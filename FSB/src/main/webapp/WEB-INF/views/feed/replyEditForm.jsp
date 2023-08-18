<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 댓글 작성 -->
  		<form name="feedReplyForm" action="InsertfeedReply.do" method="post">
  			<input type="hidden" name="feed_num" value="">
    		<div class="d-flex w-100 align-items-center justify-content-between">
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
	        		</div>
	       			<div class="row">
	     	 			<div class="col small">
	     	 				<input id="edit_content" name="fr_content" class="form-control mt-2" type="text" placeholder="내용을 입력해주세요" value="${reply.fr_content}">
	     	 			</div>
	      	 			<div class="col-auto small">
	      	 				<input type="hidden" name="noEnter"/>
	      	 				<button type="button" class="btn btn-outline-primary mt-2" onclick="feedReplyEditCheck(${reply.fr_num})">수정완료</button>
	      	 			</div>
	       			</div>
	       		</div>
   			</div>
		</form>