<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <style>
 
 table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding : 5px 10px;	
}

textarea {
	width: 100%;
	height: 150px;
	resize: none;
}

 
 </style>
</head>
<body>

	<form action="inquiryBoardDetail" method="get">
	<table>
		<tr>
			<th>제목</th>
			<td>${info.title}</td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td>${info.board_cate_no}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${info.bHit}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td id="user_id">${info.user_id}</td>
		</tr>
		<tr>
			<th>작성일자</th>
			<td>${info.reg_date}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${info.content}</td>
		</tr>
	
		<tr>
			<th colspan="3">
				<input type="button" class="identify" onclick="location.href='./inquiryUpdateForm?board_no=${info.board_no}'" value="수정"/>
				<input type="button" class="identify" onclick="exposure()" value="삭제"/>			
				<input type="button" onclick="location.href='./inquiryBoardList?currpage=1'" value="목록"/>
			</th>
		</tr>

	</table>
	
	
	<table>
		<thead>
			<tr>
				<td colspan="3">
				 	<textarea class="adminbutton" name="reply_comment"></textarea><input class="adminbutton" type="button" onclick="reply_write()" value="저장"/>
					<input type="hidden" name="user_id" value="${sessionScope.loginId}"/>
					<input type="hidden" name="board_no" value="${info.board_no}"/>	
				</td>
			</tr>
		</thead>
		<tbody id="reply">
		</tbody>
	
	</table>
	</form>
	
</body>
<script>
	console.log("${sessionScope.loginId}");
	console.log($('#user_id').html());
	console.log("${sessionScope.admin}");
	
	if("${sessionScope.loginId}" != $('#user_id').html()) {
		$('.identify[type="button"]').attr('type','hidden');
	
	};
	
	if("${sessionScope.admin}" != 'Y') {
		$('.adminbutton').css('display','none');
	
	};
	
	
	
	function exposure(){
		var yn = confirm("정말 이 글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./inquiryBoardexposure?board_no=${info.board_no}';
		}
		
	}
	

	
	
	
	
	
	
	
	/* reply 기능 */
	$.ajax({
		type : 'GET',
		url : 'reply_call',
		data : {'board_no':"${info.board_no}"},
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			//ajax 는 페이지를 새로고치하지 않기 때문에, 적용된 내용을 확인하기 위해서는 리스트를 다시 그려야 한다.
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
	
	
	




</script>
</html>