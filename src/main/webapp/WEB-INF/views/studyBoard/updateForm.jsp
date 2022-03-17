<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/css/common.css">
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
	<form action="update" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<th>제목</th>
				<td>
	            	<input type="hidden" name="board_no" value="${dto.board_no}"/>
	            	<input type="text" name="title" value="${dto.title }"/>
			   </td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
	            	<input type="text" name="user_id" value="${dto.user_id }"/>
			   </td>
			   <th>작성일자</th>
			   <td>
	            	<input type="text" name="user_id" value="${dto.reg_date}"/>
			   </td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<input type="text" name="quiz"/>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>내용</th>
				<td><input name="content" value="${dto.content}"/></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><img src="/photo/${photo.new_filename}" width="400px" height="400px"/></td>
			</tr>
		</table>
		<br/>
		<input type="file" name="uploadFile"/>
		<br/>
		<input type="button" onclick="location.href='list'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
</body>
<script>
	
</script>
</html>