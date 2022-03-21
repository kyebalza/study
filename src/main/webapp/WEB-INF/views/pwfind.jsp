<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
	table, th, td {
		border-collapse: collapse;
		padding : 5px 10px;  
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
    		<input type = "text" name = "user_id" placeholder="아이디를 입력하세요"/> 
			</td>   
		</tr>
		<tr>			
			<td>
				<input type = "text" name = "user_email" placeholder="이메일 주소를 입력하세요"/>
			</td>
		</tr>	
			<tr>
				<th>
				<input type="button" id = "toemail" value="전송"/>
				<input type="button" id = "idfindcan" onclick = "location.href='loginPage'" value="취소"/>
				</th>
			</tr>
		</table>
	</div>
</div>
</body>
<script>
$('#toemail').click(function(){
	$user_id = $('input[name="user_id"]').val();
	$user_email = $('input[name="user_email"]').val();
	console.log($user_id);
	console.log($user_email);
	
	$.ajax({
		url : 'submitTempPw',
		type : 'get',
		data : {'user_id':$user_id,'user_email':$user_email},
		dataType : 'json',
		success : function(data){
			if(data.msg == 0){
				alert('일치하는 회원정보가 없습니다.');
			}
			if(data.msg > 0){
				alert('해당 이메일 주소로 임시비밀번호가 발급되었습니다.\n 이메일을 통해 확인해주세요');
				location.href='loginPage';
			}
			
			
		},
		error : function(e){}
		
		
		
	});
	
});


</script>
</html>