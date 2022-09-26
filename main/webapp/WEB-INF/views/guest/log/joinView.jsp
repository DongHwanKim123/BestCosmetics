<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	if(session.getAttribute("num") != null) {
		response.sendRedirect("/");
	}
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
        //처음 시작시 네이버캡챠 생성
        $(document).ready(function() {
            $.ajax({
                url : "/guest/naverCaptcha",
                dataType:"json",
                success : function(data) {
                    $("#key").val(data.key);
                    $("#div01").html("<img src='/captchaImage/"+data.captchaImageName+"'>");
                }
            });
        });
    </script>
    <script>
        //시작후 캡챠 리셋
        function codeReset() {
            $.ajax({
                url : "/guest/naverCaptcha",
                dataType:"json",
                success : function(data) {
                    $("#key").val(data.key);
                    $("#div01").html("<img src='/captchaImage/"+data.captchaImageName+"'>");
                }
            });
        }
    </script>
    <script>
        var isIdChecked = false;

        function idCheck() {
            if ($('#id').val().length == 0){
                $("#p1").html("아이디를 입력하세요");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length < 4) {
                $("#p1").html("아이디는 4자리 이상이어야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length >11) {
                $("#p1").html("아이디는 10자리 이하이어야 합니다.");
                $('#id').focus();
                return;
            }
            var idCheck = /^[a-zA-Z0-9]*$/;
            if (!idCheck.test($('#id').val())) {
                $("#p1").html("아이디는 영문 대/소문자와 숫자만 사용가능합니다.");
                $('#id').focus();
                return;
            }
            var queryString=$("#id").serialize();
            $.ajax({
                url : '/guest/idCheck',
                type : 'POST',
                data : queryString,
                dataType: 'json',
                success : function(json) {
                    console.log(json);
                    if(json.userjson == null){
                        $("#p1").html("사용가능한 아이디입니다.");
                        isIdChecked = true;
                    }else {
                        $("#p1").html("중복된 아이디입니다.");
                        isIdChecked = false;
                    }
                }
            });
        }

        function form_check(){
            if ($('#id').val().length == 0){
                $("#p1").html("아이디를 입력하세요");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length < 4) {
                $("#p1").html("아이디는 4자리 이상이어야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#id').val().length >11) {
                $("#p1").html("아이디는 10자리 이하이어야 합니다.");
                $('#id').focus();
                return;
            }
            var idCheck = /^[a-zA-Z0-9]*$/;
            if (!idCheck.test($('#id').val())) {
                $("#p1").html("아이디는 영문 대/소문자와 숫자만 사용가능합니다.");
                $('#id').focus();
                return;
            }
            if (isIdChecked==false){
                $("#p1").html("아이디 중복확인을 하셔야 합니다.");
                $('#id').focus();
                return;
            }
            if ($('#pw').val().length == 0){
                $("#p1").html("비밀번호를 입력하세요");
                $('#pw').focus();
                return;
            }
            var pwCheck = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
            if (!pwCheck.test($('#pw').val())) {
                $("#p1").html("비밀번호는 숫자,영문,특수문자(!@#$%^&+=)를 포함한 8~16자리여야합니다.");
                $('#pw').focus();
                return;
            }
            //비밀번호와 비밀번호 확인 같은지 확인
            if($('#pw').val() != $('#pwConfirm').val()){
                $("#p1").html("비밀번호가 일치하지 않습니다.");
                $('#pwConfirm').focus();
                return;
            }
            if ($('#name').val().length == 0){
                $("#p1").html("이름을 입력하세요");
                $('#name').focus();
                return;
            }
            if ($('#name').val().length < 2){
                $("#p1").html("이름은 두자리 이상이어야 합니다.");
                $('#name').focus();
                return;
            }
            var nameCheck =/^[가-힣]*$/;
            if (!nameCheck.test($('#name').val())) {
                $("#p1").html("이름은 한글만 사용가능합니다.");
                $('#name').focus();
                return;
            }
            //secondEmail 잠시 활성화
            $("#secondEmail").attr("disabled",false);
            var firstEmailCheck =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/;
            var secondEmailCheck =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
            if ($('#firstEmail').val().length == 0){
                $("#p1").html("이메일을 입력하세요");
                $('#firstEmail').focus();
                return;
            }
            if (!firstEmailCheck.test($('#firstEmail').val())) {
                $("#p1").html("이메일 형식에 맞지 않습니다");
                $('#firstEmail').focus();
                return;
            }
            if ($('#secondEmail').val().length == 0){
                $("#p1").html("이메일을 입력하세요");
                $('#secondEmail').focus();
                return;
            }
            if (!secondEmailCheck.test($('#secondEmail').val())) {
                $("#p1").html("이메일 형식에 맞지 않습니다");
                $('#secondEmail').focus();
                return;
            }

            //네이버캡챠 result check
            var form01Data = $("#JoinForm").serialize();
            $.ajax({
                url : "/guest/naverCaptcha",
                data : form01Data,
                success : function(data) {
                    console.log(data);
                    if(data=="true"){
                        submit_ajax();
                    }else{
                        $("#p1").html("보안코드를 다시입력해주세요");
                        //이메일 다시 비활성화
                        $("#secondEmail").attr("disabled",true);
                    }
                }
            });

        }

        function submit_ajax() {
            var queryString=$("#JoinForm").serialize();
            $.ajax({
                url : '/guest/joinProcess',
                type : 'POST',
                data : queryString,
                dataType: 'json',
                success : function(json) {
                    console.log(json);
                    //이메일비활성화
                    $("#secondEmail").attr("disabled",true);
                    if(json.desc == "1"){
                        alert("회원가입되었습니다.")
                        window.location.replace('/guest/loginView');
                    } else if (json.desc == "0") {
                        $("#p1").html("데이터베이스입력에러");
                    } else if (json.desc == "-1") {
                        $("#p1").html("중복된 아이디입니다.");
                    } else {
                        $("#p1").html(json.desc);
                    }
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
    	padding: 30%;
	}		
   	.joinchart {
   		top: 12%;
   		width: 600px;
   		position: absolute;
   		font-family: 'tway_air'; 
   		border-spacing: 5px;
   		font-size: 20px;  
   		vertical-align: middle;		
   	}
   	.headline {
   		font-size: 35px;
   		text-align: center;
   		background-color: #d2d2fc;
   		color: white;
   		border: none;
   		border-radius: 15px;
   		height: 40px;
   	}
   	</style>
</head>
<body style="background-color: #E6E6FA;">				
    <table class="joinchart">
    <colgroup>
    	<col style="width:20%">
    	<col style="width:30%">
    	<col style="width:50%">
    </colgroup>
    <thead>
    	<tr><td colspan="3">
    		<a href="/" > 
				<img src="/image/logo.PNG" width="70px" alt="" style="float:right;">
			</a></td></tr>
    	<tr><td colspan="3"><p class="headline">회원가입</p></td></tr>
    </thead>
    <tbody>
	    <form id="JoinForm">
	        <tr><td>아이디</td>
	        	<td colspan="2"><input type="text" id="id" name="id" maxlength="10" placeholder="4~10자의 영문 또는 숫자를 입력해주세요"
	        			   style="width: 75%; height: 40px; border: none; border-radius: 10px; font-size: 15px;">
	                <input type="button" value="중복확인" onclick="idCheck()" 
	                	   style="width: 20%; height: 40px; text-align:center; font-size: 15px; float: right; font-family: 'tway_air'; 
	                	   		  border: none; border-radius: 10px; cursor:pointer; background-color: #f2f2fc;"></td></tr>	                
	        <tr><td>비밀번호</td>
	        	<td colspan="2"><input type="password" id="pw" name="pw" maxlength="16" placeholder="숫자, 영문, 특수문자(!@#$%^&+=)를 포함한 8~16자를 입력해주세요"
	        			   style="width: 100%; height: 40px; border: none; border-radius: 10px; font-size: 15px;"></td></tr>
	        <tr><td>비밀번호확인</td>
	        	<td colspan="2"><input type="password" id="pwConfirm" name="pwConfirm" maxlength="16" placeholder="비밀번호를 한번 더 입력해주세요"
	        			   style="width: 100%; height: 40px; border: none; border-radius: 10px; font-size: 15px;"></td></tr>
	        <tr><td>이름</td>
	        	<td colspan="2"><input type="text" id="name" name="name" placeholder="두 글자 이상의 한글을 입력해주세요"
	        			   style="width: 100%; height: 40px; border: none; border-radius: 10px; font-size: 15px;"></td></tr>
	        <tr><td>이메일</td>
	        	<td colspan="2"><input type="text" id="firstEmail" name="firstEmail"
	        			   style="width: 30%; height: 40px; border: none; border-radius: 10px; font-size: 15px;">
	        		@<input style="width: 30%;height: 40px; border: none; border-radius: 10px; font-size: 15px;
	        					   font-family: 'tway_air';" type="text" id="secondEmail" name="secondEmail" disabled value="naver.com">
	        		<select id="selectEmail" name="selectEmail"
	        				style="width: 33%; height: 40px; border: none; border-radius: 10px; font-size: 15px;
	        					   float: right; font-family: 'tway_air';">
			            <option value="1">직접입력</option>
			            <option value="naver.com" selected>naver.com</option>
			            <option value="hanmail.net">hanmail.net</option>
			            <option value="hotmail.com">hotmail.com</option>
			            <option value="nate.com">nate.com</option>
			            <option value="yahoo.co.kr">yahoo.co.kr</option>
			            <option value="empas.com">empas.com</option>
			            <option value="dreamwiz.com">dreamwiz.com</option>
			            <option value="freechal.com">freechal.com</option>
			            <option value="lycos.co.kr">lycos.co.kr</option>
			            <option value="korea.com">korea.com</option>
			            <option value="gmail.com">gmail.com</option>
			            <option value="hanmir.com">hanmir.com</option>
			            <option value="paran.com">paran.com</option>
			        </select></td></tr>
<script type="text/javascript">
    //이메일 입력방식 선택
    $('#selectEmail').change(function(){
        $("#selectEmail option:selected").each(function () {
            if($(this).val()== '1'){ //직접입력일 경우
                $("#secondEmail").val('');                        //값 초기화
                $("#secondEmail").attr("disabled",false); //활성화
            }else{ //직접입력이 아닐경우
                $("#secondEmail").val($(this).text());      //선택값 입력
                $("#secondEmail").attr("disabled",true); //비활성화
            }
        });
    });
</script>
	        <tr><td colspan="2" style="width:300px;"><div id="div01" style="width: 100%;"><!--네이버캡챠 들어가는 곳--></div></td>
		        <td><input type="hidden" id="key" name="key">
			        <input type="text" name="value" placeholder="보안코드를 입력하세요"
			        	   style="width: 85%; height: 40px; border: none; border-radius: 10px; font-size: 15px; ">
			        <img src="/image/icons-reset.png" onclick="codeReset()" style="top: 10; cursor:pointer;"/></td></tr>
	        <tr><td colspan="3"><h4 id="p1" style="text-align: center; color: red;"></h4></td></tr>
	        <tr><td colspan="3"><input type="button" value="가입하기" onclick="form_check()"
	        						   style="width: 100%; height: 40px; border: none; border-radius: 10px; font-size: 25px;
	        						   		  font-family: 'tway_air'; cursor:pointer; text-align:center; background-color: #d2d2fc;"></td></tr>
	    </form>
	</tbody> 
    </table>
<c:import url="/guest/channelTalk"></c:import>
</body>
</html>
