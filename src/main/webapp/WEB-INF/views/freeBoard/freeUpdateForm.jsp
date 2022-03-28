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
 
	<form action="freeUpdate" method="post" enctype="multipart/form-data">
		<table> 
			<tr>
				<td>
					<select onclick="boardcate" name="board_cate_no">
						<c:forEach items="${free_cate}" var="free_cate"> 
		               		<option value="${free_cate.board_cate_no}">${free_cate.board_cate}</option>
		               	</c:forEach>
            		</select>
            		<input type="hidden" name="board_no" value="${fbdto.board_no}"/>
            		<input class="title" type="text" placeholder="제목을 입력하세요" name="title" value="${fbdto.title}"/>
				</td>
			</tr>
			<tr>
				<td><textarea placeholder="내용을 입력하세요 " name="content">${fbdto.content}</textarea></td>
			</tr>

			<tr>
				<td><input type="file" name="uploadFile" accept="image/jpg, image/jpeg, image/png"/></td>
				<!-- 현재 업로드된 파일 삭제 -->
				<c:forEach items="${uploadFile}">
					<img src="/photo/${fbphoto.new_filename}"/>
				</c:forEach>
			</tr>
		</table>
		
		<input type="button" onclick="location.href='freeBoardDetail?board_no=${fbdto.board_no}'" value="취소"/>
		<input type="submit" value="저장"/>
	</form>
  	
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