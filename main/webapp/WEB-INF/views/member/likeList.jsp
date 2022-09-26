<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜목록</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<style>
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	body {
		    padding-top: 190px;
		    padding-bottom: 120px;  
	}
	.tableD {
		font-family: 'tway_air';
		position: relative;
	    left: 210px; 
	    border-spacing: 5px;
	    border-collapse: separate;
	}
	.tdsize {
		width: 300px;	
		position: relative;
	}
	.badge {
		position: absolute;
		z-index: 2;
		right: 15px;
		top: 15px;
		cursor:pointer;
	}
</style>
<body style="background-color: #E6E6FA;">
<div>
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<table class="tableD">
	<tr>
		<td colspan="4">총 ${page.totalCount}개</td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:set var="j" value="4" />
	<c:forEach items="${likeList}" var="like">
	<c:if test="${i%j == 0 }">		
	<tr>
	</c:if>
	<td class="tdsize"> 
		<form id="deleteForm${like.bcg_key}">
			<input type="hidden" name="bcm_num" value="${like.bcm_num}">
			<input type="hidden" name="bcg_key" value="${like.bcg_key}">
			<div class="badge" id="badge">
			<img src="/image/delete.png" height="30" width="30" onclick="찜목록삭제${like.bcg_key}()"/>
			</div>
		</form>
		<img src="${like.bcg_img}" onclick="javascript:window.location='/guest/detailPage?BCG_KEY=${like.bcg_key}'" 
			 width="100%" style="border-radius:15%">
	</td>
	<c:if test="${i%j == j-1 }">
	</tr>	
	</c:if>
	<c:set var="i" value="${i+1 }" />
<script>
	function 찜목록삭제${like.bcg_key}() {	
		var queryString = $('#deleteForm${like.bcg_key}').serialize();
		$.ajax({
			url : '/member/likeDelete',
			type : 'POST',
			data : queryString,
			success : function(data) {
   				if(data == 'success'){
       				window.location.reload();
   				}
   				else {
   					alert("에러가 발생했습니다.");
   				}
			}
		});
	}
</script>
	</c:forEach>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>	
	<c:if test="${page.totalCount > 0 }">   
	<tr style="text-align: center">
		<td colspan="4">
			<!-- 처음 -->
		<c:choose>
		<c:when test="${(page.curPage - 1) < 1}">
			 &lt;&lt; 
		</c:when>
		<c:otherwise>
			<a href="like?page=1"> &lt;&lt; </a>
		</c:otherwise>
		</c:choose>
		
		<!-- 이전 -->
		<c:choose>
		<c:when test="${(page.curPage - 1) < 1}">
			 &lt; &nbsp;
		</c:when>
		<c:otherwise>
			<a href="like?page=${page.curPage - 1}"> &lt; </a> &nbsp;
		</c:otherwise>
		</c:choose>
		
		<!-- 개별 페이지 -->
		<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
			<c:choose>
			<c:when test="${page.curPage == fEach}">
				 ${fEach}  &nbsp;
			</c:when>
			<c:otherwise>
				<a href="like?page=${fEach}"> ${fEach} </a> &nbsp;
			</c:otherwise>
			</c:choose>
		</c:forEach>	
	
		<!-- 다음 -->
		<c:choose>
		<c:when test="${(page.curPage + 1) > page.totalPage}">
			 &gt; 
		</c:when>
		<c:otherwise>
			<a href="like?page=${page.curPage + 1}"> &gt; </a>
		</c:otherwise>
		</c:choose>
		
		<!-- 끝 -->
		<c:choose>
		<c:when test="${page.curPage == page.totalPage}">
			 &gt;&gt; 
		</c:when>
		<c:otherwise>
			<a href="like?page=${page.totalPage}"> &gt;&gt; </a>
		</c:otherwise>
		</c:choose>
		</td>
	</tr>
	</c:if>
</table>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>