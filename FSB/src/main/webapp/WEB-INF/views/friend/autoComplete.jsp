<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<c:forEach var="prof" items="${listProf}" varStatus="status">
	<li>
		<a class="dropdown-item d-flex align-items-center gap-2 py-2 to-feed-div" onclick="javascript: goToFeed(${prof.mem_num})">
			<div class="container mb-3" align="left">
				<div class="row align-items-center">
					<div class="col-1" align="left" style="padding: 0; vertical-align: middle;">
						<img src="resources/img/${prof.prof_img}" width="30" height="30">&nbsp;
					</div>
					<div class="col-8 container" style="padding-left: 20px;">
						<div class="row">
							<div class="col">
								<strong>${prof.mem_nickname}</strong>
								<c:if test="${prof.prof_open == 'secret'}">
									<svg xmlns="http://www.w3.org/2000/svg" width="15" height="12" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
	  									<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
									</svg>
								</c:if>
								<small class="text-muted" style="margin-left: 0.5rem;">${prof.mem_id}</small>
							</div>
						</div>
						<div class="row col mt-2">
							<span style="text-overflow:ellipsis;overflow:hidden;width:100%">
								<small>${prof.prof_msg}</small>
								<c:if test="${prof.prof_msg == null}">&nbsp;</c:if>
							</span>
						</div>
					</div>
					<div class="col-3" align="right" style="padding: 0;">
						<!-- 남일 때 -->
						<c:if test="${prof.m_friend_accept == null}">
							<!-- 상대가 전체공개일 때 -->
							<c:if test="${prof.prof_open == 'open'}">
								<button type="button" class="btn btn-outline-primary btn-sm" style="width:82%;" onclick="javascript: follow(${prof.mem_num},'follow','${prof.prof_open}','autoBox')">팔로우</button>
							</c:if>
							<!-- 상대가 친구공개일 때 -->
							<c:if test="${prof.prof_open == 'secret'}">
								<button type="button" class="btn btn-outline-secondary btn-sm" style="width:82%;" onclick="javascript: follow(${prof.mem_num},'request','${prof.prof_open}','autoBox')">팔로우 요청</button>
							</c:if>
						</c:if>
						<!-- 팔로우 중일 때 -->
						<c:if test="${prof.m_friend_accept == 'follow'}">
							<button type="button" class="btn btn-primary btn-sm" style="width:82%;" onclick="javascript: follow(${prof.mem_num},'unfollow','${prof.prof_open}','autoBox')">언팔로우</button>
						</c:if>
						<!-- 요청 중일 때 -->
						<c:if test="${prof.m_friend_accept == 'request'}">
							<button type="button" class="btn btn-secondary btn-sm" style="width:82%;" onclick="javascript: follow(${prof.mem_num},'unrequest','${prof.prof_open}','autoBox')">요청 취소</button>
						</c:if>
						<!-- (내가) 차단 중일 때 -->
						<c:if test="${prof.m_friend_accept == 'block'}">
							<button type="button" class="btn btn-danger btn-sm" style="width:82%;" onclick="javascript: follow(${prof.mem_num},'unblock','${prof.prof_open}','autoBox')">차단 해제</button>
						</c:if>
						<!-- 차단 당했을 때 -->
						<c:if test="${prof.f_friend_accept == 'block'}">
							<button type="button" class="btn btn-danger btn-sm" style="width:82%;" disabled>차단됨</button>
						</c:if>
					</div>
				</div>
			</div>
		</a>
	</li>
</c:forEach>