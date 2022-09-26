<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
	<!-- Bootstrap CSS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<style>
	 <style>
    	@font-face {
		    font-family: 'tway_air';
		    src: url('/tway_air.ttf') format('truetype');
		}
    
        #adminPageDiv01{
	        position: fixed;
        	top: 130px;
            width: 200px;
            height:100%;
            white-space: nowrap;
            background: #E6E6FA;
            font-family: 'tway_air';
            z-index: 4;
        }
        
        a {
        	color: #000000;
        }
        
        li .nav-item{
        	list-style:none;
        	padding: 3px;
        }
        
        #left {
        	margin-left: 3px;
        }
        


    </style>
</style>
</head>
<body>
    <div id="adminPageDiv01">
    <section id="left"><br>
    <a href="/admin">&nbsp;&nbsp;관리자페이지</a>
        <ul class="nav flex-column nav-light" >
            <li class="title">
            	<br>
                 &nbsp;&nbsp;- 회원
                <ul>
                    <li class="nav-item active">
                    	<a href='/admin/memberManagement'>회원관리</a>
                    </li>	
                </ul>
            </li>
            <li class="title">
                 &nbsp;&nbsp;- 주문관리
                <ul>
                    <li class="nav-item active">
                    	<a href='/admin/deliveryReady'>배송준비</a></li>
                    <li class="nav-item active">
                     	<a href='/admin/inTransit'>배송중</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/deliveryCompleted'>배송완료</a></li>
                    <li class="nav-item active"> 
                    	<a href='/admin/cancelExchangeRefundAdmin'>취소/교환/반품</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/purchaseConfirmation'>구매확정</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/orderListAdmin'>주문리스트</a></li>
                </ul>
            </li>
            <li class="title">
                 &nbsp;&nbsp;- 상품관리
                <ul>
                    <li class="nav-item active"> 
                    	<a href='/admin/goodsList'>상품리스트</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/goodsAdd'>상품등록</a></li>
                    <li class="nav-item active">
                    	<a href='/admin/stockManager'>재고관리</a></li>                  
                    <li class="nav-item active">
                    	<a href='/admin/goodsQuestionList'>상품문의</a></li>	
                </ul>
            </li>
            <li class="title">
                &nbsp;&nbsp;- 푸쉬메세지
                <ul>
                    <li class="nav-item active">
                        <a href='/admin/push'>푸쉬알림</a></li>
                </ul>
            </li>
        </ul>
    </section>
    </div>
</body>
</html>