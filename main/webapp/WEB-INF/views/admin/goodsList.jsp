<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 상품리스트</title>
<style type="text/css">
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	
	body  {
	    padding-top: 160px;
	    padding-bottom: 120px;
	}
	
	#all {
		margin-left: 220px;
		font-family: 'tway_air';
	}
	
	#myList {
		text-align: center;
		width: 1000px;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function del() {     //상품 삭제 : 여러개 한번에 삭제 가능
		console.log($("input[name=BCG_KEY]:checked").length);
		if($("input[name=BCG_KEY]:checked").length<1) {
            alert("적어도 1개는 체크.");
			return;
        } else if($("input[name=BCG_KEY]:checked").length>=1){
        	var queryString=$("#ModifyDelete").serialize();
	        $.ajax({
	        	url: '/admin/delete',  
	            type: 'POST',
	            data: queryString,
	            dataType: 'text',
	            success: function(json) { }
	        });
	        del2();
		} 
    }
	
	function del2() {     //상품 삭제 시 옵션까지 삭제
        var queryString=$("#ModifyDelete").serialize();       
        $.ajax({
        	url: '/admin/deleteDetail',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	window.location.replace("/admin/goodsList");           		               	           	
            }
        });
    }	
	
	function opAdd() {     //옵션추가 : 1개만 선택 가능
		if($("input[name=BCG_KEY]:checked").length<1){
            alert("적어도 1개는 체크.");
			return;
		} else if($("input[name=BCG_KEY]:checked").length==1){
			var queryString=$("#ModifyDelete").serialize();
	        $.ajax({
	        	url: '/admin/opSelect',  
	            type: 'POST',
	            data: queryString,
	            dataType: 'text',
	            success: function(json) {
	            	window.location="/admin/goodsAddDetail";   
	        	}
	    	});
		} else {
			alert("중복ㄴㄴ");
			return;
		}
		
	}

	function mod() {     //상품 수정 : 1개만 선택 가능
		if($("input[name=BCG_KEY]:checked").length<1){
            alert("적어도 1개는 체크.");
			return;
		} else if($("input[name=BCG_KEY]:checked").length==1){
			var queryString=$("#ModifyDelete").serialize();
			$.ajax({
	        	url: '/admin/opSelect',  
	            type: 'POST',
	            data: queryString,
	            dataType: 'text',
	            success: function(json) {
	            	window.location.replace("/admin/goodsModify");   
	            }
	        });
		} else {
			alert("중복ㄴㄴ");
			return;
		}

    }
	
	function sch_check() {
		var num_check = /^[0-9]*$/;
  		if($('#srchText').val().length == 0) {
  			alert("검색어를 입력해주세요");
  			$('#srchText').focus();
  			return;
  		} else if (($('#type').val() == 'bcg_key')&&(!num_check.test($('#srchText').val()))) {
  			alert("품번은 숫자만 입력 가능합니다.");
  			$('#srchText').focus();
  			return;
  		} else { sch(); }
  	}
	
	function sch() {     //검색기능
        var queryString=$("#adminSch").serialize();
        $.ajax({
        	url: '/admin/adminSearch',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	window.location="/admin/searchRs";
            }       	
        });
    }
</script>
</head>
<body style="background-color: #E6E6FA;">	
	
<div style="float: top">
   	<c:import url="/admin/adminTop"></c:import>
</div>

<div style="float: left">
   	<c:import url="/admin/adminPageView"></c:import>
</div>

	<section id="all">
	<h3>상품리스트</h3>
	<br>
	<table border="1" id="myList">
		<form id="adminSch" name="adminSch">					
			<select id="type" name="type" class="nav-link dropdown-toggle" style="float:left;">
				<option value="bcg_key">품번</option>
				<option value="bcg_name">품명</option>						
			</select>
			<input class="form-control mr-sm-2" type="text" id="srchText" name="srchText" style="width: 200px; float:left;">
			<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sch_check()" style="float:left;">검색</button>&nbsp;
		</form>
		<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="location.href='/admin/goodsList'">전체보기</button>	
		<br>
		<form id="ModifyDelete" method="post">
			<p>
				총 ${page.totalCount}개
			</p>
			<c:if test="${page.totalCount>0}"> 
			<tr>
				<td></td>
				<td>대분류</td>
				<td>품번</td>
				<td>품명</td>
				<td>판매가</td>
				<td>출시일</td>
				<td>재고량</td>
				<td>판매량</td>
				<td>찜</td>
				<td>할인율</td>
				<td>MD's Pick</td>			
			</tr>
			</c:if>
			<c:if test="${page.totalCount==0}"> 
				<tr><td colspan="11">검색어와 일치하는 상품이 없습니다.</td></tr>
			</c:if> 
			<c:forEach items="${list}" var="dto">
			<tr>
				<td> 
					<input type="checkbox" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
					<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${dto.bcg_name}">
					<input type="hidden" id="BCG_CATEGORY" name="BCG_CATEGORY" value="${dto.bcg_category}">
					<input type="hidden" id="BCG_PRICE" name="BCG_PRICE" value="${dto.bcg_price}">
					<input type="hidden" id="BCG_DISCOUNT" name="BCG_DISCOUNT" value="${dto.bcg_discount}">
					<input type="hidden" id="BCG_MDPICK" name="BCG_MDPICK" value="${dto.bcg_mdpick}">
					<input type="hidden" id="BCG_IMG" name="BCG_IMG" value="${dto.bcg_img}"> 
					<input type="hidden" id="BCG_INFO" name="BCG_INFO" value="${dto.bcg_info}"> 
				</td>
				<td> ${dto.bcg_category} </td>
				<td> ${dto.bcg_key} </td>
				<td> 
					<a href="opDelete?BCG_KEY=${dto.bcg_key}">
                  		${dto.bcg_name}
                 	</a>
 				</td>							
				<td> ${dto.bcg_price}원 </td>							
				<td> <fmt:formatDate value="${dto.bcg_date}" pattern="yyyy-MM-dd" var="bcg_date" /> ${bcg_date} </td>							
				<td> ${dto.bcg_stock} </td>							
				<td> ${dto.bcg_sale} </td>							
				<td> ${dto.bcg_like} </td>							
				<td> ${dto.bcg_discount}% </td>							
				<td>
					<c:if test="${dto.bcg_mdpick != 0}"> ${dto.bcg_mdpick} </c:if> 
					<c:if test="${dto.bcg_mdpick == 0}"> - </c:if> 
				</td>
			</tr>
			</c:forEach>	
		</form>	
		<c:if test="${page.totalCount>0}"> 
		<tr>
			<td colspan="11">
				<!-- 처음 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					 &lt;&lt; 
				</c:when>
				<c:otherwise>
					<c:choose>
                         <c:when test="${page.searchText == null}">
                             <a href="goodsList?page=1"> &lt;&lt; </a>
                         </c:when>
                         <c:otherwise>
                             <a href="searchRs?page=1&type=${page.type}&srchText=${page.searchText}"> &lt;&lt; </a>
                         </c:otherwise>
                     </c:choose>
				</c:otherwise>
				</c:choose>
				
				<!-- 이전 -->
				<c:choose>
				<c:when test="${(page.curPage - 1) < 1}">
					 &lt; 
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${page.searchText == null}">
	                        <a href="goodsList?page=${page.curPage - 1}"> &lt; </a> &nbsp;
	                    </c:when>
	                    <c:otherwise>
	                        <a href="searchRs?page=${page.curPage - 1}&type=${page.type}&srchText=${page.searchText}">  &lt; </a> &nbsp;
	                    </c:otherwise>
                    </c:choose>
				</c:otherwise>
				</c:choose>
				
				<!-- 개별 페이지 -->
				<c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
					<c:choose>
					<c:when test="${page.curPage == fEach}">
						 ${fEach}  &nbsp;
					</c:when>
					<c:otherwise>
						<c:choose>
	                         <c:when test="${page.searchText == null}">
	                             <a href="goodsList?page=${fEach}"> ${fEach} </a> &nbsp;
	                         </c:when>
	                         <c:otherwise>
	                             <a href="searchRs?page=${fEach}&type=${page.type}&srchText=${page.searchText}"> ${fEach} </a>&nbsp;
	                         </c:otherwise>
	                     </c:choose>
					</c:otherwise>
					</c:choose>
				</c:forEach>	
				
				<!-- 다음 -->
				<c:choose>
				<c:when test="${(page.curPage + 1) > page.totalPage}">
					 &gt; 
				</c:when>
				<c:otherwise>
					<c:choose>
                         <c:when test="${page.searchText == null}">
                             <a href="goodsList?page=${page.curPage + 1}"> &gt; </a>
                         </c:when>
                         <c:otherwise>
                             <a href="searchRs?page=${page.curPage + 1}&type=${page.type}&srchText=${page.searchText}"> &gt; </a>
                         </c:otherwise>
                     </c:choose>
				</c:otherwise>
				</c:choose>
				
				<!-- 끝 -->
				<c:choose>
				<c:when test="${page.curPage == page.totalPage}">
					 &gt;&gt; 
				</c:when>
				<c:otherwise>
					<c:choose>
                         <c:when test="${page.searchText == null}">
                             <a href="goodsList?page=${page.totalPage}"> &gt;&gt; </a>
                         </c:when>
                         <c:otherwise>
                             <a href="searchRs?page=${page.totalPage}&type=${page.type}&srchText=${page.searchText}"> &gt;&gt; </a>
                         </c:otherwise>
                     </c:choose>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		</c:if>
		
	</table>
	<br>
	<button class="btn btn-outline-secondary my-2 my-sm-0"  onclick="opAdd()">옵션추가</button>
	<button class="btn btn-outline-secondary my-2 my-sm-0"  onclick="mod()">수정</button>
	<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="del()">삭제</button>
</section>				
</body>
</html>