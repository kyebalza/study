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
<h3>문제은행페이지입니다</h3>
	
	<form action="search" method="get">
		<fieldset>
			<select name="opt">
				<option value="test_cate">시험명</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어를 입력하세요">
			<button>검색</button>
		</fieldset>	
	</form>

	<div class="all">
		<c:forEach items="${list}" var="list">		
			<div class="quizList">
				<a class="boardtitle" href="testdetail?test_cate_no=${list.test_cate_no}">${list.test_cate}</a>
				<br/>
			</div>
		</c:forEach>
	</div>
</body>
<script></script>
</html>