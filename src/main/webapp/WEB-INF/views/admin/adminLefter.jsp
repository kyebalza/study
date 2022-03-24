<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	
	<style>
	body{
		background-color : white;
		border-right : 1px solid black;
		border-top : 1px solid black;
		
	}
	ul,li{
		padding : 0;
	}
	a,h3 {
		color : black;
		text-decoration : none;
	}
	.bold{
	
		font-weight : bold;
	}
	
	div{
		
	}
	#all{
		padding-top : 20px;
	}
	
	
	</style>
</head>
<body>
		<div id="all">
		<h3>시험관리</h3>
			<ul>
				<li><a href="adminRegistTest" target="_parent">-시험 및 문제 등록</a></li>
				<li><a href="adminQuizList" target="_parent">-시험 문제 관리</a></li>	
				<li><a href="adminQuizReport" target="_parent">-문제 오류신고 관리</a></li>				
			</ul>	
			
		<h3>신고</h3>
				<ul>
					<li><a href="ManagDe" target="_parent">-신고 게시글</a></li>		
					<li><a href="ManagDeComent" target="_parent">-신고 댓글</a></li>		
				</ul>	
		<h3>게시글 관리</h3>
				<ul>
					<li><a href="ManagPostStudy" target="_parent">-공부질문게시글</a></li>
					<li><a href="ManagPostFree" target="_parent">-자유게시글</a></li>
					<li><a href="ManagPostInquriy" target="_parent">-문의게시글</a></li>	
				</ul>	
		<h3>회원관리</h3>
				<ul>
					<li><a href="ManagUser" target="_parent">-회원관리</a></li>	
				</ul>	
	
		</div>	
</body>
<script>
$('li').click(function(){
	$(this).children('a')[0].click();
	
});
var link = document.referrer.split("/");; 
console.log(link);
var nowPage = link[link.length-1];
$('a[href="'+nowPage+'"]').addClass('bold');


</script>
</html>