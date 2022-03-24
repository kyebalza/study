<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src = "https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
	.alllogin{
		width: 375px;
		height: 300px;
		text-align: center;
		top: 20px;	
		margin : auto;
		}			
	.login {
		text-align: center;
		margin-top: 150px;
		}
	#login{
		height: 35px;
	    width: 75px;
	    text-align: center;
	    border: solid #4caf50;
	    border-radius: 8px;
	    background-color: #4caf50;
	    color: white;
	}
	#login:hover{
		cursor: pointer;
		color: #4caf50;
		background-color: white;
	}
	#user_id{
		width: 350px;
    	height: 30px;
    	text-align: center;
    	border: solid #4caf50;
	}
	#user_pw{
		width: 350px;
    	height: 30px;
    	text-align: center;
    	border: solid #4caf50;
	}		
	table,th,td{
		/*border-collapse : collapse ;*/
		padding : 5px;
		/*border: solid 1px gray;*/
	}
	a{
		color: black;
    	text-decoration: none;	
	}
	a:hover{
		color: #4caf50;
	}
	#header{
		width: 100%;
		height: 100px;
		/* border-style: none; */
		overflow: hidden;
	}
	body{
	margin : 0px;
	}		
	</style>
</head>
<body>
<%@ include file="./header.jsp" %>


<div class = "alllogin">
<div class = "login">
	<table>
		<img id="MainLogo" src="resources/img/Logo.png" alt="메인로고"/>
		<tr>
			<!-- <th>ID</th> -->
			<td><input type = "text" id = "user_id" placeholder="아이디를 입력하세요"/></td>
		</tr>
		<tr>
			<!-- <th>PW</th> -->
			<td><input type = "password" id = "user_pw" placeholder="비밀번호를 입력하세요"/></td>
		</tr>
		<tr>
			<th colspan = "2">
			<input type = "button" id = "login" value = "로그인"/>
			</br>
			</br>
			<a href="idfind">아이디 찾기</a> | 
			<a href="pwfind">비밀번호 찾기</a> | 
			<a href="joinForm">회원가입</a>
			
			<!-- <input type = "button" id= "pwfind" value = "비밀번호 찾기" onclick = "location.href='pwfind'"/> -->
			<!-- <input type = "button" id= "idfind" value = "아이디 찾기" onclick = "location.href='idfind'"/> -->
			<!-- <input type = "button" id= "joinForm" value = "회원가입" onclick = "location.href='joinForm'"/> -->
			</th>
		</tr>
	</table>
</div>
</div>
</body>
<script>
	$('#login').click(function() {
		var user_id = $('#user_id').val();
		var user_pw = $('#user_pw').val();	
		console.log(user_id+'/'+user_pw);
	
		$.ajax({
			type:'POST',
			url : 'login',
			data:{'user_id':user_id,'user_pw':user_pw},
			dataType : 'JSON',
			//아래data는 컨트롤러 에서 넘어노는 map의 값 
			//위에 data가 아님 
			success : function (data) {
				if (data.success != null) {
				console.log("로그인된 아이디 :" + data.loginId);
				console.log("관리자여부 : "+data.admin);
					alert(data.loginId+'님 반갑습니다.');
					location.href = './'; 
					//메인페이지 명으로 수정 예정
				}else{
					alert('아이디 또는 패스워드가 일치 하지 않습니다.');
				}
			},
			
			error : function (e) {
				console.log(e);
			}
		});
	}); 	

</script>
</html>
