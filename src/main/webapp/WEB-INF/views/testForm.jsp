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
	</style>
</head>
<body>

	<div>
		<h1 id="stopwatch">
                스톱워치
        </h1>
	</div>
	<h3>시험페이지입니다.</h3>
		
		<c:forEach items="${test}" var="test">
			<hr/>
				<input type="hidden" value="${test.quiz_no}"/>
				<c:choose>
					<c:when test="${test.bookmark_quiz_no != null && test.user_id == loginId}">
						<img class="bookmark" src="resources/img/별.png" alt="북마크">
					</c:when>
					
					<c:otherwise> 
						<img class="bookmark" src="resources/img/빈별.png" alt="빈 북마크">
					</c:otherwise> 
				</c:choose>  
			<br/>
			<div >
				<div>${test.quiz_index}번. ${test.quiz_content}</div>
				<br/>
				<div>정답률</div>
				<br/>
				<div>사진</div>
				<br/>
				<ul>
					<li>①${test.option1}</li>
					<li>②${test.option2}</li>
					<li>③${test.option3}</li>
					<li>④${test.option4}</li>
				</ul>
			</div>
		</c:forEach>
</body>
<script>
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
            
            timeData = getTimeFormatString();// 변환한 시간 변수에 넣어주기
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
            }, 1*60*1000); // 1분 후 알림창
        }

        // 시간(int)을 시, 분, 초 문자열로 변환
        function getTimeFormatString() {
            var hour = parseInt(String(time / (60 * 60))); //시간을 3600초 로 바꾼 뒤 나누기
            var min = parseInt(String((time - (hour * 60 * 60)) / 60)); //time 에서 시간 빼고 나머지를 60으로 나누기
            var sec = time % 60; // 시간을 60으로 나눴을 때 나머지

            return String(hour).padStart(2, '0') + ":" + String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
        }

</script>
</html>