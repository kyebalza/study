<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
		/*
			border: 1px solid #6AA84F;
			border-collapse: collapse;
			padding : 5px 10px;
		*/	
			min-width : 1170px;
			border: 2px solid #6AA84F;
			text-align: center;
			padding : 10px;
			margin : auto;
		}
		th{
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
		select{
			background-color: #6AA84F;
			color: white;
			border-radius: 9px;
			height: 30px;
			text-align: center;
		}
		#sbListAll{
		/*
			max-width: 1200px;
            margin: 0 auto;
			padding: 10%,30%;
		*/
			min-width : 1150px;
			left: 20%;
			position: absolute;
			
		}
		#sbwirte{
			min-width : 1170px;
			border: 2px solid #6AA84F;
			padding : 15px;
			margin : auto;
		}
		input.button{
			margin: 5px;
		}
		#quiz{/*문제 전체*/
			text-align: left;
		}
		
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div id="sbListAll">
		<br/>
		<form action="write" method="post" name="sbWrite" enctype="multipart/form-data">
			<table class="sbwrite">
				<tr>
					<th>제목</th>
					<td>
						<select onclick="boardcate" name="board_cate_no">
			               <c:forEach items="${study_cate}" var="study_cate"> 
			               		<option value="${study_cate.board_cate_no }">${study_cate.board_cate }</option>
			               	</c:forEach>
		            	</select>
		            	<input type="text" name="title" id ="title" placeholder="제목을 입력해주세요."
		            		style="
								width: 230px;
								height: 30px;
								border-radius: 9px;
								border: 1px solid #6AA84F;
								text-align: center;
							"
		            	/>
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
						<input id="quizcall" type="button" onclick="quiz()" value="문제불러오기"
							style="
								background-color : #6AA84F;
								color: white;
								border: none;
								margin: auto;
								width: 100px;
								height: 30px;
								border-radius: 11px;
							"/>
						<hr/>
						
						<!-- 문제 -->
						<div id="quiz">
						<p style="padding : 15px;">${Qinfo.quiz_index}번 문제.<br/> ${Qinfo.quiz_content}</p>
						<!-- 보기 -->
							<p class="option_num" style="padding : 5px;">보기1 : ${Qinfo.option1}</p>
							<p class="option_num" style="padding : 5px;">보기2 : ${Qinfo.option2}</p>
							<p class="option_num" style="padding : 5px;">보기3 : ${Qinfo.option3}</p>
							<p class="option_num" style="padding : 5px;">보기4 : ${Qinfo.option4}</p>
							<p class="option_num" style="padding : 5px;">보기5 : ${Qinfo.option5}</p>
						</div>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" 
							style="width: 603px; height: 112px; border-radius: 9px;
									border: 1px solid #6AA84F;
									text-align: center;"></textarea>
					</td><!-- 글내용 -->
				</tr>
				<tr>
					<th>이미지</th>
					<td>
						<input id="file" type="file" name="uploadFile" 
							style="border: 1px solid #6AA84F;
							"/><!-- 파일첨부 -->
					</td>
				</tr>
			</table>
			<div style="margin-top: 10px;">
				<input class="button" type="button" onclick="location.href='list'" value="취소"
					style="
							background-color : #6AA84F;
							color: white;
							border: none;
							margin: auto;
							width: 100px;
							height: 30px;
							border-radius: 11px;
					"/>
				<input id="submit" class="button" type="submit" value="등록" onclick="check_input()"
					style="
							background-color : #6AA84F;
							color: white;
							border: none;
							margin: auto;
							width: 100px;
							height: 30px;
							border-radius: 11px;
					
					"/>
				</div>
		</form>
	<%@ include file="../footer.jsp" %>
	</div>
</body>
<script>	

	function check_input(){
		var title = $('#title').val();
		if($('#title').val() == ""){
			alert("제목을 입력해주세요.");
			$('#title').focus();
		   }
		if(document.sbWrite.title.value) {
			confirm("게시글을 등록하시겠습니까?")
		   	document.sbWrite.submit();
		}
	};
	
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
				$('#quiz_content').val(data.quiz_content);
				$('#option1').val(data.option1);
				$('#option2').val(data.option2);
				$('#option3').val(data.option3);
				$('#option4').val(data.option4);
				$('#option5').val(data.option5);//값 없으면 숨기기
				
				
			},
			error:function(e){
				console.log('문제발생: ',e);
			}
		});//ajax괄호끝
		
		if($('#option5').val() == null){
			$('#option5').hide();
		};
	};//quiz() 괄호끝
	
	
</script>
</html>