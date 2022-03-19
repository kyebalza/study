<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
			border: 2px solid green;
			text-align: center;
			padding : 10px;
		}
		tr,td,th{
			border: 1px solid green;
		}
		input.button{
			text-align: center;
		}
		input.quiz_content{
		}
	</style>
</head>
<body>
	<form action="write" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<select onclick="boardcate" name="board_cate_no">
		               <c:forEach items="${study_cate}" var="study_cate"> 
		               		<option value="${study_cate.board_cate_no }">${study_cate.board_cate }</option>
		               	</c:forEach>
	            	</select>
	            	<input type="text" name="title" placeholder="제목을 입력해주세요."/>
			   </td>
			</tr>
			<tr>
				<th>문제</th>
				<td>
					<select onclick="quiz_name" name="quiz_name" id="quiz_name"><!-- 시험종류 -->
						<c:forEach items="${quiz_name}" var="quiz_name">
							<option value="${quiz_name.test_cate}">${quiz_name.test_cate}</option>
						</c:forEach>
					</select>
					<select onclick="quiz_year" name="quiz_year" id="quiz_year"><!-- 시행년도 -->
						<c:forEach items="${year_count}" var="year_count">
							<option value="${year_count.test_year}">${year_count.test_year}</option>
						</c:forEach>
					</select>
					<select onclick="quiz_times" name="quiz_times" id="quiz_times"><!-- 시험회차 -->
						<c:forEach items="${year_count}" var="year_count">
							<option value="${year_count.test_count}">${year_count.test_count}</option>
						</c:forEach>
					</select>
					<select onclick="quiz_no" name="quiz_no" id="quiz_no"><!-- 문제번호 -->
						<c:forEach items="${quiz_no}" var="quiz_no">
							<option value="${quiz_no.quiz_index}">${quiz_no.quiz_index}</option>
						</c:forEach>
					</select>
					<input type="button" onclick="quiz()" value="문제불러오기"/>
					<hr/>
					<input class="quiz_content" value=""/>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><input type="file" name="uploadFile"/></td>
			</tr>
		</table>
		<input type="button" onclick="location.href='list'" value="취소"/>
		<input type="submit" value="등록"/>
	</form>
</body>
<script>
	
	function quiz(){
		console.log("문제불러오기");
		
		var quiz_name = $('#quiz_name').val();
		var quiz_year = $('#quiz_year').val();
		var quiz_times = $('#quiz_times').val();
		var quiz_no = $('#quiz_no').val();
		console.log(quiz_name,quiz_year,quiz_times,quiz_no);
		
		var params = {'quiz_name':quiz_name,'quiz_year':quiz_year,'quiz_times':quiz_times,'quiz_no':quiz_no};
		console.log(params);
		
		$.ajax({
			type:'POST',
			url:'selectquiz',
			data:params,
			dataType:'JSON',
			success:function(data){
				console.log('문제가져오기 : ',data);
			},
			error:function(e){
				console.log('문제발생: ',e);
			}
		});//ajax괄호끝
		
	};//quiz() 괄호끝
		
		
	
	
</script>
</html>