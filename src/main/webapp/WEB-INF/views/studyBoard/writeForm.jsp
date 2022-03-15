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
	<form action="write" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<td>
					<select onclick="boardcate" name="board_cate_no">
		               <c:forEach items="${study_cate}" var="study_cate"> 
		               		<option value="${study_cate.board_cate_no }">${study_cate.board_cate }</option>
		               	</c:forEach>
	            </select>
					<td><input type="text" name="title" placeholder="제목을 입력해주세요."/></td>
			   </td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<select onclick="quiz_name" name="quiz_name" placeholder="시험회차">
						<c:forEach items="${quiz_name}" var="quiz_name">
							<option value="${quiz_name.test_cate}">${quiz_name.test_cate}</option>
						</c:forEach>
					</select>
					<select onclick="quiz_year" name="quiz_year" placeholder="시행년도">
						<c:forEach items="${year_count}" var="year_count">
							<option value="${year_count.test_year}">${year_count.test_year}</option>
						</c:forEach>
					</select>
					<select onclick="quiz_times" name="quiz_times" placeholder="시험회차">
						<c:forEach items="${year_count}" var="year_count">
							<option value="${year_count.test_count}">${year_count.test_count}</option>
						</c:forEach>
					</select>
					<input type="text" name="quiz_no" placeholder="문제번호를 입력해주세요"/>
					<button name="quiz">문제불러오기</button>
					<hr/>
					<textarea type="text" name="quiz"></textarea>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><input type="file" name="uploadFile"/></td>
			</tr>
		</table>
		<input type="button" onclick="location.href='list'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
</body>
<script>
	
</script>
</html>