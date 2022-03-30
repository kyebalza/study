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
		th,td{
			height : 10px;
		}
		th{
			text-align: left;
		}
		.alljoin{
			width: 380px;
			/*height: 600px;*/
			text-align: center;
			top: 20px;	
			margin : auto;
			margin-top: 190px;
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
		#overlay_msg{
			color: blue;
		    font-size: 13px;
		    font-weight: 600;
		}
		body{
			margin : 0px;
		}
		input{
			height: 23px;
		}
		input[type="button"]{
		    background-color: #6AA84F;
		    border: solid #6AA84F;
		    border-radius: 2px;
		    color: white;
		}
		table{
			background-color: #f3f3f3;
			width: 450px;
		}
		input{
			height: 50px;
		}
	</style>
</head>
<body>
<%@ include file="./header.jsp" %>
	<div class="alljoin">
		<form id="joinForm" action="join" method="post">
		<table>
			<tr><th>아이디</th></tr>
				<tr>
					<td>
						<input type="text" name="user_id" placeholder="영문 or 숫자만 입력가능"  style="width: 71.5%;"/>
						<input id="overlay" type="button" value="중복체크" style="width: 27%;"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<h5 id="overlay_msg"></h5>
					</td>
				</tr>
				<tr><th>비밀번호</th></tr>
				<tr>
					<td><input id="pass" class="pwconfirmSet" type="password" name="user_pw" style="width: 100%;"/></td>
				</tr>
				<tr><th>비밀번호 확인</th></tr>
				<tr>
					<td>
						<input id="pass_confirm" class="pwconfirmSet" type="password" name="pwConfirm" style="width: 100%;"/>
						<p id="pw_confirm"></p>
					</td>
				</tr>
				<tr>	
					<td colspan="2" id="confirm">		
					</td>
				</tr>
				<tr><th>이름</th></tr>
				<tr>
					<td><input type="text" name="user_name" style="width: 100%;"/></td>
				</tr>
				<tr><th>EMAIL</th></tr>
				<tr>
					<td>
						<input type="email" name="user_email" style="width: 71.5%;"/>
						<input type="button" id="indetify" value="인 증" style="width: 27%;"/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" id="emailIdnum" value="" style="width: 71.5%;"/>
						<input type="hidden" id="emailIdbtn" value="확 인" style="width: 27%;"/>
					</td>		
				</tr>
				<tr><th>전화번호</th></tr>				
				<tr>
					<td>
						<input type="text" name="user_phone" placeholder="010-0000-0000" style="width: 100%;"/>
						<p id="phone_confirm"></p>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<br/>
						<input id="user_join" type="button" value="회원가입" style="width: 100%;"/>
					</th>
				</tr>
			</table>
		</form>
	</div>
	
<%@ include file="./footer.jsp" %>
</body>
<script>
var pw = '';
var pwConfirm = '';
var pw_check = 'T';
var certifinum = null;
var certifinum_check = false;
var overlayChk = false;//ID
var phoneConfirm =  'F';




$('#indetify').click(function(){
	console.log('중복체크시작');
	var email = $('input[name="user_email"]').val();
	console.log('check email : ',email);
	
	
	//이메일 정규식 체크
	function email_check(email) {
		var reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		return reg.test(email);
	}
	
	if(!email_check(email)){
		alert("이메일 형식에 맞게 입력해주세요");
	}else{
		
		$.ajax({
			type:'get',
			url :'overlayemail',
			data:{'email':email},
			dataType:'json',
			success:function(data){
				console.log(data.certifiNum);
							
				
				if(data.overLay > 0){
					alert('이미 사용중인 이메일 입니다.');
	
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
		
	}
	
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

	//1. 아이디 중복 확인
	
	
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
	
	//1-1. 인증 후 아이디 값이 바뀌면, 인증을 false로 변경
	$('input[name="user_id"]').keyup(function(e){
		overlayChk = false;
		
		//영문과 숫자만입력 가능
		v = $(this).val();
        var engNum = /^[a-zA-Z0-9]*$/;

        if (!engNum.test(v)) {
            alert("영문과 숫자만 입력가능 합니다.");
            $(this).val(v.replace(v,''));
        }
        
	});
	
	//2. 비밀번호 확인
	$('input[class="pwconfirmSet"]').keyup(function(e){
		pw = $('input[name="user_pw"]').val();
		pwConfirm = $('input[name="pwConfirm"]').val();
		

		if(pw==pwConfirm){
			$('#confirm').html('비밀번호가 일치합니다.');
			$('#confirm').css({'color':'blue','font-size':'13px','font-weight':'600'});
			pw_check = 'T';
		} else {
			$('#confirm').html('비밀번호가 일치하지 않습니다..')
			$('#confirm').css({'color':'red','font-size':'13px','font-weight':'600'});
			pw_check = 'F';
		}
	});	
	//3. member_join이 클릭 됬을 때 overlayChk(아이디 중복체크) 됬는지 확인 -> 안했으면 하라는 메세지, 했으면 서버 전송
	$('#user_join').click(function() {
		if(overlayChk){
			var $user_id = $('input[name="user_id"]');
			var $user_pw = $('input[name="user_pw"]');
			var $user_name = $('input[name="user_name"]');
			var $user_email = $('input[name="user_email"]');
			var $user_phone = $('input[name="user_phone"]');
		
			
			if($user_id.val() == '') {
				alert('아이디를 입력 해주세요');
				$user_id.focus();
			}else if ($user_pw.val() == '') {
				alert('비밀번호를 입력 해주세요');
				$user_pw.focus();
			} else if (pw_check == 'F'){
				alert('비밀번호확인을 해주세요');
				$user_pw.focus();
			} else if ($user_name.val() == '') {
				alert('이름을 입력 해주세요');
				$user_name.focus();
			}else if ($user_email.val() == '') {
				alert('이메일을 입력해주세요');
				$user_email.focus();			
			}else if ($user_phone.val() == '') {
				alert('휴대폰 번호를 입력해주세요');
				$user_phone.focus();
			}else if(phoneConfirm == 'F'){
				alert('전화번호를 확인해주세요');
				$user_phone.focus();
			}else if(!certifinum_check){
				alert('메일 인증을 해주세요');
			} else {
				$('#joinForm').submit();//서버전송				
				alert('회원가입에 성공하셨습니다');					
			}	
			
			
			
		}else{
			alert('아이디 중복 체크를 해 주세요');			
		}
	});
	//4. 전화번호 형식확인
		
	$('input[name="user_phone"]').keyup(function(e){
		var phone = $('input[name="user_phone"]').val();
		

		if(/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(phone)){
			$('#phone_confirm').html('유효한 전화번호 형식입니다.');
			$('#phone_confirm').css({'color':'blue','font-size':'13px','font-weight':'600'});
			phoneConfirm = 'T';
		} else {
			$('#phone_confirm').html('전화번호를 확인해주세요.')
			$('#phone_confirm').css({'color':'red','font-size':'13px','font-weight':'600'});
			phoneConfirm = 'F';
		}
	});	
</script>
</html>




