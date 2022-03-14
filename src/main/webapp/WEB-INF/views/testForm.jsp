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
	<h3>시험페이지입니다.</h3>
		<c:forEach items="${test}" var="test">
			<hr/>
			<div>북마크</div>
			<br/>
			<div >
				<div>${test.quiz_index}번. ${test.quiz_content}</div>
				<br/>
				<div>정답률</div>
				<br/>
				<div>사진</div>
				<br/>
				<ul>
					<li>①${test.option1}</li>
					<li>②${test.option2}</li>
					<li>③${test.option3}</li>
					<li>④${test.option4}</li>
				</ul>
			</div>
		</c:forEach>
</body>
<script></script>
</html>