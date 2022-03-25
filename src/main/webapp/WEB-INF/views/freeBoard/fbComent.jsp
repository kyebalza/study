<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<style>
		
	</style>
</head>
<body>
</br>
</br>
	<div id="fbcoment_wep">
		<span id="loginId"> ${loginId} </span>
		<div id="fbinput_wep">
			<form action="fbcoment" id="fbcoment" method="POST">
				<input type="hidden" name="loginId" value="${loginId}">
				<input type="hidden" name="user_id" value="${info.user_id}">
				<input type="hidden" name="board_no" value="${info.board_no}">
				<textarea id="reply_content" name="reply_content" placeholder="댓글을 입력하세요"></textarea>
				<input type="button" id="fbcom_button" value="등록" />
			</form>
		</div>
		<div>
			<div id = "fbcomentlist">
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
			
				<%-- <c:forEach items="${fbcomList}" var="fbcomList">
					<table>
						<tr>
							<td>
								<div class = "fbcom_list">
									<span class="fbcom_user_id"> ${fbcomList.user_id} </span>
									<input type="hidden" value = "${fbcomList.reply_no}"/>
									<span class = "fbcom_a">
										<c:if test="${loginId == fbcomList.user_id}">
											<a class="fbcom_del" href="./fbcomdel?reply_no=${fbcomList.reply_no}&board_no=${fbcomList.board_no}&user_id=${fbcomList.user_id}">삭제</a>
										</c:if>
										<c:if test="${loginId != fbcomList.user_id}">
											<a href="#" onclick="singoPop()">신고</a>
										</c:if>
									</span>
									<span>
										<c:choose>
											<c:when test="${fbcomList.board_no != null && fbcomList.user_id == loginId}">
												<img class="relike" src="/bank/resources/img/like.png" alt="좋아요">
											</c:when>
											
											<c:otherwise> 
												<img class="relike" src="/bank/resources/img/unlike.png" alt="빈 좋아요">
											</c:otherwise> 
										</c:choose> 
									</span>
									<div class="fbcom_coment">
										<span>${fbcomList.reply_content}</span>
									</div>
								</div>
							</td>
						</tr>			
					</table>
				</c:forEach> --%>
				
		</div>
	</div>
</body>
<script>

	//댓글 전송 버튼
	$('#fbcom_button').click(function () {
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
		}else if ($('#com_content').val() == ""){
			alert("내용을 입력해주세요.");
		}else{
			console.log("클릭 확인");
			$('#fbcoment').submit();
		}
		
	});
	
	
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
	
	 function listCall(page, cnt){	
		 
		$.ajax({
			type:'GET',
			url:'FBClistCall',
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
						listCall(page, 10);
					}
				});
			},
			error:function(e){
				console.log(e);
			
			}
		});
	 }
	
	function listDraw(list) {
		console.log("리스트 호출 확인");
		var content = '';
		var loginId = '${loginId}';
		list.forEach(function (item, reply_no) {
			
			content += '<table>';
			content += '<tr>';
			content += '<td>';
			content += '<div class = "fbcom_list">';
			content += '<input type="hidden" class="fbcuser_id '+item.reply_no+'" value='+item.user_id+'    />';
			content += '<span>'+item.user_id+'</span>';
			content += '<input type="hidden" class="reply_no '+item.reply_no+'" value='+item.reply_no+'   />';
			content += '<span class = "fbcom_a">';
			
				if (loginId == item.user_id) {
					content += '<a class="fbcom_del" href="./fbcomdel?reply_no='+item.reply_no+'&board_no='+item.board_no+'&user_id='+item.user_id+'">삭제</a>';
				}else{
					content += '<a href="#" class="fbComReport '+item.reply_no+'">신고</a>';
				}
			
			content += '</span>';
			content += '<span>';
			console.log(item.likeYN);
				if (item.likeYN > 0) {
					content += '<img class="relike  '+item.reply_no+'" src="/bank/resources/img/like.png" alt="좋아요">';
				}else{
					content += '<img class="relike  '+item.reply_no+'" src="/bank/resources/img/unlike.png" alt="빈 좋아요">';
				}
			
			content += '</span>';
			content += '<div class="fbcom_coment">';
			content += '<span>'+item.reply_content+'</span>';
			content += '</div>';
			content += '</div>';
			content += '</td>';
			content += '</tr>';
			content += '</table>';
			
		});
		
		$('#fbcomentlist').empty();
		$('#fbcomentlist').append(content);
		
	
	}
	
	
	$(document).on("click",".fbComReport",function() {
		console.log(this.classList[1]);
		
		if ('${loginId}' == null) {
			alert ('로그인이 필요한 서비스 입니다.');
		}else{
			var report_reason = prompt ("신고 사유를 입력해주세요.","");
			console.log(report_reason);
			
			var board_name = $('#board_name').val();
			var board_no = $('#board_no').val();
			
			
			
			var reported_user = $('.fbcuser_id.'+this.classList[1]).val(); //값을 못가져옴
			var reply_no = this.classList[1];
			
			
			
			var board_cate_no = $('#board_cate_no').val();
			
			console.log(reported_user);
			console.log(reply_no);
			
			var params = {'board_name':board_name ,'board_no':board_no ,'reported_user':reported_user, 'reply_no':reply_no ,'board_cate_no':board_cate_no ,'report_reason':report_reason}
			
			console.log(params);

			/* $.ajax({
				type:'POST',
				url:'fbcomReport',
				data:params,
				dataType:'JSON',
				success:function(result){
					console.log('신고등록 완료',result);
				},
				error:function(e){
					console.log('서버에 문제가 발생하였습니다.',e);
				}
			}); */
			
			
		}
		
	});
	
	

	
	
	
	//댓글 좋아요
	$(document).on("click",".relike",function(){
		console.log($(this)[0].classList[1]);
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
				url:'fbcrelike',
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
			
			
			
		}
	});
	
	
	
</script>
</html>
