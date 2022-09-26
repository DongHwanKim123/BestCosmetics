<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    int sNum = 0;
    String sName = "";
    String sEmail = "";
    String sId = "";
    String firstEmail = "";
    String secondEmail = "";
    if(session.getAttribute("num") != null) {
        sNum = (int) session.getAttribute("num");
        sId = (String) session.getAttribute("id");
        sName = (String) session.getAttribute("name");
        sEmail = (String) session.getAttribute("email");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>취소/교환/반품</title>
    <script src="http://code.jquery.com/jquery.js"></script>
<style>
    @font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	body {
	    padding-top: 210px;
	    padding-bottom: 120px;  
	}
	.selectpage {
		background-color: #d2d2fc;
		border-radius: 0 50px 50px 0;
	}
	.payheader {
		font-size: 30px;
		text-align: center;
		height: 100px;
		width: 100%;
		background-color: #f2f2fc;
		border-radius: 50px;
	}
	.tableD {
		position: relative;
	    margin: auto;
	    width: 1200px;	  
	    padding-left: 15px;  
	    text-align: center;
	    align: center; 
	    font-family: 'tway_air';
	}

</style>    
</head>
<body style="background-color: #E6E6FA;">
<div style="float: top">
    <c:import url="/guest/menuTop"></c:import>
</div>
<div class="tableD">
    <br>
    <table class="payheader" >
    	<colgroup>
    		<col style="width: 25%">
    		<col style="width: 12%">
    		<col style="width: 25%">
    		<col style="width: 12%">
    		<col style="width: 25%">
    	</colgroup>       	
        <tr>
        	<td>장바구니</td>
         	<td><img src="/image/rightBtn.png"></td>
        	<td>주문/결제</td>
        	<td><img src="/image/rightBtn.png"> </td>
         	<td class="selectpage">주문완료</td>
    	</tr>
    </table>
    <br>
    <table style="width:100%; font-size: 20px; border-spacing: 5px;">
        <thead style="height: 50px; background-color: #d2d2fc;">
        <tr>
            <td>주문자</td>
            <td>이메일</td>
        </tr>
        </thead>
        <tbody>
        <tr>
    	    <input type="hidden" id="sId" name="sId" value="<%= sName %>">
    	    <input type="hidden" id="orderNum" name="orderNum" value="${orderNum}">
            <td id="sName"><%=sName %></td>
            <td id="sEmail"><%=sEmail %></td>
        </tr>
        </tbody>
    </table>
	<div>
	    <h4>주문 완료 되었습니다.</h4>
	    <br>
        <button style="width: 100%; border: none; font-size: 30px; background-color: #d2d2fc; text-align: center; border-radius: 30px;" onclick="location.href='/member/orderDelivery'";>
            주문내역 보기
        </button>
	</div>    
</div>
<hr/>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
