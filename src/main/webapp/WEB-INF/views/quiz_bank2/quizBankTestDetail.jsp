<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		#header{
			width: 100%;
			height: 100px;
			/* border-style: none; */
			overflow: hidden;
		}	
		body {
			margin : 0px;
		}	
		table, th, td{
			border-top : 1px solid white;
			border-bottom : 1px solid white;
			border-collapse: collapse;
			padding: 5px;
		}
		th {
		 background-color : #7cc35d; 
		 color : white; 
		 font-weight : bold;
		}
		td {
		 background-color : #e9e9e9; 
		 color : gray; 
		 font-weight : bold;
		}
		

		.quizPage{
			height: 40px;
			color : black;
			
		}
		
		.quizPage input{
			height : 40px;
			/*
			background-color : BEFABF;
			*/
			border : none;
			width : 156px;
			padding : 0px;
			margin : 0px;
				
		}
		.onClk{
			color : white;
			background-color : #7cc35d; 
			font-weight : bold;
		}	
			
		#listArea img{
			width : 20px;
			height : 20px;
		}
		span{
			font-size : 3px;
		}
		.testList input[type="button"]{
			border-radius : 5px;
			border : none;
			color : white;
		}
		.testList input[value="시험보기"]{
			background-color : #fb84ac;
			cursor: pointer;
		}
		.testList input[value="연습하기"]{
			background-color : CornflowerBlue;
			cursor: pointer;
		}
		th input[value="문제풀기"]{
			background-color : #fb84ac;
			cursor: pointer;
		}
		td input[value="문제풀기"]{
			background-color : CornflowerBlue;
			cursor: pointer;		
		}
		table{
			width : 480px;
		}
		#all2{
			width : 500px;
		}
		#listBtnArea{
			width : 450px;
			text-align : right;
		}
		
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="all2"  style="margin-left: auto; margin-right: auto;">
<h3 style="text-align : center">${test_category.test_cate}</h3>
 <div class="quizPage">
	<input type="button" id="countListBtn" class="" value="회차별 문제풀기" onclick="testCountListCall(this)"/>
	<input type="button" id="subjectListBtn" class="" value="과목별 문제풀기" onclick="subjectListCall(this)"/>
	<input type="button" id="bookMarkListBtn" class="" value="북마크 문제풀기" onclick="bookmarkListCall(this)"/> 
 </div>
	<div class="testList">
		<table>
			<!-- <thead>
				<tr>
					<th colspan="6">${test_category.test_cate}</th>
				</tr>
			</thead> -->
			<tbody id="listArea">
			
			</tbody>

		</table>	
	</div>
	<div id="listBtnArea">
		<button onclick="location.href='quizBankList'">리스트</button>
	</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>	
</body>
<script>
var test_cate = "${test_category.test_cate}"
var test_cate_no = "${test_category.test_cate_no}";
var loginId = "${sessionScope.loginId}";

$('#countListBtn').click();

function testCountListCall(e){
	
	$($('.quizPage input[type="button"]')[0]).addClass('onClk');
	$($('.quizPage input[type="button"]')[1]).removeClass('onClk');
	$($('.quizPage input[type="button"]')[2]).removeClass('onClk');
	
	
	$.ajax({
		url : 'testCountListCall',
		type : 'get',
		data : {"test_cate_no":test_cate_no},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var txt = '<tr><th colspan="3">'+test_cate+'</th></tr>';
			data.testCountList.forEach(function(item,idx){
				txt += '<tr>';
				txt += '<td>';
				txt += item.test_year+'년 '+item.test_count+'회 '+test_cate;
				txt += '</td>';
				txt += '<td style="text-align : center;" ><input type="button" value="시험보기" onclick="testForm('+item.test_no+')"/></td>';
				txt += '<td style="text-align : center;" ><input type="button" value="연습하기" onclick="practiceForm('+item.test_no+')"/></td>';

			});
			$('#listArea').empty();
			$('#listArea').append(txt);
		},
		error : function(e){console.log(e)}		
	});
}

function practiceForm(test_no){
	location.href='practiceForm?test_no='+test_no;
	
}

function subjectListCall(){
	$($('.quizPage input[type="button"]')[0]).removeClass('onClk');
	$($('.quizPage input[type="button"]')[1]).addClass('onClk');
	$($('.quizPage input[type="button"]')[2]).removeClass('onClk');
	
	$.ajax({
		url : 'subjectListCall',
		type : 'get',
		data : {"test_cate_no":test_cate_no},
		dataType : 'json',
		success : function(data){
			console.log(data);
			var txt = '';
			
			data.subjectList.forEach(function(item,idx){
				var subjectCorrectPer =' -';
				if(item.AllCnt > 0){
					subjectCorrectPer = (item.rightCnt/(item.AllCnt)*100).toFixed() + '%';
				}				
				txt += '<tr>';
				txt += '<th>'+item.subject_cate+'</th>';
				txt += '<th><span>나의 정답률  </span> '+subjectCorrectPer +'</th>';
				txt += '<th style="text-align : center;"><input type="button" value="문제풀기" onclick="subjectOnebyOne('+item.subject_cate_no+')"/><input type="button" style="background-color:LimeGreen;" class="'+item.subject_cate_no+'" onclick="detailView(this)" value="▲"/></th>';
				txt += '</tr>';
				data.detailedSubjectList.forEach(function(item2,idx2){
					var detailedSubjectCorrectPer =' -';
					if(item2.AllCnt > 0){
						detailedSubjectCorrectPer = (item2.rightCnt/(item2.AllCnt)*100).toFixed() + '%';
					}					
					if(item.subject_cate_no == item2.subject_cate_no){
						txt +='<tr class="'+item.subject_cate_no+'">';
						txt +='<td>'+item2.detailed_subject_cate+'</td>';
						txt +='<td><span>나의 정답률  </span> '+detailedSubjectCorrectPer +'</td>';
						txt +='<td><input type="button" value="문제풀기" onclick="detailedOnebyOne('+item2.detailed_subject_cate_no+')"/></td>';
						txt +='</tr>';	
					}
				});				
				$('#listArea').empty();
				$('#listArea').append(txt);
			});
			
		},
		error : function(e){console.log(e)}		
	});
}
function bookmarkListCall(){
	var yn = ${sessionScope.loginId eq null};
	if(yn){
		alert('로그인이 필요한 기능입니다.');
	} else {
		$($('.quizPage input[type="button"]')[0]).removeClass('onClk');
		$($('.quizPage input[type="button"]')[1]).removeClass('onClk');
		$($('.quizPage input[type="button"]')[2]).addClass('onClk');
		$.ajax({
			url : 'bookmarkListCall',
			type : 'get',
			data : '',
			dataType : 'json',
			success : function(data){
				console.log(data);
				var txt = '<tr><th colspan="5">북마크 문제</th><th style="text-align : center;"><input type="button" value="문제풀기" onclick="bookMarkOneByOne()"/></th></tr>';
				data.bookMarkList.forEach(function(item,idx){
					console.log(item);
					txt += '<tr>';
					txt += '<td colspan="5">';
					txt += '<img src="resources/img/별.png" class="bookmark '+item.quiz_no+'" onclick="bookMarkChange('+item.quiz_no+')"/>';
					txt += item.test_year+'년 '+item.test_count+'회 '+test_cate+' '+item.quiz_no;
					txt += '</td>';
					txt += '<td style="text-align : center;"><input type="button" value="문제풀기" onclick="bookMarkOne('+item.quiz_no+')"/></td>';
					txt += '</tr>';
				});
				$('#listArea').empty();
				$('#listArea').append(txt);
			},
			error : function(e){console.log(e)}		
		});
	}
	
	
}



function detailView(e){
	console.log(e);
	console.log($('tr.'+e.classList[0]));
	$('tr.'+e.classList[0]).toggle(100,function(){});
	if(e.value == '▼'){
		$(e).val('▲');				
		//$('tr.'+e.classList[0]).css('display','');
	}else {
		$(e).val('▼');	
		//$('tr.'+e.classList[0]).css('display','none');
	}
	
}

function bookMarkChange(quiz_no){
	if($('.bookmark.'+quiz_no).attr('src') == 'resources/img/빈별.png'){
		$('.bookmark.'+quiz_no).attr('src','resources/img/별.png');
	}else{ 
		$('.bookmark.'+quiz_no).attr('src','resources/img/빈별.png');
	}
	$.ajax({
		url : 'bookMarkChange',
		type : 'post',
		data : {'loginId':loginId,'quiz_no':quiz_no},
		dataType : 'json',
		success : function(data){
		},
		error : function(e){
			console.log(e);
		}
	});
}


function subjectOnebyOne(no){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='quizOneByOne?table_type=subject&no='+no;
	}
function detailedOnebyOne(no){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='quizOneByOne?table_type=detailedSubject&no='+no;
	}
function bookMarkOneByOne(no){	
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='quizOneByOne?table_type=bookmark&no='+no;
	}
function bookMarkOne(no){	
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='quizOneByOne?table_type=quiz&no='+no;
}
function testForm(no){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='testForm?test_no='+no;	
}
function practiceForm(no){
	var openNewWindow = window.open("about:blank");
	openNewWindow.location.href='practiceForm?test_no='+no;	
}
</script>
</html>