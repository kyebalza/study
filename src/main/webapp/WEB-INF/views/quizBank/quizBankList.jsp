<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		.quizList{
			text-align: center;
		    width: 20%;
		    height: 150px;
		    display: inline-block;
		    margin-left: 2%;
		    margin-right: 2%;
		    max-width: 300px;
		    background-color: #ededed;
		    border-radius: 7px;
		    border-bottom: solid 3px gray;
		    border-top: solid 5px #6AA84F;
		}
		.quizList a{
		    text-decoration: none;
		    color: #6AA84F;
		    font-size: 20px;
		    font-weight: 600;
		}
		.quizList_all{
			text-align : center;
			width: auto;
			height: auto;
		    min-width: 1500px;
			margin: 40px;
		}
		.testTitle{
		    background-color: white;
		    border-radius: 8px;
		    height: 40px;
		    width: 100px;
		    border-top-style: none;
		    border-right-style: none;
		    border-left-style: none;
		    border-bottom-color: gray;
		}
		.testTitle:hover{
			background-color: #4caf50;
			color: white;
			cursor:pointer;
		}
		.quizBankListSearch{
			min-width: 1500px;
			border-style: none;
		}
		.quizBankTitle h1{
			text-align: center;
    		margin-top: 50px;
		}
		.quizBankSearchBar{
			height: 90%;
		    border-style: none;
		    background-color: #ededed;
		    width: 100%;
		    z-index: 2;
		    border-radius: 5px;
		    text-align: center;
    		font-size: 15px;
		}
		.quizBankSearchButton{
			height: 35px;
		    background-color: #6AA84F;
		    color: white;
		    border-style: none;
		    border-radius: 3px;
		    z-index: 9;
		    position: absolute;
		    width: 70px;
		}
		.searchGroup{
			width: 500px;
		    height: 35px;
		    background-color: #ededed;
		    border-radius: 3px;
		    margin-left: 34%;
		    z-index: 2;
		}
		.quizBankTitle{
			min-width: 1600px;
		}
	</style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="quizBankTitle">
	<h1>????????? ????????????</h1>
</div>

	
	<div class="quizBankListSearch">
		<form action="search" method="get">
			<div class="searchGroup">
					<input class="quizBankSearchBar" type="text" name="keyword" placeholder="???????????? ???????????????">
					<button class="quizBankSearchButton">??????</button>
			</div>
		</form>
			<!-- <img id="search_icon" src="resources/img/??????1.png" alt="????????????"> -->
	</div>	

	<div class="quizList_all">
		<c:forEach items="${list}" var="list">		
			<div class="quizList">
				<br/>
				<br/>
				<a class="boardtitle" href="quizBankTestDetail?test_cate_no=${list.test_cate_no}">${list.test_cate}</a>
				<br/>
				<br/>
				<input type = "button" class= "testTitle" value = "???????????????" onclick = "location.href='quizBankTestDetail?test_cate_no=${list.test_cate_no}'"/>
			</div>
		</c:forEach>
	</div>
	
	
<jsp:include page="../footer.jsp"></jsp:include>	
</body>
<script></script>
</html>