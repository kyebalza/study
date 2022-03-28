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
		
		.date{
			width : 100px;
		}
		.count{
			width : 300px;
		}
		.point{
			width : 50px;
		}
		
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>

<div id="all">
<div id="myPageHeader">
<!-- 	<input type="button" value="내 알림" onclick="location.href='myNotice'"/> -->
	<input type="button" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" id="nowPage"  value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" value="회원정보" onclick="location.href='myInfo'"/>
</div>



<div>
<table style="margin-left: auto; margin-right: auto; text-align : center">
	<thead>
		<tr>
			<td class="date">날짜</td>
			<td class="count">시험회차</td>
			<td class="point">점수</td>
		</tr>
	</thead>
	<tbody id="TestList"></tbody>

</table>
</div>


</div>

		
</body>
<script>
$.ajax({
	url:'myTestListCall',
	type : 'get',
	data : '',
	dataType : 'json',
	success : function(data){
		console.log(data);
		var txt ='';
		data.myTestList.forEach(function(item,idx){
			var date = new Date(item.test_execute_date);
			txt += '<tr>';
			txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
			txt += '<td><a onclick="reTest('+item.test_no+')">'+item.test_year+'년 '+item.test_cate+' '+item.test_count+' 회차'+'</a></td>';
			txt += '<td>'+item.score+' 점</td>';
			txt += '</tr>';
			
			
			
		});
		$('#TestList').empty();
		$('#TestList').append(txt);
	
	},
	error : function(e){console.log(e)}
	
	
	
});

function reTest(test_no){
	if(confirm('재시험을 보시겠습니까?')){
		var openNewWindow = window.open("about:blank");
		openNewWindow.location.href='testForm?test_no='+test_no;	
		
	}
	
	
};


</script>
</html>