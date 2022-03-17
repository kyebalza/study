<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
	table,th,td{
    	border-collapse: separate;    
    	border :1p solid gray;           
    }
	table {
    	border : 1px solid gray;
        text-align: center;
        border-radius: 8px;
    }
	h5{
    	margin : 1px;
        color : gray;
    }
    td{
    	width:150px;
    }
	input[type="number"]{
		border-bottom : 1px solid gray;
    	border-top: none;
        border-left : none;
        border-right: none;
        width : 100px;
        height: 20px;
        text-align : center;
    }
	input[type="text"] {
		border-bottom : 1px solid gray;
        border-top: none;
        border-left : none;
        border-right: none;
        width : 200px;
        height: 20px;
        }
    input[type="checkbox"]{
		width : 15px;
        }    
     input[type="button"]{
		border-color: gray;
        background-color : greenyellow;
        color : black;
        border-radius : 5px;
        width : 50px;
        height : 30px;        
	}
    .photoArea{
    	width: 300px;
        height: 200px;
        border-radius: 5px;
        border : 1px solid gray;
	}
    .quiz_type{
    	width : 215px;
    }
	img{
		width : 250px;
		height : 200px;
	}    
	textarea{
    	width: 300px;
    	height: 100px;
        border-radius: 5px;
        border : 1px solid gray;
    }			
    
	</style>
</head>
<body>
	<div class="">
	<table>
	<tr>

		<td colspan="4" style="text-align : right;"><input type="button" class="quizUpdate" onclick="quizUpdate(this)" value="수정"/></td>
	</tr>
	<tr>
		<td><h5>문제번호</h5><input type="number" min=1 id="quiz_index" value="${quiz_info.quiz_index }"/></td>
		<td><h5>배점</h5><input type="number" min=1 id="quiz_point" value="${quiz_info.quiz_point }"/></td>
		<td><h5>과목선택</h5><select id="subject_cate_no"></select></td>
		<td><h5>세부과목선택</h5><select id="detailed_subject_cate_no"></select></td>
	<tr>
		<td colspan="2">
			<h5>사진</h5>
			<div class="photoArea 0" onclick="photoChildOpen(this)">
			<c:if test="${quiz_info.new_filename ne null}">
				<img src="/photo/${quiz_info.new_filename}"/>
				<input type="hidden" class="quiz_img_newName 0" value="${quiz_info.new_filename }"/>
				<input type="hidden" class="quiz_img_oriName 0" value="${quiz_info.ori_filename }"/>
			</c:if>
			</div>
		</td>
		<td colspan="2" style="vertical-align:text-bottom;">
		<h5>문제유형선택</h5>
		<select id="quiz_type" onchange="selectQuizType(this)">
			<option value="1">주관식</option>
			<option value="2">2지선다</option>
			<option value="3">3지선다</option>
			<option value="4">4지선다</option>
			<option value="5">5지선다</option>
		</select>
		<div id="quiz_type_opt_area"></div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h5>문제내용</h5>
			<textarea id="quiz_content">${quiz_info.quiz_content }</textarea>
		</td>
		<td colspan="2">
		<h5>해설</h5>
		<textarea id="quiz_explation">${quiz_info.quiz_explation }</textarea>
		</td>
	</tr>
	</table>
	</div>
	<div>
	<input type="button" value="목록" onclick="toList()"/>
	</div>


	
</body>
<script>

function toList(){
	if("${sessionScope.prevPage}" == "adminQuizReport"){
		location.href='adminQuizReport';
	} else {
		location.href='adminQuizList';		
	}
}



var test_cate_no = "${quiz_info.test_cate_no}";
var subject_cate_no = "${quiz_info.subject_cate_no}";
var quiz_type = "${quiz_info.quiz_type}"*1;
var before_answer = "${quiz_info.quiz_answer}";
var option = {};
option.option1 = "${quiz_info.option1}";
option.option2 = "${quiz_info.option2}";
option.option3 = "${quiz_info.option3}";
option.option4 = "${quiz_info.option4}";
option.option5 = "${quiz_info.option5}";


subjectCategoryCall(test_cate_no,"subject",$('#subject_cate_no'))
detailSubjectCategoryCall(subject_cate_no,"detailed",$('#detailed_subject_cate_no'));


$('#quiz_type').val(quiz_type);

selectQuizType(document.querySelector('#quiz_type'));
for (var i = 1; i <= quiz_type; i++) {
	$('#option'+i).val(option["option"+i]);
	if(before_answer.includes(String(i))){
		$('#option_yn'+i).prop("checked",true);						
	}
}

function subjectCategoryCall(upperCate,Cate,id){
	var obj = {upperCate:upperCate,Cate:Cate};
	console.log(obj);
	$.ajax({
		url : 'adminSubjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			var txt = '<option value="">-- 과목카테고리 --</option>';
			data.Category.forEach(function(item,idx){
				if(item.subject_cate_no == subject_cate_no){
					txt += '<option value="'+item.subject_cate_no+'" selected>'+item.subject_cate+'</option>';				
				} else {
					txt += '<option value="'+item.subject_cate_no+'">'+item.subject_cate+'</option>';				
				}
			});		
			id.empty();
			id.append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
}
function detailSubjectCategoryCall(upperCate,Cate,id){
	var obj = {upperCate:upperCate,Cate:Cate};
	console.log(obj);
	$.ajax({
		url : 'adminDetailSubjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			
			var txt = '<option value="">-- 시험과목 카테고리 --</option>';
			data.Category.forEach(function(item,idx){
				if(item.detailed_subject_cate_no == "${quiz_info.detailed_subject_cate_no}") {
					txt += '<option value="'+item.detailed_subject_cate_no+'" selected>'+item.detailed_subject_cate+'</option>';
				} else {
					txt += '<option value="'+item.detailed_subject_cate_no+'">'+item.detailed_subject_cate+'</option>';	
				}
								
			});
			id.empty();
			id.append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
}

function selectQuizType(e){
	var inputTxt = '';
	if(e.value == 1){
		console.log(e.value);
		inputTxt += '<input type="text" id="option1"/>';
	} else {
		inputTxt += '<ol>';
		for (var i = 1; i <= e.value; i++) {
		inputTxt += '<li><input type="text" id="option'+i+'"/><input type="checkbox" id="option_yn'+i+'" value="'+i+'"></li>';
		}
		inputTxt += '</ol>';	
	}
	$(e).siblings('div').empty(inputTxt);	
	$(e).siblings('div').append(inputTxt);
}
function photoChildOpen(e){
	console.log(e.classList[1]);
	var photoChild = window.open('adminPhotoChildOpen?quizCnt='+e.classList[1],'사진첨부','width=300,height=300');
}



function quizUpdate(){
	var obj = {};
	obj.quiz_no = "${quiz_info.quiz_no}"
	
	obj.quiz_content = $('#quiz_content').val();
	obj.quiz_explation = $('#quiz_explation').val();
	obj.quiz_index = $('#quiz_index').val();
	obj.quiz_point = $('#quiz_point').val();
	obj.option1 = '';
	obj.option2  = '';
	obj.option3  = '';
	obj.option4  = '';
	obj.option5  = '';
	obj.subject_cate_no = $('#subject_cate_no').val();
	obj.detailed_subject_cate_no = $('#detailed_subject_cate_no').val();
	obj.quiz_type = $('#quiz_type').val();
	obj.before_ori_filename = "${quiz_info.ori_filename}";
	obj.before_new_filename = "${quiz_info.new_filename}";
	obj.new_filename = $('.quiz_img_newName').val();
	obj.ori_filename= $('.quiz_img_oriName').val();
	
	
	var answer = '';
	for (var j = 1; j <= obj.quiz_type; j++) {
		obj["option"+j] = $('#option'+j).val();
	}
	if(obj.quiz_type == 1){
		answer = obj.option1 = $('#option1').val();
	} else {
		for (var k = 1; k <= 5; k++) {
			if($('#option_yn'+k+':checked').val() > 0){
				answer += $('#option_yn'+k+':checked').val();							
			}
		}			
	}
	obj.quiz_answer = answer;

	console.log(obj);
	if(confirm('문제를 수정하시겠습니까?')){
		$.ajax({
			url : 'adminUpdateQuiz',
			type : 'get',
			data : obj,
			dataType : 'json',
			success : function(data){
				console.log(data.msg);
				alert('수정완료되었습니다.')},
			error : function(e){console.log(e)}		
		});
		
	}
	
	
	
}


</script>
</html>