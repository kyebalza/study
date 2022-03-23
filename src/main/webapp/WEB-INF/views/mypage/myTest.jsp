<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/myPage.css"/>
	<style>
		#header{
		width: 100%;
		height: 100px;
			/* border-style: none; */
		overflow: hidden;
		}
body{
	margin : 0px;
		
}
		
	</style>
</head>
<body>
<iframe id="header" src="header"></iframe>

<div id="all">
<div id="myPageHeader">
	<input type="button" value="내 알림" onclick="location.href='myNotice'"/>
	<input type="button" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" id="nowPage"  value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" value="회원정보" onclick="location.href='myInfo'"/>
</div>



<div>

</div>


</div>

		
</body>
<script>





</script>
</html>