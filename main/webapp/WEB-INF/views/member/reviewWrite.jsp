<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
	int bcm_num = 0;
	String bcm_name = ""; 
	if(session.getAttribute("num")!=null) {
		bcm_num = (int)session.getAttribute("num");
		bcm_name = (String)session.getAttribute("name");
	}
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link href="/assets/css/star.css" rel="stylesheet"/>		
    <!-- firebase sdk -->
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="/script.js">
    	//api key 소스보기로 볼 수 없도록 js파일로 옮겨둠
    </script> 
    <script type="text/javascript">
    	// 대표사진 스토리지Url 만들어서 value 넣기
	 	function getRealPath(obj){  
			document.getElementById('BCR_PHOTO').value = 
				'https://firebasestorage.googleapis.com/v0/b/bestcosmetic-624a1.appspot.com/o/image%2F' 
				+ $(obj).val().toString().split('/').pop().split('\\').pop() 
				+ '?alt=media';
		}
	</script>   
    <script>    
	    function form_check() {
			if($('#BCR_CONTENT').val().length == 0) {
				alert("리뷰 내용을 입력해주세요");
				$('#BCR_CONTENT').focus();
				return;
			}
			file_form_check();
	    }
    
    	function file_form_check(){      //사진유무체크  
    		var filecheck = document.getElementsByClassName('hidden-upload-btn')[0].value;
    		console.log("filecheck : "+filecheck);
        	if (filecheck!='') { 
        		imgUpload(); 
        	} else { 
        		submit_ajax();
        	}        
        }
    	
    	function imgUpload() {     //firebase에 이미지 저장     
    		// 리뷰사진 업로드
    		// get dom in variables
        	var hiddenBtn = document.getElementsByClassName('hidden-upload-btn')[0]; 
        	// get file
            var file = hiddenBtn.files[0];
            // change file name so cannot overwrite
            var name = file.name.split('.').shift() + '.' + file.name.split('.').pop();
            var type = file.type.split('/')[0];
            var path = type + '/' + name;
            // now upload
            var storageRef = firebase.storage().ref(path);
            var uploadTask = storageRef.put(file);
            
            submit_ajax();
    	}

        function submit_ajax() {     //BC_REVIEW oracle DB에 저장
            var queryString=$("#AddForm").serialize();
            $.ajax({
            	url: '/member/upReview',  
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
		.fset fieldset{
		    display: inline-block;
		    direction: rtl;
		    border: 2px;
		}
		.fset fieldset legend{
		    text-align: right;
		}
		.fset input[type=radio]{
		    display: none;
		}
		.fset label{
		    font-size: 3em;
		    color: transparent;
		    text-shadow: 0 0 0 #f0f0f0;
		}
		.fset label:hover{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		.fset label:hover ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		.fset input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#BCR_CONTENT {
		    width: 100%;
		    height: 150px;
		    padding: 10px;
		    box-sizing: border-box;
		    border: solid 1.5px #D3D3D3;
		    border-radius: 5px;
		    font-size: 16px;
		    resize: none;
		    font-family: 'tway_air';
		}
		@font-face {
	    	font-family: 'tway_air';
	    	src: url('/tway_air.ttf') format('truetype');
		}
		.filebox label {
		    display: inline-block;
		    padding: .5em .75em;
		    font-size: inherit;
		    line-height: normal;
		    text-align: right;
		    vertical-align: middle;
		    background-color: #d2d2fc;
		    cursor: pointer;
		    border: 2px;
		    border-radius: 5px;
		    -webkit-transition: background-color 0.2s;
		    transition: background-color 0.2s;
		    font-family: 'tway_air';
		}
		
		.filebox label:hover {
		    background-color: #E6E6FA;
		}
		.filebox input[type="file"] {
  		    position: absolute;
		    width: 1px;
		    height: 1px;
		    padding: 0;
		    margin: -1px;
		    overflow: hidden;
		    clip: rect(0, 0, 0, 0);
		    border: 0;
		}
		.rUp {
			font-family: 'tway_air';
			text-align: center;
			width: 100%;
		}
	</style>
</head>
<body style="background-color: #f2f2fc;">
	<table class="rUp">
	<thead style="font-size: 30px; background-color: #d2d2fc;">	
		<tr><td>리뷰 등록창</td></tr>
    </thead>
    <tbody>
	    <form id="AddForm" method="post">
			<tr><td><img src="${BCG_IMG}" width="250px"></td></tr>
			<tr><td>${BCG_NAME}<br/></td></tr>
			<tr><td class="fset"><fieldset>
				<!-- 라디오 선택 안하면 0점인거 체크해야함 -->
				<input type="radio" name="BCR_SCORE" value="5" id="rate1"><label
					for="rate1">★</label>
				<input type="radio" name="BCR_SCORE" value="4" id="rate2"><label
					for="rate2">★</label>
				<input type="radio" name="BCR_SCORE" value="3" id="rate3"><label
					for="rate3">★</label>
				<input type="radio" name="BCR_SCORE" value="2" id="rate4"><label
					for="rate4">★</label>
				<input type="radio" name="BCR_SCORE" value="1" id="rate5"><label
					for="rate5">★</label>
			</fieldset></td></tr>
			<tr><td class="filebox">
				<label for="r_file">리뷰 사진 업로드</label>
				<input type="file" class="hidden-upload-btn" id="r_file" onchange="javascript:getRealPath(this);"><br/>
		    	<input type="hidden" id="BCR_PHOTO" name="BCR_PHOTO">   			         	                          
			</td></tr>
			<tr><td>	
				<textarea class="col-auto form-control" type="text" id="BCR_CONTENT" name="BCR_CONTENT"
						  placeholder="리뷰 내용을 150자 이내로 기재해주세요."></textarea>
				<br /><p class="bytes">(0 / 150자)</p>
				<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">   
				<input type="hidden" id="BCO_ORDERNUM" name="BCO_ORDERNUM" value="${BCO_ORDERNUM}">   
	       		<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">           
	       		<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="<%=bcm_num%>">           
	       		<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="<%=bcm_name%>">           
	       	</td></tr>
	       	<tr><td>
	       		<input type="button" value="등록" onclick="form_check()"
	       			   style="border: 0; border-radius: 5px; font-family: 'tway_air';
							  background-color: #d2d2fc; font-size: 15px; text-align: center; cursor: pointer; padding:10px;">
			</td></tr>
	    </form>
	</tbody>  
    </table>
</body>
</html>
