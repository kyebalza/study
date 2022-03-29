<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/myPage.css"/>
	<style>
body{
	margin : 0px;
		
}	
		table, th, td{
			border : none;
			border-collapse: collapse;
			padding: 5px;
		}
		th,td{
			height : 10px;
		}

		#joinForm{
			text-align: center;
		}
		#header{
			width: 100%;
			height: 100px;
			/* border-style: none; */
			overflow: hidden;
		}
		th{
			font-size : 15px;
		
		}
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>

<div id="all">
<div id="myPageHeader">
<!-- 	<input type="button"value="내 알림" onclick="location.href='myNotice'"/> -->
	<input type="button" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" id="nowPage" value="회원정보" onclick="location.href='myInfo'"/>
</div>

	
		<form id="updateForm" action="updateUser" method="post">
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="user_id" readonly value="${userInfo.user_id }"/>

					</td>
				</tr>
				<tr>
					<th>
					</th>
					<td>
						<h5 id="overlay_msg"></h5>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input id="pass" class="pwconfirmSet" type="password" name="user_pw"/></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input id="pass_confirm" class="pwconfirmSet" type="password" name="pwConfirm"/>
						<p id="pw_confirm"></p>
					</td>
				</tr>
				<tr>
					<th></th>		
					<td id="confirm">		
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="user_name" value="${ userInfo.user_name}"/></td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td>
						<input type="email" name="user_email" value="${userInfo.user_email }"/>
						<input type="button" id="indetify" value="인증"/>
					</td>
				</tr>
				<tr>
					<th>
					</th>
					<td>
						<input type="hidden" id="emailIdnum" value=""/>
						<input type="hidden" id="emailIdbtn" value="확인"/>
					</td>		
				</tr>				
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="user_phone" placeholder="010-0000-0000" value="${userInfo.user_phone }"/></td>
				</tr>
				<tr>
					<th colspan="2">
						<input id="user_update" type="button" value="수정"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
<%@ include file="../footer.jsp" %>	
</body>
<script>
var pw = '';
var pwConfirm = '';
var pw_check = 'T';
var certifinum = null;
var certifinum_check = true;
var overlayChk = false;//ID





$('#indetify').click(function(){
	console.log('중복체크시작');
	var email = $('input[name="user_email"]').val();
	console.log('check email : ',email);
	
	$.ajax({
		type:'get',
		url :'overlayemail',
		data:{'email':email},
		dataType:'json',
		success:function(data){
			console.log(data.certifiNum);
						
			
			if(data.overLay > 0){
				alert('이미 사용중인 아이디 입니다.');

			} else {
				alert('메일로 인증번호를 전송했습니다.');
				$('#emailIdnum').attr('type','text');
				$('#emailIdbtn').attr('type','button');
				certifinum = data.certifiNum;
			} 
		},
		error:function(e){//에러시 서버에서보낸 에러관련 매개변수이다.
			console.log('에러...');
			console.log(e);	
		}
	});		
});

//인증확인 버튼
$('#emailIdbtn').click(function(){
	$('#emailIdnum').val();
	if($('#emailIdnum').val() == certifinum){
		certifinum_check = true;
		alert('이메일 인증 성공!');
		$('#emailIdnum').attr('type','hidden');
		$('#emailIdbtn').attr('type','hidden');

	} else {
		certifinum_check = false;
		alert('확인되지 않은 인증번호 입니다.');
	}		
});
//이메일 값이 한번이라도 바뀌면, 체크를 false로
$('input[name="user_email"]').keyup(function(e){
	certifinum_check = false;
});	


	$('input[class="pwconfirmSet"]').keyup(function(e){
		pw = $('input[name="user_pw"]').val();
		pwConfirm = $('input[name="pwConfirm"]').val();
		

		if(pw==pwConfirm){
			$('#confirm').html('비밀번호가 일치합니다.');
			$('#confirm').css({'color':'blue','font-size':'5px'});
			pw_check = 'T';
		} else {
			$('#confirm').html('비밀번호가 일치하지 않습니다..')
			$('#confirm').css({'color':'red','font-size':'5px'});
			pw_check = 'F';
		}
	});	
	//3. member_join이 클릭 됬을 때 overlayChk(아이디 중복체크) 됬는지 확인 -> 안했으면 하라는 메세지, 했으면 서버 전송
	$('#user_update').click(function() {


		var $user_pw = $('input[name="user_pw"]');
		var $user_name = $('input[name="user_name"]');
		var $user_email = $('input[name="user_email"]');
		var $user_phone = $('input[name="user_phone"]');
	
		
		if ($user_pw.val() == '' && pw_check == 'F') {
			alert('비밀번호를 입력 해주세요');
			$user_pw.focus();
		} else if (pw_check == 'F'){
			alert('비밀번호확인을 해주세요');
			$user_pw.focus();
		} else if ($user_name.val() == '') {
			alert('이름을 입력 해주세요');
			$user_name.focus();
		}else if ($user_email.val() == '') {
			alert('이메일을 입력하세요');
			$user_email.focus();			
		}else if ($user_phone.val() == '') {
			alert('휴대폰 번호를 입력 하세요');
			$user_phone.focus();
		} else if(!certifinum_check){
			alert('메일을 인증 해 주세요');
		} else {
			$('#updateForm').submit();//서버전송				
			alert('수정에 성공하셨습니다');					
			}	

	});
	
</script>
</html>




