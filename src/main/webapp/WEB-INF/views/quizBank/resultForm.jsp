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
		.statisticArea{
			text-align: right;
		    color: #b9b9b9;
		    font-size: 15px;
		}
		.quiz_titleArea{
			font-size: 20px;
    		font-weight: 600;
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
	</div>
	<div class="score">
		<c:choose>
			<c:when test="${test_info.test_cate_pass <= testResult.score}">
				?????? [ ${testResult.score}??? ]
			</c:when>
			<c:otherwise>
				????????? [ ${testResult.score}??? ]
			</c:otherwise>
		</c:choose>
	</div>
	<div class="elapse_time">
		 ???????????? : ${testResult.elapse_time}
	</div>
			<c:forEach items="${test}" var="test">
				<input type="hidden" value="${test.quiz_no}"/>
			<div class="quiz_form ${test.quiz_index}">
				<hr/>
			
				<c:choose>
					<c:when test="${test.correct_wrong eq true}">
						<div class="correct"><img src="resources/img/correct_circle.png"/></div>
					</c:when>
					<c:otherwise>
						<div class="wrong"><img src="resources/img/wrong_x.png"/></div>
					</c:otherwise>
				</c:choose>
				<br/>
				<input type="hidden" class="quiz_index ${test.quiz_index}" value="${test.quiz_index}">
				<input type="hidden" value="${test.quiz_no}"/>
				<c:choose>
					<c:when test="${test.bookmark_quiz_no != null && test.user_id == loginId}">
						<img class="bookmark" src="resources/img/???.png" alt="?????????">
					</c:when>
					
					<c:otherwise> 
						<img class="bookmark" src="resources/img/??????.png" alt="??? ?????????">
					</c:otherwise> 
				</c:choose>  
				<div class="quiz_titleArea"><input type="hidden" class="quiz_no ${test.quiz_index}" value="${test.quiz_no}">${test.quiz_index}. ${test.quiz_content}</div>
				<br/>
				<c:if test="${test.percent != null}">
					<div class="statisticArea">????????? ${test.percent}%</div>
				</c:if>
				<br/>
				<br/>
				<c:if test="${test.photo != null}">
					<div class="imgArea"><img class="quiz_photo" src="/photo/${test.photo}" alt="quiz_img"/></div>
				</c:if>
				<br/>
				<div class="optArea">
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
				<div class="answerArea">?????? : ${test.quiz_answer}</div>
				<div class="explationArea">?????? : ${test.quiz_explation}</div>
			<div class="bntArea">
				<input type="button" class="question" onclick="question(${test.quiz_no})" value="????????????"/>
				<input type="hidden" value="${test.quiz_no}"/>
				<input type="button" class="error" onclick="error()" value="????????????"/>
			</div>
			</div>
		</c:forEach>
</body>
<script>

/////////////////////////////////////////////////////////
var quiz = {}; //quiz??? ???????????? ?????? 
var quiz_index = 0;// 
var quiz_state = true;//
var loginId = "${sessionScope.loginId}";
quizState(quiz_state);//????????? ?????? ?????????
var test_no = $('.test_no.1').val();
JSON.stringify(test_no);
//////////////////////////////////////////////////////////////
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
		$('.correct').addClass('view');
		$('.wrong').addClass('view');
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
///////////////////////////////////////////////////////////////////////////
//?????? ????????????
function question(quiz_no){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='studyBoard/writeForm?quiz_no='+quiz_no;
}
///////////////////////////////////////////////////////////////////////////
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
				data : {'report_content':report_content,'quiz_no':quiz_no ,'user_id':loginId},
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