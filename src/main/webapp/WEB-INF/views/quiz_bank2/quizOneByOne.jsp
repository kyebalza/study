<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
	
	<style>
	#all {
		width : 500px;
		height : 500px;
		border : 1px solid gray;
		border-radius : 5px;
		margin-left: auto; 
		margin-right: auto;
	}
	
	#titleArea h2{
		background-color : greenyellow;
	
	}
	#bookMarkArea img{
		width : 20px;
		height : 20px;
	}	
	input[type="checkbox"]{
		border-radius : 5px;
	}
	.view{
		display : none;
	}
	#imgArea img{
	    width: 400px;
    	height: 300px;
	}
	#correct,#correct img{
		width : 10px;
        height : 10px;
		position: absolute;

		top : 5%;
		left : 2%;
        z-index: 3;	
	}
	#worng,#wrong img{
		width : 10px;
        height : 10px;
		position: absolute;

		top : 5%;
		left : 2%;
        z-index: 3;	
	}
	#correct img{
		width : 150px;
		height : 150px;
	}
	#wrong img{
		width : 150px;
		height : 150px;
	}
	</style>
</head>
<body>
<div id="all">
<div id="correct"><img src="resources/img/correct_circle.png"/></div>
<div id="wrong"><img src="resources/img/wrong_x.png"/></div>
<div id="titleArea"></div>
<div id="bookMarkArea"></div>
<div id="subjectArea"></div>
<div id="statisticArea"></div>
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
<div id="answerArea"></div>
<div id="explationArea"></div>
</div>
</body>
<script>
var quiz_list = ${quizNumList}; // 처음 문제 리스트
console.log(JSON.parse("${quizNumList}"));
quiz_call(quiz_list[0]);
var quiz = {};
var quiz_index = 0;
var quiz_state = false;
var loginId = "${sessionScope.loginId}";

if(quiz_list.length == 0){
	alert('문제가 없습니다!');
	window.close();
}






quizState(quiz_state);

function skip(){
	quiz_index += 1;
	if(quiz_index == quiz_list.length){
		alert('모두 다 풀었습니다');
		window.close();
	} else {
		quiz_call(quiz_list[quiz_index]);			
	}
}
function result(){
	quizState(quiz_state = !quiz_state);
	var answer = '';
	if(quiz.quiz_type == 1){
		answer = $('input[type="text"]').val();
	} else {
		for (var i = 1; i <= quiz.quiz_type; i++) {
			if($($('input[type="checkbox"]')[i]).is(":checked")){
				answer += $('input[type="checkbox"]')[i].value;
			}
		}	
	}
	params = {'quiz_no':quiz_list[quiz_index]
			,'answer':answer
			,'test_prac_flag':'연습'}
	if('${sessionScope.loginId eq null}'){
		params.loginId = loginId;
	}
	
	console.log(params);
	$.ajax({
		url : 'quizSolve',
		type : 'get',
		data : params,
		dataType : 'json',
		success : function(data){
			console.log(data);
			if(data.result == 1){
				$('#correct').removeClass('view');
			} else if(data.result == 0){
				$('#wrong').removeClass('view');
			}
			
		},
		error : function(e){console.log(e)}	
	});	
}
function question(){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='studyBoard/writeForm';
}
function error(){
	if('${sessionScope.loginId eq null}'){
		alert('로그인 서비스입니다.');
	} else{
		
		var report_content = prompt('오류내용을 입력해주세요.');

		
		if(report_content  == ''){
			alert('오류내용을 입력해 주세요');
		} else if(report_content == null){
			alert('취소했습니다.');
		} 	else {
			$.ajax({
				url : 'quizErrorReport',
				type : 'get',
				data : {'report_content':report_content,'quiz_no':quiz_list[quiz_index] ,'loginId':loginId,'answer':answer},
				dataType : 'json',
				success : function(data){
					if(data.msg > 0){alert('오류신고가 접수되었습니다.');}
				},
				error : function(e){console.log(e);}
			});	
		}	
	}
}
function nextQuiz(){
	quizState(quiz_state = !quiz_state);
	quiz_index += 1;
	if(quiz_index == quiz_list.length){
		alert('모두 다 풀었습니다');
		window.close();
	} else {
		quiz_call(quiz_list[quiz_index]);		
	}
}


function quizState (quiz_state_bool){
	if(quiz_state_bool){
		$('#skip').addClass('view');
		$('#result').addClass('view');
		$('#question').removeClass('view');
		$('#error').removeClass('view');
		$('#next').removeClass('view');	
		$('#answerArea').removeClass('view');
		$('#explationArea').removeClass('view');
		

	} else {
		$('#skip').removeClass('view');
		$('#result').removeClass('view');
		$('#question').addClass('view');
		$('#error').addClass('view');
		$('#next').addClass('view');	
		$('#correct').addClass('view');
		$('#wrong').addClass('view');
		$('#answerArea').addClass('view');
		$('#explationArea').addClass('view');
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
			$('#titleArea').html('<h2>'+quiz.test_cate+'>'+quiz.subject_cate+'>'+quiz.detailed_subject_cate+'</h2>');
			if(data.book == '1'){
				$('#bookMarkArea').html('<img src="resources/img/별.png" class="bookmark '+quiz.quiz_no+'" onclick="bookMarkChange('+quiz.quiz_no+')"/>');
			} 
			if(data.book == '0'){
				$('#bookMarkArea').html('<img src="resources/img/빈별.png" class="bookmark '+quiz.quiz_no+'" onclick="bookMarkChange('+quiz.quiz_no+')"/>');				
			}
			
			$('#subjectArea').html('<h4>'+quiz.quiz_index+'. '+quiz.quiz_content+'</h4>');
			$('#statisticArea').html('<span>정답률 : '+(data.qos.rightCnt/data.qos.allCnt*100).toFixed()+'%</span>');
			var optTxt = '';
			optTxt += '<ol>';
			if(parseInt(quiz.quiz_type) == 1){
				optTxt = '<input type="text"/>';
			} else  {
				for (var i = 1; i <= parseInt(quiz.quiz_type); i++) {
					optTxt += '<li><input type="checkbox" value="'+i+'"/>'+quiz["option"+i]+'</li>';					
				}
			}
			if(quiz.quiz_type*1 !=1){
				optTxt += '</ol>';				
			}
			$('#optArea').html(optTxt);
			if(data.photo != null){
				$('#imgArea').html('<img id="quiz_photo" src="/photo/'+data.photo+'"/>');		
			}
			
			var ans = '';
			if(quiz.quiz_type > 1){
				for (var i = 0; i < quiz.quiz_type.length; i++) {
					ans += quiz.quiz_answer[i];
					ans += ' ';
				}
			}
			if(quiz.quiz_type == 1){
				ans = quiz.quiz_answer;
			}
			
			$('#answerArea').html('<h3>정답 : '+ans+' 번</h3>');
			$('#explationArea').html('<h3>해설 : '+quiz.quiz_explation+'</h3>')
			
			
		},
		error : function(e){
			console.log(e);
		}
	});
	}
//2.

function bookMarkChange(quiz_no){
	if(${sessionScope.loginId eq null}){
		alert('회원 서비스입니다.');
		console.log();
	} else {
		console.log('${sessionScope.loginId eq null}'+'222');

		$.ajax({
			url : 'bookMarkChange',
			type : 'post',
			data : {'loginId':loginId,'quiz_no':quiz_no},
			dataType : 'json',
			success : function(data){
				if($('.bookmark.'+quiz_no).attr('src') == 'resources/img/빈별.png'){
					$('.bookmark.'+quiz_no).attr('src','resources/img/별.png');
				}else{ 
					$('.bookmark.'+quiz_no).attr('src','resources/img/빈별.png');
				}
			},
			error : function(e){
				console.log(e);
			}
		});		
	}
}

</script>
</html>