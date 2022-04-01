<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="/bank/resources/js/jquery.twbsPagination.js"></script>
	<script src="<c:url value='resources/js/.bootstrap.min.js'/>"></script>
   <link rel="stylesheet" href="<c:url value='esources/css/bootstrap.min.css'/>"/>
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
			border-radius: 9px;
		}
		th{
			text-align: center;
			width: 100px;
			background-color: #6AA84F;
			color: white;
				
		}
		.sbcom_list{
			padding: 5px;
			margin:5px;
			border-radius: 9px;
		}
		a{
			text-decoration:none;
		}
		.relike{
			width:31;
			height:31;
			margin-left: 10px;
			margin-bottom: 5px;
		}
		#sbcoment{
			margin-left: 70px;
			height: 150px;
		}
		#sbcomentAll{
			margin: auto;
		}
		#sbinput_wep{
			margin-bottom: 50px;
		}
	</style>
</head>
<body>
<br/>
<br/>
	<div id="sbcomentAll">
		<span id="loginId" 
			 style="padding-left: 10px;
   						font-weight: bold;
   						margin-left: 70px;
   						font-size: 17px;
    	"> ${loginId} </span>
		<div id="sbinput_wep">
			<form action="sbcoment" id="sbcoment" method="POST">
				<input type="hidden" name="loginId" value="${loginId}">
				<input type="hidden" name="user_id" value="${info.user_id}">
				<input type="hidden" name="board_no" value="${info.board_no}">
				<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"
						style="border: 1px solid #6AA84F;
								border-radius: 9px;
								width: 1000px;
				"></textarea>
				<input type="button" id="sbcom_button" value="등록" 
					style="border: 1px solid #6AA84F;
					    border-radius: 9px;
					    background-color: #6AA84F;
					    height: 150;
					    margin-bottom: 0px;
					    position: relative;
					    top: -71px;
					    margin-left: 5px;
				"/>
			</form>
		</div>
		<div>
			<div id = "sbcomentlist">
			</div>
				<table>
					<tr>
						<td id="paging">
							<div class="container">
								<nav aria-label="Page navigation" style="text-align:center">
									<ul class="pagenation" id="pagination"></ul>
								</nav>
							</div>
						</td>
					</tr>
				</table>
			<%-- <c:forEach items="${sbcomList}" var="sbcomList">
				<table>
					<tr>
						<td>
								<div class = "sbcom_list">
									<span id="reported" class="sbcom_user_id"> ${sbcomList.user_id} </span>
									<input id="reply_no" type="hidden" value = "${sbcomList.reply_no}"/>
									<span class = "sbcom_a">
						
										<c:if test="${loginId == sbcomList.user_id}">
											<a class="sbcom_del" href="./sbcomdel?reply_no=${sbcomList.reply_no}&board_no=${sbcomList.board_no}&user_id=${sbcomList.user_id}">삭제</a>
										</c:if>
										<c:if test="${loginId != sbcomList.user_id}">
											<img class="comReport" src="/bank/resources/img/report.png" alt="신고하기">
										</c:if>
									</span>
									<span>	
										<input id="board_no" type="hidden" value="${info.board_no}"></input>
										<c:choose>
										<c:when test="${sbcomList.likeYN == 1}">
											<img class="relike ${sbcomList.reply_no}" src="/bank/resources/img/like.png" alt="좋아요">										
										</c:when>

										<c:otherwise> 
											<img class="relike ${sbcomList.reply_no}" src="/bank/resources/img/unlike.png" alt="빈 좋아요">
										</c:otherwise> 
										</c:choose>
									</span>
									<div class="sbcom_coment">
										<span>${sbcomList.reply_content}</span>
									</div>		
									<c:if test="${loginId != info.user_id}">
											<a id ="selectCom" onclick="selectCom()">채택</a>
									</c:if>
								</div>
						</td>
					</tr>
				</table>
			</c:forEach>--%>
		</div>
	</div>
</body>
<script>
			
		var currPage = 1;
		var totalPage = 10;
		
		var board_no = ${info.board_no}
		
		console.log("글번호 번호 확인 : "+board_no);
		
		listCall(currPage,10);
		
		function more(){ //다음 페이지로 넘겼을 때
			currPage++;
			console.log('currPage',currPage);
			if(currPage>totalPage){
				$('button').attr('disabled',true);
			}else{
				listCall(currPage, 10);			
			}
		}
		
		var callFlag = 0;
		
		 function listCall(page, cnt){	
			
			$.ajax({
				type:'GET',
				url:'SBClistCall',
				data:{'page':page, 'cnt':cnt, 'board_no' : board_no},
				dataType:'JSON',
				success:function(data){
					console.log(data);
					totalPage = data.pages;
					listDraw(data.list);
					
					$('#pagination').twbsPagination({
						startPage: currPage,//현재페이지
						totalPages: totalPage,//만들 수 있는 총 페이지 수
						visiblePages: 5,//[1],[2],[3]...이걸 몇개까지 보여줄 것인지
						onPageClick: function(evt,page){//해당 페이지 번호를 클릭했을 때 일어날 일들
							console.log(evt);//현재 일어나는 클릭 이벤트 관련 정보들
							console.log(page);//몇 페이지를 클릭했는지에 대한 정보
							if(callFlag != 0){//클릭이 있을때만 listCall 실행하도록 조건 걸어줌
									listCall(page, 10);
								}
							
							callFlag++;
						}
					});
					
				},
				error:function(e){
					console.log(e);
				
				}
			});
		 }//페이징
 
 function listDraw(list) {
		console.log("리스트 호출 확인");
		var content = '';
		var loginId = '${loginId}';
		list.forEach(function (item, reply_no) {
			
			content += '<table>';
			content += '<tr>';
			content += '<td>';
			content += '<div class = "sbcom_list">';
			content += '<span style="font-weight: bold;">'+item.user_id+'</span>';
			content += '<input id="sbcuser_id" type="hidden" class = "sbcuser_id" value = '+item.user_id+'   />';
			content += '<input id="reply_no" type="hidden" class = "reply_no" value = '+item.reply_no+'   />';
			content += '<span class = "sbcom_a">';
			
				if (loginId == item.user_id) {
					content += '<a class="sbcom_del" href="./sbcomdel?reply_no='+item.reply_no+'&board_no='+item.board_no+'&user_id='+item.user_id+'">삭제</a>';
				}else{
					content += '<a href="#" class="sbComReport">신고</a>';
				}
			
			content += '</span>';
			content += '<span>';
			console.log(item.likeYN);
				if (item.likeYN > 0) {
					content += '<img class="relike '+item.reply_no+'" src="/bank/resources/img/like.png" alt="좋아요">';
				}else{
					content += '<img class="relike '+item.reply_no+'" src="/bank/resources/img/unlike.png" alt="빈 좋아요">';
				}
			
			content += '</span>';
			content += '<div class="sbcom_coment">';
			content += '<span>'+item.reply_content+'</span>';
			content += '</div>';
			content += '</div>';
			content += '</td>';
			content += '</tr>';
			content += '</table>';
			
		});
		
		$('#sbcomentlist').empty();
		$('#sbcomentlist').append(content);
		
	
	}
		
	//댓글 신고하기
 	$(document).on("click",".sbComReport",function(){
		
		if ('${loginId}' == '') {
			alert ('로그인이 필요한 서비스 입니다.');
		}else{
			var report_reason = prompt ("신고 사유를 입력해주세요.","");
			
			if(report_reason == ''){
				alert('신고사유를 입력해주세요');
			}else if(report == null){
				alert('취소했습니다.');
			}else{
				
				console.log(report_reason);
				
				var board_name = $('#board_name').val();
				var board_no = $('#board_no').val();
				var reported_user = $('.sbcuser_id').val(); //값을 못가져옴
				var reply_no = $('.reply_no').val();
				var board_cate_no = $('#board_cate_no').val();
				
				console.log(reported_user);
				console.log(reply_no);
				
				var params = {'board_name':board_name ,'board_no':board_no ,'reported_user':reported_user, 'reply_no':reply_no ,'report_reason':report_reason}
				
				console.log(params);
				
				 $.ajax({
					type:'POST',
					url:'sbcomreport',
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
			
			
		
		}
	});
			
			
	//댓글 전송 버튼
	$('#sbcom_button').click(function () {
		//console.log('댓글');
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
			location.href="redirect:/loginPage";
		}else if ($('#com_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			$('#sbcoment').submit();
		}
		
	});
	
	var loginId = "${loginId}";
	var board_no = "${info.board_no}";
	var user_id = "${info.user_id}";
	
	//댓글 삭제
	$('.sbcom_del').click(function () {
		console.log('댓글삭제 요청 : ');
		var yn = confirm("이 댓글을 삭제 하시겠습니까?");
		
		if(yn){
			location.href='./studycomdelete?reply_no=${info.reply_no}';
		}
	})
	
	
	//댓글 좋아요
	$(document).on("click",".relike",function(){
		console.log($(this)[0].classList[1]);//페이징 하면서 바뀜 ㅠ
		if('${loginId}' == ''){
			alert('로그인이 필요한 서비스 입니다.');
		}else{
			var loginId = '${loginId}';
			var board_no = $('#board_no').val();
			var reply_no = $(this)[0].classList[1];
			console.log('댓글 좋아요',loginId,board_no,reply_no);
			
			var param = {'loginId':loginId,'reply_no':reply_no,'board_no':board_no};
			
			var thissrc = $(this).attr('src');
			
			if(thissrc == '/bank/resources/img/unlike.png'){
				$(this).attr('src','/bank/resources/img/like.png');
			}else{
				$(this).attr('src','/bank/resources/img/unlike.png');
			}
			
			$.ajax({
				type:'POST',
				url:'relike',
				data:param,
				dataType:'JSON',
				success:function(data){
					if(data.success==1){
						console.log('댓글 좋아요 추가');
					}
					if(data.row2 == 1){
						console.log('댓글 좋아요 취소');
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 발생했습니다.');
				}
			});//ajax괄호끝
			
		}//else괄호끝
		
	});//좋아요 괄호끝	
	
	
	
</script>
</html>
