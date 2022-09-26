<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	$(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김
	setInterval(nextSlide, 4000); //4초(4000)마다 다음 슬라이드로 넘어감
});

//이전 슬라이드
function prevSlide() {
	$(".mySlideDiv").hide(); //모든 div 숨김
	var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
	var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
	
	//반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
	$(".mySlideDiv").each(function(index,item){ 
		if($(this).hasClass("active")) {
			currentIndex = index;
		}     
	});
	
	//새롭게 나타낼 div의 index
	var newIndex = 0;
    
	if(currentIndex <= 0) {
		//현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
		newIndex = allSlide.length-1;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
		newIndex = currentIndex-1;
	}

	//모든 div에서 active 클래스 제거
	$(".mySlideDiv").removeClass("active");
    
	//새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();
}

//다음 슬라이드
function nextSlide() {
	$(".mySlideDiv").hide();
	var allSlide = $(".mySlideDiv");
	var currentIndex = 0;
	
	$(".mySlideDiv").each(function(index,item){
		if($(this).hasClass("active")) {
			currentIndex = index;
		}        
	});
	
	var newIndex = 0;
	
	if(currentIndex >= allSlide.length-1) {
		//현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
		newIndex = 0;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
		newIndex = currentIndex+1;
	}

	$(".mySlideDiv").removeClass("active");
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();	
}
</script>
<style>
@font-face {
    font-family: 'tway_air';
    src: url('/tway_air.ttf') format('truetype');
}

body {
    padding-top: 200px;
    padding-bottom: 120px;
}

.main {
	width: 1200px;
	background-color: #E6E6FA;
	margin-left:auto; 
    margin-right:auto;
	font-family: 'tway_air';
	border-spacing: 5px;
    border-collapse: separate;
}

.mdpick {
	text-align: center; 
	width: 300px;
	background-color: #E6E6FA;
}

.NnB {
	text-align: center; 
	width: 240px;
	background-color: #E6E6FA;
}

/* Slideshow container */
.slideshow-container {
    width: 1200px;
    position: relative;
    margin: auto;
}

/* effect */
.fade {
    -webkit-animation-name: fade;
    -webkit-animation-duration: 4s;
    animation-name: fade;
    animation-duration: 4s;
}

@-webkit-keyframes fade {
    from {opacity: .4} 
    to {opacity: 1}
}

@keyframes fade {
    from {opacity: .4} 
    to {opacity: 1}
}

/* Next & previous buttons */
.prev, .next {
    cursor: pointer;
    position: absolute;
    top: 50%;	
    width: auto;
    padding: 16px;
    margin-top: -22px;
    color: white;
    font-weight: bold;
    font-size: 18px;
    transition: 0.6s ease;
    border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
    right: 0;
    border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
    background-color: rgba(0,0,0,0.8);
}
</style>
</head>
<body style="background-color: #E6E6FA;">
	<div class="menuTop" style="float: top">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	
	<div class="slideshow-container">
	     <div class="mySlideDiv fade active" id="active">
	        <img src="/banner/0.jpg" height="auto" width="100%" > 
	     </div> 
	     <div class="mySlideDiv fade">
	        <img src="/banner/1.jpg" height="auto" width="100%" style="cursor:pointer;" onclick="javascript:window.location='/guest/detailPage?BCG_KEY=64'"> 
	     </div>          
	     <div class="mySlideDiv fade">
	         <img src="/banner/2.jpg" height="auto" width="100%" > 
	     </div>            
	     <div class="mySlideDiv fade">
	         <img src="/banner/3.jpg" height="auto" width="100%" > 
	     </div>
	     <div class="mySlideDiv fade">
	         <img src="/banner/4.jpg" height="auto" width="100%" > 
	     </div>
	     <a class="prev" onclick="prevSlide()">&#10094;</a>
	     <a class="next" onclick="nextSlide()">&#10095;</a>            
	</div>
	
	<table class="main">
		<tr>
			<td colspan="4">MDPICK</td>
		</tr>		
		<tr>
			<c:forEach items="${mdlist}" var="dto" begin="0" end="3">		
				<td class="mdpick"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">	
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">						
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>	
	</table>
	<table class="main">	
		<tr>
			<td colspan="5">BEST</td>
		</tr>		
		<tr>
			<c:forEach items="${blist}" var="dto" begin="0" end="4">		
				<td class="NnB"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>		
		<tr>
			<td colspan="5">NEW</td>
		</tr>		
		<tr>
			<c:forEach items="${nlist}" var="dto" begin="0" end="4">		
				<td class="NnB"> 
					<a href="/guest/detailPage?BCG_KEY=${dto.bcg_key}">
						<img src="${dto.bcg_img}" height="auto" width="100%" style="border-radius:15%">
						<input type="hidden" name="BCG_KEY" value="${dto.bcg_key}">
					</a><br/>
					${dto.bcg_name}<br/>						
				</td>
			</c:forEach>
		</tr>			
	</table>	
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>