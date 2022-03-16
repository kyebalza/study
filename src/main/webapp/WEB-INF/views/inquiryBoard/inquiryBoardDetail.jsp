<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <style>
 
 table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding : 5px 10px;	
}

textarea {
	width: 100%;
	height: 150px;
	resize: none;
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
			<th>카테고리</th>
			<td>${info.board_cate_no}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td id="user_id">${info.user_id}</td>
		</tr>
		<tr>
			<th>작성일자</th>
			<td>${info.reg_date}</td>
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
	
	<p>조회수(${info.bHit})</p>
	<input type="button" onclick="location.href='./inquiryUpdateForm?board_no=${info.board_no}'" value="수정"/>
	<input type="button" onclick="del()" value="삭제"/>			
	<input type="button" onclick="location.href='./inquiryBoardList?currpage=1'" value="목록"/>
	

	
</body>
<script>

	function del(){
		var yn = confirm("정말 이 글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./inquirydelete?board_no=${info.board_no}';
		}
		
	}
	





</script>
</html>