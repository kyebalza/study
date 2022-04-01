<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 	<link rel="stylesheet" href="resources/css/header.css"/>
	<script src="resources/js/.bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css"/>
 
 <style>
 
	 table, td{
		border: 1px solid #6AA84F;
		border-collapse: collapse;
		padding : 5px 10px;
	}
	
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}

	.fbdall{
		position: absolute;
		/* background: blue; */
		min-width : 1150px;
		left: 20%;
	}
	
	.detail{
		min-width : 1170px;
		border: 2px solid #6AA84F;
		padding : 15px;
		margin : auto;
		
	}
	
	th{
		text-align: center;
		width: 100px;
		background-color: #6AA84F;
		color: white;
		
	}
	 .input{
      position: absolute;
      left: 40%;
   }
 
    .button{
       text-align: center;
      background-color : #6AA84F;
      color: white;
      border: 1px solid #6AA84F;
      border-radius: 9px;
      width: 65px;
      height: 30px;
      margin: 5px;
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
		</br></br></br></br></br>
	<div class=fbdall>
		<form id = "fbd" name="fbd">
			<table class="detail">
				<tr>
					<th style="text-align:center; padding : 15px;" >제목</th>
					<td>${info.title}</td>
				
					<th style="text-align:center" >카테고리</th>
					<td>
						<input type="hidden" id="board_cate_no" value="${info.board_cate_no }" id="board_cate_no"/>
						${info.board_cate}
					</td>
				</tr>
				<tr>
					<th style="text-align:center; padding : 15px;" >작성자</th>
					<td id="user_id">${info.user_id}</td>
					<th  style="text-align:center">작성일자</th>
					<td>${info.reg_date}</td>
				</tr>
				<tr>
					<th rowspan="2" style="width: 25px; text-align:center; padding : 15px;">내용</th>
					<td colspan="4">${info.content}</td>
				</tr>
				<c:if test="${fbphoto.size()>0}">
					<tr>
						<td colspan="4" style="width: 25px; text-align:center;">
							<c:forEach items="${fbphoto}" var="fbphoto">
								<img src="/photo/${fbphoto.new_filename}" width="250px"/><br/><br/>
							</c:forEach>
						</td>
					</tr>
				</c:if>
			</table>
		</form>
			<div style="float: right;">
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
				<img class="bHit" src="/bank/resources/img/bHit.png" alt="조회수">(${info.bHit})
				<img class="boardreport" src="/bank/resources/img/report.png"  alt="신고하기">
			</div>
			<div class="buttonout">
				<div class="buttonin">
					<c:if test="${loginId == info.user_id}">			
						<input type="button" class="button" onclick="location.href='./freeUpdateForm?board_no=${info.board_no}'" value="수정"/>
						<input type="button" class="button" onclick="del()" value="삭제"/>			
					</c:if>
					<input type="button" class="button" onclick="location.href='./freeBoardList?currpage=1'" value="목록"/>
				</div>
			</div>
		<%@ include file="fbComent.jsp" %>
	</div>
	
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
			location.href='redirect:/loginPage';
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
			});

		}
	});

	
	//신고하기
	$(document).on("click",".boardreport",function () {
		console.log("신고 클릭 확인");
		var blank_pattern = /^\s+|\s+$/g;
		
		if ('${loginId}' == '') {
			alert("로그인이 필요한 서비스 입니다.");
			location.href='redirect:/loginPage';
		}else{
			var report = prompt("신고 사유를 입력해주세요.","");
			console.log(report);
			
			if (report == '') {
				alert("신고 사유를 입력해주세요.");
			}else if(report.replace(blank_pattern, '') == ""){
				alert("신고 사유를 입력해주세요.");
			}else{
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
			
		}
		
	});
	


</script>
</html>