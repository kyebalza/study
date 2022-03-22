<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style></style>
</head>
<body>
	<div id="freeSingoPopup">
			<form action="freeBoardSingo" method="POST" id="freesingoForm">
				<table>
					<tr>
						<th id="SingoPopupHead">[신고하기]</th><td id="closebtn"><input type="button" value="X" onclick="freesingoPop()"/></td>
					</tr>
					<tr>
						<td id="SingoUser">
							작성자 : ${loginId}
							<input type="hidden" value="${loginId}" name="dec_targetId"/>
							<input type="hidden" value="${info.board_no }" name="dec_targetNum"/>
						</td>
					</tr>
					<tr>
						<td id="SingoCont">내용 : ${info.content}</td>
					</tr>
					<tr>
						<td id="SingoSelect"> 신고항목
							<select name ="user_state">
								<option value="일단" >일단</option>
								<option value="테스트" >테스트</option>
								<option value="해볼게요" >해볼게요</option>
								<option value="그렇습니다." >그렇습니다.</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" value="보내기" id="singoCom"/>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
</body>
<script>


		
		
		$('#singoCom').click(function() {
			
			var loginId = '<%=(String)session.getAttribute("loginId")%>';
			
			if (loginId == "null") {
				alert("로그인이 필요한 기능입니다.");
			}else{
				var yn = confirm("정말 이글을 신고 하시겠습니까?");
				if (yn) {
					alert("신고가 완료되었습니다.");
					$('#freesingoForm').submit();		
					
				}
				
			}
		
		})

</script>
</html>