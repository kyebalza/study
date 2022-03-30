<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 
 <style>
 	
 	#ibcom_button{
 		text-align: center;
 		background-color : #6AA84F;
	    color: white;
	    border: 1px solid #6AA84F;
	    border-radius: 9px;
	    width: 65px;
	    height: 30px;
	    margin: 5px;
	}
	
	table, tr, td, th {
		padding: 10px;
	}
	
	textarea {
         width: 100%;
         height: 50px;
         padding: 10px;
         box-sizing: border-box;
         border: solid 2px #6AA84F;
         border-radius: 5px;
         font-size: 15px;
         resize: none;
   	}
	
 

 
 </style>
</head>
<body>

<p style="color: green;">답변<p>
<hr/>

	<c:if test="${sessionScope.admin eq '관리자'}">
	<div id="ibcoment_wep">
		<span id="loginId"> ${loginId} </span>
		<div id="ibinput_wep">
			<form action="ibcoment" id="ibcoment" method="POST"> 
			<input type="hidden" name="loginId" value="${loginId}">
			<input type="hidden" name="user_id" value="${info.user_id}"> 
			<input type="hidden" name="board_no" value="${info.board_no}">
			<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"></textarea>
			<input type="button" id="ibcom_button" value="등록"/>
			</form>
		</div>
	</div>
	</c:if>
	
	
	<div id = "ibcomentlist">
		<c:forEach items="${ibcomList}" var="ibcomList">
			<table>
				<tr>
					<td>
						<c:if test="${ibcomList.ori_reply == 0}">
						
							<div class="ibcom_list">
								<span class="ibcom_user_id"> ${ibcomList.user_id} </span>
								<input type="hidden" value="${ibcomList.reply_no}"/>
							</div>
							
							<div class="ibcom_coment">
								<span> ${ibcomList.reply_content} </span>
							</div>
						
						</c:if>
					</td>
				</tr>
			
			</table>
		
		</c:forEach>
	</div>
	
	
	
	<jsp:include page="../footer.jsp"></jsp:include>
		

  
</body>
<script>

	/*
	console.log("${sessionScope.loginId}");
	console.log($('#user_id').html());
	console.log("${session.Scope.admin}");
	
	if ("${sessionScope.loginId}" !=$('user_id'.html)()) {
		$('#ibcom_button').attr('type','hidden');
	};
	
	if ("${sessionScope.admin}" != 'Y') {
		$('#ibcom_button').attr('display','none');
	};
	*/
	


	//댓글 전송 버튼
	$('#ibcom_button').click(function () {
		
		if ($('#reply_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			$('#ibcoment').submit();
		}
		
		
	});
	

</script>
</html>