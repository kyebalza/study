<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
			margin:5px;
		}
		.sbcom_list{
			padding: 5px;
			margin:5px;
		}
		a{
			text-decoration:none;
		}
	</style>
</head>
<body>
</br>
</br>
	<div id="sbcoment_wep">
		<span id="loginId"> ${loginId} </span>
		<div id="sbinput_wep">
			<form action="sbcoment" id="sbcoment" method="POST">
				<input type="hidden" name="loginId" value="${loginId}">
				<input type="hidden" name="user_id" value="${info.user_id}">
				<input type="hidden" name="board_no" value="${info.board_no}">
				<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"></textarea>
				<input type="button" id="sbcom_button" value="등록" />
			</form>
		</div>
		<div>
			<c:forEach items="${sbcomList}" var="sbcomList">
				<table>
					<tr>
						<td>
								<div class = "sbcom_list">
									<span class="sbcom_user_id"> ${sbcomList.user_id} </span>
									<input type="hidden" value = "${sbcomList.reply_no}"/>
									<span class = "sbcom_a">
										<c:if test="${loginId == sbcomList.user_id}">
											<a class="sbcom_del" href="./sbcomdel?reply_no=${sbcomList.reply_no}&board_no=${sbcomList.board_no}&user_id=${sbcomList.user_id}">삭제</a>
										</c:if>
										<c:if test="${loginId != sbcomList.user_id}">
											<a id="sbcoreport" href="#" onclick="SBsingoPop()">신고</a>
										</c:if>
									</span>
									<span>
										<%-- <c:choose>
											<c:when test="${fbcomList.board_no != null && fbcomList.user_id == loginId}">
												<img class="relike" src="/bank/resources/img/like.png" alt="좋아요"> ${like}
											</c:when>
											
											<c:otherwise> 
												<img class="relike" src="/bank/resources/img/unlike.png" alt="빈 좋아요"> ${like}
											</c:otherwise> 
										</c:choose> --%>
									</span>
									<div class="sbcom_coment">
										<span>${sbcomList.reply_content}</span>
									</div>
									<c:if test="${loginId != sbcomList.user_id}">
										<input class="sbcom_reply_create" type="button" value="채택">
									</c:if>
								</div>
							<%-- <c:if test="${fbcomList.ori_reply eq 1}">
								<div class="fbcom_list" id="rereple">
									<input type="hidden" value="${fbcomList.reply_no}"/>
									<span class="fbcom_reply_a">
										<c:if test="${loginId eq fbcomList.reply_no}">
										<a class="fbcom_del" href="">삭제</a>
										</c:if>
										<c:if test="${loginId ne fbcomList.user_id}">
										<a href="#" onclick="singoPop()">신고</a>
										</c:if>
									</span>
									
									<div class="fbcom_coment">
										<span>${fbcomList.reply_content}</span>
									</div>
									<c:if test="${loginId ne fbcomList.user_id }">
										<input class="fbcom_reply_create" type="button" value="답글">
									</c:if>
								</div>
							</c:if> --%>
						</td>
					</tr>
				</table>
			</c:forEach>
		</div>
	</div>
</body>
<script>

	//댓글 전송 버튼
	$('#sbcom_button').click(function () {
		//console.log('댓글');
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
		}else if ($('#com_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			$('#sbcoment').submit();
		}
		
	});
	
	var loginId = "${loginId}";
	var board_no = "${info.board_no}";
	var user_id = "${info.user_id}";
	
	$('.sbcom_del').click(function () {
		console.log('댓글삭제 요청 : ');
		var yn = confirm("이 댓글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./studycomdelete?reply_no=${info.reply_no}';
		}
	})
	
	
	//댓글신고
	$('#sbcoreport').click(function(){
		console.log('댓글신고');
		if('${loginId}' == null){
			alert("로그인이 필요한 서비스 입니다.");
			location.href='/loginPage';
		}else{
			var report = prompt("신고 사유를 입력해주세요.","");
			console.log(report);
		}
	});
	
</script>
</html>
