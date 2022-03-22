<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <style></style>
</head>
<body>
<br/>
댓글
<hr/>
	<div id="ibcoment_wep">
		<span id="loginId"> ${loginId} </span>
		<div id="ibinput_wep">
			<form action="ibcoment" id="ibcoment" method="POST"> 
			<input type="hidden" name="loginId" value="${loginId}">
			<input type="hidden" name="user_id" value="${info.user_id}"> 
			<input type="hidden" name="board_no" value="${info.board_no}">
			<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"></textarea>
			<input type="button" id="ibcom_button" value="등록" />
			</form>
		</div>
	</div>
	
	<div>
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
		
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
		}else if ($('#com_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			$('#ibcoment').submit();
		}
		
		
	});
	
	/*
	var loginId = "${loginId}";
	var $board_no = "${info.board_no}";
	var $user_id = "${info.user_id}";
	
	$('.ibcom_del').click(function () {
		
		var yn = confirm("이 댓글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./freecomdelete?reply_no=${info.reply_no}';
		}
	})
	*/

</script>
</html>