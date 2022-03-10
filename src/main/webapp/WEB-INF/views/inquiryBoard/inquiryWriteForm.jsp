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
 
	<form action="inquiryWrite" method="post">
	<input type="hidden" name="user_id" value="${sessionScope.loginId}"/>
		<table> 
			<tr>
				<th>
					<select class="category" name="Category">
                    <option value="" disabled selected>전체</option>
                    <option value="계정문의">계정문의</option>
                    <option value="이용문의">이용문의</option>
            		</select>
				</th>
				<td>
					<input class="title" type="text" placeholder="제목을 입력하세요" name="board_title"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea placeholder="내용을 입력하세요 " name="board_content"></textarea></td>
			</tr>
 			<tr>
				<th>파일</th>
				<td><input type="file" name="photos" multiple="multiple"/></td>
			</tr>
			<tr>
				<th colspan="2">
			
				
				<input type="button" onclick="location.href='./inquiryBoardList'" value="취소" />
				<button>등록</button>
				</th>
			</tr>
		</table>
	</form>
  	
</body>
<script></script>
</html>