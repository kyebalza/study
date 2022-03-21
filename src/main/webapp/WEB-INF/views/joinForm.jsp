<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table, th, td{

			border-collapse: collapse;
			padding: 5px;
		}
		.alljoin{
			width: 600px;
			/*height: 600px;*/
			text-align: center;
			top: 20px;	
			margin : auto;
		}
		#joinForm{
			text-align: center;
		}
	</style>
</head>
<body>
	<div class="alljoin">
		<form id="joinForm" action="join" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="user_id"/>
						<input id="overlay" type="button" value="중복체크"/>
						<p id="overlay_msg"></p>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input id="pass" type="password" name="user_pw"/></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input id="pass_confirm" type="password"/>
						<p id="pw_confirm"></p>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="user_name"/></td>
				</tr>
				<tr>
					<th>EMAIL</th>
					<td>
						<input type="email" name="user_email"/>
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
					<td><input type="text" name="user_phone" placeholder="010-0000-0000"/></td>
				</tr>
				<tr>
					<th colspan="2">
						<input id="user_join" type="button" value="회원가입"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
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
				console.log('인증번호 : '+data.certifiNum);		
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
		alert('인증번호좀 똑바로 입력해주세요');
	}		
});


	//1. 아이디 중복 확인
	var overlayChk = false;
	
	
	$('#overlay').on('click', function() {
		console.log('click');
		var chkId = $('input[name="user_id"]').val();
		console.log('chkId : '+chkId);
		$.ajax({
			url:'overlay',
			type:'get',
			data:{
				user_id:$('input[name="user_id"]').val()
				},
			dataType:'JSON',
			success: function(data){
				var msg = "";
				if(data.overlay){
					msg="사용중인 아이디 입니다";
					$('input[name="user_id"]').val('');
				}else{
					msg="사용 가능한 아이디 입니다.";
					overlayChk = true;
				}
				$("#overlay_msg").html(msg);
			},
			error: function(e){
				console.log(e);
			}
		});
	});
	
	
	//2. 비밀번호 확인
	$('#pass_confirm').keyup(function() {
		var confirm = $('#pass_confirm').val(); 
		var pass =	$('#pass').val();
		var msg =	"";
		console.log(pass,confirm);
		if(pass === confirm){
			msg = "비밀번호가 일치합니다.";
		}else{
			msg = "비밀번호가 일치하지 않습니다.";
		}
		$("#pw_confirm").html(msg);
	});
	
	//3. member_join이 클릭 됬을 때 overlayChk(아이디 중복체크) 됬는지 확인 -> 안했으면 하라는 메세지, 했으면 서버 전송
	$('#user_join').click(function() {
		if(overlayChk){
			$('#joinForm').submit();//서버전송
			alert('회원가입에 성공하셨습니다');					
		}else{
			alert('아이디 중복 체크를 해 주세요');			
		}
	});
	
</script>
</html>




