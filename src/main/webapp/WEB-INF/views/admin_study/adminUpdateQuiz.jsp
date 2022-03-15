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

		<td colspan="4" style="text-align : right;"><input type="button" class="quizUpdate" onclick="quizFormDelete(this)" value="수정"/></td>
	</tr>
	<tr>
		<td><h5>문제번호</h5><input type="number" min=1 class="quiz_index" value="${quiz_info.quiz_no }"/></td>
		<td><h5>배점</h5><input type="number" min=1 class="quiz_point" value="${quiz_info.quiz_point }"/></td>
		<td><h5>과목선택</h5><select id="quiz_subject"></select></td>
		<td><h5>세부과목선택</h5><select id="quiz_detailed_subject"></select></td>
	<tr>
		<td colspan="2">
			<h5>사진</h5>
			<div class="photoArea" onclick="photoChildOpen(this)">
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
		<div class="quiz_type_opt_area"></div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h5>문제내용</h5>
			<textarea class="quiz_content">${quiz_info.quiz_content }</textarea>
		</td>
		<td colspan="2">
		<h5>해설</h5>
		<textarea class="quiz_explation">${quiz_info.quiz_explation }</textarea>
		</td>
	</tr>
	</table>
	</div>


	
</body>
<script>
var test_cate_no = "${quiz_info.test_cate_no}";
var subject_cate_no = "${quiz_info.subject_cate_no}"
console.log(test_cate_no);
subjectCategoryCall(test_cate_no,"subject",$('#quiz_subject'))
detailSubjectCategoryCall(subject_cate_no,"detailed",$('#quiz_detailed_subject'));


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
function quiz_typeCategoryCall(){
	var txt = '';
	
	for (var i = 0; i < 5; i++) {
		
	}
	
	$('#quiz_type').html();
	
}



</script>
</html>