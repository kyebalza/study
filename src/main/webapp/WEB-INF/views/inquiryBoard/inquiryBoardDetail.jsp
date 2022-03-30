<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link rel="stylesheet" href="resources/css/header.css"/>
 
 <style>


	
	table {
		margin-left: auto;
	   	margin-right: auto;
	   	min-width: 1296px;
	   	min-width: 1166px;
	}
	
	table,td{
		border: 1px solid #6AA84F;
		border-collapse: collapse;
		padding : 5px 10px;			
		width: 1000px;
		margin: auto;
		margin-top: 10px;
	}
	
	
	th {
		border: 1px solid black;
		border-color: white;
		background-color: #6AA84F;
		width: 500px;
		padding: 15px;
	}
	
	td {
		border-color: #6AA84F;
		text-align: left;
	
	}
	
	input.button {
		text-align: center;
		background-color: #6AAA84F;
	}
	
	#iblistAll {
		min-width : 1150px;
		left: 20%;
		position: absolute;
	
	}
	
	
	.bHit {
		float: left;
		margin: 0px;
	}
	
	.boardButton{
			background-color : #6AA84F;
			color: white;
			border: none;
			margin: auto;
			width: 100px;
			height: 30px;
			border-radius: 11px;
	
	}
	
	#board_sub {
		display: float;
		float: right;
		height:31;
	}
	
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
	
	.buttonout{
		display: flex;
	}
	
	.buttonin{
		margin: auto;
		
	}
	
	
	
	
	
	

 
 </style>
</head>
<body>


	<%@ include file="../header.jsp" %>
	<br/><br/>
	
	<div id="ibListAll">
		<table class="ibdetail">
			<tr>
				<th style=" color:white;">제목</th>
				<td>${info.title}</td>
				<th style="color:white;">카테고리</th>
				<td class="cate" style="text-align:center" >${info.board_cate}</td>
			</tr>
			
			<tr>
				<th style="color:white;">작성자</th>
				<td id="user_id">${info.user_id}</td>
				<th style="color:white;">작성일자</th>
				<td class="date" style="text-align:center">${info.reg_date}</td>
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
	
	
	<div id="board_sub" style="margin-top: 10px;">
		<img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수" style="
		    margin-left: 10px;
		"/>
		<p class="bHit" style="
		    margin-top: 6px;
		    margin-bottom: 8px;
		">(${info.bHit})</p>
	</div>

	
	<br/>
	<br/>
	
	<div class="buttonout">
		<div class="buttonin">
			<c:if test="${sessionScope.loginId eq info.user_id}">
				<input class="boardButton" type="button" onclick="location.href='./inquiryUpdateForm?board_no=${info.board_no}'" value="수정"/>
				<input class="boardButton" type="button" onclick="del()" value="삭제"/>			
			</c:if>
			<input class="boardButton" type="button" onclick="location.href='./inquiryBoardList?currpage=1'" value="목록"/>
		</div>
	</div>

	<br/><br/>
	
	<%@ include file="ibComent.jsp" %>
	
	
	

</div>
	
	

	
	

	
</body>
<script>


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