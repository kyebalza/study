<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
		

	<style>
		#header{
		width: 100%;
		height: 100px;
		/* border-style: none; */
		overflow: hidden;
	}
	body{
	margin : 0px;
	}	

	.alllogin{
		width: 375px;
		height: 300px;
		text-align: center;
		top: 20px;	
		margin : auto;
		}			
	/*
	.login {
		width: 320px;
		height: 300px;
		top: 10px;	
		margin : auto;
		left : 300px;
		}
	*/
	.login {
		text-align: center;
		margin-top: 150px;
		}	
	input[type="text"]{
		
		width: 350px;
    	height: 30px;
    	text-align: center;
    	border: solid #4caf50;
	
	}
	input[type="button"]{
		height: 35px;
	    width: 80px;
	    text-align: center;
	    border: solid #4caf50;
	    border-radius: 8px;
	    background-color: #4caf50;
	    color: white;
	}
	input[type="button"]:hover{
		cursor: pointer;
		color: #4caf50;
		background-color: white;
	}
	
	a{
		color: black;
    	text-decoration: none;	
	}
	a:hover{
		color: #4caf50;
	}
	#findpass{
		width : 85px;
		font-size : 4px;
	}
	</style>
</head>
<body>
<%@ include file="./header.jsp" %>

<div class = "alllogin">
<div class = "login">
	<table>
		<tr>
			<th>
				<img id="MainLogo" src="resources/img/Logo.png" alt="메인로고"/>
			</th>
		</tr>
		<tr>
			
			<td>
    		<input type = "text" name = "user_name" placeholder="이름을 입력하세요"/> 
			</td>   
		</tr>
		<tr>
			
			<td>
				<input type = "text" name = "user_phone" placeholder="핸드폰을 입력하세요"/>
			</td>
		</tr>
		<tr>
			
			<td>
				<input type = "text" name = "user_email" placeholder="이메일을 입력하세요"/>
			</td>
		</tr>	
			<tr>
				<th>
				<input type="button" id = "idfind" value="아이디찾기"/>
				<input type="button" id = "idfindcan" onclick = "location.href='loginPage'" value="취소"/>
				</th>
			</tr>
			<tr>
				<th>비밀번호를 잊으셨나요?
				<input type = "button" id = "findpass" value = "비밀번호 찾기" 
				onclick = "location.href='pwfind'"/>
				</th> 
			</tr>
		</table>
		<br/><br/>
		<table>
		</table>
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