<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 상품 옵션 삭제</title>
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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function optionDelete() {     //재고수정
		if($("input[name=BCD_DETAILKEY]:checked").length<1){
            alert("적어도 1개는 체크.");
			return;
		} else {
			var queryString=$("#optionDelete").serialize();     
		    $.ajax({
		        url: '/admin/optionDelete',  
		        type: 'POST',
		        data: queryString,
		        dataType: 'json',
		        success: function(json) {  
		            if(json.desc == 1){
		                window.location.reload();    
		            } else if (json.desc == 0){
		                alert("데이터베이스입력오류")
		            } else if (json.desc == -1) {
		                alert("배열없음")
		            } else {
		                alert(json.desc);
		            }                                           
		        }
		    });
		}
	    
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
	<h3>옵션삭제</h3><br>
	<table border="1" id="myList">
		<form id="optionDelete" method="post">   
		<tr>
            <td></td>
            <td>품번</td>
            <td>상세품번</td>
            <td>옵션</td>
            <td>재고수량</td>       	       
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
		<c:choose>
			<c:when test="${fn:length(list) == 1}">
            <td>
				<input type="checkbox" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="${dto.bcd_detailkey}" disabled>
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
				<input type="hidden" id="BCD_OPTION" name="BCD_OPTION" value="${dto.bcd_option}">
				<input type="hidden" id="BCD_STOCK" name="BCD_STOCK" value="${dto.bcd_stock}">
            </td>
            옵션이 1개일 때는 전체 상품 삭제 페이지에서 삭제 해주세요.
            </c:when>
            <c:otherwise>
            <td>
				<input type="checkbox" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="${dto.bcd_detailkey}" >
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
				<input type="hidden" id="BCD_OPTION" name="BCD_OPTION" value="${dto.bcd_option}">
				<input type="hidden" id="BCD_STOCK" name="BCD_STOCK" value="${dto.bcd_stock}">
            </td>	
            </c:otherwise>   
         </c:choose>   
            <td> ${dto.bcg_key} </td>   
            <td> ${dto.bcd_detailkey} </td>   
            <td> ${dto.bcd_option} </td>            
            <td> ${dto.bcd_stock} </td>              
		</tr>
		</c:forEach>   
		</form>   
	</table>
	<br>
	<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="optionDelete()">삭제</button>&nbsp;
	<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="javascript:window.location='/admin/goodsList'">목록</button>
</section>
</body>
</html>