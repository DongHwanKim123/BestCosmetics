<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<html>
<head>
    <title>Title</title>
<style type="text/css">
	@font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	
	body  {
	    padding-top: 160px;
	    padding-bottom: 120px;
	}
	
	#all {
		margin-left: 220px;
		font-family: 'tway_air';
	}
	
	#myList {
		text-align: center;
		width: 1000px;
	}
</style>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- firebase sdk -->
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="/script.js">
    	//api key 소스보기로 볼 수 없도록 js파일로 옮겨둠
    </script> 
    <script type="text/javascript">
    	// 대표사진 스토리지Url 만들어서 value 넣기
	 	function getRealPath(obj){  
			document.getElementById('BCG_IMG').value = 
				'https://firebasestorage.googleapis.com/v0/b/bestcosmetic-624a1.appspot.com/o/image%2F' 
				+ $(obj).val().split('/').pop().split('\\').pop() 
				+ '?alt=media';
		}
		
		// 상세사진 스토리지Url 만들어서 value 넣기
	 	function getRealPath2(obj){  
			document.getElementById('BCG_IMGDETAIL').value = 
				'https://firebasestorage.googleapis.com/v0/b/bestcosmetic-624a1.appspot.com/o/image%2F' 
				+ $(obj).val().split('/').pop().split('\\').pop() 
				+ '?alt=media';
		}
	</script>   
    <script>  
	    function null_check() {
	    	var num_check = /^[0-9]*$/;
			if($('#BCG_IMG').val().length == 0) {
				alert("대표사진은 필수사항입니다.");
				return;
			}
			
			if($('#BCG_IMGDETAIL').val().length == 0) {
	   			alert("상세사진은 필수사항입니다.");
	   			return;
	   		}
					
			if($('#BCG_NAME').val().length == 0) {
	   			alert("상품명은 필수사항입니다.");
	   			$('#BCG_NAME').focus();
	   			return;
	   		}
			
			if($('#BCG_PRICE').val().length == 0) {
	   			alert("가격은 필수사항입니다.");
	   			$('#BCG_PRICE').focus();
	   			return;
	   		}

			if (!num_check.test($('#BCG_PRICE').val())) {
                alert("가격은 숫자만 입력 가능합니다.");
                $('#BCG_PRICE').focus();
                return;
            }
			
			if($('#BCG_INFO').val().length > 300) {
	   			alert("전성분 글자수가 너무 많습니다.");
	   			$('#BCG_INFO').focus();
	   			return;
	   		}
			
			form_check();
		}
	    
    	function form_check(){       //firebase에 이미지 저장       	
        	// 대표사진 업로드
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
            
            // 상세사진 업로드
            // get dom in variables
            var hiddenBtn2 = document.getElementsByClassName('hidden-upload-btn2')[0];       
            // get file
            var file2 = hiddenBtn2.files[0];
            // change file name so cannot overwrite           
            var name2 = file2.name.split('.').shift() + '.' + file2.name.split('.').pop();
            var type2 = file2.type.split('/')[0];
            var path2 = type2 + '/' + name2;
            // now upload            
            var storageRef2 = firebase.storage().ref(path2);
            var uploadTask2 = storageRef2.put(file2);          
            
            submit_ajax();
        }
 
        function submit_ajax() {     //BC_GOODS oracle DB에 저장
            var queryString=$("#AddForm").serialize();
            $.ajax({
            	url: '/admin/upload',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                success: function(json) {  
                	window.location.replace("/admin/goodsAddDetail");           		               	           	
                }
            });
        }
    </script>
</head>
<body style="background-color: #E6E6FA;">
	<div style="float: top">
    	<c:import url="/admin/adminTop"></c:import>
	</div>
	
	<div style="float: left">
    	<c:import url="/admin/adminPageView"></c:import>
	</div>
	<section id="all">
    <h3>상품등록</h3><br>
    <form id="AddForm" method="post">
	    대표사진 : <input type="file" class="hidden-upload-btn" onchange="javascript:getRealPath(this);">
	    		   <input type="hidden" id="BCG_IMG" name="BCG_IMG">  <br/>      			    
        상세사진 : <input type="file" class="hidden-upload-btn2" onchange="javascript:getRealPath2(this);">
        		   <input type="hidden" id="BCG_IMGDETAIL" name="BCG_IMGDETAIL"><br/>       	                   
        상품명 : <input type="text" id="BCG_NAME" name="BCG_NAME"><br/>
        카테고리 : <select id="BCG_CATEGORY" name="BCG_CATEGORY">
        			<option value="skincare">스킨케어</option>
        			<option value="cleansing">클렌징</option>
        			<option value="suncare">선케어</option>
        			<option value="base">베이스메이크업</option>
        			<option value="point">포인트메이크업</option>
        			<option value="perfume">향수</option>
        		</select> <br/>
        가격 : <input type="text" id="BCG_PRICE" name="BCG_PRICE"><br>
        전성분 : <br/>
        <textarea id="BCG_INFO" name="BCG_INFO" cols="50" rows="15"></textarea><br><br>               
        <input type="button" class="btn btn-outline-secondary my-2 my-sm-0" value="등록" onclick="null_check()">
    </form>
    </section>
</body>
</html>
