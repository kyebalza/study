<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link rel="stylesheet" href="resources/css/header.css"/>
 
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
	<%@ include file="../header.jsp" %>
	
	
	<form id = "fbd" name="fbd">
		<table>
			<tr>
				<th >제목</th>
				<td>${info.title}</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<input type="hidden" id="board_cate_no" value="${info.board_cate_no }" id="board_cate_no"/>
					${info.board_cate}
				</td>
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
			<c:if test="${fbphoto.size()>0}">
			<tr>
				<th>사진</th>
				<td>
					<c:forEach items="${fbphoto}" var="fbphoto">
						<img src="/photo/${fbphoto.new_filename}" width="250px"/><br/><br/>
					</c:forEach>
				</td>
			</tr>
			</c:if>
		</table>
	</form>
		<input type="hidden" id="board_name" value="${info.board_name}"/>
		<c:choose>
			<c:when test="${likecheck == 1}">
				<img class="like" src="/bank/resources/img/like.png" alt="좋아요"> ${like}
			</c:when>
			
			<c:otherwise> 
				<img class="like" src="/bank/resources/img/unlike.png" alt="빈 좋아요"> ${like}
			</c:otherwise> 
		</c:choose>
	<input type="hidden" id="board_no" value="${info.board_no}"/>
	<p><img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수">(${info.bHit})</p>
	<img class="boardreport" src="/bank/resources/img/report.png"  alt="신고하기">
	<input type="button" onclick="location.href='./freeUpdateForm?board_no=${info.board_no}'" value="수정"/>
	<input type="button" onclick="del()" value="삭제"/>			
	<input type="button" onclick="location.href='./freeBoardList?currpage=1'" value="목록"/>
	
	<%@ include file="fbComent.jsp" %>
	
</body>
<script>

	function del(){
		var yn = confirm("정말 이 글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./freedelete?board_no=${info.board_no}';
		}
		
	}
	


	//좋아요
	$('.like').click(function(){
		//console.log("좋아요");
		if('${loginId}' == ''){
			alert('로그인이 필요한 서비스 입니다.');
		}else{
			
			var loginId = '${loginId}';
			var board_name = $(this).prev().val();
			var board_no = $(this).next().val();
			
			console.log("로그인 아이디 : "+loginId);
			console.log("게시판 : "+board_name);
			console.log("글번호 : "+board_no);
			
			var param = {'loginId':loginId,'board_name':board_name,'board_no':board_no};
			console.log(param);
			
			var thissrc = $(this).attr('src');
			
			if(thissrc == '/bank/resources/img/unlike.png'){
				$(this).attr('src','/bank/resources/img/like.png');
			}else{
				$(this).attr('src','/bank/resources/img/unlike.png');
			}
			
	
			$.ajax({
				type:'POST',
				url:'fbUplike',
				data:param,
				dataType:'JSON',
				success:function(data){
					if(data.success==1){
						console.log('좋아요 추가');
					}
					if(data.row2 == 1){
						console.log('좋아요 취소');
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 발생했습니다.');
				}
			});

		}
	});

	
	//신고하기
	$(document).on("click",".boardreport",function () {
		console.log("신고 클릭 확인");
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
			location.href='redirect:/loginPage';
		}else{
			
			var report = prompt("신고 사유를 입력해주세요.","");
			console.log(report);
			
			var board_name = $('#board_name').val();
			var board_no = $('#board_no').val();
			var reported_user = '${info.user_id}';
			var board_cate_no = $('#board_cate_no').val();
			
			var params = {'report':report ,'board_name':board_name ,'board_no':board_no ,'reported_user':reported_user, 'board_cate_no':board_cate_no}
			
			console.log(params)
			
			$.ajax({
				type:'POST',
				url:'fbReport',
				data:params,
				dataType:'JSON',
				success:function(result){
					console.log('신고등록 완료',result);
				},
				error:function(e){
					console.log('서버에 문제가 발생하였습니다.',e);
				}
			});
		}
		
	});
	


</script>
</html>