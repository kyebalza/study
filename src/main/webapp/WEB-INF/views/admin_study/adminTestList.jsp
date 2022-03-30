<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- 
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
     -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<link rel="stylesheet" href="resources/css/adminLefter.css"/>
	<script src="resources/js/.bootstrap.min.js"></script>
   <link rel="stylesheet" href="resources/css/bootstrap.min.css"/>
	
	<style>
	body{
		margin : 0px;
	}
	hr{
		border : 1.5px solid gray;
		margin : 10px 0px 10px 0px;
	}
	#pageTitle{
		text-align : left;
		width : 300px;
	}
	#pageTitle h3{
		font-weight : bold;
	}

	#topDivs {
		text-align : center;
	}
	
	#searchBar select{
		border-top : none;
		border-left : none;
		border-right : 1px solid gray;
		border-bottom : 1px solid gray;
		width : 100px;
		border-radius : 5px;
	}
	#searchBar input[type="text"]{
		border:none;
		width : 300px;
		border-bottom : 1px solid gray;
		text-align : center;
	}
	
	#searchBar h5{
		font-size : 5px;
		text-align : left;
		margin : 0px;
		color : gray;
	}

	table,th,td {
	 border : 1px solid lightgray;
	 border-left : none;
	 border-right : none;
	 border-collapse : collapse;
	 font-size : 9px;
	 height : 25px;
		
	}
	.quiz_content a{
		color : RoyalBlue;
		width : 150px;
		display : inline-block;
		test-overflow : ellipsis;
		overflow : hidden;
		white-space:nowrap;
		word-wrap : break-word;
	}
	input[value="복구"]{
		color : skyblue;
		border : none;
	}
	input[value="삭제"]{
		color : Tomato;
		border : none;
	}
	#quizList tr:nth-child(odd){
		background-color :  #e6ffe6;
		
	}
	#quizList tr:nth-child(odd) input{
		background-color :  #e6ffe6;	
	}
	#quizList tr:nth-child(even){
		background-color :  white;
		
	}
	#quizList tr:nth-child(even) input{
		background-color :  white;	
	}
	#topRegistTest{
		text-align : left;
	}
	
	#topRegistTest input{
		background-color : white;
		color : green;
		font-weight : bold;
		border : none;
	}
	#grid {
		min-height : 1000px;
		}
		#mainPage{
			padding-top : 5px;
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
<%@ include file="../header.jsp" %>

<div id="grid">    
    <div>
		<iframe id="lefter" src="adminLefter"></iframe>			
	</div>
	<div id="mainPage">
<div id="pageTitle">
<h3>시험 관리</h3>
<hr/>
</div>

<div id="topDivs">

<div id="searchBar">
		
		<select id="test_cate_no">
			<option value="0" selected>선택하세요</option>
			<c:forEach items="${testCateList }" var="testCate">
				<option value="${testCate.test_cate_no }">${testCate.test_cate}</option>			
			</c:forEach>
		
		
		
		</select><!-- 시험 -->

		
</div>



</div>


<div class="wrap">
<table>
	<thead>
		<tr>
			<th style="width : 50px">시험ID</th>
			<th style="width : 50px">시험종류</th>
			<th style="width : 30px">월</th>
			<th style="width : 30px">회차</th>
			<th style="width : 30px">만점</th>
			<th style="width : 120px">합격기준</th>
			<th style="width : 120px">합격률</th>
			<th style="width : 120px">삭제</th>
		</tr>
	</thead>
	<tbody id="quizList">
	</tbody>
</table>
</div>
</div>
</div>
</body>
<script>
$('select').change(function(){
		console.log('카테고리 선택!');
		selectTestCate(this.value);	
});
function selectTestCate(test_cate_no){
	$.ajax({
		url : 'adminTestListCall',
		type : 'get',
		data : {'test_cate_no':test_cate_no},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var str = '';
			if(data.testList.length > 0){
				data.testList.forEach(function(item,idx){
					str += '<tr>';
					str += '<td>'+item.test_no+'</td>';
					str += '<td>'+item.test_cate+'</td>';
					str += '<td>'+item.test_month+'</td>';
					str += '<td>'+item.test_count+'</td>';
					str += '<td>'+item.test_fullscore+'</td>';
					str += '<td>'+item.pass_criterion+'</td>';
					str += '<td>'+item.test_passrate+'</td>';
					
					if(!item.del_flag){
						str += '<td><a onclick="adminDeleteTest('+item.test_no+')">삭제</a></td>';						
					} else {
						str += '<td>삭제완료</td>';						
					}
					str += '<tr>';
	
				});		
			} else {
				str += '<tr><td colspan="8">등록된 시험이 없습니다.</td></tr>';
			}
			$('#quizList').empty();
			$('#quizList').append(str);
			
			
			
			},
		error : function(e){console.log(e)
			}
	});
}


function adminDeleteTest(test_no){
	console.log('삭제버튼!');
	if(confirm('해당 시험을 완전히 삭제하시겠습니까?\n삭제하실 경우 관련된 데이터들은 모두 삭제됩니다.')){
		$.ajax({
			url : 'adminDeleteTest',
			type : 'get',
			data : {'test_no':test_no},
			dataType : 'json',
			success : function(data){
				console.log(data);
				selectTestCate($('select').val())
			},
			error : function(e){console.log(e)}		
		});
	}
}


</script>
</html>