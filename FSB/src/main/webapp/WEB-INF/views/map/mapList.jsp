<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
<c:forEach var="list" items="${plist}">
	  <tr>
		<td id="maplist">
		<div class="card">
  			<div class="card-body" style=height:165px;>
   				<a href="map_click_search.do?bp_num=${list.bp_num }"><h5 class="card-title">${list.bp_store_name }</h5></a>
   			 <p class="card-text">🚩${list.bp_location }&nbsp;${list.bp_d_location }
   				 <br>
  				 📞${list.bp_tel } 		 ⭐${list.bp_starrating }/5.0</p>
    			<a href="b_personalHome.do?bp_num=${list.bp_num }&num=${list.mem_num}" class="card-link">프로필로 이동</a>
 			 </div>
		</div>
		</td>
		</tr>              
</c:forEach>
</table>