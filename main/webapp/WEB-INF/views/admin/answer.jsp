<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Bootstrap CSS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
    <script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script>
	function Add() {	//BC_QUESTION oracle DB에 update
		var queryString=$("#answer").serialize();	
		console.log(queryString);
        $.ajax({
        	url: '/admin/answerSuccess',  
            type: 'POST',
            data: queryString,
            dataType: 'text',
            success: function(json) {  
            	opener.parent.location.reload();
            	window.close();           		               	           	
            }
        });
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
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
</style>
</head>
<body style="background-color: #E6E6FA; font-family: 'tway_air'">
<h3>답변</h3>&nbsp;
	<table>
		<tr>
			<td>
				<form id="answer">
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY }">
				<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="${BCM_NUM }">
				<input type="hidden" id="BCQ_CONTENT" name="BCQ_CONTENT" value="${BCQ_CONTENT }">
				<input type="hidden" id="BCQ_DATE" name="BCQ_DATE" value="${BCQ_DATE }">
				<textarea id="BCA_CONTENT" id="BCA_CONTENT" name="BCA_CONTENT" cols="50" rows="15"
						  placeholder="답변 내용을 150자 이내로 기재해주세요."></textarea>
				<br /><p class="bytes">(0 / 150자)</p>
				</form>
			</td>
		</tr>
	</table>
<input type="button" class="btn btn-outline-secondary my-2 my-sm-0"  value="등록" onclick="Add()" style="float: left;">
</body>
</html>