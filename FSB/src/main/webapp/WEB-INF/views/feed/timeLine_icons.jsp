<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="col-auto" align="left" style="padding:0">
		<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#text-quote"></use></svg>
	</div>
	<div class="col-auto" align="left" style="padding:0">
		<span name="rcount_${feed.feed_num}">${feed.feed_replyCount}</span>
	</div>&nbsp;&nbsp;
	<c:if test="${empty feed.isLike || feed.isLike==0}">
		<div class="col-auto" align="left" style="padding:0" onclick="likeFeed(${feed.feed_num})">
			<svg class="bi pe-none me-2" fill="#A6A6A6" width="20" height="20"><use xlink:href="#heart-empty"></use></svg>
		</div>		       					
	</c:if>
	<c:if test="${feed.isLike==1}">
		<div class="col-auto" align="left" style="padding:0" onclick="likeDeleteFeed(${feed.feed_num})">
			<svg class="bi pe-none me-2" fill="#FF0000" width="20" height="20"><use xlink:href="#heart-fill"></use></svg>
		</div>
	</c:if>
	<div class="col" align="left" style="padding:0">
		<span>${feed.feed_likeCount}</span>		       							
	</div>

