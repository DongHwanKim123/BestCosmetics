<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><!DOCTYPE html>
<html>
<head>
    <title>주문배송</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<style>
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	.orderInfo {
		display : none;
	}
	.text {
		font-size : 16px;
		font-family: 'tway_air';
		margin : 0px;
		float : left;
		padding-top : 0px;
		padding-left : 5px;
		border : 0;
	}
	.textbutton {
		border: 2; 
		border-radius: 5px; 
		font-family: 'tway_air';
		background-color: #d2d2fc; 
		text-align: center;
	}
	#pimg {
		float : left;
	}
	/*popup*/
	.popup_layer {
		position:fixed;
		top:0;
		left:0;
		z-index: 10000; 
		width: 100%; 
		height: 100%; 
		background-color: rgba(0, 0, 0, 0.4); 
	}
	/*팝업 박스*/
	.popup_box {
		position: relative;
		top:50%;
		left:50%; 
		overflow: auto; 
		height: 600px; 
		width:500px;
		border-radius: 10px;
		transform:translate(-50%, -50%);
		z-index:1002;
		box-sizing:border-box;
		background-color: #f2f2fc;
		box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);
		-webkit-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);
		-moz-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);
	}
	/*주문내역제목*/
	.popup_box .poplist {
		display:table;
		table-layout: fixed;
		width:100%;
		height:30px;
		background: #d2d2fc;
		word-break: break-word;
		position: absolute;
		top: 0;
		text-align:center;
		font-size: 25px;
		font-family: 'tway_air';
	}
	/*내역 리스트*/
	.popup_box #infoDiv {		
		position: relative;
		top: 40px;
		width: 100%;
	}
	/*버튼영역*/
	.popup_box .popup_btn {
		display:table;
		table-layout: fixed;
		width:8%;
		height:40px;
		word-break: break-word;
		position : fixed;
		top: 0px;
		right: 0px;
		cursor:pointer;
	}
	/*오버레이 뒷배경*/
	.popup_overlay {
		position:fixed;
		top:0px;
		right:0;
		left:0;
		bottom:0;
		z-index:1001;
		background:rgba(0,0,0,0.5);
	}
	
	body {
	    padding-top: 190px;
	    padding-bottom: 120px;  
	}
	.tableD {
		font-family: 'tway_air';
		position: relative;
	    left: 210px; 
	    width: 1200px;	    
	}
	thead {
		background-color: #f2f2fc;
		text-align: center;
	}
</style>
<body style="background-color: #E6E6FA;">
<div style="float: top">
    <c:import url="/guest/menuTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/member/mypageView"></c:import>
</div>
<table border="3" bordercolor="#f2f2fc" class="tableD">
	<thead>
	<tr><td colspan="5" style="font-size: 25px;">주문 / 배송조회</td></tr>
    <tr>
        <td>주문번호</td>
        <td>주문금액</td>
        <td>주문정보</td>
        <td>주문상태</td>
        <td>주문변경</td>
    </tr>
    </thead>
    <tbody id="tableDD">
    <c:if test="${fn:length(list)==0}">
    	<tr><td colspan="5" style="text-align:center">주문 / 배송조회할 내역이 없습니다</td></tr>
    </c:if>
    <c:forEach items="${list}" var="dto">
    <tr>
        	<input type="hidden" id="ordernum${dto.bco_ordernum}" name="bco_ordernum" value="${dto.bco_ordernum}">
        <td>${dto.bco_ordernum}</td>
        <td id="money${dto.bco_ordernum}" style="text-align:right;">${dto.bco_totalprice}원</td>
        	<input id="realmoney${dto.bco_ordernum}" type="hidden" value="${dto.bco_totalprice}"/>
        <td style="text-align:center;"><a href="#" onclick="openPop${dto.bco_ordernum}()">${dto.bco_order_name}</a></td>
        <td>${dto.bco_order_status}</td>
        <td align="center" >
            <c:if test="${dto.bco_order_status == '배송준비중'}">
                <input type="button" value="취소신청" onclick="취소신청${dto.bco_ordernum}()"
                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; text-align: center;"><br>
                <input type="button" value="교환신청" onclick="교환신청${dto.bco_ordernum}()"
                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; text-align: center;">
            </c:if>
            <c:if test="${dto.bco_order_status == '배송완료'}">
                <input type="button" value="교환신청" onclick="교환신청${dto.bco_ordernum}()"
                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; text-align: center;"><br>
                <input type="button" value="반품신청" onclick="반품신청${dto.bco_ordernum}()"
                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; text-align: center;"><br>
                <input type="button" value="구매확정" onclick="구매확정${dto.bco_ordernum}()"
                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; text-align: center;">
            </c:if>
        </td>
    </tr>

<script>
    function 취소신청${dto.bco_ordernum}() {
        console.log('취소신청');
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);

        $.ajax({
            url : '/member/cancellationRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                   
                    window.location='/member/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });


    }
    function 교환신청${dto.bco_ordernum}() {
        console.log('교환신청');
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/member/exchangeRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    
                    window.location='/member/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
    function 반품신청${dto.bco_ordernum}() {
        console.log('반품신청')
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/member/refundRequest',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                    window.location='/member/cancelExchangeRefund';
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
    function 구매확정${dto.bco_ordernum}() {
        console.log("구매확정")
        var queryString = $('#ordernum${dto.bco_ordernum}').serialize();
        console.log(queryString);
        $.ajax({
            url : '/member/purchaseConfirmation',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                console.log(json);
                if(json.desc == 1){
                	alert("구매확정되었습니다");
                	window.location.reload();
                }else if (json.desc == 0) {
                    alert("데이터베이스입력오류입니다.")
                }
            }
        });
    }
</script>
<script>
    var money = $('#money${dto.bco_ordernum}').text();
    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    $('#money${dto.bco_ordernum}').text(money2);
    //머니값체크 , 넣은거
    var moneyValCheck =  $('#money${dto.bco_ordernum}').text();
    //진짜 머니 , 없는거
    var realmoneyValCheck = $('#realmoney${dto.bco_ordernum}').val();
</script>
<script>
	function openPop${dto.bco_ordernum}() { 	
		var queryString = 'bco_ordernum=${dto.bco_ordernum}';
		$.ajax({
		url : '/member/orderDetail',
			type : 'POST',
			data : queryString,
			success : function(data) {
				var text = "";
				for(var i=0; i<data.length; i++) {
					var bcg_price = data[i].bcg_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					var total_price = data[i].total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					var imgbase64 = btoa(data[i].bcg_img);
					var namebase64 = btoa(encodeURIComponent(data[i].bcg_name));
					var url = '/member/reviewWrite?bco_ordernum='+data[i].bco_ordernum+'&bcg_img='+imgbase64+'&bcg_name='+namebase64+'&bcg_key='+data[i].bcg_key+'';
					var width = '400';
					var height = '650';
					console.log(url);
					text += '<img id="pimg" src="'+data[i].bcg_img+'" width="115" height="115" style="padding-left: 10px;">';
					text += '<p class="text">상품명 : '+data[i].bcg_name+'</p><br>';
					text += '<p class="text">금액 : <span>'+bcg_price+'</span>원</p><br>';
					text += '<p class="text">옵션 : '+data[i].bcd_option+'</p><br>';
					text += '<p class="text">수량 : '+data[i].bco_count+'</p><br>';
					text += '<p class="text">결제 금액 : <span>'+total_price+'</span>원</p><br>';
					if(data[i].bco_order_status == '구매확정' && data[i].bco_reviewcheck == 'false') {
						text += '<p style="padding-left:10px;"><input type="button" class="textbutton" value="리뷰쓰기" onclick="javascript:window.open(\''+url+'\', \'\', \'width='+width+', height='+height+'\');"></p>';
					}
					else if(data[i].bco_order_status == '구매확정' && data[i].bco_reviewcheck == 'true'){
						text += '<p style="font-size: 12px; color:grey; padding-left:10px; font-family: \'tway_air\';">리뷰작성완료</p>';
					}
					text += '<hr>';
					$('#infoDiv').empty().append(text);
				}
				document.getElementById("popup_layer").style.display = "block";
			}
		});
	}
</script>
    </c:forEach>	
		<c:if test="${page.totalCount > 0 }">   		
		<tr style="text-align: center; background-color: #f2f2fc;">
	        <td colspan="5">
	            <!--처음-->
	            <c:choose>
	                <c:when test="${(page.curPage-1)<1}">
	                     &lt;&lt; 
	                </c:when>
	                <c:otherwise>
	                    <a href="orderDelivery?page=1"> &lt;&lt; </a>
	                </c:otherwise>
	            </c:choose>
	
	            <!--이전-->
	            <c:choose>
	                <c:when test="${(page.curPage-1) < 1}">
	                     &lt; &nbsp;
	                </c:when>
	                <c:otherwise>
	                    <a href="orderDelivery?page=${page.curPage-1}"> &lt; </a> &nbsp;
	                </c:otherwise>
	            </c:choose>
	
	            <!--개별 페이지-->
	            <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
	                <c:choose>
	                    <c:when test="${page.curPage == fEach}">
	                         ${fEach} &nbsp;
	                    </c:when>
	
	                    <c:otherwise>
	                        <a href="orderDelivery?page=${fEach}"> ${fEach} </a> &nbsp;
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	
	            <!--다음-->
	            <c:choose>
	                <c:when test="${(page.curPage +1) > page.totalPage}">
	                    &gt;
	                </c:when>
	                <c:otherwise>
	                    <a href="orderDelivery?page=${page.curPage+1}">&gt;</a>
	                </c:otherwise>
	            </c:choose>
	
	            <!--끝-->
	            <c:choose>
	                <c:when test="${page.curPage == page.totalPage}">
	                    &gt;&gt;
	                </c:when>
	                <c:otherwise>
	                    <a href="orderDelivery?page=${page.totalPage}">&gt;&gt;</a>
	                </c:otherwise>
	            </c:choose>
	        </td>
	    </tr>
	    </c:if>
    </tbody>
</table>
	<script>
    	function closePop() {
	        document.getElementById("popup_layer").style.display = "none";
	        $('#infoDiv').empty();
	    }
   	</script>
   	<div class="popup_layer" id="popup_layer" style="display: none;">
		<div class="popup_box">
		<!--팝업 컨텐츠 영역-->
			<div class="poplist">주문내역</div>
			<div id="infoDiv">
				
			</div>
			<!--팝업 버튼 영역-->
			<div class="popup_btn">
				<img src="/image/delete.png" width="33" height="33" onclick="closePop();">
			</div>
		</div>
	</div>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
