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
	<form action="write" method="post">
		<table>
			<tr>
				<td>
					<select onclick="boardcate" name="boardcate">
		                <option value="문제">문제</option>
		                <option value="개념">개념</option>
	            </select>
					<td><input type="text" name="title" value="${info.title }"/></td>
					<td><input type="hidden" name="user_id" value=""/></td>
			   </td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<input type="selectbox" name="quiz_name" placeholder="시험이름"/>
					<input type="selectbox" name="quiz_year" placeholder="시험년도"/>
					<input type="selectbox" name="quiz_times" placeholder="시험회차"/>
					<input type="text" name="quiz_num" placeholder="문제번호를 입력해주세요"/>
					<button name="quiz">문제불러오기</button>
					<hr/>
					<textarea type="text" name="quiz"></textarea>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" value="${info.content}"></textarea></td>
			</tr>
			<tr>
				<th colspan="2">
					<form action="upload" method="post" enctype="multipart/form-data">
						<input type="text" name="title"/>
						<input type="file" name="uploadFile"/>
						<input type="submit" name="전송"/>
					</form>
				</th>
			</tr>
		</table>
		<input type="button" onclick="location.href='list'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
</body>
<script></script>
</html>