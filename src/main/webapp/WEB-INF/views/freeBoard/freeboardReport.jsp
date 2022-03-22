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
					<tr >
						<td id="SingoPopupHead">[신고하기]</td>
						<td id="closebtn"> <input type="button" value="X" onclick="fbsingo()"/></td>
					</tr>
					<tr>
						<td id="SingoUser"  colspan="2">
							작성자 : ${loginId}
							<input type="hidden" value="${loginId}" name="report_user"/>
							<input type="hidden" value="${info.user_id }" name="reported_user"/>
							<input type="hidden" value="${info.board_cate_no }" name="board_cate_no"/>
							<input type="hidden" value="${info.board_no }" name="board_no"/>
							<input type="hidden" value="${info.board_name }" name = "board_name"/>
						</td>
					</tr>
					<tr>
						<td id="SingoCont"  colspan="2">내용 : ${info.title}</td>
					</tr>
					<tr>
						<td id="SingoSelect"  colspan="2"> 신고항목 </br>
								<input type='radio' name='report_reason' value='광고'/>광고 </br>
								<input type='radio' name='report_reason' value='선정성'/>선정성 </br>
								<input type='radio' name='report_reason' value='욕설'/>욕설 </br>
								<input type='radio' name='report_reason' value='부적절한 내용'/>부적절한 내용 </br>
							</select>
						</td>
					</tr>
					<tr>
						<td  colspan="2">
							<input type="button" value="보내기" id="singoCom"/>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
</body>
<script>

		$('#freeSingoPopup').hide();
		
		
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