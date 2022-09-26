<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>
    	@font-face {
		    font-family: 'tway_air';
		    src: url('/tway_air.ttf') format('truetype');
		}
        #myPageDiv01{
            position: fixed;
        	top: 190px;
            width: 210px;
            height: 100%;
            white-space: nowrap;
            background-color: #E6E6FA;
            font-family: 'tway_air';
            padding: 15px;
            z-index: 4;
        }
        a:hover{
            font-weight : bold;
            color: #000000;
        }
        a {
        	color: #000000;
        }
    </style>
</head>
<body>
    <div id="myPageDiv01">
        <ul class="nav flex-column nav-light">
        	<li style="font-size: 30px; text-align: center;">MyPage</li>
        	<li><br/></li>
            <li>
                주문
                <ul>
                    <li class="nav-item active">
                   		<a class="nav-link" href="/member/orderDelivery" id="sidebar">주문/배송조회</a></li>
                    <li class="nav-item active">
                    	<a class="nav-link" href="/member/cancelExchangeRefund" id="sidebar">취소/교환/반품</a></li>
                </ul>
            </li>
            <li>
                회원
                <ul>
                    <li class="nav-item active">
                    	<a class="nav-link" href="/member/like" id="sidebar">찜 목록</a></li>
                    <li class="nav-item active">
                    	<a class="nav-link" href="/member/modifyMemberView" id="sidebar">회원 정보 수정</a></li>
                    <li class="nav-item active">
                    	<a class="nav-link" href="/member/passwordChange" id="sidebar">비밀번호 변경</a></li>
                    <li class="nav-item active">
                    	<a class="nav-link" href="/member/out" id="sidebar">회원 탈퇴</a></li>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>
