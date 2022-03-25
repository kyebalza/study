<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
			border: 2px solid #6AA84F;
		}
		tr,td,th{
			border: 1px solid #6AA84F;
		}
		input.button{
			text-align: center;
		}
		#sbListAll{
			max-width: 1200px;
            margin: 0 auto;
			padding: 10%,30%;
		}
		#footer{
			top: 100%;
		}
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div id="sbListAll">
	<form action="update" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<th>제목</th>
				<td>
	            	<input type="hidden" name="board_no" value="${dto.board_no}"/>
	            	<input type="text" name="title" value="${dto.title }"/>
			   </td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
	            	<input type="text" name="user_id" value="${dto.user_id }"/>
			   </td>
			   <th>작성일자</th>
			   <td>
	            	<input type="text" name="user_id" value="${dto.reg_date}"/>
			   </td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<!-- 문제 -->
					<div id="quiz">
					<p>${Qinfo.quiz_content}</p>
					<!-- 보기 -->
					<div class="quiz_option">
						<p class="option_num">보기1 : ${Qinfo.option1}</p>
					</div>
					<div class="quiz_option">
						<p class="option_num">보기2 : ${Qinfo.option2}</p>
					</div>
					<div class="quiz_option">
						<p class="option_num">보기3 : ${Qinfo.option3}</p>
					</div>
					<div class="quiz_option">
						<p class="option_num">보기4 : ${Qinfo.option4}</p>
					</div>
					<div class="quiz_option">
						<p class="option_num">보기5 : ${Qinfo.option5}</p>
					</div>
				</div>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>내용</th>
				<td><input name="content" value="${dto.content}"/></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><img src="/photo/${photo.new_filename}" width="400px" height="400px"/></td>
			</tr>
		</table>
		<br/>
		<input type="file" name="uploadFile"/>
		<br/>
		<input type="button" onclick="location.href='list'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
	</div>
	<div id="footer">
		<%@ include file="../footer.jsp" %>
	</div>
</body>
<script>
	
</script>
</html>