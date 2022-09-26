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
    <h3>어플 알림</h3><br>

    <form action="/admin/FCMSender" method="post">
        <textarea name="notiTitle" cols="50" placeholder="알림 타이틀" /></textarea> <br />
        <textarea name="notiBody" rows="4" cols="50" placeholder="알림 서브타이틀" ></textarea> <br />
        <textarea name="message" rows="4" cols="50" placeholder="알림 메세지" ></textarea> <br />
        <input type="submit" class="btn btn-outline-secondary my-2 my-sm-0" value="보내기" />
    </form>
</section>
</body>
</html>
