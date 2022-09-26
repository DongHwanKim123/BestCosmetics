<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상단바</title>
<!-- Bootstrap CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<script type="text/javascript">
  	function form_check_Search() {
  		if($('#srchText').val().length == 0) {
  			alert("검색어를 입력해주세요");
  			$('#srchText').focus();
  			return;
  		} else { sch_Search(); }
  	}
  	
  	function sch_Search() {     //검색기능
       var queryString=$("#search_ck").serialize();
       $.ajax({
       	url: '/guest/guestSearch',  
           type: 'POST',
           data: queryString,
           dataType: 'text',
           success: function(json) {  
           	   window.location="/guest/searchARs";
           }       	
       });
   }
</script> 
<style>
   	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
   	div #logo {
   		font-size: 50px;
   		font-weight: bold;
   		padding-left: 10%;
   	}
   	.myNav {
		position: fixed;
		width: 100%;
		top: 0;
		background: #E6E6FA;
		font-family: 'tway_air';
		height: 40px;		
		z-index: 5;
	}
	.logoNav {
		position: fixed;
		box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);		
		width: 100%;
		top: 38px;
		background: #E6E6FA;
		font-family: 'tway_air';
		height: 150px;
		z-index: 10;
	}
	div #navbarSupportedContent {
		font-size: 15px;
		margin-left: 70%;
	}
	div #navbarScroll {
		font-size: 20px;
		background: #E6E6FA;
		padding-left: 10%;
		padding-right: 10%;
	}
	/* 상단바 호버 애니메이션 */
	.navbar-nav:after{display:block; content:''; clear:both;}
	.navbar-nav > li{position:relative; float:left; margin-right:5px;}
	.navbar-nav > li > a{display:block; padding:0 15px; height:40px; line-height:40px;}
	.navbar-nav > li:hover .dropdown-menu {display:block;}
	.navbar-nav .dropdown-menu{display:none; position:absolute; left:0; right:0; text-align:center;}
	.navbar-nav .dropdown-menu a{display:block; padding:5px;}
	.navbar-nav .dropdown-menu a:active {background-color: #E6E6FA; color: black;}
	
	#search_ck { width: 40%; }
	@media ( max-width: 1150px ) {
 	    .logoNav > ul{
 	    	padding-right: 0%;
 	    }
 	    div #navbarScroll {
			font-size: 20px;
			background: #E6E6FA;
			padding-left: 0%;
			padding-right: 0%;
		}		
	}
</style> 
</head>
<body>
	<nav class="myNav navbar-expand-sm navbar-light">
		<div class="container-fluid" id="navbarSupportedContent" >
			<ul class="navbar-nav">					
				<li class="nav-item">
					<a class="nav-link" href="/member/orderDelivery" id="myTopMyPage">마이페이지</a>
				</li>
				<sec:authorize access="isAnonymous()">
				<li class="nav-item">
					<a class="nav-link" href="/guest/loginView" id="myTopLogin">로그인</a>
				</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<a class="nav-link" href="/logout" id="myTopLogout">로그아웃</a>
				</li>
				</sec:authorize>
				<li class="nav-item">
					<a class="nav-link" style="cursor:pointer;"onclick="javascript:window.location='/member/basketView'">
						장바구니
						<c:choose>
							<c:when test="${basketCount>0}">
								<span>(${basketCount})</span>
							</c:when>
							<c:otherwise>
								<span></span>
							</c:otherwise>
						</c:choose>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/member/like" id="myTop">찜</a>
				</li>
			</ul>
		</div>
	</nav>	
	<nav class="logoNav navbar-expand-sm navbar-light">		
	    <div class="container-fluid">
		    <a class="navbar-brand" href="/" id="logo"> 
				<img src="/image/logo.PNG" width="80" height="80" alt="">
				BestCosmetic
			</a>
		    <div class="collapse navbar-collapse" id="navbarScroll">
		        <ul class="navbar-nav me-auto navbar-nav-scroll" style="width: 60%; padding-right: 20%;">
					<li class="nav-item dropdown">
					    <a class="nav-link dropdown-toggle" href="#" id="navbarScrollingDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
							상품
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarScrollingDropdown">
							<li><a class="dropdown-item" href="/guest/categoryAll">전체보기</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">스킨케어</a></li>
							<li><a class="dropdown-item" href="#">클렌징</a></li>
							<li><a class="dropdown-item" href="#">선케어</a></li>
							<li><a class="dropdown-item" href="#">베이스 메이크업</a></li>
							<li><a class="dropdown-item" href="/guest/categoryPoint">포인트 메이크업</a></li>
							<li><a class="dropdown-item" href="#">향수</a></li>
						</ul>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="">베스트</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">신상</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="">특가</a>
					</li>
		        </ul> 
		        <form id="search_ck" name="search_ck" action="" class="form-inline my-2 my-lg-0">
					<input type="hidden" name="type" value="bcg_name">					
					<input class="form-control mr-sm-2" id="srchText" name="srchText" type="search"
						placeholder="전체 상품 검색" aria-label="Search" style="width: 75%">
					<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="form_check_Search()" style="width: 20%; text-align:center;">Search</button>
				</form>
			</div>
	    </div>
	</nav>	
</body>
</html>