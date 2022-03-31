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
			width : 150px;
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
		<form id="write" action="write" method="post" name="sbWrite" enctype="multipart/form-data">
			<table class="sbwrite">
				<tr>
					<th>제목</th>
					<td>
						<select name="board_cate_no">
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
						<select name="quiz_name" id="quiz_name"><!-- 시험종류 -->
							<option value="none">선택하세요</option>
							<c:forEach items="${quiz_name}" var="quiz_name">
								<option value="${quiz_name.test_cate_no}">${quiz_name.test_cate}</option>
							</c:forEach>
						
						</select>
						<select name="quiz_year" id="quiz_year"><!-- 시행년도 -->
<!-- 
							<c:forEach items="${year_count}" var="year_count">
								<option value="${year_count.test_year}">${year_count.test_year}</option>
							</c:forEach>
 -->
						</select>
						<select name="quiz_times" id="quiz_times"><!-- 시험회차 -->
						<!-- 
							<c:forEach items="${year_count}" var="year_count">
								<option value="${year_count.test_count}">${year_count.test_count}</option>
							</c:forEach>
						 -->
						</select>
						<select name="quiz_no" id="quiz_no"></select><!-- 문제번호 -->
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
							<p id="quiz_content"></p>
							<p id="opt1"></p>
							<p id="opt2"></p>
							<p id="opt3"></p>
							<p id="opt4"></p>
							<p id="opt5"></p>
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
						<input id="file" type="file" name="uploadFile" accept="image/jpg, image/jpeg, image/png"
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
				<input id="SBsubmit" class="button" type="button" value="등록"
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
var quiz_no = "${quiz_no}";

window.addEventListener('load', function () {
	if(quiz_no > 0){
		$.ajax({
			url : 'quizinfo',
			type : 'get',
			data : {'quiz_no':quiz_no},
			dataType : 'json',
			success : function(data){
				console.log('문제정보 : ',data);
				$('#quiz_name').val(data.quizInfo.test_cate_no).change();
				setTimeout(function() {
					$('#quiz_year').val(data.quizInfo.test_year).change();	
					setTimeout(function() {
						$('#quiz_times').val(data.quizInfo.test_count).change();	
						setTimeout(function() {
							$('#quiz_no').val(data.quizInfo.quiz_no).change();
							setTimeout(function(){
								quiz();
							},100);
						}, 100);

					}, 100);

				}, 100);

			},
			error : function(e){}
			
		});
	}
	  
	});	

$('#quiz_name').change(function(){
	selectYearListCall($(this).val());
});
$('#quiz_year').change(function(){
	selectMonthListCall($(this).val());		
});
$('#quiz_times').change(function(){
	selectCountListCall($(this).val());		
});

function selectYearListCall(test_cate_no){

	$.ajax({
		url : 'selectYearListCall',
		type : 'get',
		data : {'test_cate_no':test_cate_no},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var opt = '<option>------</option>';
			

			data.year.forEach(function(item,idx){
				opt += '<option value="'+item.test_year+'">'+item.test_year+' 년</option>';
				console.log(item);
			});
			$('#quiz_year').empty();
			$('#quiz_times').empty();
			$('#quiz_no').empty();
			$('#quiz_year').append(opt);
		
		},
		error : function(e){console.log(e)},		
	});
};
function selectMonthListCall(test_year){
	console.log(test_year);
	$.ajax({
		url : 'selectMonthListCall',
		type : 'get',
		data : {'test_cate_no':$('#quiz_name').val(),'test_year':test_year},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var opt = '<option>------</option>';
			

			data.count.forEach(function(item,idx){
				opt += '<option value="'+item.test_count+'">'+item.test_count+' 회</option>';
			});
			$('#quiz_times').empty();
			$('#quiz_no').empty();
			$('#quiz_times').append(opt);

		},
		error : function(e){console.log(e)},		
	});
};
function selectCountListCall(test_count){
	$.ajax({
		url : 'selectCountListCall',
		type : 'get',
		data : {'test_cate_no':$('#quiz_name').val(),'test_year':$('#quiz_year').val(),'test_count':test_count},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var opt = '<option>------</option>';
			
		
			data.quiz.forEach(function(item,idx){
				opt += '<option value="'+item.quiz_no+'">'+item.quiz_index+'</option>';
			});
			$('#quiz_no').empty();
			$('#quiz_no').append(opt);
	
		
			
		},
		error : function(e){console.log(e)},		
	});
};

	$('#SBsubmit').click(function(){
		console.log('버튼클릭');
		var title = $('#title').val();
		var blank_pattern = /^\s+|\s+$/g;
		
		if(title.replace(blank_pattern, '') == ""){
			alert("제목을 입력해주세요.");
			$('#title').val('');
			$('#title').focus();
	   }else{
		   console.log('폼 전송');
		   $('#write').submit();
	   }
		
	});
	
	function quiz(){

		
		$.ajax({
			type:'POST',
			url:'selectquiz',
			data:{'quiz_no':$('#quiz_no').val()},
			dataType:'JSON',
			success:function(data){
				console.log('문제가져오기 : ',data);
				$('#quiz_content').html(data.quiz.quiz_content);
				/*
				$('#quiz_content').val(data.quiz_content);
				$('#option1').val(data.option1);
				$('#option2').val(data.option2);
				$('#option3').val(data.option3);
				$('#option4').val(data.option4);
				$('#option5').val(data.option5);//값 없으면 숨기기
				*/
				for (var i = 1; i <= data.quiz.quiz_type; i++) {
					$('#opt'+i).html(i+'번 : '+data.quiz["option"+i]);
				}
				
				
			},
			error:function(e){
				console.log('문제발생: ',e);
			}
		});//ajax괄호끝

	};//quiz() 괄호끝
	
</script>
</html>