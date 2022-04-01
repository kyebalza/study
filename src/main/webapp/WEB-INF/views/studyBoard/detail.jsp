<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/header.css"/>
	<style>
		table,td{
		/*
			border: 2px solid #6AA84F;
			text-align: center;
			padding : 10px;
			width: 70%;
			margin: auto;
			border-collapse: collapse;
		*/	
			border: 1px solid #6AA84F;
			border-collapse: collapse;
			padding : 5px 10px;
			width: 1000px;
		    margin: auto;
		    margin-top: 10px;
		}
		th{
			text-align: center;
			width: 130px;
			background-color: #6AA84F;
			color: white;
				
		}
		input.button{
			text-align: center;
		}
		#quiz{/*문제 전체*/
			text-align: left;
		}
		textarea {
			width: 100%;
			height: 150px;
			resize: none;
		}
		.sbcom_reply_create{
			float:right;
		}
		img.like,img.bHit,img.report{
			width:31;
			height:31;
			margin:0px;
		}
		/*.like{
			float: right;
		}*/
		#sbListAll{/*페이지 전체*/
			/*
			max-width: 1200px;
            margin: 0 auto;
			padding: 10%,30%;
		*/
			min-width : 1150px;
			left: 20%;
			position: absolute;
		}
		.like,.bHit,.report{
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
		#board_sub{
			display: float;
			float: right;
			height:31;
		}
		.sbdetail{
			min-width : 1170px;
			border: 2px solid #6AA84F;
			padding : 15px;
			margin : auto;
		}
	
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<br/><br/>
	<div id="sbListAll" >
		<table class="sbdetail">
			<tr>
				<th style="text-align:center; padding : 15px;">제목</th>
				<td colspan="3" style="padding : 15px;">${info.title}</td>
			</tr>
			<tr>
				<th style="text-align:center; padding : 15px;">작성자</th>
				<td style="padding : 15px;">${info.user_id}</td>
				<th style="text-align:center">작성일자</th>
				<td style="padding : 15px;">${info.reg_date}</td>
			</tr>
			<tr>
				<th style="width: 25px; text-align:center; padding : 15px;">문제</th>
				<td colspan="3">
					<div id="quiz">
						<c:if test="${info.quiz_no != '0' }">
						<h4 style="padding : 15px;">${Qinfo.test_cate}-${Qinfo.subject_cate}-${Qinfo.detailed_subject_cate} ${Qinfo.quiz_index}번 문제.<br/> ${Qinfo.quiz_content}</h4>

						<!-- 문제보기 -->
						<p style="padding : 15px;" class="option_num">보기1 : ${Qinfo.option1}</p>
						<p style="padding : 15px;" class="option_num">보기2 : ${Qinfo.option2}</p>
						<p style="padding : 15px;" class="option_num">보기3 : ${Qinfo.option3}</p>
						<p style="padding : 15px;" class="option_num">보기4 : ${Qinfo.option4}</p>
						<p style="padding : 15px;" class="option_num">보기5 : ${Qinfo.option5}</p>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<th rowspan="2" style="width: 25px; text-align:center; padding : 15px;">내용</th>
				<td colspan="3" height="100px" style="padding : 15px;">${info.content}</td>
			</tr>
			<c:if test="${photo != null}">
				<tr>
					<%-- <th style="width: 25px; padding : 15px;">이미지</th>--%>
					<td colspan="4" style="padding : 15px;" style="padding : 15px;">
						<%-- <c:forEach items="${photo}" var="photo">--%>
							<input type="hidden" value="${photo.photo_no}"/>
							<img src="/photo/${photo.new_filename}" width="400px" height="400px"/>
						<%-- </c:forEach>--%>
					</td>
				</tr>
			</c:if>
		</table>
		<div id="board_sub" style="margin-top: 10px;">
			<input id="board_name" type="hidden" value="${info.board_name}"/>
			<c:choose>
				<c:when test="${like2 == 1}">
					<img class="like" src="/bank/resources/img/like.png" alt="좋아요">
				</c:when>
				
				<c:otherwise> 
					<img class="like" src="/bank/resources/img/unlike.png" alt="빈 좋아요">
				</c:otherwise> 
			</c:choose>
			<input id="board_no" type="hidden" value="${info.board_no}">
				<p class="like" style="
				    margin-top: 6px;
				    margin-bottom: 5px;
				">${countlike}</p>
			
		
		<img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수" style="
		    margin-left: 10px;
		"/>
		<p class="bHit" style="
		    margin-top: 6px;
		    margin-bottom: 5px;
		">(${info.bHit})</p>
		<img class="report" src="/bank/resources/img/report.png" alt="신고하기" style="
		    margin-left: 10px;
		"/>
		</div>
		<div style="margin-top: 10px;">
			<input class="boardButton" type="button" onclick="location.href='./list'" value="목록"/>
			<c:if test="${loginId == info.user_id}">	
				<input class="boardButton" type="button" onclick="location.href='./updateForm?board_no=${info.board_no}'" value="수정"/>
				<input class="boardButton" type="button" onclick="del()" value="삭제"/>
			</c:if>
		</div>
	<hr/>
	<%@ include file="sbComent.jsp" %>
	<%@ include file="../footer.jsp" %>
	</div>
</body>
<script>

//신고하기
$('.report').click(function(){
	//console.log('신고하기');
	
	if('${loginId}' == ''){
		alert("로그인이 필요한 서비스 입니다.");
		//location.href='redirect:/login';
	}else{
		
		var report = prompt("신고 사유를 입력해주세요.","");
		
		if(report == ''){
			alert('신고내용을 입력해주세요');
		}else if(report == null){
			alert('취소했습니다.');
		}else{
			console.log(report);
			
			var board_name = $('#board_name').val();
			var board_no = $('#board_no').val();
			var reported_user = '${info.user_id}';//글 작성자
			console.log(report,'+',board_name,'+',board_no,'+',reported_user);
			
			var params = {'report':report, 'board_name':board_name,'board_no':board_no,'reported_user':reported_user};
			
			$.ajax({
				type:'POST',
				url:'studyReport',
				data:params,
				dataType:'JSON',
				success:function(result){
					console.log('신고등록 완료',result);
					alert("신고가 완료되었습니다.");
				},
				error:function(e){
					console.log('서버에 문제가 발생하였습니다.',e);
				}
			});//ajax괄호끝
			
		}
		
	}
});//신고하기 괄호끝

//글 삭제
function del(){
	var yn = confirm("정말 이 글을 삭제하시겠습니까?");
	
	if(yn){
		location.href='./delete?board_no=${info.board_no}';
	}
}

//좋아요
	$('.like').click(function(){
		//console.log("좋아요");
		if('${loginId}' == ''){
			alert('로그인이 필요한 서비스 입니다.');
		}else{
			
			var loginId = '${loginId}';
			var board_name = $('#board_name').val();
			var board_no = $('#board_no').val();
			
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
				url:'uplike',
				data:param,
				dataType:'JSON',
				success:function(data){
					if(data.success==1){
						console.log('좋아요 추가');
						location.reload();
					}
					if(data.row2 == 1){
						console.log('좋아요 취소');
						location.reload();
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 발생했습니다.');
				}
			});//ajax괄호끝
		}
	});//좋아요 괄호끝
	
	

	
	$('#reply').click(function reply(){
		console.log('댓글등록');
		
	});//댓글괄호 끝


</script>
</html>