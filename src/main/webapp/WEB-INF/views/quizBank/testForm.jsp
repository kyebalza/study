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

	<div>
		<h1 id="stopwatch">
             <input type="hidden" class="elapse_time">
        </h1>
	</div>
		<h3>시험페이지입니다.</h3>
			<c:forEach items="${test}" var="test">
			<!-- 지울 것 : <c:set var="i" value="${i+1}"/> -->
			<div class="quiz_form ${test.quiz_index}">
			<input type="hidden" class="quiz_index ${test.quiz_index}" value="${test.quiz_index}">
				<hr/>
					<!-- 지울 것 :  <input type="hidden" value="${test.quiz_no}"/> -->
					<c:choose>
						<c:when test="${test.bookmark_quiz_no != null && test.user_id == loginId}">
							<img class="bookmark" src="resources/img/별.png" alt="북마크">
						</c:when>
						
						<c:otherwise> 
							<img class="bookmark" src="resources/img/빈별.png" alt="빈 북마크">
						</c:otherwise> 
					</c:choose>  
				<br/>
				<div class="correct"><img src="resources/img/correct_circle.png"/></div>
				<div class="wrong"><img src="resources/img/wrong_x.png"/></div>
				<div class="quiz_titleArea"><input type="hidden" class="quiz_no ${test.quiz_index}" value="${test.quiz_no}"> ${test.quiz_index}번. ${test.quiz_content}</div>
				<br/>
				<div class="statisticArea">정답률 ${test.percent}%</div>
				<br/>
				<input type="hidden" class="quiz_point ${test.quiz_index}" value="${test.quiz_point}">
				<br/>
				<div class="imgArea">사진</div>
				<br/>
				<!-- 지울 것 :  <ul class="${test.quiz_no}+'${i}'"> -->
				<div class="optArea">
					<input type="hidden" class="quiz_type ${test.quiz_index}" value="${test.quiz_type}">
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
				<input type="hidden" class="quiz_answer ${test.quiz_index}" value="${test.quiz_answer}">
				<div class="answerArea"><h3>정답 : ${test.quiz_answer}</h3></div>
				<div class="explationArea"><h3>해설 : ${test.quiz_explation}</h3></div>
			</div>
			<input type="button" class="question" onclick="question()" value="질문하기"/>
			<input type="button" class="error" onclick="error()" value="오류신고"/>
		</c:forEach>
			<input type="hidden" class="var" value="${i}">
		<div id="bntArea">
			<input type="button" class="result" onclick="result()" value="결과보기"/>
		</div>
</body>
<script>



/////////////////////////////////////////////////////////
var quiz = {}; //quiz의 전역변수 선언 
var quiz_index = 0;// 
var quiz_state = false;//
var loginId = "${sessionScope.loginId}";
quizState(quiz_state);//클래스 상태 바꾸기

///////////////////////////////////////////////////////////////
//체점하기
$('.result').click(function(){
	quizState(quiz_state = !quiz_state);// 클래스 상태 바꾸기
	var quiz_solve = [];//개별문제결과 테이블 저장
	var all_quiz_cnt = $('div.quiz_form').length;//문제 양식의 갯수를 센다. quizCnt는 문제 있을 수 있음
	console.log("all_quiz_cnt : "+all_quiz_cnt);
	var obj = {};
	
	
	for (var i = 0; i < all_quiz_cnt; i++) {
		
		var class_num = $('div.quiz_form')[i].classList[1];//클래스 번호	
		obj.quiz_index = $('.quiz_index.'+class_num).val();//문제번호
		obj.quiz_no = $('.quiz_no.'+class_num).val();//문제 식별번호
		obj.quiz_point = $('.quiz_point.'+class_num).val();//배점
		obj.quiz_type = $('.quiz_type.'+class_num).val();//문제유형
		obj.quiz_answer = $('.quiz_answer.'+class_num).val();//문제 정답
		
		///////////////////////////////////
/*		없어도 되나??
		obj.option1 = '';
		obj.option2  = '';
		obj.option3  = '';
		obj.option4  = '';
		obj.option5  = '';
		for (var j = 1; j <= obj.quiz_type; j++) {
			obj["option"+j] = $('.option'+j+'.'+class_num).val();
		}
*/		
		/////////////////////////////////////////////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!현재 여기까지 진행 $(e)[0].classList[1] 이게 뭐지????????
		var answer = '';
		//정답저장 : 주관식일때
		if(obj.quiz_type == 1){
			answer = obj.option1 = $('.option1.'+class_num).val();
		} else {
			for (var k = 1; k <= 5; k++) {
				if($('.option_yn'+k+'.'+class_num+':checked').val() > 0){
					answer += $('.option_yn'+k+'.'+class_num+':checked').val();							
				}
			}			
		}
		if(answer == ''){
			answer = "0";
		}
		obj.my_answer = answer;
		//////////////////////////////////////
		
		quiz_solve.push(JSON.stringify(obj));//개별 문제 풀이 저장
		console.log(obj);
	}
	console.log(quiz_solve);
	console.log(JSON.stringify(quiz_solve));
	
	$.ajax({
		url : 'testResult',
		type : 'get',
		data : {
			//"test_info":JSON.stringify(test_obj),
			"params":quiz_solve
			,"test_prac_flag":"시험"			
			,"loginId":loginId			
			//,"elapse_time":elapse_time			
		},
		dataType : 'JSON',
		success : function(data){
			console.log(data.msg);
		},
		error : function(e){}
	});
});



//////////////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////////
//스톱워치

		var timerId;
        var time = 0;
        const stopwatch = document.getElementById("stopwatch");
        var  hour, min, sec;
        var timeData = "";

        //시간 보여주기
        function printTime() {
            time++;
            
            var timeData = getTimeFormatString(time);// 변환한 시간 변수에 넣어주기
            stopwatch.innerText = timeData;// HTML에 변환한 시간 넣어주기
        }

        //시계 시작 -> 3초 후 페이지 이동
        window.onload = function startClock() {
            printTime();
            timerId = setTimeout(startClock, 1000);
            setTimeout(function postTime() {
                clearTimeout(timerId);// 시간 멈추기
                // 데이터 보내기 추가 할 것!!(데이터 전송 버튼 시작)
                location.href="testDetail?test_cate_no=${test_name.test_cate_no}";// 임시 페이지 이동(결과페이지로 연결할 것)
                alert('시험이 종료되었습니다');
            }, 100*60*1000); // 100분 후 알림창
        }

        // 시간(int)을 시, 분, 초 문자열로 변환
        function getTimeFormatString(time) {
            var hour = parseInt(String(time / (60 * 60))); //시간을 3600초 로 바꾼 뒤 나누기
            var min = parseInt(String((time - (hour * 60 * 60)) / 60)); //time 에서 시간 빼고 나머지를 60으로 나누기
            var sec = time % 60; // 시간을 60으로 나눴을 때 나머지

            return String(hour).padStart(2, '0') + ":" + String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
        }

</script>
</html>