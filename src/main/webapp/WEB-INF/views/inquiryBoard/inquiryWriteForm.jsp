<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link rel="stylesheet" href="resources/css/header.css"/>
 
 <style>
 
 	table {
 		min-width : 1000px;
		border: 2px solid #6AA84F;
		text-align: center;
		padding : 10px;
		margin : auto;
 	
 	}
 	
 	th {
 		height: 50px;
		background-color:#6AA84F;
		border: 1px solid #6AA84F;
		text-align: center;
		padding: 10px;
		margin:5px;
		color:white;
 	}
 	
 	tr,td{
		border: 1px solid #6AA84F;
		text-align: center;
		padding: 10px;
		margin:5px;
			
	}
	

 	.title {
 		text-align: center;
 		width: 500px;
 		border: 2px solid #6AA84F;
		left: 20%;
		border-radius: 9px;
 	
 	}
 	
 	textarea {
 		width: 800px;
 		height: 250px;
 		border-radius: 9px;
 		resize: none;
 	}
 	
 	
 	select{
		background-color: #6AA84F;
		color: white;
		border-radius: 9px;
		height: 30px;
		text-align: center;
	}
	

	

	
	.buttonout{
		display: flex;
	}
	.buttonin{
		margin: auto;
		
	}
		


 
 
 
 </style>
</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<br/>
	<br/>
 
	<form action="inquiryWrite" method="post" enctype="multipart/form-data">
		<table class="ibwrite"> 
			<tr>
				<th>
				제목
				</th>
				<td>
            		<input class="title" type="text" placeholder="제목을 입력하세요." name="title"/>
            	</td>
            </tr>
            
            <tr>
            	<th>카테고리 선택</th>
            	<td>
					<select class="select" onclick="boardcate" name="board_cate_no">
						<c:forEach items="${inquiry_cate}" var="inquiry_cate"> 
		               		<option value="${inquiry_cate.board_cate_no}">${inquiry_cate.board_cate}</option>
		               	</c:forEach>
            		</select>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea placeholder="내용을 입력하세요." name="content"></textarea></td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td><input type="file" name="uploadFile"/></td>
			</tr>

		</table>
		
		<br/>
		
		<div class="buttonout">
			<div class="buttonin">
				<input type="button" onclick="location.href='inquiryBoardList'" value="취소"
					style="
						background-color : #6AA84F;
						color: white;
						border: none;
						width: 100px;
						height: 30px;
						border-radius: 11px;
					"/>
				
				<input id="registration" type="button" class="button" value="등록"
					style="
						background-color : #6AA84F;
						color: white;
						border: none;
						width: 100px;
						height: 30px;
						border-radius: 11px;
					"/>
			</div>
		</div>
		
	</form>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	
	
	
  	
</body>
<script>
	
	$("#registration").click(function() {
		console.log('click');
		var check = true;
		var $title = $('input[name="title"]');
		var $content = $('textarea[name="content"]');
		if($title.val() == ''){
			alert('제목을 입력해주세요');
			check = false;
		}
		if($content.val() == ''){
			alert('내용을 입력해주세요');
			check = false;
		}
		if (check) {
			console.log('문의게시글 작성 시작');
			$('form').submit();
		}
		
		
	})
	
	

</script>
</html>