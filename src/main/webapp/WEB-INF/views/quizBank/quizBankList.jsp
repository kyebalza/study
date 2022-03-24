<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		.quizList{
			border: solid black;
			text-align : center;
			width: 20%;
			height: 150px;
			display: inline-block;
		}
		.all{
			border: solid black;
			text-align : center;
			width: auto;
			height: auto;
			min-width: 900px;
		
		}
		.testTitle{
			background-color: white;
		    border-radius: 8px;
		    height: 30px;
		    width: 100px;
		}
		.testTitle:hover{
			background-color: #4caf50;
			color: white;
			cursor:pointer;
		}
	</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<h3>문제은행페이지입니다</h3>
	
	<form action="search" method="get">
		<fieldset>
			<input type="text" name="keyword" placeholder="검색어를 입력하세요">
			<button>검색</button>
		</fieldset>	
	</form>

	<div class="all">
		<c:forEach items="${list}" var="list">		
			<div class="quizList">
				<a class="boardtitle" href="testDetail?test_cate_no=${list.test_cate_no}">${list.test_cate}</a>
				<br/>
				<input type = "button" class= "testTitle" value = "문제리스트" onclick = "location.href='quizBankTestDetail?test_cate_no=${list.test_cate_no}'"/>
			</div>
		</c:forEach>
	</div>
</body>
<script></script>
</html>