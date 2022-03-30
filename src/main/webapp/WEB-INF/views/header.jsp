<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script> -->
	<style>
	#header_all{
		height : 150px;
		min-width : 1150px;
    	border-bottom: solid 10px #6AA84F;
	}
	#header_all div{
		height : 10px;
		text-align : center;
		font-weight : bold;
	}
	#header_all div,#header_all img{
		float : left;
		cursor: pointer;
	}
	.header_center_cate a{
		text-decoration: none;
		color : gray;
		font-size: 25px;
	}
	.header_login a{
		text-decoration: none;
		color : gray;
		font-size: 25px;
	}
	
	.header_main_logo{
		width : 20%;
	    margin-top: 35px;
	}
	.header_center_cate{
		width : 13%;
	    margin-top: 48px;    
	}
	.header_login{
		width : 25%; 
		text-align : center;
		margin-top: 48px;
		color: gray;
    	font-size: 25px;  
	}
	</style>
</head>
<body>

<div id="header_all">
	<div class="header_main_logo" ><img src="<c:url value='/resources/img/Logo.png'/>" onclick="parent.location.href='<c:url value='/./'/>'" style="margin-left: 35%;"/></div>
	<div class="header_center_cate" ><a href="<c:url value='/quizBankList'/>" target="_parent">문제은행</a></div>
	<div class="header_center_cate" ><a href="<c:url value='/studyBoard/list'/>" target="_parent">공부게시판</a></div>
	<div class="header_center_cate" ><a href="<c:url value='/freeBoardList'/>" target="_parent">자유게시판</a></div>
	<div class="header_center_cate" ><a href="<c:url value='/inquiryBoardList'/>" target="_parent">문의게시판</a></div>
	<div class="header_login">
		<c:if test="${admin == '관리자' }">
			<a href="<c:url value='/adminPage'/>" target="_parent">관리자페이지</a>
		</c:if>
		<c:if test="${admin == '회원' }">
			<a href="<c:url value='/myBoard'/>" target="_parent">마이페이지</a>
		</c:if>
		<c:if test="${loginId eq null }">
			<a href="<c:url value='/joinForm'/>" target="_parent">회원가입</a>
		</c:if>
		 | 
		<c:if test="${loginId eq null }">
			<a href="<c:url value='/loginPage'/>" target="_parent">로그인</a>
		</c:if>
		<c:if test="${loginId ne null }">
			<a href="<c:url value='/logout'/>" target="_parent">로그아웃</a>
		</c:if>
	</div>
</div>
</body>
<script>



</script>
</html>