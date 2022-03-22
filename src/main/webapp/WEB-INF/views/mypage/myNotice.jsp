<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/myPage.css"/>
	<style>
	
	
	
	
	</style>
</head>
<body>
<div id="all">
<div>
	<input type="button" id="nowPage" value="내 알림" onclick="location.href='myNotice'"/>
	<input type="button" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" value="회원정보" onclick="location.href='myInfo'"/>
</div>
<hr/>
<div>
<table>
	<thead>
		<tr>
			<th style="width : 300px;">알림내용</th>
			<th style="width : 100px;">날짜</th>
			<th style="width : 50px;">삭제</th>
		</tr>
	</thead>
	<tbody id="noticeList">
	</tbody>
</table>
</div>
</div>	
</body>
<script>
noticeListCall();
function noticeListCall(){
	$.ajax({
		url : 'noticeListCall',
		type : 'get',
		data : '',
		dataType : 'json',
		success : function(data){
			console.log(data);
			var txt = '';
			data.noticeList.forEach(function(item,idx){
				var date = new Date(item.notice_date);
				txt += '<tr>';
				txt += '<td>'+item.user_content+'</td>';
				txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '<td onclick="delNotice()"></td>';
				txt += '</tr>';
				
			});
			$('#noticeList').empty();
			$('#noticeList').append(txt);
			},
		error : function(e){console.log(e);}
		
		
	});
	
	
}


</script>
</html>