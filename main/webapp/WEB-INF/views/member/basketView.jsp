<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery.js"></script>
<script>
    //총금액
    var allPrice=0;
    var allCount=0;
    //배송비
    var prePrice=0;
</script>
<script>
    function orderCheckBoxList() {
        console.log("length : " + $("input:checkbox[name=checkbox]:checked").length);
        if($("input:checkbox[name=checkbox]:checked").length<1){
            alert("장바구니에 상품이 없습니다.");
            return
        }

        var keyList ="";
        var detailkeyList = "";
        var countList = "";

        var checkbox = $("input:checkbox[name=checkbox]:checked");

        checkbox.each(function (i) {
            //checkbox.parent() : checkbox의 부모 td.
            //checkbox.parent().parent : td의 부모가 tr.
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();

            var key = td.eq(0).children().eq(2).val();
            var detailkey = td.eq(0).children().eq(1).val();
            var count = td.eq(4).children().eq(0).val();

            keyList += key+"/";
            detailkeyList += detailkey + "/";
            countList += count + "/";
        })

        keyList = keyList.substring(0,keyList.length-1);
        detailkeyList = detailkeyList.substring(0,detailkeyList.length-1);
        countList = countList.substring(0,countList.length-1);

        console.log(keyList);
        console.log(detailkeyList);
        console.log(countList);

        var queryString = "keyList="+keyList+"&detailkeyList="+detailkeyList+"&countList="+countList;
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
</script>
<style>
    @font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	body {
	    padding-top: 210px;
	    padding-bottom: 120px;  
	}
	.selectpage {
		background-color: #d2d2fc;
		border-radius: 50px 0 0 50px;
	}
	.payheader {
		font-size: 30px;
		text-align: center;
		height: 100px;
		width: 100%;
		background-color: #f2f2fc;
		border-radius: 50px;
	}
	.tableD {
		position: relative;
	    margin: auto;
	    width: 1200px;	  
	    padding-left: 15px;  
	    text-align: center;
	    align: center; 
	    font-family: 'tway_air';
	}
	input[type=checkbox] {
		zoom: 2;
		cursor:pointer; 	
	}
</style>
</head>
<body style="background-color: #E6E6FA;">
<div style="float: top">
    <c:import url="/guest/menuTop"></c:import>
</div>
<div class="tableD">
    <div style="width:100%;">
    	<br>
        <table class="payheader" >
        	<colgroup>
        		<col style="width: 25%">
        		<col style="width: 12%">
        		<col style="width: 25%">
        		<col style="width: 12%">
        		<col style="width: 25%">
        	</colgroup>       	
            <tr>
            	<td class="selectpage">장바구니</td>
	            <td><img src="/image/rightBtn.png"></td>
	            <td>주문/결제</td>
	            <td><img src="/image/rightBtn.png"> </td>
	            <td>주문완료</td>
        	</tr>
        </table>
        <div style="display: block">
<%--            <input type="checkbox" id="checkAll" value="checkall" onclick="checkAll(this)" checked>--%>
<%--                전체선택--%>
<%--            <button onclick="">선택삭제</button>--%>
        </div>
        <br>
        <div>
            <form id="orderForm">
                <table style="width:100%; font-size: 20px; border-spacing: 5px;">
                    <thead style="height: 50px; background-color: #d2d2fc;">
	                    <tr>
	                        <td></td>
	                        <td colspan="2">상품정보</td>
	                        <td>판매가</td>
	                        <td>수량</td>
	                        <td>합계금액</td>
	                        <td>선택</td>
	                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="dto">
                        <tr>
                            <td>
                                <input type="checkbox" id="check${dto.bcg_key}" name="checkbox"
                                       onclick="checkbox${dto.bcg_key}()" value="${dto.bcg_key}" checked>
                                <input type="hidden" id="detailkey${dto.bcg_key}" name="bcd_detailkey" value="${dto.bcd_detailkey}">
                                <input type="hidden" id="key${dto.bcg_key}" name="bcg_key" value="${dto.bcg_key}">
                                <input type="hidden" name="realprice${dto.bcg_key}" id="realprice${dto.bcg_key}" class="" value="${dto.bcg_price}">

                            </td>
                            <td onclick="javascript:window.location='/guest/detailPage?BCG_KEY=${dto.bcg_key}'">
                                <img src="${dto.bcg_img}" width="200" height="200">
                            </td>
                            <td onclick="javascript:window.location='/guest/detailPage?BCG_KEY=${dto.bcg_key}'">
                                ${dto.bcg_name} <br>
                                    <c:if test="${dto.bcd_option != '-'}">
                                        ( ${dto.bcd_option} )
                                    </c:if>
                            </td>
                            <td name="price${dto.bcg_key}" id="price${dto.bcg_key}">
                                ${dto.bcg_price}
                            </td>
                            <td>
                                <!--수량 나중에 ajax로 받을것-->
                                <input type="text" name="count" id="count${dto.bcg_key}"
                                       min="1" max="${dto.bcd_stock}" size="2" maxlength="2" value="${dto.bcb_count}" readonly>
                                <span onclick="upCount${dto.bcg_key}()"><i class="fas fa-arrow-alt-circle-up up"></i></span>
                                <span onclick="downCount${dto.bcg_key}()"><i class="fas fa-arrow-alt-circle-down down"></i></span>
                            </td>
                            <input type="hidden" id="realtotalprice${dto.bcg_key}" name="realtotalprice${dto.bcg_key}" >
                            <td id="totalprice${dto.bcg_key}" name="totalprice${dto.bcg_key}" style="color: red">
                                합계금액
                            </td>
                            <td>
                                <input type="button" onclick="deleteBasket${dto.bcg_key}()" value="삭제"
                                	   style="border: 2; border-radius: 5px; font-family: 'tway_air';
				  							  background-color: #d2d2fc; text-align: center;">
                            </td>
                        </tr>

<script>
    function deleteBasket${dto.bcg_key}() {
        var queryString = "bcd_detailkey=" + $('#detailkey${dto.bcg_key}').val();
        queryString = queryString + "&bcg_key=" + $('#key${dto.bcg_key}').val();
        $.ajax({
            url : '/member/deleteBasket',
            type : 'POST',
            data : queryString,
            dataType: 'json',
            success : function(json) {
                if(json.desc == "1"){
                    alert("장바구니에서 삭제되었습니다.")
                    window.location.reload();
                } else if (json.desc == "0") {
                    alert("데이터베이스입력에러");
                } else if (json.desc == "-1") {
                    alert("이상현상");
                } else {
                    alert(json.desc);
                }
            }
        });
    }
</script>
<%--<script>--%>
<%--    function checkAll(checkAll) {--%>
<%--        const checkboxes = document.getElementsByName('checkbox');--%>
<%--        checkboxes.forEach((checkbox) => {--%>
<%--            checkbox.checked = checkAll.checked;--%>
<%--        })--%>

<%--        if($('#checkAll').is(':checked')){--%>

<%--        }else {--%>
<%--            allPrice=0;--%>
<%--            prePrice=2500;--%>
<%--            calAndUiReset${dto.bcg_key}();--%>
<%--        }--%>



<%--    }--%>
<%--</script>--%>
<script>
    function checkbox${dto.bcg_key}(){
        var checkPrice = $('#realprice${dto.bcg_key}').val();
        var checkCount = $('#count${dto.bcg_key}').val();
        var checkTotalPrice = checkPrice * checkCount;
        if($('#check${dto.bcg_key}').is(':checked')){
            allPrice += checkTotalPrice;
            prePrice += checkTotalPrice;
            calAndUiReset${dto.bcg_key}();
        }else{
            allPrice -= checkTotalPrice;
            prePrice -= checkTotalPrice;
            calAndUiReset${dto.bcg_key}();
        }
    }
</script>
<script>
    // 초기 합계금액 생성
    var price = $('#realprice${dto.bcg_key}').val();
    var count = $('#count${dto.bcg_key}').val();
    var totalPrice = price*count;
    $('#realtotalprice${dto.bcg_key}').attr('value',totalPrice);
    var totalPrice2 = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    $('#totalprice${dto.bcg_key}').text(totalPrice2+"원");

    if($('#check${dto.bcg_key}').is(':checked')){
        allPrice += totalPrice;
        prePrice += totalPrice;
    }
</script>
<script>
    var countReset =0;
    var upIntCount=0
    var downIntCount=0;
    var priceReset=0;
    var countReset=0;
    var totalPriceReset=0;
    var totalPrice2Reset=0;
    var allPrice2;
    var prePrice2;
    function upCount${dto.bcg_key}(){
        countReset = $('#count${dto.bcg_key}').val();
        if(countReset >= parseInt('${dto.bcd_stock}')){
            alert("남은재고가 ${dto.bcd_stock}개 입니다.")
            return;
        }
        upIntCount = parseInt(countReset)+1;
        $('#count${dto.bcg_key}').val(upIntCount);
        allPrice += parseInt(price);
        prePrice += parseInt(price);
        calAndUiReset${dto.bcg_key}();

        var queryString = "bcd_detailkey=" + $('#detailkey${dto.bcg_key}').val();
        queryString = queryString + "&bcg_key=" + $('#key${dto.bcg_key}').val();
        $.ajax({
            url : '/member/basketUpCount',
            type : 'POST',
            data : queryString,
            dataType: 'text',
            success : function(text) {

            }
        });
    }
    function downCount${dto.bcg_key}(){
        countReset = $('#count${dto.bcg_key}').val();
        if(countReset <= 1){
            return;
        }
        downIntCount = parseInt(countReset)-1;
        $('#count${dto.bcg_key}').val(downIntCount);
        allPrice -= parseInt(price);
        prePrice -= parseInt(price);
        calAndUiReset${dto.bcg_key}();

        var queryString = "bcd_detailkey=" + $('#detailkey${dto.bcg_key}').val();
        queryString = queryString + "&bcg_key=" + $('#key${dto.bcg_key}').val();
        $.ajax({
            url : '/member/basketDownCount',
            type : 'POST',
            data : queryString,
            dataType: 'text',
            success : function(text) {

            }
        });
    }
    //수량 변할때마다 리셋
    function calAndUiReset${dto.bcg_key}() {
        priceReset = $('#realprice${dto.bcg_key}').val();
        countReset = $('#count${dto.bcg_key}').val();
        totalPriceReset = priceReset*countReset;
        $('#realtotalprice${dto.bcg_key}').val(totalPriceReset);
        totalPrice2Reset = totalPriceReset.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        $('#totalprice${dto.bcg_key}').text(totalPrice2Reset+"원");

        allPrice2 = allPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        prePrice2 = prePrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        $('#allPrice').text(allPrice2+"원");
        $('#prePrice').text(prePrice2+"원");
    }
</script>
<script>
    var money = $('#price${dto.bcg_key}').text();
    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    $('#price${dto.bcg_key}').text(money2+"원");
</script>
                    </c:forEach>
                </tbody>    
                </table>
            </form>
            <br>
            <table style="width:100%; font-size: 20px; border-spacing: 5px;">
                <thead style="height: 50px; background-color: #d2d2fc;">
                <tr>
                    <td>상품 금액</td>
                    <td>배송비</td>
                    <td>결제 예정금액</td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="allPrice" name="allPrice"></td>
                    <td>0원</td>
                    <td id="prePrice" name="prePrice" style="color: red"></td>
                </tr>
                </tbody>
            </table>
            <br>
            <div style="width: 100%; background-color: #d2d2fc; text-align: center; cursor:pointer; border-radius: 30px;" onclick="orderCheckBoxList()">
                <h1>주문하기</h1>
            </div>
        </div>
    </div>
</div>

<script>
    allPrice2 = allPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    prePrice2 = prePrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    $('#allPrice').text(allPrice2+"원");
    $('#prePrice').text(prePrice2+"원");
</script>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
