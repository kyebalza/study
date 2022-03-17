<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table, th, td{
			border : 1px solid black;
			border-collapse: collapse;
			padding: 5px;
		}
		
		.onClk{
			color : red;
			background-color : blue;
		
		}
		
	</style>
</head>
<h3>${test_name.test_cate} 시험 상세보기 페이지 입니다.</h3>

<!-- 검색기능인데 지울 것
	<form action="test_search" method="get">
		<fieldset>
			<select name="opt">
				<option value="test_year">시험년도</option>
				<c:forEach items="${test}" var="test">
					<option value="${test.test_year}">${test.test_year}</option>
				</c:forEach>
			</select>
			<select name="opt2">
				<option value="test_count">시험회차</option>
				<c:forEach items="${test}" var="test">
					<option value="${test.test_count}">${test.test_count}</option>
				</c:forEach>
			</select>
			<button>검색</button>
		</fieldset>	
	</form>
 -->
 <div class="quizPage">
	<input type="button" id="countListBtn" class="" value="회차별 문제풀기" onclick="testCountListCall(this)"/>
	<input type="button" id="subjectListBtn" class="" value="과목별 문제풀기" onclick="subjectListCall(this)"/>
	<input type="button" id="bookMarkListBtn" class="" value="북마크 문제풀기" onclick="bookmarkListCall(this)"/> 
 </div>
<body>
	<div class="testList">
		<table>
			<thead>
				<tr>
					<th colspan="4">${test_category.test_cate}</th>
				</tr>
			</thead>
			<tbody id="listArea">
			
			</tbody>

		</table>	
	</div>
	
	<button onclick="location.href='quizBankList'">리스트</button>
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
			var txt = '';
			data.testCountList.forEach(function(item,idx){
				txt += '<tr>';
				txt += '<td>';
				txt += item.test_year+'년 '+item.test_count+'회 '+test_cate;
				txt += '</td>';
				txt += '<td><input type="button" value="시험보기"/></td>';
				txt += '<td><input type="button" value="연습하기"/></td>';

			});
			$('#listArea').empty();
			$('#listArea').append(txt);
		},
		error : function(e){console.log(e)}		
	});
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
				var subjectCorrectPer ='없음';
				if(item.AllCnt > 0){
					subjectCorrectPer = (item.rightCnt/(item.AllCnt)*100).toFixed() + '%';
				}				
				txt += '<tr style="background-color : lightgreen;">';
				txt += '<td>'+item.subject_cate+'</td>';
				txt += '<td>정답률 '+subjectCorrectPer +'</td>';
				txt += '<td><input type="button" onclick="" value="시험보기"/><input type="button" class="'+item.subject_cate_no+'" onclick="detailView(this)" value="▲"/></td>';
				data.detailedSubjectList.forEach(function(item2,idx2){
					var detailedSubjectCorrectPer ='없음';
					if(item2.AllCnt > 0){
						detailedSubjectCorrectPer = (item2.rightCnt/(item2.AllCnt)*100).toFixed() + '%';
					}					
					if(item.subject_cate_no == item2.subject_cate_no){
						txt +='<tr class="'+item.subject_cate_no+'">';
						txt +='<td>'+item2.detailed_subject_cate+'</td>';
						txt +='<td>정답률 '+detailedSubjectCorrectPer +'</td>';
						txt += '<td><input type="button" value="시험보기"/></td>';
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
			var txt = '';
			data.bookMarkList.forEach(function(item,idx){
				txt += '<tr>';
				txt += '<td>';
				txt += item.test_year+'년 '+item.test_count+'회 '+test_cate+' '+item.quiz_no;
				txt += '</td>';
				txt += '<td><input type="button" value="문제풀기"/></td>';
			});
				$('#listArea').empty();
				$('#listArea').append(txt);
		},
		error : function(e){console.log(e)}		
	});
}


function detailView(e){
	console.log(e);
	console.log($('tr.'+e.classList[0]));
	$('tr.'+e.classList[0]).slideToggle();
	if(e.value == '▼'){
		$(e).val('▲');				
		//$('tr.'+e.classList[0]).css('display','');
	}else {
		$(e).val('▼');	
		//$('tr.'+e.classList[0]).css('display','none');
	}
	
}





</script>
</html>