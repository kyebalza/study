<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		
	</style>
</head>
<body>
</br>
</br>
	<div id="fbcoment_wep">
		<span id="loginId"> ${loginId} </span>
		<div id="fbinput_wep">
			<form action="fbcoment" id="fbcoment" method="POST">
				<input type="hidden" name="loginId" value="${loginId}">
				<input type="hidden" name="user_id" value="${info.user_id}">
				<input type="hidden" name="board_no" value="${info.board_no}">
				<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"></textarea>
				<input type="button" id="fbcom_button" value="등록" />
			</form>
		</div>
		<div>
			<c:forEach items="${fbcomList}" var="fbcomList">
				<table>
					<tr>
						<td>
							<div class = "fbcom_list">
								<span class="fbcom_user_id"> ${fbcomList.user_id} </span>
								<input type="hidden" value = "${fbcomList.reply_no}"/>
								<span class = "fbcom_a">
									<c:if test="${loginId == fbcomList.user_id}">
										<a class="fbcom_del" href="./fbcomdel?reply_no=${fbcomList.reply_no}&board_no=${fbcomList.board_no}&user_id=${fbcomList.user_id}">삭제</a>
									</c:if>
									<c:if test="${loginId != fbcomList.user_id}">
										<a href="#" onclick="singoPop()">신고</a>
									</c:if>
								</span>
								<span>
									<c:choose>
										<c:when test="${fbcomList.board_no != null && fbcomList.user_id == loginId}">
											<img class="relike" src="/bank/resources/img/like.png" alt="좋아요">
										</c:when>
										
										<c:otherwise> 
											<img class="relike" src="/bank/resources/img/unlike.png" alt="빈 좋아요">
										</c:otherwise> 
									</c:choose> 
								</span>
								<div class="fbcom_coment">
									<span>${fbcomList.reply_content}</span>
								</div>
								<c:if test="${loginId != fbcomList.user_id}">
									<input class="fbcom_reply_create" type="button" value="답글">
								</c:if>
							</div>
						</td>
					</tr>			
				</table>
			</c:forEach>
		</div>
	</div>
</body>
<script>

	//댓글 전송 버튼
	$('#fbcom_button').click(function () {
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
		}else if ($('#com_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			console.log("클릭 확인");
			$('#fbcoment').submit();
		}
		
	});
	
	
/* 	var currPage = 1;
	var totalPage = 2;
	
	
	listCall(currPage, 10);
	
	$.ajax ({
		type:'GET',
		url:'FBlistCall',
		date:{'page':page, 'cnt':cnt},
		dataType:'JSON',
		success:function(date){
			console.log(date);
			totalPage = data.pages;
			listDraw(data.list);
			
			$('#pagination').twbsPagination({
				startPage: currPage,//현재페이지
				totalPages: totalPage,//만들 수 있는 총 페이지 수
				visiblePages: 5,//[1],[2],[3]...이걸 몇개까지 보여줄 것인지
				onPageClick: function(evt,page){//해당 페이지 번호를 클릭했을 때 일어날 일들
					console.log(evt);//현재 일어나는 클릭 이벤트 관련 정보들
					console.log(page);//몇 페이지를 클릭했는지에 대한 정보
					listCall(page, 10);
				}
			});
		},
		error:function(e){
			console.log(e);
		
		}
	}); */
	
	
	
	
	

	

	
</script>
</html>
