<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
			border: 2px solid green;
		}
		tr,td,th{
			border: 1px solid green;
		}
		input.button{
			text-align: center;
		}
	</style>
</head>
<body>
	<table>
		<tr>
			<th>제목</th>
			<td>${info.title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${info.user_id}</td>
			<th>작성일자</th>
			<td>${info.reg_date}</td>
		</tr>
		<tr>
			<th>문제</th>
			<td>${info.quiz_content}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${info.content}</td>
		</tr>
		<tr>
			<th>이미지</th>
			<td><img src="/photo/${photo.new_filename}" width="400px" height="400px"/></td>
		</tr>
	</table>
	<input type="hidden" value="${info.board_name}"/>
	<c:choose>
		<c:when test="${like.board_no != null && like.user_id == loginId}">
			<img class="like" src="/bank/resources/img/like.png" alt="좋아요">
		</c:when>
		
		<c:otherwise> 
			<img class="like" src="/bank/resources/img/unlike.png" alt="빈 좋아요">
		</c:otherwise> 
	</c:choose>
	<input type="hidden" value="${info.board_no}"></input>
	<p>${countlike}</p>
	<p><img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수">(${info.bHit})</p>&nbsp;&nbsp;
	<img class="report" src="/bank/resources/img/report.png" alt="신고하기">
	<input type="button" onclick="location.href='./list'" value="목록"/>
	<input type="button" onclick="location.href='./updateForm?board_no=${info.board_no}'" value="수정"/>
	<input type="button" onclick="del()" value="삭제"/>
	
	<!-- 댓글 -->
	<hr/>
		<input type="text" name="reply"/>
		<input id="reply" type="button" onclick="reply" value="등록"/>
	<br/>
	<!-- 
	<c:forEach items="${reply_list}" var="reply">
		<input>
	</c:forEach>
	 -->
</body>
<script>

//신고하기
$('.report').click(function(){
	console.log('신고하기');
	var report = prompt("신고 사유를 입력해주세요.","");
	console.log(report);
	
	var params : {''};
	
	$.ajax({
		type:'POST',
		url:'studyReport',
		data:params,
		dataType:'JSON',
		success:function(result){
			console.log(result);
		},
		error:function(e){
			console.log('서버에 문제가 발생하였습니다.',e);
		}
	});//ajax괄호끝
});//신고하기 괄호끝

//글 삭제
function del(){
	var yn = confirm("정말 이 글을 삭제하시겠습니까?");
	
	if(yn){
		location.href='./delete?board_no=${info.board_no}';
	}
}

//좋아요
	$('.like').click(function(){
		//console.log("좋아요");
		if('${loginId}' == ''){
			alert('로그인이 필요한 서비스 입니다.');
		}else{
			
			var loginId = '${loginId}';
			var board_name = $(this).prev().val();
			var board_no = $(this).next().val();
			
			console.log("로그인 아이디 : "+loginId);
			console.log("게시판 : "+board_name);
			console.log("글번호 : "+board_no);
			
			var param = {'loginId':loginId,'board_name':board_name,'board_no':board_no};
			console.log(param);
			
			var thissrc = $(this).attr('src');
			
			if(thissrc == '/bank/resources/img/unlike.png'){
				$(this).attr('src','/bank/resources/img/like.png');
			}else{
				$(this).attr('src','/bank/resources/img/unlike.png');
			}
			
	
			$.ajax({
				type:'POST',
				url:'uplike',
				data:param,
				dataType:'JSON',
				success:function(data){
					if(data.success==1){
						console.log('좋아요 추가');
					}
					if(data.row2 == 1){
						console.log('좋아요 취소');
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 발생했습니다.');
				}
			});//ajax괄호끝
		}
	});//좋아요 괄호끝
	
	

	
	$('#reply').click(function reply(){
		console.log('댓글등록');
		
	});//댓글괄호 끝


</script>
</html>