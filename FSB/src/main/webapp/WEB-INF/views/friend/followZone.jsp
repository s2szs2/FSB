<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- 본인일 때 -->
<c:if test="${login_mem.mem_num == target_profile.mem_num}">
  	<button type="button" class="btn btn-outline-primary" onclick="#">프로필 수정</button>
</c:if>
<!-- 남일 때 -->
<c:if test="${login_mem.mem_num != target_profile.mem_num}">
	<c:if test="${target_profile.m_friend_accept == 'none'}">
		<!-- 상대가 전체공개일 때 -->
		<c:if test="${target_profile.prof_open == 'open'}">
			<button type="button" class="btn btn-outline-primary" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'follow','${target_profile.prof_open}','personalHome')">팔로우</button>
		</c:if>
		<!-- 상대가 친구공개일 때 -->
		<c:if test="${target_profile.prof_open == 'secret'}">
			<button type="button" class="btn btn-outline-secondary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'request','${target_profile.prof_open}','personalHome')">팔로우 요청</button>
		</c:if>
	</c:if>
	<!-- 팔로우 중일 때 -->
	<c:if test="${target_profile.m_friend_accept == 'follow'}">
		<button type="button" class="btn btn-primary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unfollow','${target_profile.prof_open}','personalHome')">언팔로우</button>
	</c:if>
	<!-- 요청 중일 때 -->
	<c:if test="${target_profile.m_friend_accept == 'request'}">
		<button type="button" class="btn btn-secondary btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unrequest','${target_profile.prof_open}','personalHome')">요청 취소</button>
	</c:if>
	<!-- (내가) 차단 중일 때 -->
	<c:if test="${target_profile.m_friend_accept == 'block'}">
		<button type="button" class="btn btn-danger btn-sm" style="width:70%;" onclick="javascript: follow(${target_profile.mem_num},'unblock','${target_profile.prof_open}','personalHome')">차단 해제</button>
	</c:if>
	<!-- 차단 당했을 때 -->
	<c:if test="${target_profile.f_friend_accept == 'block'}">
		<button type="button" class="btn btn-danger btn-sm" style="width:70%;" disabled>차단됨</button>
	</c:if>
	
	<svg class="dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-expanded="false" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#A6A6A6" class="bi bi-lock-fill" viewBox="0 0 16 16" preserveAspectRatio="none">
		<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
	</svg>
	<ul class="dropdown-menu">
		<li><small class="dropdown-item text-muted" onclass onclick="checkReport_member(${target_profile.mem_num})">신고</small></li>
		<c:if test="${target_profile.m_friend_accept != 'block'}">
			<li><small class="dropdown-item text-muted" onclass onclick="javascript: follow(${target_profile.mem_num},'block','${target_profile.prof_open}','personalHome')">차단</small></li>
		</c:if>
	</ul>
</c:if>