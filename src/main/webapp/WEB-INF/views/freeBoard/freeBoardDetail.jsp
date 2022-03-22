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
		
		
	<%@ include file="freeboardReport.jsp" %>
		
		
	<form id = "fbd" name="fbd">
		<table>
			<tr>
				<th >제목</th>
				<td>${info.title}</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>${info.board_cate}</td>
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
		<input type="hidden" value="${info.board_name}"/>
		<c:choose>
			<c:when test="${likecheck == 1}">
				<img class="like" src="/bank/resources/img/like.png" alt="좋아요"> ${like}
			</c:when>
			
			<c:otherwise> 
				<img class="like" src="/bank/resources/img/unlike.png" alt="빈 좋아요"> ${like}
			</c:otherwise> 
		</c:choose>
	<input type="hidden" value="${info.board_no}"/>
	<p><img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수">(${info.bHit})</p>
	<img class="boardreport" src="/bank/resources/img/report.png" onclick="fbsingo()" alt="신고하기">
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
	function fbsingo(){
		//console.log("아 왜 안열리냐고 (땡깡)");
		
		/* let url = "/freeBoard/freeboardReport";
		let popup = "width = 650px, height = 550px, top = 300px, left = 300px, scrollbars=no";
		
		window.open(url,"신고창",popup); */
		
		$('#freeSingoPopup').toggle();
		
	};
	


</script>
</html>