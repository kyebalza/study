<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/adminLefter.css"/>
	
	<style>
		#mainPage div{
			width : 300px;
			height : 300px;
			float : left;
		}
		
		#grid {
		min-height : 1000px;
		}
		#mainPage{
			padding-right : 200px;
			padding-top : 50px;
			padding-left : 10px;
		}
		
	hr{
		border : 1px solid gray;
		margin : 10px 0px 10px 0px;
		width : 200px;
	}		
	</style>
</head>
<body>
	<iframe id="header" src="header">
	</iframe>
	<div id="grid">
		<div>
			<iframe id="lefter" src="adminLefter"></iframe>			
		</div>
		<div id="mainPage">
			<div>
				<h3>문제오류신고 미처리건</h3>
				<hr/>
				<p>5/235</p>
			</div>
			<div>
				<h3>신고 미처리건</h3>
				<hr/>
				<p>게시글</p>
				<p>댓글</p>
			</div>
			<div>
				<h3>금일 신규 게시글</h3>
				<hr/>
				<p>공부</p>
				<p>자유</p>
				<p>문의</p>
			</div>
			<div>
				<h3>회원현황</h3>
				<hr/>
				<p>정상</p>
				<p>탈퇴</p>
				<p>휴면</p>
				<p>정지</p>						
			</div>
		</div>
	</div>		
	
</body>
<script>
	
</script>
</html>
