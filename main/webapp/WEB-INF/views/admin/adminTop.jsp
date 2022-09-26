<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String name = (String)session.getAttribute("name");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Bootstrap CSS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<style>
   	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
   	#logo {
   		font-size: 50px;
   		font-weight: bold;
   		margin-left: 10%;
   		margin-top: 25px;
   	}
	.logoNav {
		position: fixed;
		box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);		
		width: 100%;
		top: 0px;
		background: #E6E6FA;
		font-family: 'tway_air';
		height: 150px;
		z-index: 10;
	}
	div #navbarSupportedContent {
		font-size: 20px;
		margin-left: 80%;
		display: inline;
	}
	
	#logout {
		font-size: 15px;
		display: inline;
	}


</style> 
	
</head>
<body>
<div class="adminTop" style="display: inline-block;">
		<nav class="logoNav navbar-light" >
			<div>
				<a class="navbar-brand" href="/" id="logo"> 
				<img src="/image/logo.PNG" width="80" height="80">
					BestCosmetic
				</a>
				<span id="navbarSupportedContent">관리자 <%=name %>님<a class="nav-link" href="/logout" id="logout">로그아웃</a></span>
			</div>
		</nav>
</div>
</body>
</html>