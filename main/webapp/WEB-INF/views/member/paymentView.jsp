<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    int sNum = 0;
    String sName = "";
    String sEmail = "";
    String sId = "";
    String firstEmail = "";
    String secondEmail = "";
    if(session.getAttribute("num") != null) {
        sNum = (int) session.getAttribute("num");
        sId = (String) session.getAttribute("id");
        sName = (String) session.getAttribute("name");
        sEmail = (String) session.getAttribute("email");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>주문/결제</title>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.1.5.min.js"
            type="application/javascript"></script>
    <script>
        var orderList = JSON.parse(sessionStorage.getItem("orderList"));
        //console.log(orderList);

        var totalPrice = 0;
        var goodsPrice = 0;
        var goodsCount = 0;
        // 상품종류 수
        var length = 0;
        // 상품명 1개만
        var bcgName= "";

        var aJsonArray = new Array();
        for(key in orderList) {
            // console.log(key)
            // console.log(orderList[key]);
            var list = orderList[key][0];
            // console.log(list)
            for(k in list){
                if(k=="bcg_price"){
                    goodsPrice = list[k];
                }
                if(k=="count"){
                    goodsCount = list[k];
                    totalPrice += goodsPrice * goodsCount;
                }
            }
            aJsonArray.push(list);
        }
        //console.log(aJsonArray);

        var JsonArr = new Array();
        length = aJsonArray.length-1;

        for(var i=0; i<aJsonArray.length; i++){
            var aJson = new Object();
            aJson.id = aJsonArray[i]["bcg_key"];
            aJson.name = aJsonArray[i]["bcg_name"];
            aJson.qty = aJsonArray[i]["count"];
            aJson.price = aJsonArray[i]["bcg_price"];
            //console.log(aJson);
            JsonArr.push(aJson);
            bcgName = aJsonArray[i]["bcg_name"];
        }
        //console.log(JsonArr);

        var orderName=""
        if(length > 0){
            orderName = bcgName + " 외 " + length+ " 건";
        }else{
            orderName = bcgName;
        }
        //console.log(orderName);

        var orderId="";

        var id ="";
        var username="";
        var phone = "";
        var email= "";

        //배송비
        var deliveryPrice= 0;
        // 배송비 더해주기
        var totalPrice2= totalPrice+deliveryPrice;

        $(document).ready(function() {
            //결제금액 toString
            var totalPriceStr = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            var totalPrice2Str = totalPrice2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

            $('#idTotalPrice').text(totalPriceStr+"원");
            $('#idTotalPrice2').text(totalPrice2Str+"원");

            id =$('#sId').val();
            username = $('#sName').text();
            email = $('#sEmail').text();
            orderId = $('#orderNum').val();
            $('#sorderName').val(orderName);

        });
    </script>
    <script>
        function afterPayment() {
            var jsonStr = JSON.stringify(aJsonArray);
            //var encodejsonStr = btoa(encodeURIComponent(jsonStr));
            //console.log(encodejsonStr);
            $('#orderListJson').val(jsonStr);
            //console.log($('#orderListJson').val());
            $('#realTotalPrice').val(totalPrice2);

            $("#sample2_postcode").attr("disabled",false);
            $("#sample2_address").attr("disabled",false);
            $("#sample2_extraAddress").attr("disabled",false);

            var queryString = $('#paymentForm').serialize();
            //console.log(queryString);
            $("#sample2_postcode").attr("disabled",true);
            $("#sample2_address").attr("disabled",true);
            $("#sample2_extraAddress").attr("disabled",true);

            $.ajax({
                url : '/member/afterPayment',
                type : 'POST',
                data : queryString,
                dataType: 'text',
                success : function(text) {
                    if(text==="1"){
                        console.log("결제성공");
                    }else if(text ==="0"){
                        console.log("결제실패")
                        return;
                    }
                }
            });

        }
    </script>
    <script>
        async function payment(){
            try {
                const response = await Bootpay.requestPayment({
                    "application_id": "62c95b83e38c3000235af573",
                    "price": totalPrice2,
                    "order_name": orderName,
                    "order_id": orderId,
                    "pg": "",
                    "method": ["휴대폰","카드"],
                    "tax_free": 0,
                    "user": {
                        "id": id,
                        "username": username,
                        "phone": phone,
                        "email": email
                    },
                    "items": JsonArr,
                    "extra": {
                        "open_type": "iframe",
                        "card_quota": "0,2,3",
                        "escrow": false,
                        "separately_confirmed": true
                    }
                })
                switch (response.event) {
                    case 'issued':
                        // 가상계좌 입금 완료 처리
                        break
                    case 'done':
                        console.log(response);
                        // 결제 완료 처리
                        break
                    case 'confirm':
                        console.log(response.receipt_id);
                        // { extra: { separately_confirmed: true } } 인 경우 승인전 이벤트 발생
                        // -- 승인 전 로직 처리 -- //
                        /**
                         * 1. 클라이언트 승인을 하고자 할때
                         * // validationQuantityFromServer(); //예시) 재고확인과 같은 내부 로직을 처리하기 한다.
                         */
                        const confirmedData = await Bootpay.confirm() //결제를 승인한다
                        if(confirmedData.event === 'done') {
                            //결제 성공
                            afterPayment();
                            window.location="/member/completePayment";
                        } else if(confirmedData.event === 'error') {
                            alert("결제 승인 실패")
                            //결제 승인 실패
                        }
                        /**
                         * 2. 서버 승인을 하고자 할때
                         * // requestServerConfirm(); //예시) 서버 승인을 할 수 있도록  API를 호출한다. 서버에서는 재고확인과 로직 검증 후 서버승인을 요청한다.
                         * Bootpay.destroy(); //결제창을 닫는다.
                         */
                        break
                }
            } catch (e) {
                // 결제 진행중 오류 발생
                // e.error_code - 부트페이 오류 코드
                // e.pg_error_code - PG 오류 코드
                // e.message - 오류 내용
                console.log(e.message)
                switch (e.event) {
                    case 'cancel':
                        // 사용자가 결제창을 닫을때 호출
                        console.log(e.message);
                        break
                    case 'error':
                        // 결제 승인 중 오류 발생시 호출
                        console.log(e.error_code);
                        break
                }
            }
        }

        function formCheck() {

            if ($('#reciName').val().length === 0){
                alert("수령인 정보를 입력하세요.")
                $('#reciName').focus();
                return;
            }
            if ($('#reciName').val().length < 2) {
                alert("수령인 글자수는 2자리 이상 이어야 합니다. ")
                $('#reciName').focus();
                return;
            }
            if ($('#bcm_phonenum1').val().length ===0){
                alert("휴대폰 번호를 입력 해주세요.")
                $('#bcm_phonenum1').focus();
                return;
            }
            if ($('#bcm_phonenum2').val().length ===0){
                alert("휴대폰 번호를 입력 해주세요.")
                $('#bcm_phonenum2').focus();
                return;
            }
            if ($('#bcm_phonenum3').val().length ===0){
                alert("휴대폰 번호를 입력 해주세요.")
                $('#bcm_phonenum3').focus();
                return;
            }
            $("#sample2_postcode").attr("disabled",false);
            $("#sample2_address").attr("disabled",false);
            $("#sample2_extraAddress").attr("disabled",false);
            if($("#sample2_postcode").val.length ===0){
                alert("우편번호를 입력해주세요");
                return;
            }
            if($("#sample2_address").val.length ===0){
                alert("주소를 입력해주세요");
                return;
            }
            $("#sample2_postcode").attr("disabled",true);
            $("#sample2_address").attr("disabled",true);
            $("#sample2_extraAddress").attr("disabled",true);

            phone= $('#bcm_phonenum1').val()+$('#bcm_phonenum2').val()+$('#bcm_phonenum3').val();
            if($('#checkbox').is(':checked')){
                payment();
            }else {
                alert("주문내역확인 동의가 필요합니다.")
                return;
            }
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
            	<td>장바구니</td>
	            <td><img src="/image/rightBtn.png"></td>
	            <td class="selectpage">주문/결제</td>
	            <td><img src="/image/rightBtn.png"> </td>
	            <td>주문완료</td>
        	</tr>
        </table>
    </div>
    <br>
    <form id="paymentForm">
    <div>
        <table style="width:100%; font-size: 20px; border-spacing: 5px;">
	        <thead style="height: 50px; background-color: #d2d2fc;">
	        <tr>
	            <td>주문자</td>
	            <td>이메일</td>
	        </tr>
	        </thead>
	        <tbody>
	        <tr>	            
	            <input type="hidden" id="sId" name="sId" value="<%= sName %>">
	    	    <input type="hidden" id="orderNum" name="orderNum" value="${orderNum}">
	            <td id="sName"><%=sName %></td>
	            <td id="sEmail"><%=sEmail %></td>
	        </tr>
	        </tbody>
	    </table>
    </div>
    <hr/>
    <div>
        <table style="width:100%; font-size: 20px; border-spacing: 5px;">
        	<colgroup>
        		<col style="width:20%; background-color: #d2d2fc;">
        		<col style="width:80%; float: left; background-color: #f2f2fc;">
        	</colgroup>
        	<thead style="height: 50px; background-color: #d2d2fc;">
		        <tr>
		            <td colspan="2">[배송정보]</td>
		        </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td>수령인 *</td>
	                <td>
	                    <input type="text" id="reciName" name="reciName" value="<%= sName %>"
	                    	   style="width: 100%; border: none; border-radius: 10px;">
	                    <input type="hidden" id="orderListJson" name="orderListJson" value="">
	                    <input type="hidden" id="realTotalPrice" name="realTotalPrice" value="">
	                    <input type="hidden" id="sorderName" name="orderName" value="">
	                </td>
	            </tr>
	            <tr>
	                <td>휴대폰 *</td>
	                <td style="align: left;">
	                    <select id="bcm_phonenum1" name="bcm_phonenum1"
	                    		style="width: 15%; border: none; height: 30px; border-radius: 10px; ">
	                        <c:choose>
	                            <c:when test="${user.bcm_phonenum1 == null}">
	                                <option value="">::선택::</option>
	                            </c:when>
	                            <c:otherwise>
	                                <option value="${user.bcm_phonenum1}">${user.bcm_phonenum1}</option>
	                            </c:otherwise>
	                        </c:choose>
	                        <option value="011">011</option>
	                        <option value="016">016</option>
	                        <option value="017">017</option>
	                        <option value="019">019</option>
	                        <option value="010">010</option>
	                    </select>
	                    &nbsp;-&nbsp;
	                    <input type="text" id="bcm_phonenum2" size="4" maxlength="4" name="bcm_phonenum2" value="${user.bcm_phonenum2}"
	                    	   style="width: 15%; border: none; border-radius: 10px;">
	                    &nbsp;-&nbsp;
	                    <input type="text" id="bcm_phonenum3" size="4" maxlength="4" name="bcm_phonenum3" value="${user.bcm_phonenum3}"
	                    	   style="width: 15%; border: none; border-radius: 10px;">
	                </td>
	            </tr>
	            <tr>
	                <td>주소 *</td>
	                <td>
	                    <input type="text" name="bcm_zipcode" id="sample2_postcode" placeholder="우편번호" disabled value="${user.bcm_zipcode}"
	                    	   style="width: 30%; border: none; border-radius: 10px;">
	                    <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"
	                    	   style="width: 20%; border: 2; border-radius: 10px; cursor:pointer; background-color: #f2f2fc;">
	                    <input type="button" onclick="lastDeliveryDestination()" value="최근 배송지"
	                    	   style="width: 20%; border: 2; border-radius: 10px; cursor:pointer; background-color: #f2f2fc;"><br>
	                    <input type="text" name="bcm_address1" id="sample2_address" placeholder="주소" disabled value="${user.bcm_address1}"
	                    	   style="width: 100%; border: none; border-radius: 10px;"><br>
	                    <input type="text" name="bcm_address2" id="sample2_detailAddress" placeholder="상세주소" value="${user.bcm_address2}"
	                    	   style="width: 50%; border: none; border-radius: 10px;">
	                    <input type="text" name="bcm_address3" id="sample2_extraAddress" placeholder="참고항목" disabled value="${user.bcm_address3}"
	                    	   style="width: 48%; border: none; border-radius: 10px;">
	                </td>
	            </tr>
	            <tr>
	                <td>배송요청사항</td>
	                <td>
	                    <input type="text" maxlength="20" name="deliveryRequest" placeholder="최대 20자까지 입력가능합니다"
	                    	   style="width: 100%; border: none; border-radius: 10px;">
	                </td>
	            </tr>
	    	</tbody>        
        </table>
        <br>
        <table style="width:100%; font-size: 20px; ">
        	<colgroup>
        		<col style="width:50%;">
        		<col style="width:50%;">
        	</colgroup>
        	<thead style="height: 50px; background-color: #d2d2fc;">
		        <tr>
		            <td colspan="2">[결제정보]</td>
		        </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td>상품금액</td>               
	                <td id="idTotalPrice">45,000원</td>
	            </tr>
	            <tr>
	                <td id="deliveryPrice">배송비</td>
	                <td>0원</td>
	            </tr>
	            <tr>
	                <td>할인금액</td>
	                <td>0원</td>
	            </tr>
	            <tr style="background-color: #f2f2fc; color: red; font-size:30px;">
	                <td>최종결제금액</td>
	                <td id="idTotalPrice2">47,500원</td>
	            </tr>
	            <tr>
	                <td colspan="2">
	                    <input type="checkbox" id="checkbox" name="checkbox">
	                    주문내역확인 동의(필수)
	                </td>
	            </tr>
	            <tr>
	            	<td>
	                    <input type="button" value="장바구니가기" onclick="javascript:window.location='/member/basketView'"
	                    	   style="border: 2; width: 30%; font-size: 30px; border-radius: 10px; cursor:pointer; background-color: #d2d2fc;">
	                </td>
	                <td>
	                    <input type="button" value="결제하기" onclick="formCheck();"
	                    	   style="border: 2; width: 30%; font-size: 30px; border-radius: 10px; cursor:pointer; background-color: #d2d2fc;">
	                </td>                   
	            </tr>
            </tbody>
        </table>
    </div>
    </form>
</div>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 1; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 100 + 'px';
    }
</script>
<div style="background-color: #f2f2fc; border: 1px solid; display: none; position: fixed; top: 310px; left: 750px;
			z-index: 999999;" id="lastDeliveryDestinationDiv">
    <div id="selectDestination" style="width: 400px; height: 350px; padding: 15px; font-family: 'tway_air';">

    </div>
    <div style="height:20px;">
        <a href="javascript:closelastDeliveryDestination()" style="position:absolute; right:5px; bottom: 5px; color: black; font-family: 'tway_air';">[닫기]</a>
    </div>
</div>
<script>
    $(document).ready(function() {
        $.ajax({
            url : '/member/lastDeliveryDestination',
            type : 'POST',
            dataType: 'json',
            success : function(json) {
                //console.log(json);
                for(key in json){
                    var lastDeliveryList = json[key];
                    //console.log(lastDeliveryList);

                    for(i=0;i<lastDeliveryList.length ; i++){
                        //console.log(lastDeliveryList[i]);
                        var text ='';
                        text += '<span id="desZipcode'+i+'">'+lastDeliveryList[i].bcd_zipcode+'</span><br>';
                        text += '<span id="desAddress1'+i+'">'+lastDeliveryList[i].bcd_address1+'</span>&nbsp;&nbsp;';
                        text += '<span id="desAddress2'+i+'">'+lastDeliveryList[i].bcd_address2+'</span>';
                        if (lastDeliveryList[i].bcd_address3 != null){
                            text += '<span id="desAddress3'+i+'">'+lastDeliveryList[i].bcd_address3+'</span>';
                        }
                        text += '<input type="button" value="선택" onclick="selectDestinationFn'+i+'()"><br><hr>';

                        $('#selectDestination').append(text);
                    }

                }
            }
        });

    });
    function lastDeliveryDestination(){
        $("#lastDeliveryDestinationDiv").css({ 'display' : 'block' });
    }
    function closelastDeliveryDestination(){
        $("#lastDeliveryDestinationDiv").css({ 'display' : 'none' });
    }
    function selectDestinationFn0(){
        $('#sample2_postcode').val($('#desZipcode0').text());
        $('#sample2_address').val($('#desAddress10').text());
        $('#sample2_detailAddress').val($('#desAddress20').text());
        $('#sample2_extraAddress').val($('#desAddress30').text());
        $("#lastDeliveryDestinationDiv").css({ 'display' : 'none' });
    }
    function selectDestinationFn1(){
        $('#sample2_postcode').val($('#desZipcode1').text());
        $('#sample2_address').val($('#desAddress11').text());
        $('#sample2_detailAddress').val($('#desAddress21').text());
        $('#sample2_extraAddress').val($('#desAddress31').text());
        $("#lastDeliveryDestinationDiv").css({ 'display' : 'none' });
    }
    function selectDestinationFn2(){
        $('#sample2_postcode').val($('#desZipcode2').text());
        $('#sample2_address').val($('#desAddress12').text());
        $('#sample2_detailAddress').val($('#desAddress22').text());
        $('#sample2_extraAddress').val($('#desAddress32').text());
        $("#lastDeliveryDestinationDiv").css({ 'display' : 'none' });
    }
</script>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
