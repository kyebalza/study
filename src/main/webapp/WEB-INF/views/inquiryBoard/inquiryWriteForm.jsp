<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <style>
 
 	iframe{
		width: 100%;
		height: 210px;
		border-style: none;
	}
	textarea {
	    width: 1255px;
	    height: 450px;
	    resize: none;
	}
	table{
	   	margin-left: auto;
	   	margin-right: auto;
    }

 	.category{
 		width:150px;
 		height:50px;
 	}
 	.title{
 		width: 1099px;
 		height:50px;
 	}  
 
 
 </style>
</head>
<body>
 
	<form action="inquiryWrite" method="post" enctype="multipart/form-data">
		<table> 
			<tr>
				<td>
					<select onclick="boardcate" name="board_cate_no">
						<c:forEach items="${inquiry_cate}" var="inquiry_cate"> 
		               		<option value="${inquiry_cate.board_cate_no}">${inquiry_cate.board_cate}</option>
		               	</c:forEach>
            		</select>
            		<input class="title" type="text" placeholder="제목을 입력하세요" name="title"/>
				</td>
			</tr>
			<tr>
				<td><textarea placeholder="내용을 입력하세요 " name="content"></textarea></td>
			</tr>

			<tr>
				<td><input type="file" name="uploadFile"/></td>
			</tr>
		</table>
		
		<input type="button" onclick="location.href='inquiryBoardList'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
  	
</body>
<script>
</script>
</html>