<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;  
	}
	.alllogin{
		width: 700px;
		height: 300px;
		text-align: center;
		top: 10px;	
		margin : auto;
		}			
	.login {
		width: 320px;
		height: 300px;
		top: 10px;	
		margin : auto;
		left : 300px;
		}	 	
	</style>
</head>
<body>
<div class = "alllogin">
<div class = "login">
	<table>
	<h3>아이디 찾기</h3>
		<tr>
			<th>이름</th>
			<td>
    		<input type = "text" name = "user_name"/> 
			</td>   
		</tr>
		<tr>
			<th>핸드폰번호</th>
			<td>
				<input type = "text" name = "user_phone"/>
			</td>
		</tr>
		<tr>
			<th>이메일 주소</th>
			<td>
				<input type = "text" name = "user_email"/>
			</td>
		</tr>	
			<tr>
				<th colspan="2">
				<input type = "button" id = "idfind" value = "아이디찾기"/>
				<input type = "button" id = "idfindcan" value = "취소" 
					onclick = "location.href='loginMain'"/>
				</th>
			</tr>
		</table>
			<tr><th>비밀번호를 잊으셨나요?</th> 
		<input type = "button" id = "fingpass" value = "비밀번호 찾기" 
			onclick = "location.href='pwfind'"/>
		</tr>
	</div>
</div>
</body>
<script>
 $('#idfind').click(function() {

	var user_name = $('input[name="user_name"]').val();
	var user_phone = $('input[name="user_phone"]').val();   
	var user_email = $('input[name="user_email"]').val();
	console.log(user_name+'/'+user_phone +'/'+user_email);
	
	$.ajax({
		type:'POST',
		url : 'findid',
		data:{'user_name':user_name,
				'user_phone':user_phone, 
				'user_email':user_email},
		dataType : 'JSON',
		success : function (data) {
			if (data.success != '아이디없음') {
				alert('고객님의 아이디는 '+ data.success+'입니다.');
				location.href = './loginPage';
			}else{
				alert('입력하신 정보가 일치 하지 않습니다. 다시 확인 후 입력바랍니다.');
			}
		},
		error : function (e) {
			console.log(e);
		}  
	});
 }); 	
</script>
</html>