<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		
	</style>
</head>
<body>
	<form action="adminUserUpdate" method="POST">
		<table>
			<tr>
				<th>아이디<input type="hidden" name="user_id" value="${info.user_id}" readonly="readonly"></th>
				<td>
					${info.user_id}
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>${info.user_pw}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${info.user_name}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${info.user_email}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${info.user_phone}</td>
			</tr>
			<tr>
				<th>계정상태</th>
				<td>
					<select name ="user_state" >
						<option value="정상" <c:if test="${info.user_state == '정상'}"> selected</c:if>>정상</option>
						<option value="탈퇴" <c:if test="${info.user_state == '탈퇴'}"> selected</c:if>>탈퇴</option>
						<option value="휴면" <c:if test="${info.user_state == '휴면'}"> selected</c:if>>휴면</option>
						<option value="정지" <c:if test="${info.user_state == '정지'}"> selected</c:if>>정지</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>계정상태</th>
				<td>
					<select name ="user_admin">
						<option value="회원" <c:if test="${info.user_admin == '회원'}"> selected</c:if>>회원</option>
						<option value="관리자" <c:if test="${info.user_admin == '관리자'}"> selected</c:if>>관리자</option>
					</select>
				</td>
			</tr>
		</table>
		<input type="button" onclick="submit()" value="저장"/>
		<input type="button" onclick="location.href='./ManagUser'" value="목록"/>
	</form>
</body>
<script>
	
	//onclick이 sumit과 동일하여 아래 script가 실행하지 않음. controller 수정 필요
	
	function sub() {
		const yn = confirm("회원 정보를 수정하시겠습니까?");
		
		if (yn) {
			location.href='adminUserUpdate?user_id=${info.user_id}';
		}
	}
	
</script>
</html>
