<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		width: 1200px;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

function AnswerAdd(BCG_KEY,BCM_NUM,BCQ_CONTENT,BCQ_DATE) {
    var url= "/admin/answer?"+"BCG_KEY="+BCG_KEY+"&BCM_NUM="+BCM_NUM+"&BCQ_CONTENT="+BCQ_CONTENT+"&BCQ_DATE="+BCQ_DATE;
    var url2= "BCG_KEY="+BCG_KEY+"&BCM_NUM="+BCM_NUM+"&BCQ_CONTENT="+BCQ_CONTENT+"&BCQ_DATE="+BCQ_DATE;
    console.log("url : " + url);
    console.log("url2 : " + url2);
    $.ajax({
        url : '/admin/answer',
        type : 'POST',
        data : url2,
        success : function(json) {
            window.open(url, "", "width=500, height=500");
        }
    });
 }
</script>
</head>
<body style="background-color: #E6E6FA; ">
	<div style="float: top">
    	<c:import url="/admin/adminTop"></c:import>
	</div>
	
	<div style="float: left">
    	<c:import url="/admin/adminPageView"></c:import>
	</div>
<section id="all">
<h3>상품문의리스트</h3>
<br>
총 ${page.totalCount}개
<table border="1" id="myList">
		<form id="questionList" method="post">
			<c:if test="${page.totalCount>0}"> 
			<tr>
				<td>품번</td>
				<td>품명</td>
				<td>회원번호</td>
				<td>회원이름</td>
				<td>질문일</td>
				<td>질문내용</td>
				<td>답변일</td>
				<td>답변내용</td>		
			</tr>
			</c:if>

			<c:forEach items="${list}" var="dto">
			<tr>
					<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${dto.bcg_key}">
					<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="${dto.bcm_num}">
					<input type="hidden" id="BCQ_CONTENT" name="BCQ_CONTENT" value="${dto.bcq_content}">
					<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${dto.bcg_name}">
					<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="${dto.bcm_name}">
					<input type="hidden" id="BCQ_DATE" name="BCQ_DATE" value="${dto.bcq_date}">
					<input type="hidden" id="BCA_DATE" name="BCA_DATE" value="${dto.bca_date}">
				<td> ${dto.bcg_key}</td>
				<td> ${dto.bcg_name} </td>
				<td> ${dto.bcm_num}</td>							
				<td> ${dto.bcm_name} </td>							
				<td> <fmt:formatDate value="${dto.bcq_date}" pattern="yyyy-MM-dd" var="bcq_date" /> ${bcq_date} </td>							
				<td> ${dto.bcq_content} </td>
				<c:if test="${dto.bca_content != null}">	
					<td> <fmt:formatDate value="${dto.bca_date}" pattern="yyyy-MM-dd" var="bca_date" /> ${bca_date} </td>								
					<td> ${dto.bca_content}</td>
				</c:if>							
				<c:if test="${dto.bca_content == null}">
					<td colspan="2"> 
						<input type="button" class="btn btn-outline-secondary my-2 my-sm-0" value="답변등록" onclick="AnswerAdd('${dto.bcg_key}','${dto.bcm_num}', '${dto.bcq_content}', '${dto.bcq_date}');">
					</td>
				</c:if>				
			</tr>
			</c:forEach>	
		</form>	
	</table>
</section>
</body>
</html>