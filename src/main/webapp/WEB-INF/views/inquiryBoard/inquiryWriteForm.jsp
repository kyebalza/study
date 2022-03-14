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
            		<input class="title" type="text" placeholder="제목을 입력하세요" name="title"/>
				</th>
				
			</tr>
			<tr>
				<td><textarea placeholder="내용을 입력하세요 " name="content"></textarea></td>
			</tr>

			<tr>
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