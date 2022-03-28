<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link rel="stylesheet" href="resources/css/header.css"/>
 
 <style>
 
 
	textarea {
	    width: 1185px;
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
 		width: 1100px;
 		height:50px;
 	}
 			
 			
 	button{
 		text-align: center;
		background-color : green;
		color: white;
	}  
 
 
 </style>
</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<br/>
	<br/>
 
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
		<input type="submit" id="registration" value="등록"/>
	</form>
	
	
	
  	
</body>
<script>
	
	$("#registration").click(function() {
		console.log('click');
		if (check) {
			console.log('문의게시글 작성 시작');
			var $title = $('input[name="title"]');
			var $content = $('input[name="content"]');
		}
		
		
	})
	
	

</script>
</html>