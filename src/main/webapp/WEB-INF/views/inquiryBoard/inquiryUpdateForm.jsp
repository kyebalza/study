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
	    width: 1255px;
	    height: 450px;
	    resize: none;
	}
	table{
	   	margin-left: auto;
	   	margin-right: auto;
    }


 	.title{
 		width: 1099px;
 		height:50px;
 	}  
 
 
 </style>
</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<br/>
	<br/>

	
	<form action="inquiryUpdate" method="post" enctype="multipart/form-data">
		<table> 
			<tr>
				<td>
					<select onclick="boardcate" name="board_cate_no">
						<c:forEach items="${inquiry_cate}" var="inquiry_cate"> 
		               		<option value="${inquiry_cate.board_cate_no}">${inquiry_cate.board_cate}</option>
		               	</c:forEach>
            		</select>
            		<input type="hidden" name="board_no" value="${dto.board_no}"/>
            		<input class="title" type="text" placeholder="제목을 입력하세요" name="title" value="${dto.title}"/>
				</td>
			</tr>
			<tr>
				<td><textarea placeholder="내용을 입력하세요 " name="content">${dto.content}</textarea></td>
			</tr>

			<tr>
				<td><input type="file" name="uploadFile" accept=".gif, .jpg, .png"/></td>
				<!-- 현재 업로드된 파일 삭제 -->
				<c:forEach items="${uploadFile}">
					<img src="/photo/${photo.new_filename}"/>
				</c:forEach>
			</tr>
		</table>
		
		<input type="button" onclick="location.href='inquiryBoardDetail?board_no=${dto.board_no}'" value="취소"/>
		<input type="submit" value="저장"/>
	</form>
	
	<jsp:include page="../footer.jsp"></jsp:include>

	
  	
</body>
<script>
	function photodel() {
		var $delphoto = $('.delphoto');
		
		for (var i = 0; i <$delphoto.length; i++) {
			console.log($delphoto[i].id);
		}
		
		
	}

</script>
</html>