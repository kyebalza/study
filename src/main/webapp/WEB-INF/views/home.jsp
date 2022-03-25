<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/header.css"/>
	
	<style>
	li{
		padding : 5px;
	}
	table,th,td{
		border-collapse : collapse;
	}
	
	#allDiv {
		height : 500px;
		margin-left : auto;
		margin-right : auto;
		/*
		border : 1px solid blue;
		*/
	}
	#rankingDiv {
		margin-left : auto;
		margin-right : auto;
	

		width : 910px;
		height : 300px;
	}
	#boardDiv{
		margin-left : auto;
		margin-right : auto;
		width : 800px;
		/*
		border : 1px solid tomato;
		*/
	}
	
	#rankingDiv div{
		/*
		border : 1px solid red;
		*/
		width : 300px;
		height : 300px;
		float : left;
	}
	table{
		float : left;
		/*
		border : 1px solid yellow;
		*/
		text-align : center;
		width : 400px;
	}
	tbody th,tbody td{
		border-bottom : 1px solid lightGreen;
	}
	thead th{
		border-bottom : 2px solid lightGreen;
	}
	
	
	
	</style>
</head>
<body>
<%@ include file="./header.jsp" %>
<div id="allDiv">
	<div id="rankingDiv">
		<div>
			<h3>열심상</h3>
			<ol id="manyQuiz">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
		<div>
			<h3>다득점</h3>
			<ol id="manyCorrect">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
		<div>
			<h3>백발백중</h3>
			<ol id="manyCorrectPer">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
			
	</div>
	
	<div id="boardDiv">
		<table>
			<thead>
				<tr><th colspan="2">공부게시판 인기 게시글</th></tr>
			</thead>
			<tbody id="studyBoardLike">
			</tbody>
		</table>
		<table>
			<thead>
				<tr><th colspan="2">자유게시판 인기 게시글</th></tr>
			</thead>
			<tbody id="freeBoardLike">
			</tbody>
		</table>
	</div>
</div>






<jsp:include page="./footer.jsp"></jsp:include>
</body>
<script>
mainStatics();
function mainStatics(){
	$.ajax({
		url : 'mainStatics',
		type: 'get',
		data : '',
		dataType : 'json',
		success : function(data){
			console.log(data);
			var manyQuiz = '';
			data.manyQuiz.forEach(function(item,idx){
				manyQuiz += '<li>'+item.user_id+'  '+item.ccw+'개 </li>';
				});
			var manyCorrect = '';
			data.manyCorrect.forEach(function(item,idx){
				manyCorrect += '<li>'+item.user_id+'  '+item.scw+'개 </li>';	
				});
			var manyCorrectPer = '';
			data.manyCorrectPer.forEach(function(item,idx){
				manyCorrectPer += '<li>'+item.user_id+'  '+item.per*100+'% </li>';
				});
			
				
			$('#manyQuiz').empty();
			$('#manyQuiz').append(manyQuiz);
			$('#manyCorrect').empty();
			$('#manyCorrect').append(manyCorrect);
			$('#manyCorrectPer').empty();
			$('#manyCorrectPer').append(manyCorrectPer);
			var studyBoardLike = '';
			data.studyBoardLike.forEach(function(item,idx){
				studyBoardLike += '<tr>';
				studyBoardLike += '<td><img src="resources/img/like.png"/>'+item.like_cnt+'</td>';
				studyBoardLike += "<td>"+"<a onclick='goStudyBoard(\""+item.board_no+"\")'>"+item.title+"</a>"+"</td>";
				studyBoardLike += '</tr>';
			});
			
			
			$('#studyBoardLike').empty();
			$('#studyBoardLike').append(studyBoardLike);
			var freeBoardLike = '';
			data.freeBoardLike.forEach(function(item,idx){
				freeBoardLike += '<tr>';
				freeBoardLike += '<td><img src="resources/img/like.png"/>'+item.like_cnt+'</td>';
				freeBoardLike += "<td>"+"<a onclick='goFreeBoard(\""+item.board_no+"\")'>"+item.title+"</a>"+"</td>";
				freeBoardLike += '</tr>';
			});
			$('#freeBoardLike').empty();
			$('#freeBoardLike').append(freeBoardLike);
		},
		
		error : function(e){console.log(e);}
		
		
		
		
	});
	
	
	
}

function goStudyBoard(board_no){
	location.href='./studyBoard/detail?board_no='+board_no;
}

function goFreeBoard(board_no){
	location.href='freeBoardDetail?board_no='+board_no;
}

</script>
</html>