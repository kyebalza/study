<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link rel="stylesheet" href="resources/css/header.css"/>
 
 <style>
 
 
 
	table, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;	
		width: 1000px;
		height: 10%;
	}
	
	table {
		margin-left: auto;
	   	margin-right: auto;
	   	min-width: 1296px;
	   	min-width: 1166px;
	}
	
	th {
		border: 1px solid black;
		background-color: #6AA84F;
		width: 500px;
	}
	
	td {
		text-align: left;
	}
	
	
	.cate, .date {
		text-align: center;
	}
	
	
	
	

 
 </style>
</head>
<body>


	<jsp:include page="/WEB-INF/views/header.jsp"/>

	
	
	
	<br/>
	<br/>
	<br/>

	
	<table>
		<tr>
			<th style="color:white;">제목</th>
			<td>${info.title}</td>
			<th style="color:white;">카테고리</th>
			<td class="cate">${info.board_cate}</td>
		</tr>
		
		<tr>
			<th style="color:white;">작성자</th>
			<td id="user_id">${info.user_id}</td>
			<th style="color:white;">작성일자</th>
			<td class="date">${info.reg_date}</td>
		</tr>
		<tr>
			<th style="color:white;" rowspan="2">내용</th>
			<td colspan="4">${info.content}</td>
		</tr>
		
		<c:if test="${photo.size()>0}">
		<tr>
			<td colspan="4">
			<c:forEach items="${photo}" var="photo">
			<img src="/photo/${photo.new_filename}" width="400px" height="400px"/>
			</c:forEach>
			</td>
		</tr>
		</c:if>
		
	</table>
	
	<img src="/bank/resources/img/bHit.png">${info.bHit} 
	<br/>
	<br/>
	<input type="button" onclick="location.href='./inquiryUpdateForm?board_no=${info.board_no}'" value="수정"/>
	<input type="button" onclick="del()" value="삭제"/>			
	<input type="button" onclick="location.href='./inquiryBoardList?currpage=1'" value="목록"/>
	
	
	
	<br/><br/>
	
	  
	<%@ include file="ibComent.jsp" %>
	
	
	
	<!--  
	<table>
		<thead>
			<tr>
				<td colspan="3">
					<textarea class="adminbutton" name="reply_comment"></textarea><input class="adminbutton" type="button" onclick="reply_write()" value="등록"/>
						<input type="hidden" name="user_id" value="${sessionScope.loginId}"/>
						<input type="hidden" name="board_no" value="${info.board_no}"/>	
				</td>
			</tr>
		</thead>
	
	<tbody id="reply">
	</tbody>
	
	</table>
	-->
	
	
	
	

	
</body>
<script>

/*
console.log("${sessionScope.loginId}");
console.log($('#user_id').html());
console.log("${sessionScope.admin}");

if("${sessionScope.loginId}" != $('#user_id').html()) {
	$('.identify[type="button"]').attr('type','hidden');

};

if("${sessionScope.admin}" != 'Y') {
	$('.adminbutton').css('display','none');

};
*/



	function del(){
		var yn = confirm("정말 이 글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./inquirydelete?board_no=${info.board_no}';
		}
		
	}
	
	

/*
	// 관리자 문의게시글 답변 기능
	$.ajax({
		type : 'GET',
		url : 'reply_call',
		data : {'board_no':"${info.board_no}"},
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			//ajax 는 페이지를 새로고침하지 않기 때문에, 적용된 내용을 확인하기 위해서는 리스트를 다시 그려야 한다.
			//listCall();
			listDraw(data.list);
		},
		error : function(e){
			console.log(e);
		}
	});


	function listDraw(list){
		var content = '';

		//list.forEach(function(item,idx)) 으로 해도 된다.
		for(var i = 0; i<list.length; i++){
			//console.log(list[i]);
			content += '<tr>';
			content += '<td style="width:200px" class="none2">'+list[i].user_id+'</td>';
			content += '<td style="width:500px" class="none2">'+list[i].reply_comment+'</td>';
			content += '<td style="width:200px" class="none2">'+list[i].reply_date+'</td>';		
			content += '</tr>';
			
		}
		
		$("#reply").empty();
		$("#reply").append(content);
	}


	function reply_write(){

		var loginId = "${sessionScope.loginId}";

		var $reply_comment = $('textarea[name="reply_comment"]');
		var $user_id = $('input[name="user_id"]');
		var $board_no = $('input[name="board_no"]');
			
		var reply = {}
		reply.reply_comment = $reply_comment.val();			
		reply.user_id = $user_id.val();
		reply.board_no = $board_no.val();
		reply.board_name = '문의게시판';
		console.log(reply);
			$.ajax({
				type : 'GET',
				url : 'reply_write',
				data : reply,
				dataType : 'JSON',
				success : function(data){
					
					if(data.msg == 'fail'){
						alert('로그인 후 이용 가능한 서비스입니다.');
					} else {
						console.log(data.msg);
						//ajax 는 페이지를 새로고침하지 않기 때문에, 적용된 내용을 확인하기 위해서는 리스트를 다시 그려야 한다.
						//listCall();
						listDraw(data.list);
						$('textarea[name="reply_comment"]').val('');
						alert('댓글이 정상적으로 등록되었습니다.');
					}
					
				},
				error : function(e){
					console.log(e);
				}
			});		
	}
	
	
	
	
	var files = [];

	<c:forEach items="${photos}" var="photo">
	files.push("${photo}");
	</c:forEach>

	console.log(files);

	if(files.length>0){//업로드된 파일이 있을 경우
		
		var content="";
		
		for(var i=0; i<files.length;i++){			
			console.log("fileName : "+files[i]);//풀 파일명
			//확장자만 추출(마지막에 있는 . 의 취를 찾아 substring 으로 잘라낸다.)
			var ext = files[i].substring(files[i].lastIndexOf(".")+1);
			console.log("ext : "+ext);
			
			content += '<a href="/photo/'+files[i]+'"/>'+files[i]+' 다운로드 <a>';
			content += '<br/>';			
		}
		
		$("#photos").html(content);
		
				
	}else{		//업로드 된 파일이 없을 경우
		$("#photos").html("<p>업로드 된 파일이 없습니다.</p>");
	}
	*/






	





</script>
</html>