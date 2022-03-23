<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		.bookmark{
			width: 30px;
			height: 30px;
			cursor: pointer;
			margin-bottom: 10px;
			align: top;
		}
		.view{
			display : none;
		}
	</style>
</head>
<body>
	<div class="elapse_time">
		${testResult.elapse_time}
	</div>
		<h3>결과페이지입니다.</h3>
			<c:forEach items="${test}" var="test">
			<div class="quiz_form ${test.quiz_index}">
				<hr/>
					<c:choose>
						<c:when test="${test.bookmark_quiz_no != null && test.user_id == loginId}">
							<img class="bookmark" src="resources/img/별.png" alt="북마크">
						</c:when>
						
						<c:otherwise> 
							<img class="bookmark" src="resources/img/빈별.png" alt="빈 북마크">
						</c:otherwise> 
					</c:choose>  
				<br/>
				<c:when test="${test.correct_wrong eq'q' }">
					<div class="correct"><img src="resources/img/correct_circle.png"/></div>
				</c:when>
				<c:otherwise>
					<div class="wrong"><img src="resources/img/wrong_x.png"/></div>
				</c:otherwise>
				<div class="quiz_titleArea">${test.quiz_index}번. ${test.quiz_content}</div>
				<br/>
				<div class="statisticArea">정답률 ${test.percent}%</div>
				<br/>
				<br/>
				<div class="imgArea">사진</div>
				<br/>
				<div class="optArea">
					<c:choose>
						<c:when test="${test.quiz_type eq '1'}">
							<p><input type="text" class="option1"/></p>
						</c:when>
						<c:when test="${test.quiz_type eq '2'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}">①${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}">②${test.option2}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '3'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}">①${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}">②${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}">③${test.option3}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '4'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}">①${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}">②${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}">③${test.option3}</p>
							<p><input type="checkbox" name="answer" value="4" class="option_yn4 ${test.quiz_index}">④${test.option4}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '5'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}">①${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}">②${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}">③${test.option3}</p>
							<p><input type="checkbox" name="answer" value="4" class="option_yn4 ${test.quiz_index}">④${test.option4}</p>
							<p><input type="checkbox" name="answer" value="5" class="option_yn5 ${test.quiz_index}"> ⑤${test.option5}</p>
						</c:when>
						<c:otherwise>
					        <p><input type="hidden" name="answer" value="0"></p>
					    </c:otherwise>
					</c:choose>
				</div>
				<div class="answerArea"><h3>정답 : ${test.quiz_answer}</h3></div>
				<div class="explationArea"><h3>해설 : ${test.quiz_explation}</h3></div>
			</div>
			<input type="button" class="question" onclick="question()" value="질문하기"/>
			<input type="button" class="error" onclick="error()" value="오류신고"/>
		</c:forEach>
</body>
<script>

/////////////////////////////////////////////////////////
var quiz = {}; //quiz의 전역변수 선언 
var quiz_index = 0;// 
var quiz_state = true;//
var loginId = "${sessionScope.loginId}";
quizState(quiz_state);//클래스 상태 바꾸기
var test_no = $('.test_no.1').val();
JSON.stringify(test_no);
//////////////////////////////////////////////////////////////
//버튼바꾸기
function quizState (quiz_state_bool){
	if(quiz_state_bool){
		$('.result').addClass('view');
		$('.question').removeClass('view');
		$('.error').removeClass('view');
		$('.answerArea').removeClass('view');
		$('.explationArea').removeClass('view');
		

	} else {
		$('.result').removeClass('view');
		$('.question').addClass('view');
		$('.error').addClass('view');
		$('.correct').addClass('view');
		$('.wrong').addClass('view');
		$('.answerArea').addClass('view');
		$('.explationArea').addClass('view');
	}
}

/////////////////////////////////////////////////////////////////////////
//문제 보기가 체크되지 않았을경우 기본값
if(document.getElementsByName("answer").checked) {
    document.getElementsByName("answer").disabled = true;
}

///////////////////////////////////////////////////////////////////////////
//하트 클릭 시 찜 추가/삭제
$('.bookmark').click(function(){
	
	if('${loginId}' == ''){ //비회원이면 로그인 페이지로 이동
		alert('로그인이 필요한 서비스 입니다.');
	}else{
				
		var loginId = '${loginId}';
		var quiz_no = $(this).prev().val();
		
		console.log("로그인 아이디 : "+loginId);
		console.log("문제 번호 : "+quiz_no);
		
		var param = {'loginId':loginId,'quiz_no':quiz_no};
		console.log(param);
		
		
		var thissrc = $(this).attr('src');
		
		if(thissrc == 'resources/img/빈별.png'){
			$(this).attr('src','resources/img/별.png');
		}else{ 
			$(this).attr('src','resources/img/빈별.png');
		}
		
		
		
		$.ajax({
			type:'POST',
			url:'bookMarkChange',
			data: param,
			dataType:'JSON',
			success:function(data){
				if(data.success == 1){
					console.log('북마크 추가');
					
				}
				if(data.row2 == 1){
					console.log('북마크 삭제');
				}
			},	
			error:function(e){
				console.log(e);
				alert('서버에 문제가 발생했습니다.');
			}
		}); 
       

	}
});
</script>
</html>