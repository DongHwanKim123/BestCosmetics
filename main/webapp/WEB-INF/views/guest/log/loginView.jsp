<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
	if(session.getAttribute("num") != null) {
		response.sendRedirect("/");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function join() {
	window.location = '/guest/join';
}
function snsLogin(sns) {
	window.location = "/oauth2/authorization/"+sns;
}
</script>
<style type="text/css">
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	body {
    	padding: 35%;
	}		
   	.loginchart {
   		top: 5%;
   		width: 400px;
   		position: absolute;
   		font-family: 'tway_air'; 
   		border-spacing: 5px;
   		font-size: 20px;  		
   	}
</style>
<body style="background-color: #E6E6FA;">
	<table class="loginchart">
		<tr><td colspan="2" style="width: 400px; text-align:center;">
			<div class="container-fluid">
				<a href="/" id="logo"> 
					<img src="/image/logo.PNG" width="70%" alt="">
				</a>
			</div>
		</td></tr>
		<form action="/loginDo" method="post">
			<tr><td style="width: 300px; height: 100px;">
					<input type="text" name="j_username" placeholder="ID" 
						   style="width: 100%; height: 40px; border: none; border-radius: 10px;
						   font-size: 20px;"><br/><br/>
					<input type="password" name="j_password" placeholder="Password" 
						   style="width: 100%; height: 40px; border: none; border-radius: 10px; 
						   font-size: 20px;"></td>
				<td style="height: 100px;"><input type="submit" value="LOGIN" 
						   style="width: 100%; height: 100%; border: none; border-radius: 10px; font-family: 'tway_air';
								  background-color: #d2d2fc; cursor:pointer; font-size: 25px; text-align: center; color: white;"></td></tr>
		</form>
		<tr><td><br/></td></tr>
		<tr><td colspan="2" style="font-size: 15px; color:grey; text-align: center;">${message}</td></tr>
		<tr><td><br/></td></tr>
		<tr><td colspan="2"><button onclick="join()" 
						style="width: 100%; height: 40px; border: none; border-radius: 10px; font-family: 'tway_air';
							  background-color: #d2d2fc; cursor:pointer; font-size: 25px; text-align: center; color: white;">회원가입</button></td></tr>
		<tr><td><br/></td></tr>
		<!-- 
		<a href="https://www.flaticon.com/kr/free-icons/" title="구글 아이콘">구글 아이콘  제작자: Freepik - Flaticon</a>
		<a href="https://www.flaticon.com/free-icons/kakao-talk" title="kakao talk icons">Kakao talk icons created by Fathema Khanom - Flaticon</a>
		<a href="https://www.flaticon.com/free-icons/facebook" title="facebook icons">Facebook icons created by Freepik - Flaticon</a>
		-->
		<tr><td colspan="2" style="text-align:center; color: grey">sns 로그인</td></tr>
		<tr><td colspan="2" style="text-align:center;">
			<input type="image" src="/image/google.png" width="50" height="50" onclick="snsLogin('google')">&nbsp;&nbsp;
			<input type="image" src="/image/facebook.png" width="50" height="50" onclick="snsLogin('facebook')">&nbsp;&nbsp;
			<input type="image" src="/image/kakao.png" width="50" height="50" onclick="snsLogin('kakao')">&nbsp;&nbsp;
			<input type="image" src="/image/naver.png" width="50" height="50" onclick="snsLogin('naver')"></td></tr>
	</table>	
	<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
