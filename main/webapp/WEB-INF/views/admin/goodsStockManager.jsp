<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 재고관리</title>
<script src="https://kit.fontawesome.com/785a1334a7.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery.js"></script>
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
<script>

	function upCount(ths) {
		var $input = $(ths).parents("td").find("input[name='count']");
	    var tCount = Number($input.val());
	    var result =$input.val(Number(tCount)+1);
	}

	function downCount(ths) {
		var $input = $(ths).parents("td").find("input[name='count']");
	    var tCount = Number($input.val());
	    if (tCount==0) {
	    	alert("수량은 0개 이하로 내릴 수 없습니다.");
		    return;
	    } else {
	    	var result = $input.val(Number(tCount)-1);
	    }
	}
	
	function form_check() {
		var num_check = /^[0-9]*$/;
		if (!num_check.test($('#BCG_KEY').val())) {
            alert("품번검색은 숫자만 입력 가능합니다.");
            $('#BCG_KEY').focus();
            return;
        } else {
        	sch();
        }
	}
	
	function sch() {             //검색기능
	    var queryString=$("#adminSch").serialize();
	    $.ajax({
	        url: '/admin/stockManager',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'text',
	        success: function(json) {  
	            window.location.replace("/admin/optionList");
	        }          
	    });
	}	
	
	function num_check() {
		var num_check = /^[0-9]*$/;
		if (!num_check.test($('#count').val())) {
            alert("재고는 숫자만 입력 가능합니다.");
            $('#count').focus();
            return;
        } else {
        	stockModify();
        }
	}
	
	function stockModify() {     //재고수정
	    var queryString=$("#stockModify").serialize();     
	    $.ajax({
	        url: '/admin/stockUpdate',  
	        type: 'POST',
	        data: queryString,
	        dataType: 'json',
	        success: function(json) {  
	            console.log(json);
	            if(json.desc == 1){
	                alert("성공");
	                window.location.replace("/admin/goodsList");    
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
<h3>재고관리</h3><br>
	<form id="adminSch" name="adminSch">              
	  <input class="form-control mr-sm-2" type="text" id="BCG_KEY" name="BCG_KEY" style="width: 200px; float:left;">&nbsp;
	  <input type="button" class="btn btn-outline-secondary my-2 my-sm-0" value="품번검색" onclick="form_check()">
	</form>   <br> 
	<table border="1" id="myList">
		<c:if test="${BCG_KEY!= 0}">
		<form id="stockModify" method="post">
		<tr>
            <td>품번</td>
            <td>상세품번</td>
            <td>옵션</td>
            <td>재고수량</td>   
		</tr>
		<c:forEach items="${list}" var="dto">
		<tr>
			<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
			<input type="hidden" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="${dto.bcd_detailkey}">
			<input type="hidden" id="BCD_OPTION" name="BCD_OPTION" value="${dto.bcd_option}">
			<input type="hidden" id="BCD_STOCK" name="BCD_STOCK" value="${dto.bcd_stock}">                    
            <td> ${dto.bcg_key} </td>   
            <td> ${dto.bcd_detailkey} </td>   
            <td> ${dto.bcd_option} </td>            
            <td>
                <span onclick="downCount(this);"><i class="fa-solid fa-circle-minus"></i></span>
                <input type="text" name="count" id="count"
                                    min="1" max="${dto.bcd_stock}" size="2" maxlength="2" value="${dto.bcd_stock}" readonly >
                <span onclick="upCount(this);"><i class="fa-solid fa-circle-plus"></i></span>
            </td>                  
		</tr>
		</c:forEach>   
		</form>   
		</c:if>   
	</table> 
	<br>
	<input type="button" class="btn btn-outline-secondary my-2 my-sm-0" value="수정" onclick="num_check()">
</section>           
</body>
</html>