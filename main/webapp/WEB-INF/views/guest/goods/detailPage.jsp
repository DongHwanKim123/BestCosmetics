<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	int bcm_num = 0;
	String bcm_name = ""; 
	if(session.getAttribute("num")!=null) {
		bcm_num = (int)session.getAttribute("num");
		bcm_name = (String)session.getAttribute("name");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script type="text/javascript">
	//수량버튼 +
	function upCount(ths) {            
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());	
	    if(${fn:length(list)}==1) {                     //상세옵션이 따로 없을 경우
		    var option = ${list.get(0).bcd_stock};	    //상세테이블 리스트의 0번 인덱스의 재고량. 걍 &{BCG_STOCK}으로 해도됨
	    	if(tCount==option) {
		    	alert("재고수량을 초과하였습니다.");
			    return;
	    	} else {
		    	var result = $input.val(Number(tCount)+1);
		    	sum(tCount+1);
		    }	
	    } else {                                        //상세옵션이 따로 있을 경우
	    	var index = $('#BCD_DETAILKEY').find("option:selected").data("nm");   //상세옵션중 선택된 옵션의 data-nm값(인덱스값)
	    	var option = ${list.get(index).bcd_stock};	                          //리스트 중 해당 인덱스의 재고량
	    	if(tCount==option) {
		    	alert("재고수량을 초과하였습니다.");
			    return;
	    	} else {
		    	var result = $input.val(Number(tCount)+1);
		    	sum(tCount+1);
		    }	
	    }    
	}
	
	//수량버튼 -
	function downCount(ths) {                
		var $input = $(ths).parents("td").find("input[name='BCB_COUNT']");
	    var tCount = Number($input.val());
	    if (tCount==1) {
	    	alert("수량은 1개 이하로 고를 수 없습니다.");
		    return;
	    } else {
	    	var result = $input.val(Number(tCount)-1);
	    	sum(tCount-1);
	    }
	}
	
	function sum(count) {                         //가격 총 합계
		var totalPrice = ${BCG_PRICE}*count;
		if(totalPrice > 999) {
			document.getElementById("totalPrice").innerHTML = thousandSeparatorCommas(totalPrice);
		} else {
			document.getElementById("totalPrice").innerHTML = "총 "+totalPrice+"원";
		}				
	}
	
	function thousandSeparatorCommas(number) {    //총 합계에 콤마찍기
		 var string = "" + number;                       // 문자로 바꾸기. 
		 string = string.replace( /[^-+\.\d]/g, "" )     // ±기호와 소수점, 숫자들만 남기고 전부 지우기. 
		 var regExp = /^([-+]?\d+)(\d{3})(\.\d+)?/;      // 필요한 정규식. 
		 while (regExp.test(string)) string = string.replace( regExp, "총 " + "$1" + "," + "$2" + "$3" + "원");  // 쉼표 삽입. 
		 return string; 
	} 
	
	function inBag() {                 //장바구니
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {
			//장바구니에 넣기
			var queryString=$("#buyInfo").serialize();
            console.log(queryString);
			$.ajax({
            	url: '/member/addBag',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                complete: function(json) {
                	if(confirm("장바구니로 이동하시겠습니까?") == true) {        
                		window.location='/member/basketView';
              		} else {        
              			return ;    
             		}
                },
				
            });
		}
	}
	
	function goPayment() {             //바로 결제하기
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {
			var queryString = "keyList="+$('#BCG_KEY').val()+"&detailkeyList="+$('#BCD_DETAILKEY').val()+"&countList="+$('#BCB_COUNT').val();
			console.log(queryString);
			$.ajax({
				url : '/member/orderList',
				type : 'POST',
				data : queryString,
				dataType: 'json',
				success : function(json) {
					sessionStorage.setItem("orderList",JSON.stringify(json));
					window.location='/member/paymentView';
				}
			});
		}
	}
	
	function likeUpdate${BCG_KEY}() {     //찜 업데이트
		if(<%=bcm_num%> == 0) {
			alert("로그인후 이용가능합니다.");
			return;
		} else {
			<%--if(${like}==0) { alert("찜목록에 추가 완료"); } --%>
        	<%--else { alert("찜목록에서 삭제 완료"); }--%>
			var queryString=$("#list${BCG_KEY}").serialize();
		    $.ajax({
		    	url: '/member/glike',  
		        type: 'POST',
		        data: queryString,
		        success: function(json) {
		        	$('#badge3').load(location.href + ' #badge3');
		        }       	
		    });
		}
	}
	
	$(function(){                 //맨위로 버튼 스크롤 따라 생기고 사라지기
		$('#goTop').hide();
	    //마지막 스크롤 값을 저장할 lastScroll 변수
	    var lastScroll = 0;
	    $(window).scroll(function(event){ //스크롤이 움직일때 마다 이벤트 실행
	        //현재 스크롤의 위치를 저장할 st 변수
	        var st = $(this).scrollTop();
	        //스크롤 상하에 따른 반응 정의
	        if (st > lastScroll){
	            if ($(window).scrollTop() >= 600) { //스크롤이 아래로 600px 이상 내려갔을때 실행되는 이벤트 정의
	                $('#goTop').fadeIn(400);
	            } else {
	            	$('#goTop').fadeOut(400);
	            }
	        } else {
	             //스크롤이 위로 올라갔을때 실행되는 이벤트 정의
	            if ($(window).scrollTop() >= 600) { //스크롤이 아래로 600px 이상 내려갔을때 실행되는 이벤트 정의
	                $('#goTop').fadeIn(400);
	            } else {
	            	$('#goTop').fadeOut(400);
	            }
	        }
	        //현재 스크롤 위치(st)를 마지막 위치로 업데이트
	        lastScroll = st;
	    });
	});
</script>
<script>
	function uploadQnA() {                 //문의하기
		if(<%=bcm_num%> == 0) {
			window.location='/guest/loginView';
		} else {  		
			var queryString=$('#uploadQ').serialize();
			//alert(queryString);
			$.ajax({
	            url: '/member/uploadQnA',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                complete: function(json) {	   
               	    alert("문의가 등록되었습니다.");
               	    $('#qnaView').load(location.href + ' #qqna');
               	    //$('#qnaView').append(json.responseText);
                },				
	        }); 		
		}
	}
	
	$(function(){
		$('textarea').keyup(function(){
			bytesHandler(this);
		});
	});
	
	function getTextLength(str) {
		var len = 0;
	
		for (var i = 0; i < str.length; i++) {
			if (escape(str.charAt(i)).length == 6) { len++; }
			len++;
		}
		return len;
	}
	
	function bytesHandler(obj){
		var context = $(obj).val();
		$('p.bytes').text("("+context.length+" / 150자)");
		if (context.length > 150){        
			alert("최대 150자까지 입력 가능합니다.");  
			$(obj).val($(obj).val().substring(0, 150));
			$('p.bytes').text("(150 / 150자)");  
		}
	}			
</script>	
<style type="text/css">
	.gg-lock {
		top: 12px;
	    box-sizing: border-box;
	    position: relative;
	    display: block;
	    transform: scale(var(--ggs,1));
	    width: 12px;
	    height: 11px;
	    border: 2px solid;
	    border-top-right-radius: 50%;
	    border-top-left-radius: 50%;
	    border-bottom: transparent;	    
	}
	.gg-lock::after {
	    content: "";
	    display: block;
	    box-sizing: border-box;
	    position: absolute;
	    width: 16px;
	    height: 10px;
	    border-radius: 2px;
	    border: 2px solid transparent;
	    box-shadow: 0 0 0 2px;
	    left: -4px;
	    top: 9px;
	}
	.starPoint {
	    font-size: 1em;
	    color: rgba(250, 208, 0, 0.99);
	}
	@font-face {
    	font-family: 'tway_air';
    	src: url('/tway_air.ttf') format('truetype');
	}
	body {
	    padding-top: 190px;
	    padding-bottom: 120px;  
	}
	div .menuTop {
		float: top;
	}
	.goTop {
		position: fixed;
		bottom: 100px;
		right: 25px;
		cursor:pointer;
	}
	.dPage {
		font-family: 'tway_air';
		margin: auto;
		width: 1000px;
	}
	.ddPage {
		font-family: 'tway_air';
		margin: auto;
		width: 1000px;
		background-color: #f2f2fc;
	}	
	.goodsDetailView {
	    margin: auto;
	    display: block;
	    width: 1000px;
	    background-color: #f2f2fc;
	    font-family: 'tway_air';
	    padding-bottom: 50px;
	}
	.reViewView {
	    margin: auto;
	    display: none;
	    width: 1000px;
	    background-color: #f2f2fc;
	    font-family: 'tway_air';
	    padding-bottom: 50px;
	}
	.qnaView {
	    margin: auto;
	    display: none;
	    width: 1000px;
	    background-color: #f2f2fc;
	    font-family: 'tway_air';
	    padding-bottom: 50px;
	}
	.activePage {
		margin: auto;
		width: 800px;
	}
	.badge {
		position: absolute;
		z-index: 1;
		left: 10px;
		top: 10px;
	}
	.badge2 {
		position: absolute;
		z-index: 2;
		right: 20px;
		bottom: 15px;
	}
	.tdsize {
		position: relative;
		width: 500px;
	}
	.goodsInfo {
		font-size: 25px;
		height: 90%;
		width: 95%;
		margin: auto;
		text-align: right;
		flex: 1;
		word-break:break-all;
		table-layout:fixed;
	}
	#totalPrice {
		font-size: 40px;
	}
	#infotag {
		width: 150px;		
	}
	#headtag {
		font-size: 25px; 
	}
		
	.line-height-0{
	    line-height:0;
	}	
	.line-height-0>*{
	    line-height:normal;
	}	
	.text-align-center{
	    text-align:center;
	}	
	.inline-block{
	    display:inline-block;
	}	
	.cell{
	    float:left;
	    box-sizing:border-box;
	}
	.cell-right{
	    float:right;
	    box-sizing:border-box;
	}
	.menu-bar{
	    font-family: 'tway_air';
		margin: auto;
		width: 1000px;
		background-color: #f2f2fc;
	}
	.menu-bar>.menu-box{
	    width: 900px;
	    font-size: 25px;
	    margin: auto;
	}
	.menu-bar>.menu-box>ul>li{
	    list-style:none;
	    text-align:center;
	    margin: auto;
	}
	.menu-bar>.menu-box>ul>li>a{
	    display:block;
	    padding:20px;
	    position:relative;
	}
	.menu-bar>.menu-box>ul>li>a::after{
	    content:"";
	    position:absolute;
	    bottom:0;
	    right:50%;
	    width:0;
	    height:4px;
	    background-color:white;
	    transition:width 1s;	  
	}
	.menu-bar>.menu-box>ul>li>a::before{
	    content:"";
	    position:absolute;
	    bottom:0;
	    left:50%;
	    width:0;
	    height:4px;
	    background-color: #d2d2fc;
	    transition:width 1s;
	}	
	.menu-bar>.menu-box>ul>li:hover>a::after{
	     width:50%;
	}	
	.menu-bar>.menu-box>ul>li:hover>a::before{
	    width:50%;
	}
	
	.star-ratings {
		margin:auto;
		color: #aaa9a9; 
		position: relative;
		unicode-bidi: bidi-override;
		width: max-content;
		-webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
		-webkit-text-stroke-width: 2px;
		-webkit-text-stroke-color: gold;
	}
	.star-ratings-fill {
		color: #fff58c;
		padding: 0;
		position: absolute;
		z-index: 1;
		display: flex;
		top: 0;
		left: 0;
		overflow: hidden;
		-webkit-text-fill-color: gold;
	} 
	.star-ratings-base {
		z-index: 0;
		padding: 0;
	}
	.qnaContent {
		padding: 20px; 
		vertical-align: top;
	}
	.far {
		cursor:pointer;
	}
</style>
</head>
<body style="background-color: #E6E6FA;">
	<div class="menuTop">
    	<c:import url="/guest/menuTop"></c:import>
	</div>
	<table class="dPage">
		<thead class="cateLink" style="font-size: 20px;">
		<tr>
			<td colspan="2">
				<c:if test="${BCG_CATEGORY eq 'skincare'}"><a href="" style="color:grey">스킨케어</a></c:if>
				<c:if test="${BCG_CATEGORY eq 'cleansing'}"><a href="" style="color:grey">클렌징</a></c:if>
				<c:if test="${BCG_CATEGORY eq 'suncare'}"><a href="" style="color:grey">선케어</a></c:if>
				<c:if test="${BCG_CATEGORY eq 'base'}"><a href="" style="color:grey">베이스메이크업</a></c:if>
				<c:if test="${BCG_CATEGORY eq 'point'}"><a href="/guest/categoryPoint" style="color:grey">포인트메이크업</a></c:if>
				<c:if test="${BCG_CATEGORY eq 'perfume'}"><a href="" style="color:grey">향수</a></c:if>
				> ${BCG_NAME}
			</td>
		</tr>
		</thead>
		<tbody style="background-color: #f2f2fc;">
		<tr>
			<td class="tdsize">
				<img src="${BCG_IMG}" width="100%">
				<div class="badge">
					<!-- NEW 뱃지 -->
					<c:set var="now" value="<%=new java.util.Date()%>" /><!-- 현재시간 -->
		         	<fmt:formatDate value="${now}" pattern="yyMMdd" var="today" /><!-- 현재시간을 숫자로 -->
		         	<fmt:formatDate  value="${BCG_DATE}" pattern="yyMMdd" var="dtoDate" /><!-- 게시글 작성날짜를 숫자로 -->
		         		<c:if test="${today - dtoDate le 30}"><!-- 30일동안은 new 표시 -->
		            		<img src="/image/new.png" width="50" height="50">
		         		</c:if>
		         	
		         	<!-- BEST 뱃지 -->	
		         	<fmt:formatNumber value="${BCG_SALE}" var="sale"/>
			         	<c:if test="${sale >= 10}">
			         		<img src="/image/best.png" width="50" height="50">
			         	</c:if>
			         	
			        <!-- SALE 뱃지 -->	
		         	<c:if test="${BCG_DISCOUNT > 0}">
		         		<img src="/image/sale.png" width="50" height="50">
		         	</c:if>
	         	</div>
				<form id="list${BCG_KEY}" name="list${BCG_KEY}" onsubmit="return false;">
	         		<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num %>">
	         		<input type="hidden" id="key" name="BCG_KEY" value="${BCG_KEY}">
	         		<div class="badge2" id="badge2">
	         			<div class="badge3" id="badge3">
                        <c:if test="${like==1}">
                            <input type="image" src="/image/red-heart.png" height="70" width="70" onclick ="likeUpdate${BCG_KEY}()">
                        </c:if>
                        <c:if test="${like==0}">
                            <input type="image" src="/image/heart.png" height="70" width="70" onclick ="likeUpdate${BCG_KEY}()">
                        </c:if>
                        </div>
                    </div>
	         	</form>
			</td>
			<td>
				<table class="goodsInfo">
					<thead>
						<tr>
							<td colspan="4" style="font-size: 40px; text-align:left">${BCG_NAME}</td>							
						</tr>
						<tr><td><br/></td></tr>
					</thead>
					<tbody>
						<tr><td colspan="4" style="font-size: 15px; color: grey;">현재까지 ${BCG_SALE}명이 구매한 상품입니다<br/></td></tr>
						<tr>
							<c:choose>
								<c:when test="${BCG_DISCOUNT == 0}">
									<td colspan="4">판매가 <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</td>
								</c:when>
								<c:otherwise>
									<td colspan="4">
										<p style="text-decoration:line-through; display:inline; color:grey;">
											판매가 <fmt:formatNumber type="number" maxFractionDigits="0" 
											value="${BCG_PRICE/(100-BCG_DISCOUNT)*100}" pattern="#,###"/>원
										</p>  → 
										<p style="display:inline;">
											할인가 <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원
										</p>	
									</td>									
								</c:otherwise>
							</c:choose>
						</tr>
						<c:if test="${BCG_STOCK == 0}">		
						<tr>
							<td colspan="4" style="color: red">이 상품은 품절입니다 ㅠㅠ</td>
						</tr>
						</c:if>
						<c:if test="${BCG_STOCK != 0}">		
							<form id="buyInfo" name="buyInfo">
							<c:if test="${fn:length(list) != 1}">								
							<tr>
							    <td colspan="4">						    	
									<select id="BCD_DETAILKEY" name="BCD_DETAILKEY" 
											style="height: 50px; width: 95%; border: 3px solid black; border-radius: 5px;">
										<c:forEach items="${list}" var="ddtos" varStatus="status">
											<option value="${ddtos.bcd_detailkey}" data-nm="${status.index}" 
												<c:if test="${ddtos.bcd_stock == 0}">disabled</c:if>>											
												${ddtos.bcd_option} (남은수량 : ${ddtos.bcd_stock})
											</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							
							</c:if>	
							<c:if test="${fn:length(list) == 1}">								
							<tr>
							    <td colspan="4">						    	
									<input type="hidden" id="BCD_DETAILKEY" name="BCD_DETAILKEY" value="0">								
								</td>
							</tr>
							</c:if>										
							<tr>
								<td colspan="2">
					                <span onclick="downCount(this);"><i class="far fa-minus-square" style="font-size:40px;"></i></span>
					                	<input type="text" id="BCB_COUNT" name="BCB_COUNT" 
					                			style="text-align:center; border: none; background-color: #f2f2fc; font-size:40px;"
					                           	size="2" maxlength="2" value="1" readonly>
					                <span onclick="upCount(this);"><i class='far fa-plus-square' style="font-size:40px;"></i></span>
					            </td> 
								<td colspan="2"><div id="totalPrice">총 <fmt:formatNumber value="${BCG_PRICE}" pattern="#,###"/>원</div></td>				            
							</tr>				
							<tr>
							    <td colspan="4">
							    	<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num%>">
							    	<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">						    	
							    </td> 
							</tr>
							<tr>
								<td colspan="2"><input type="button" value="장바구니" onclick="inBag()" 
														style="width: 95%; border: 3px solid black; border-radius: 5px;
																background-color: #d2d2fc; font-size: 35px;"></td>
								<td colspan="2"><input type="button" value="바로구매" onclick="goPayment()" 
														style="width: 95%; border: 3px solid black; border-radius: 5px;
																background-color: #d2d2fc; font-size: 35px;"></td>
							</tr>
							</form>
						</c:if>
					</tbody>	
				</table>
			</td>
		</tr>
		</tbody>
	</table>
	<div class="menu-bar text-align-center line-height-0">
	    <div class="menu-box inline-block">
	        <ul class="row">
	            <li class="cell"><a href="#" onClick="detail();return false;" style="color:inherit; text-decoration:none;">상세설명</a></li>
	            <li class="cell"><a href="#" onClick="review();return false;" style="color:inherit; text-decoration:none;">리뷰(${fn:length(reviewList)})</a></li>
	            <li class="cell"><a href="#" onClick="qna();return false;" style="color:inherit; text-decoration:none;">문의(${fn:length(questionList)})</a></li>
	        </ul>
	        <ul><li><hr></li></ul>
	    </div>
	</div>
	<div id="goodsDetailView" class="goodsDetailView">
		<table class="activePage" id="activePage">
			<thead>
				<tr><td colspan="2" style="margin:auto;"><img src="${BCG_IMGDETAIL}"></td></tr>
			</thead>
			<tbody>
				<tr><td colspan="2" id="headtag"><br/>제품요약정보</td></tr>
				<tr><td colspan="2"><hr></td></tr>
				<tr><td id="infotag">상품명</td><td>${BCG_NAME}</td></tr>
				<tr><td id="infotag">출시일</td><td>${BCG_DATE}</td></tr>
				<tr><td id="infotag">사용기한</td><td>개봉 전 24개월/개봉 후 6개월</td></tr>
				<tr><td id="infotag">사용방법</td><td>상세페이지 참조</td></tr>
				<tr><td id="infotag">제조업자</td><td>BestCos(주)</td></tr>
				<tr><td id="infotag">제품타입</td><td>모든피부</td></tr>
				<tr><td id="infotag">전성분</td><td>${BCG_INFO}</td></tr>
				<tr><td id="infotag">주의사항</td>
					<td>1. 화장품 사용시 또는 사용 후 직사광선에 의하여 사용부위가 붉은 반점, 부어오름 또는 가려움증 등의 이상 증상이나 부작용이 있는 경우 전문의 등과 상담할 것 
						2. 상처가 있는 부위 등에는 사용을 자제할 것 
						3. 보관 및 취급 시의 주의사항 1) 어린이의 손이 닿지 않는 곳에 보관할 것 2) 직사광선을 피해서 보관할 것</td></tr>
				<tr><td id="infotag">품질보증</td><td>본 제품에 이상이 있을 경우 공정거래위원회고시 '소비자분쟁해결기준'에 의해 보상해드립니다.</td></tr>
				<tr><td id="infotag">소비자상담번호</td><td>고객서비스 센터 080-380-0114</td></tr>				
			</tbody>
			<tbody>	
				<tr><td colspan="2" id="headtag"><br/>배송정보</td></tr>
				<tr><td colspan="2"><hr></td></tr>
				<tr><td id="infotag">1</td><td>배송지역 : 전국</td></tr>
				<tr><td id="infotag">2</td><td>배송비 무료</td></tr>
				<tr><td id="infotag">3</td>
					<td>베스트코스메틱은 CJ 택배를 이용합니다. 
						군부대의 경우 주문 단계에서 군부대 배송을 체크하여 주시면, 우체국 택배로 발송됩니다. 단, 택배 송장 번호 확인시 CJ 택배 송장이 표기되며,
						우체국 송장 번호는 고객 상담실로 전화 주시면 확인 가능합니다.</td></tr>
				<tr><td id="infotag">4</td>
					<td>배송예정일 : 
						평일 오후 2시 이전 주문 건은 당일 출고되며, 그 후 주문 건은 다음 날 출고됩니다. 
						보통 주문일로부터 평일 기준 2~3일 소요되며, 주말/공휴일이 포함되거나 할인 행사로 인한 주문 폭주 및 택배사의 사정 등으로 인한 경우 
						배송이 지연될 수 있습니다.</td></tr>
				<tr><td id="infotag">5</td><td>상품 불량 및 오배송 등으로 인한 교환/반품신청의 경우 배송비는 무료 입니다.</td></tr>
				<tr><td>6</td>
					<td>고객님의 단순 변심으로 인한 교환/반품 신청은 고객님께서 왕복배송비 5,000원을 부담해 주셔야 처리가 됩니다.
						제일은행 325-20-460048 (주)베스트코스메틱</td></tr>
				<tr><td id="infotag">7</td>
					<td>주의사항 : 
						한정된 수량으로 더 많은 고객님들께 혜택을 드리기 위하여, 
						동일 주소지 대량 주문 시 1인 고객으로 집계하여 해당 아이디에 대한 주문이 제한될 수 있습니다.</td></tr>
			</tbody>
			<tbody>	
				<tr><td colspan="2" id="headtag"><br/>교환/반품정보</td></tr>
				<tr><td colspan="2"><hr></td></tr>
				<tr><td id="infotag">1</td><td>사은품 품절 시 공지 없이 대체상품이 발송됩니다.</td></tr>
				<tr><td id="infotag"></td>
					<td>- 단순변심, 착오구매에 따른 교환/반품 신청은 상품을 공급받은 날부터 7일 이내 가능합니다. (배송비 고객 부담)<br/>
						- 다만, 공급받은 상품이 표시/광고의 내용과 다르거나 계약내용과 다르게 이행된 경우에는 상품을 공급받은 날부터 3개월 이내,
						그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내 교환/반품 신청을 하실 수 있습니다. (배송비 회사 부담)<br/>
						- 교환/반품을 원하는 고객은 쇼핑몰 고객센터 (080-380-0114)에 전화하시거나 쇼핑몰의 [마이페이지>내 주문관리]를 통해 신청하시면 됩니다.<br/>
						- 신청 후 2~3일 이내에 이니스프리 지정 택배사가 직접 방문하여 상품을 수거합니다. <br/>
						- (반송지 주소: 경상북도 김천시 대광동 1000-2번지 아모레퍼시픽 김천물류센터 이니스프리 담당자 : 오연정)<br/>
						- 해당 상품 구매 시 사은품/증정품 등이 제공된 경우, 상품 교환/반품 시 함께 보내주셔야 합니다.<br/>
						- 반품 시 상품대금 환불은 상품 회수 및 청약철회가 확정된 날부터 3영업일 이내 진행되며, 기한을 초과한 경우 지연기간에 대하여 연 100분의 15를 곱하여 산정한 지연이자를 지급합니다.</td></tr>
				<tr><td id="infotag">2</td><td>교환/반품이 불가능한 경우</td></tr>
				<tr><td id="infotag"></td>
					<td>- 고객에게 책임이 있는 사유로 상품이 멸실되거나 훼손된 경우(상품내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외)<br/>
						- 고객의 사용 또는 일부 소비로 상품 가치가 현저히 감소한 경우<br/>
						- 시간이 지나 다시 판매하기 곤란할 정도로 상품 가치가 현저히 감소한 경우<br/>
						- 복제가 가능한 상품의 포장을 훼손한 경우<br/>
						- 고객의 주문에 따라 개별적으로 생산되는 상품 또는 이와 유사한 상품에 대하여 청약철회등을 인정하는 경우 <br/>
						- 통신판매업자에게 회복할 수 없는 중대한 피해가 예상되는 경우로서 사전에 해당 거래에 대하여 별도로 그 사실을 고지하고 고객의 서면(전자문서 포함)에 의한 동의를 받은 경우<br/>
						- 오프라인 매장에서 구매한 제품은 불가능</td></tr>
				<tr><td id="infotag">3</td><td>불만처리 및 분쟁해결</td></tr>
				<tr><td id="infotag"></td>
				<td>- 교환/반품/대금 환불 등에 대한 문의사항 및 불만처리 요청은 쇼핑몰 고객센터 [080-380-0114] 혹은 1:1 고객문의 게시판을 이용하세요.<br/>
					- 고객센터 운영시간: (월~목) 09:00~18:00 , (금) 09:00~17:30 , 토/일/공휴일 휴무<br/>
					- 본 상품의 품질보증 및 피해보상에 관한 사항은 관련 법률 및 공정거래위원회 고시 「소비자분쟁해결기준」에 따릅니다.<br/>
					- 트러블에 의한 반품 시 의사의 소견서를 첨부해야 하며 기타 제반 비용은 고객님이 부담하셔야 합니다.<br/>
					- 다만, 의사의 소견에 따라 구매 상품의 사용으로 인한 사유가 명백한 경우 소비자분쟁해결기준에 따릅니다.</td></tr>			
			</tbody>
		</table>
	</div>
	<div id="reViewView" class="reViewView">
		<table class="activePage" id="activePage">
			<c:if test="${reviewPage.totalCount==0}"> 
				<tr><td colspan="2" style="height: 500px; text-align:center; font-size: 25px;">리뷰가 없습니다.</td></tr>
			</c:if> 
			<c:if test="${reviewPage.totalCount!=0}"> 
			<c:set var = "sum" value = "0" />
			<c:forEach var="star" items="${reviewList}">
			<c:set var= "sum" value="${sum + star.bcr_score}"/>
			</c:forEach>
			<c:set var = "average" value ="${sum/fn:length(reviewList)}"/>
			<tr style="font-size:50px; text-align: center;">
				<td><fmt:formatNumber value="${average}" pattern="#.##" /></td>
				<td> 
					<div class="star-ratings">
						<div class="star-ratings-fill space-x-2 text-lg" style="width: ${average/5*100}%" >
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
						<div class="star-ratings-base space-x-2 text-lg">
							<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
						</div>
					</div>
				</td>
			</tr>	
			<tr><td colspan="2"><hr></td></tr>	
			<c:forEach items="${reviewList}" var="dto">			
			<tr class="starPoint">				
				<td style="font-size:25px;"> 
					<c:if test="${dto.bcr_score==0}">☆☆☆☆☆</c:if>
					<c:if test="${dto.bcr_score==1}">★☆☆☆☆</c:if>
					<c:if test="${dto.bcr_score==2}">★★☆☆☆</c:if>
					<c:if test="${dto.bcr_score==3}">★★★☆☆</c:if>
					<c:if test="${dto.bcr_score==4}">★★★★☆</c:if>
					<c:if test="${dto.bcr_score==5}">★★★★★</c:if>
				</td>
			</tr>
			<tr>				
				<td> ${dto.bcm_name} </td>
				<td style="text-align:right"> <fmt:formatDate value="${dto.bcr_date}" pattern="yyyy-MM-dd" var="bcr_date" />${bcr_date} </td>
			</tr>
			<tr>
				<c:if test="${dto.bcr_photo==null}"><td colspan="2" style="padding: 20px; vertical-align: top;"> ${dto.bcr_content} </td></c:if>
				<c:if test="${dto.bcr_photo!=null}">
					<td style="width: 300px;"><img src="${dto.bcr_photo}" width="100%"> </td>
					<td style="padding: 20px; vertical-align: top;"> ${dto.bcr_content} </td>							
				</c:if>			
			</tr>
			<tr><td colspan="2"><hr></td></tr>
			</c:forEach>
			</c:if>
			<tr><td colspan="2">&nbsp;</td></tr>
			<c:if test="${reviewPage.totalCount>0}"> 
			<tr style="text-align: center">
				<td colspan="2">
					<!-- 처음 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage - 1) < 1}">
						 &lt;&lt; 
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=1">[ &lt;&lt; ]</a>
					</c:otherwise>
					</c:choose>
					
					<!-- 이전 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage - 1) < 1}">
						 &lt; &nbsp; 
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.curPage - 1}"> &lt; </a> &nbsp;
					</c:otherwise>
					</c:choose>
					
					<!-- 개별 페이지 -->
					<c:forEach var="fEach" begin="${reviewPage.startPage}" end="${reviewPage.endPage}" step="1">
						<c:choose>
						<c:when test="${reviewPage.curPage == fEach}">
							 ${fEach}  &nbsp;
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${fEach}"> ${fEach} </a> &nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach>	
					
					<!-- 다음 -->
					<c:choose>
					<c:when test="${(reviewPage.curPage + 1) > reviewPage.totalPage}">
						 &gt; 
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.curPage + 1}"> &gt; </a>
					</c:otherwise>
					</c:choose>
					
					<!-- 끝 -->
					<c:choose>
					<c:when test="${reviewPage.curPage == reviewPage.totalPage}">
						 &gt;&gt; 
					</c:when>
					<c:otherwise>
						<a href="detailPage?BCG_KEY=${BCG_KEY}&reviewPage=${reviewPage.totalPage}"> &gt;&gt; </a>
					</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div id="qnaView" class="qnaView">
		<div id="qqna" class="qqna">
			<table class="activePage" id="activePage">	
				<form id="uploadQ" name="uploadQ">
				    <tr>
				    	<td colspan="2">
				    		<textarea id="BCQ_CONTENT" name="BCQ_CONTENT" cols="100%" rows="5" 
				    				  placeholder="문의내용을 150자 이내로 기재해주세요."
				    				  style="border: 3px solid grey; border-radius: 5px;"></textarea>
				    		<br /><p class="bytes">(0 / 150자)</p>
				    		<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">
							<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">
							<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num%>">
							<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="<%=bcm_name%>">
						</td>
					</tr>
					<tr>	
						<td>
							<i class="gg-lock"></i> &nbsp;&nbsp;&nbsp;&nbsp;비밀글설정 <input type="checkbox" name="BCQ_SECRET" id="BCQ_SECRET">
						</td>
						<td style="text-align: right">
							<input type="button" value="등록" onclick="uploadQnA()"
								   style="border: 3px solid black; border-radius: 5px; background-color: #d2d2fc; margin-left:0;">
		    			</td>
		    		</tr>
	    		</form>
    		
	    		<c:if test="${questionPage.totalCount==0}"> 
	    			<tr><td colspan="2"><hr></td></tr>
					<tr><td colspan="2" style="height: 500px; text-align:center; font-size: 25px;">문의가 없습니다.</td></tr>
				</c:if> 
				<c:forEach items="${questionList}" var="dto">
					<tr><td colspan="2"><hr></td></tr>
					<c:if test="${dto.bcq_secret eq 'off'}">
					<tr><td> ${dto.bcm_name} <fmt:formatDate value="${dto.bcq_date}" pattern="yyyy-MM-dd" var="bcq_date" />${bcq_date}</td>
						<c:if test="${dto.bca_content==null}"><td style="text-align:right">답변대기중</td></c:if>
						<c:if test="${dto.bca_content!=null}"><td style="text-align:right">답변완료</td></c:if>
					</tr>
					<tr><td colspan="2" class="qnaContent">${dto.bcq_content}</td></tr>
						<c:if test="${dto.bca_content!=null}">
							<tr><td colspan="2"> ▶RE: 관리자 <fmt:formatDate value="${dto.bca_date}" pattern="yyyy-MM-dd" var="bca_date" />${bca_date}</td></tr>
							<tr><td colspan="2" class="qnaContent">${dto.bca_content}</td></tr>
						</c:if>
					</c:if>	
					<c:if test="${dto.bcq_secret eq 'on'}">
						<c:if test="${dto.bcm_name eq (sessionScope.name)}"> 
							<tr><td> <i class="gg-lock"></i> &nbsp;&nbsp;&nbsp;&nbsp;${dto.bcm_name} <fmt:formatDate value="${dto.bcq_date}" pattern="yyyy-MM-dd" var="bcq_date" />${bcq_date}</td>
								<c:if test="${dto.bca_content==null}"><td style="text-align:right">답변대기중</td></c:if>
								<c:if test="${dto.bca_content!=null}"><td style="text-align:right">답변완료</td></c:if>
							</tr>
							<tr><td colspan="2" class="qnaContent">${dto.bcq_content}</td></tr>
							<c:if test="${dto.bca_content!=null}">
								<tr><td colspan="2"> ▶RE: 관리자 <fmt:formatDate value="${dto.bca_date}" pattern="yyyy-MM-dd" var="bca_date" />${bca_date}</td></tr>
								<tr><td colspan="2" class="qnaContent">${dto.bca_content}</td></tr>
							</c:if> 
						</c:if>
						<c:if test="${dto.bcm_name ne (sessionScope.name)}"> 
							<tr><td> <i class="gg-lock"></i> &nbsp;&nbsp;&nbsp;&nbsp;Secret <fmt:formatDate value="${dto.bcq_date}" pattern="yyyy-MM-dd" var="bcq_date" />${bcq_date}</td>
								<c:if test="${dto.bca_content==null}"><td style="text-align:right">답변대기중</td></c:if>
								<c:if test="${dto.bca_content!=null}"><td style="text-align:right">답변완료</td></c:if>
							</tr>
							<tr><td colspan="2" class="qnaContent"> '비밀글입니다' </td></tr> 
							<c:if test="${dto.bca_content!=null}">
								<tr><td colspan="2" class="qnaContent">▶RE: '비밀글답변입니다'</td></tr>
							</c:if> 
						</c:if>
					</c:if>	
				</c:forEach>
				<c:if test="${questionPage.totalCount>0}"> 
				<tr style="text-align: center">
					<td colspan="2">
						<!-- 처음 -->
						<c:choose>
						<c:when test="${(questionPage.curPage - 1) < 1}">
							 &lt;&lt; 
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=1"> &lt;&lt; </a>
						</c:otherwise>
						</c:choose>
						
						<!-- 이전 -->
						<c:choose>
						<c:when test="${(questionPage.curPage - 1) < 1}">
							 &lt; &nbsp; 
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.curPage - 1}"> &lt; </a> &nbsp;
						</c:otherwise>
						</c:choose>
						
						<!-- 개별 페이지 -->
						<c:forEach var="fEach" begin="${questionPage.startPage}" end="${questionPage.endPage}" step="1">
							<c:choose>
							<c:when test="${questionPage.curPage == fEach}">
								 ${fEach}  &nbsp;
							</c:when>
							<c:otherwise>
								<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${fEach}"> ${fEach} </a> &nbsp;
							</c:otherwise>
							</c:choose>
						</c:forEach>	
						
						<!-- 다음 -->
						<c:choose>
						<c:when test="${(questionPage.curPage + 1) > questionPage.totalPage}">
							 &gt; 
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.curPage + 1}"> &gt; </a>
						</c:otherwise>
						</c:choose>
						
						<!-- 끝 -->
						<c:choose>
						<c:when test="${questionPage.curPage == questionPage.totalPage}">
							 &gt;&gt; 
						</c:when>
						<c:otherwise>
							<a href="detailPage?BCG_KEY=${BCG_KEY}&questionPage=${questionPage.totalPage}"> &gt;&gt; </a>
						</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:if>
			</table>		
		</div>
	</div>
<script>

	function review() {
		$("#reViewView").css({ 'display' : 'block' });
		$("#qnaView").css({ 'display' : 'none' });
		$("#goodsDetailView").css({ 'display' : 'none' });
	}

	function qna() {
		$("#qnaView").css({ 'display' : 'block' });
		$("#reViewView").css({ 'display' : 'none' });
		$("#goodsDetailView").css({ 'display' : 'none' });
	}

	function detail() {
		$("#goodsDetailView").css({ 'display' : 'block' });
		$("#qnaView").css({ 'display' : 'none' });
		$("#reViewView").css({ 'display' : 'none' });
	}
</script>
	<div class="goTop" id="goTop">
		<!-- <a href="https://www.flaticon.com/kr/free-icons/-" title="- 아이콘">- 아이콘  제작자: Smauj - Flaticon</a> -->
		<input type="image" src="/image/goTop.png" width="60" height="60" alt="맨위로" onClick="javascript:window.scrollTo(0,0)" />
	</div>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>