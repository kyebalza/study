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
			<th>첨부파일</th>
			<td><div id="area"></div></td>
		</tr>
	</table>
	<button>좋아요</button>&nbsp;&nbsp;<p>조회수(${info.bHit})</p>&nbsp;&nbsp;<button>신고하기</button>
	<input type="button" onclick="location.href='./list'" value="목록"/>
	<input type="button" onclick="location.href='./updateForm?idx=${info.board_no}'" value="수정"/>
	<input type="button" onclick="del()" value="삭제"/>

</body>
<script>
function del(){
	var yn = confirm("정말 이 글을 삭제하시겠습니까?");
	
	if(yn){
		location.href='./delete?board_no=${info.board_no}';
	}
}
</script>
</html>