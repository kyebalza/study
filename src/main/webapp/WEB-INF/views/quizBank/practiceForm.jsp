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
		.quiz_form {
			width: 900px;
	    	height: auto;
			border-radius : 5px;
			margin-left: auto; 
			margin-right: auto;
		}
	
		.titleArea h2{
			background-color : greenyellow;
		
		}
		.bookMarkArea img{
			width : 20px;
			height : 20px;
		}	
		input[type="checkbox"]{
			border-radius : 5px;
		}
		.imgArea img{
		    width: 400px;
	    	height: 300px;
		}
		.correct,.correct img{
			width : 10px;
	        height : 10px;
			/*position: absolute;*/
	
			top : 5%;
			left : 2%;
	        z-index: 3;	
		}
		.wrong,.wrong img{
			width : 10px;
	        height : 10px;
			/*position: absolute;*/
	
			top : 5%;
			left : 2%;
	        z-index: 3;	
		}
		.correct img{
			width : 150px;
			height : 150px;
		}
		.wrong img{
			width : 150px;
			height : 150px;
		}
		.test_name{
		    border: solid yellowgreen;
		    text-align: center;
		    background-color: yellowgreen;
		    color: white;
		}
		.score{
			margin: 40px;
		    border: yellowgreen solid;
		    text-align: center;
		    background: yellowgreen;
		    border-radius: 25px;
		    height: 50px;
		    padding: 20px;
		    font-size: 35px;
		    color: white;
		}
		.elapse_time{
			text-align: center;
		    font-size: 23px;
		    color: red;
		}
		.answerArea{
			border: solid greenyellow;
		    text-align: center;
		    background-color: greenyellow;
		    border-radius: 9px;
		    font-size: 20px;
		}
		.explationArea{
			border: solid yellowgreen;
		    text-align: center;
		    background-color: yellowgreen;
		    border-radius: 9px;
		    font-size: 20px;
		    margin-top: 15px;
		    margin-bottom: 15px;
		    padding: 20px;
		    color: white;
		}
		#bntArea{
			text-align: right;
			margin-bottom: 15px;
		}
		.result{
			background-color: #96d36f;
		    border: #96d36f;
		    padding: 10px;
		    border-radius: 8px;
		    cursor: pointer;
		    color: white;
		}
		.statisticArea{
			text-align: right;
		    color: #b9b9b9;
		    font-size: 15px;
		}
		.quiz_titleArea{
			font-size: 20px;
    		font-weight: 600;
		}
		#stopwatch{
			text-align: right;
			padding-right: 50px;
		}
		.bntArea{
			text-align: right;
			margin-bottom: 15px;
		}
		.question{
			background-color: #96d36f;
		    border: #96d36f;
		    padding: 10px;
		    border-radius: 8px;
		    cursor: pointer;
		    color: white;
		}
		.error{
			background-color: #ffac93;
   			border: #ffac93;
		    padding: 10px;
		    border-radius: 8px;
		    cursor: pointer;
		    color: white;
		}
		
	/*?????? ?????? css*/	
	.option_yn1 {
	    display:none;
	}
	.option_yn1 + label {
		display: inline-block;
		background: url("resources/img/1???.png") 0 0 no-repeat;
	 	background-size: cover; 
	 	width: 22px; 
	 	height: 22px; 
	 	cursor:pointer; 
	 	margin-right: 9px;
	 }
	 .option_yn1:checked + label {
	 	background: url("resources/img/????????????.png") 0 0 no-repeat;
	 	background-size: cover; 
	 }
	.option_yn2{
		display: none!important;
	}
	.option_yn2 + label {
		display: inline-block;
		background: url("resources/img/2???.png") 0 0 no-repeat;
	 	background-size: cover; 
	 	width: 22px; 
	 	height: 22px; 
	 	cursor:pointer; 
	 	margin-right: 9px;
	 }
	 .option_yn2:checked + label {
	 	background: url("resources/img/????????????.png") 0 0 no-repeat;
	 	background-size: cover; 
	 }
	.option_yn3{
		display: none!important;
	}
	.option_yn3 + label {
		display: inline-block;
		background: url("resources/img/3???.png") 0 0 no-repeat;
	 	background-size: cover; 
	 	width: 22px; 
	 	height: 22px; 
	 	cursor:pointer; 
	 	margin-right: 9px;
	 }
	 .option_yn3:checked + label {
	 	background: url("resources/img/????????????.png") 0 0 no-repeat;
	 	background-size: cover; 
	 }
	.option_yn4{
		display: none!important;
	}
	.option_yn4 + label {
		display: inline-block;
		background: url("resources/img/4???.png") 0 0 no-repeat;
	 	background-size: cover; 
	 	width: 22px; 
	 	height: 22px; 
	 	cursor:pointer; 
	 	margin-right: 9px;
	 }
	 .option_yn4:checked + label {
	 	background: url("resources/img/????????????.png") 0 0 no-repeat;
	 	background-size: cover; 
	 }
	.option_yn5{
		display: none!important;
	}
	
	.option_yn5 + label {
		display: inline-block;
		background: url("resources/img/5???.png") 0 0 no-repeat;
	 	background-size: cover; 
	 	width: 22px; 
	 	height: 22px; 
	 	cursor:pointer; 
	 	margin-right: 9px;
	 }
	 .option_yn5:checked + label {
	 	background: url("resources/img/????????????.png") 0 0 no-repeat;
	 	background-size: cover; 
	 }
		
		
		
	</style>
</head>
<body>
	<div class="test_name">
		<h1>${test_info.test_year}??? ${test_info.test_count}???  ${test_info.test_cate} [??????]</h1>
		<h1 id="stopwatch">
             <input type="hidden" class="elapse_time">
        </h1>
	</div>
			<c:forEach items="${test}" var="test">
			<input type="hidden" class="test_no ${test.quiz_index}" value="${test.test_no}">
			<!-- ?????? ??? : <c:set var="i" value="${i+1}"/> -->
			<div class="quiz_form ${test.quiz_index}">
			<hr/>
			<input type="hidden" class="quiz_index ${test.quiz_index}" value="${test.quiz_index}">
					<input type="hidden" value="${test.quiz_no}"/>
					<c:choose>
						<c:when test="${test.bookmark_quiz_no != null}">
							<img class="bookmark" src="resources/img/???.png" alt="?????????">
						</c:when>
						
						<c:otherwise> 
							<img class="bookmark" src="resources/img/??????.png" alt="??? ?????????">
						</c:otherwise> 
					</c:choose>  
				<br/>
				<div class="correct" id="correct${test.quiz_index}"></div>
				<div class="wrong" id="wrong${test.quiz_index}"></div>
				<div class="quiz_titleArea"><input type="hidden" class="quiz_no ${test.quiz_index}" value="${test.quiz_no}"> ${test.quiz_index}???. ${test.quiz_content}</div>
				<br/>
				<c:if test="${test.percent != null}">
					<div class="statisticArea">????????? ${test.percent}%</div>
				</c:if>
				<br/>
				<input type="hidden" class="quiz_point ${test.quiz_index}" value="${test.quiz_point}">
				<br/>
				<div class="imgArea">??????</div>
				<br/>
				<!-- ?????? ??? :  <ul class="${test.quiz_no}+'${i}'"> -->
				<div class="optArea">
					<input type="hidden" class="quiz_type ${test.quiz_index}" value="${test.quiz_type}">
					<c:choose>
						<c:when test="${test.quiz_type eq '1'}">
							<p><input type="text" class="option1"/></p>
						</c:when>
						<c:when test="${test.quiz_type eq '2'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}" id="option_yn1 ${test.quiz_index}"><label for="option_yn1 ${test.quiz_index}"></label>${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}" id="option_yn2 ${test.quiz_index}"><label for="option_yn2 ${test.quiz_index}"></label>${test.option2}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '3'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}" id="option_yn1 ${test.quiz_index}"><label for="option_yn1 ${test.quiz_index}"></label>${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}" id="option_yn2 ${test.quiz_index}"><label for="option_yn2 ${test.quiz_index}"></label>${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}" id="option_yn3 ${test.quiz_index}"><label for="option_yn3 ${test.quiz_index}"></label>${test.option3}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '4'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}" id="option_yn1 ${test.quiz_index}"><label for="option_yn1 ${test.quiz_index}"></label>${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}" id="option_yn2 ${test.quiz_index}"><label for="option_yn2 ${test.quiz_index}"></label>${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}" id="option_yn3 ${test.quiz_index}"><label for="option_yn3 ${test.quiz_index}"></label>${test.option3}</p>
							<p><input type="checkbox" name="answer" value="4" class="option_yn4 ${test.quiz_index}" id="option_yn4 ${test.quiz_index}"><label for="option_yn4 ${test.quiz_index}"></label>${test.option4}</p>
						</c:when>
						<c:when test="${test.quiz_type eq '5'}">
							<p><input type="checkbox" name="answer" value="1" class="option_yn1 ${test.quiz_index}" id="option_yn1 ${test.quiz_index}"><label for="option_yn1 ${test.quiz_index}"></label>${test.option1}</p>
							<p><input type="checkbox" name="answer" value="2" class="option_yn2 ${test.quiz_index}" id="option_yn2 ${test.quiz_index}"><label for="option_yn2 ${test.quiz_index}"></label>${test.option2}</p>
							<p><input type="checkbox" name="answer" value="3" class="option_yn3 ${test.quiz_index}" id="option_yn3 ${test.quiz_index}"><label for="option_yn3 ${test.quiz_index}"></label>${test.option3}</p>
							<p><input type="checkbox" name="answer" value="4" class="option_yn4 ${test.quiz_index}" id="option_yn4 ${test.quiz_index}"><label for="option_yn4 ${test.quiz_index}"></label>${test.option4}</p>
							<p><input type="checkbox" name="answer" value="5" class="option_yn5 ${test.quiz_index}" id="option_yn5 ${test.quiz_index}"><label for="option_yn5 ${test.quiz_index}"></label>${test.option5}</p>
						</c:when>
						<c:otherwise>
					        <p><input type="hidden" name="answer" value="0"></p>
					    </c:otherwise>
					</c:choose>
				</div>
				<input type="hidden" class="quiz_answer ${test.quiz_index}" value="${test.quiz_answer}">
				<div class="answerArea"><h3>?????? : ${test.quiz_answer}</h3></div>
				<div class="explationArea"><h3>?????? : ${test.quiz_explation}</h3></div>
				<div class="bntArea">
					<input type="button" class="question" onclick="question(${test.quiz_no})" value="????????????"/>
					<input type="hidden" value="${test.quiz_no}"/>
					<input type="button" class="error" onclick="error()" value="????????????"/>
				</div>
			</div>
			
		</c:forEach>
			<input type="hidden" class="var" value="${i}">
		<div id="bntArea">
			<input type="button" class="result" onclick="result()" value="????????????"/>
		</div>
</body>
<script>



/////////////////////////////////////////////////////////
var quiz = {}; //quiz??? ???????????? ?????? 
var quiz_index = 0;// 
var quiz_state = false;//
var loginId = "${sessionScope.loginId}";
quizState(quiz_state);//????????? ?????? ?????????
var test_no = $('.test_no.1').val();
JSON.stringify(test_no);
var test_time = ${test_info.test_time};//?????? ?????? ????????? ???????????????

///////////////////////////////////////////////////////////////
//????????????
$('.result').click(function(){
	quizState(quiz_state = !quiz_state);// ????????? ?????? ?????????
	var quiz_solve = [];//?????????????????? ????????? ??????
	var all_quiz_cnt = $('div.quiz_form').length;//?????? ????????? ????????? ??????. quizCnt??? ?????? ?????? ??? ??????
	console.log("all_quiz_cnt : "+all_quiz_cnt);
	var obj = {};
	var elapse_time = document.getElementById("stopwatch").innerText;
	console.log(elapse_time);
	
	for (var i = 0; i < all_quiz_cnt; i++) {
		
		var class_num = $('div.quiz_form')[i].classList[1];//????????? ??????	
		obj.quiz_index = $('.quiz_index.'+class_num).val();//????????????
		obj.quiz_no = $('.quiz_no.'+class_num).val();//?????? ????????????
		obj.quiz_point = $('.quiz_point.'+class_num).val();//??????
		obj.quiz_type = $('.quiz_type.'+class_num).val();//????????????
		obj.quiz_answer = $('.quiz_answer.'+class_num).val();//?????? ??????
		

		var answer = '';
		//???????????? : ???????????????
		if(obj.quiz_type == 1){
			answer = obj.option1 = $('.option1.'+class_num).val();
		} else {
			for (var k = 1; k <= 5; k++) {
				if($('.option_yn'+k+'.'+class_num+':checked').val() > 0){
					answer += $('.option_yn'+k+'.'+class_num+':checked').val();
					/////////////////////////////////////////////////////////////
					var grading = $('.option_yn'+k+'.'+class_num+':checked').val();
					var correct = $('.quiz_answer.'+class_num).val();
					if(grading == correct){
						console.log("???????????????"+k);
						$('#correct'+class_num).html('<img src="resources/img/correct_circle.png"/>');
						$('#wrong'+class_num).empty();
					}else{
						$('#wrong'+class_num).html('<img src="resources/img/wrong_x.png"/>');
						$('#correct'+class_num).empty();
					}
				}
			}			
		}
		if(answer == ''){
			answer = "0";
			$('#wrong'+class_num).html('<img src="resources/img/wrong_x.png"/>');
			$('#correct'+class_num).empty();
		}
		obj.my_answer = answer;
		//////////////////////////////////////
		
		quiz_solve.push(JSON.stringify(obj));//?????? ?????? ?????? ??????
		console.log(obj);
	}
	console.log(quiz_solve);
	console.log(JSON.stringify(quiz_solve));
	
	$.ajax({
		url : 'practiceResult',
		type : 'post',
		data : {
			"params":quiz_solve
			,"test_prac_flag":"??????"			
			,"loginId":loginId			
			,"test_no":test_no			
			,"elapse_time":elapse_time			
		},
		dataType : 'JSON',
		success : function(data){
			console.log(data.msg);
			clearTimeout(timerId);//???????????????
		},
		error : function(e){}
	});
});



//////////////////////////////////////////////////////////////////////
//???????????????
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
/* 		$('.correct').addClass('view');
		$('.wrong').addClass('view'); */
		$('.answerArea').addClass('view');
		$('.explationArea').addClass('view');
	}
}

/////////////////////////////////////////////////////////////////////////
//?????? ????????? ???????????? ??????????????? ?????????
if(document.getElementsByName("answer").checked) {
    document.getElementsByName("answer").disabled = true;
}

///////////////////////////////////////////////////////////////////////////
//?????? ?????? ??? ??? ??????/??????
$('.bookmark').click(function(){
	
	if('${loginId}' == ''){ //??????????????? ????????? ???????????? ??????
		alert('???????????? ????????? ????????? ?????????.');
	}else{
				
		var loginId = '${loginId}';
		var quiz_no = $(this).prev().val();
		
		console.log("????????? ????????? : "+loginId);
		console.log("?????? ?????? : "+quiz_no);
		
		var param = {'loginId':loginId,'quiz_no':quiz_no};
		console.log(param);
		
		
		var thissrc = $(this).attr('src');
		
		if(thissrc == 'resources/img/??????.png'){
			$(this).attr('src','resources/img/???.png');
		}else{ 
			$(this).attr('src','resources/img/??????.png');
		}
		
		
		
		$.ajax({
			type:'POST',
			url:'bookMarkChange',
			data: param,
			dataType:'JSON',
			success:function(data){
				if(data.success == 1){
					console.log('????????? ??????');
					
				}
				if(data.row2 == 1){
					console.log('????????? ??????');
				}
			},	
			error:function(e){
				console.log(e);
				alert('????????? ????????? ??????????????????.');
			}
		}); 
       

	}
});

//////////////////////////////////////////////////////////////////
//????????????

		var timerId;
        var time = 0;
        const stopwatch = document.getElementById("stopwatch");
        var  hour, min, sec;
        var timeData = "";

        //?????? ????????????
        function printTime() {
            time++;
            
            var timeData = getTimeFormatString(time);// ????????? ?????? ????????? ????????????
            stopwatch.innerText = timeData;// HTML??? ????????? ?????? ????????????
        }

        test_timer(test_time*1); // <-- test_time(???) * 60  ????????????
        var timeOut;
        function test_timer(test_time){
	        window.onload = function startClock(){
	        	printTime();
	        	timeId = setTimeout(startClock,1000);
		        var time2 = setInterval(function(){
		            if(time == test_time ){
		                clearInterval(timeId);
		            }
		            },test_time*1000);
	        	}
	        
		        timeOut = setTimeout(function(){
		       	alert('????????? ????????? ?????????????????????.');
		       	//$('.result').click();//????????????????????? ??????X
				clearTimeout(timeOut);//????????? ????????????????????? ????????? ?????????
				},test_time*1000);        	
        }
        
        //???????????? ?????? ???????????? , 
		function result(){
			clearInterval(timeId);//???????????????
		}
        

        // ??????(int)??? ???, ???, ??? ???????????? ??????
        function getTimeFormatString(time) {
            var hour = parseInt(String(time / (60 * 60))); //????????? 3600??? ??? ?????? ??? ?????????
            var min = parseInt(String((time - (hour * 60 * 60)) / 60)); //time ?????? ?????? ?????? ???????????? 60?????? ?????????
            var sec = time % 60; // ????????? 60?????? ????????? ??? ?????????

            return String(hour).padStart(2, '0') + ":" + String(min).padStart(2, '0') + ":" + String(sec).padStart(2, '0');
        }
///////////////////////////////////////////////////////////////////////////
      //?????? ????????????
      function question(quiz_no){
      	var openNewWindow = window.open("about:blank");
      	openNewWindow.location.href='studyBoard/writeForm?quiz_no='+quiz_no;
      }
/////////////////////////////////////////////////////////////////////////
//????????????
$('.error').click(function(){
 	  quiz_no = $(this).prev().val();
});
      
function error(){
		console.log("?????? ??????"+quiz_no);
	if(loginId == null){
		alert('????????? ??????????????????.');
	} else{
		
		var report_content = prompt('??????????????? ??????????????????.');
		
		if(report_content  == ''){
			alert('??????????????? ????????? ?????????');
		} else if(report_content == null){
			alert('??????????????????.');
		} 	else {
			$.ajax({
				url : 'quizErrorReport',
				type : 'get',
				data : {'report_content':report_content,'quiz_no':quiz_no ,'loginId':loginId},
				dataType : 'json',
				success : function(data){
					if(data.msg > 0){alert('??????????????? ?????????????????????.');}
				},
				error : function(e){console.log(e);}
			});	
		}	
	}
}
      

</script>
</html>