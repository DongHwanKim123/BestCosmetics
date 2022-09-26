<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
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
    </style>
</head>
<body style="background-color: #E6E6FA;">
<div style="float: top">
   	<c:import url="/admin/adminTop"></c:import>
</div>

<div style="float: left">
   	<c:import url="/admin/adminPageView"></c:import>
</div>
<section id="all">
    <h3>어플 알림 결과</h3><br>
		알림 제목 : ${notiTitle} <br/>
        알림 부제목 : ${notiBody } <br />
        메세지 : ${message } <br />
        결과 : ${result }

</section>
</body>
</html>
