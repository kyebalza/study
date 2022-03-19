<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
	
	<style>
	#titleArea h2{
		background-color : greenyellow;
	
	}
	img{
		width : 20px;
		height : 20px;
	}	
	input[type="checkbox"]{
		border-radius : 5px;
	}
	.view{
		display : none;
	}
	</style>
</head>
<body>
<div id="tileArea"></div>
<div id="bookMarkArea"></div>
<div id="subjectArea"></div>
<div id="imgArea"></div>
<div id="optArea"></div>
<div id="answerArea"></div>
<div id="explationArea"></div>
<div id="bntArea">
<input type="button" id="skip" onclick="skip()" value="건너뛰기"/>
<input type="button" id="result" onclick="result()" value="결과보기"/>
<input type="button" id="question" onclick="question()" value="질문하기"/>
<input type="button" id="error" onclick="error()" value="오류신고"/>
<input type="button" id="next" onclick="nextQuiz()" value="다음문제"/>
</div>
</body>
<script>
var quiz_list = ${quizNumList}; // 처음 문제 리스트
console.log(JSON.parse("${quizNumList}"));
quiz_call(quiz_list[0]);
var quiz = {};
var quiz_index = 0;
var quiz_state = false;

quizState(quiz_state);
function skip(){
	quiz_index += 1;
	quiz_call(quiz_list[quiz_index]);	
}
function result(){
	quizState(quiz_state = !quiz_state);
}
function question(){
		
}
function error(){

}
function nextQuiz(){
	quizState(quiz_state = !quiz_state);
	quiz_index += 1;
	quiz_call(quiz_list[quiz_index]);
}


function quizState (quiz_state_bool){
	if(quiz_state_bool){
		$('#skip').addClass('view');
		$('#result').addClass('view');
		$('#question').removeClass('view');
		$('#error').removeClass('view');
		$('#next').removeClass('view');				
	} else {
		$('#skip').removeClass('view');
		$('#result').removeClass('view');
		$('#question').addClass('view');
		$('#error').addClass('view');
		$('#next').addClass('view');			
	}
}




function quiz_call(quiz_no){
	$.ajax({
		url : 'quiz_call',
		type : 'get',
		data : {'quiz_no':quiz_no},
		dataType : 'json',
		success : function(data){
			quiz = data.quiz;
			console.log(data);
			$('#tileArea').html('<h2>'+quiz.test_cate+'>'+quiz.subject_cate+'>'+quiz.detailed_subject_cate+'</h2>');
			$('#bookMarkArea').html('<img src="resources/img/별.png" class="bookmark '+quiz.quiz_no+'" onclick="bookMarkChange('+quiz.quiz_no+')"/>');
			$('#subjectArea').html('<h4>'+quiz.quiz_index+'. '+quiz.quiz_content+'</h4>');
			var optTxt = '';
			optTxt += '<ol>';
			if(parseInt(quiz.quiz_type) == 1){
				optTxt = '<input type="text"/>';
			} else  {
				for (var i = 1; i <= parseInt(quiz.quiz_type); i++) {
					optTxt += '<li><input type="checkbox"/>'+quiz["option"+i]+'</li>';					
				}
			}
			if(quiz.quiz_type*1 !=1){
				optTxt += '</ol>';				
			}
			$('#optArea').html(optTxt);
			if(data != null){
				$('#imgArea').html('<img src='+data.photo+'/>')				
			}
		},
		error : function(e){
			console.log(e);
		}
	});
	}
//2.



</script>
</html>