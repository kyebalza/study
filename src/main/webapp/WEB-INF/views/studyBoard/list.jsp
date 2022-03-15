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
			text-align: center;
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
	<button onclick="location.href='writeForm'">글쓰기</button>
	<table>
		<tr>
			<th>글번호</th>
			<th>자격증</th>
			<th>제목</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>작성일자</th>
		</tr>
		<c:if test="${list eq null || size ==0}">
		<tr><td colspan="6">등록된 글이 없습니다.</td></tr>
		</c:if>
		<c:forEach items="${list}" var="bbs">
		<tr>
			<td>${bbs.board_no}</td>
			<td>${bbs.test_cate}</td><!-- 자격증 종류 -->
			<td><a href="detail?board_no=${bbs.board_no}">${bbs.title}</a></td>
			<td>${bbs.board_cate}</td><!-- 게시판 카테고리 -->
			<td>${bbs.user_id}</td>
			<td>${bbs.reg_date}</td>
		</tr>
		</c:forEach>
	</table>
</body>
<script></script>
</html>