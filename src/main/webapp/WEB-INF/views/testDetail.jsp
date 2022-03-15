<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table, th, td{
			border : 1px solid black;
			border-collapse: collapse;
			padding: 5px;
		}	
	</style>
</head>
<h3>${test_name.test_cate} 시험 상세보기 페이지 입니다.</h3>

<!-- 검색기능인데 지울 것
	<form action="test_search" method="get">
		<fieldset>
			<select name="opt">
				<option value="test_year">시험년도</option>
				<c:forEach items="${test}" var="test">
					<option value="${test.test_year}">${test.test_year}</option>
				</c:forEach>
			</select>
			<select name="opt2">
				<option value="test_count">시험회차</option>
				<c:forEach items="${test}" var="test">
					<option value="${test.test_count}">${test.test_count}</option>
				</c:forEach>
			</select>
			<button>검색</button>
		</fieldset>	
	</form>
 -->
 <div class="quizPage">
	<input type="button" value="회차별 문제풀기" onclick="location.href='testDetail?test_cate_no=${test_name.test_cate_no}'"/>
	<input type="button" value="과목별 문제풀기" onclick="location.href='loginPage'"/>
	<input type="button" value="북마크 문제풀기" onclick="location.href='loginPage'"/> 
 </div>
<body>
	<div class="testList">
		<table>
			<tr>
				<th colspan="4">${test_name.test_cate}</th>
			</tr>
			<c:forEach items="${test}" var="test">
				<tr>
					<th colspan="2">${test.test_year}년도  ${test.test_count}회  ${test_name.test_cate}</th>
					<td><button onclick="location.href='testForm?test_no=${test.test_no}'">시험보기</button></td>
					<td><button onclick="location.href='practiceForm/${test.test_no}'">연습하기</button></td>
				</tr>
			</c:forEach>
		</table>	
	</div>
	
	<button onclick="location.href='quizBankList'">리스트</button>
</body>
<script></script>
</html>