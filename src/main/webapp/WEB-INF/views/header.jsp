<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script> -->
	<style>
	#all{
		height : 100px;
		min-width : 1150px;
	
	}
	#all div{
		width : 150px;
		height : 10px;
		margin-top : 35px;
		text-align : center;
		font-weight : bold;
	}
	#all div,#all img{
		float : left;
	}
	a{
		text-decoration: none;
		color : gray;
	
	}
	.header_main_logo{
		width: 30%;
	}
	.header_center_cate{
		width: 10%;
		    
	}
	</style>
</head>
<body>
<div id="all">
	<div class="header_main_logo" style="width : 20%;"><img src="resources/img/Logo.png" onclick="parent.location.href='./'" style="margin-left: 35%;"/></div>
	<div class="header_center_cate" style="width : 13%;"><a href="quizBankList" target="_parent">문제은행</a></div>
	<div class="header_center_cate" style="width : 13%;"><a href="studyBoard/list" target="_parent">공부게시판</a></div>
	<div class="header_center_cate" style="width : 13%;"><a href="freeBoardList" target="_parent">자유게시판</a></div>
	<div class="header_center_cate" style="width : 13%;"><a href="inquiryBoardList" target="_parent">문의게시판</a></div>
	<div style="width : 25%; text-align : center;">
		<c:if test="${loginId eq null }">
			<a href="loginPage" target="_parent">로그인</a>
		</c:if>
		<c:if test="${loginId ne null }">
			<a href="logout" target="_parent">로그아웃</a>
		</c:if>
		<br/>
		<c:if test="${admin == '관리자' }">
			<a href="adminPage" target="_parent">관리자페이지</a>
		</c:if>
		<c:if test="${admin == '회원' }">
			<a href="myBoard" target="_parent">마이페이지</a>
		</c:if>
	</div>
</div>
</body>
<script>



</script>
</html>