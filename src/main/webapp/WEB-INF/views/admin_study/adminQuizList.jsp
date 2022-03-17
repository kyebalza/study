<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
	<script src="resources/js/jquery.twbsPagination.js"></script>
<!-- 	<link rel="stylesheet" href="resources/css/common.css" type="text/css"/> -->
	<style>
	#searchBar h5{
		font-size : 5px;
		text-align : left;
		margin : 0px;
		color : gray;
	}
	table,th,td {
	 border : 1px solid gray;
	 border-collapse : collapse;
	 font-size : 9px;
		
	}
	.quiz_content a{
		color : red;
		width : 300px;
		display : inline-block;
		test-overflow : ellipsis;
		overflow : hidden;
		white-space:nowrap;
		word-wrap : break-word;
	}
	
	</style>
</head>
<body>

<div id="searchBar">
<table>
	<tr>
		<th><h5>시험</h5><select id="test_cate_no"></select></th><!-- 시험 -->
		<th><h5>연도</h5><select id="test_year"></select></th><!-- 년도 -->
		<th><h5>회차</h5><select id="test_count"></select></th><!-- 회차 -->
		<th><h5>과목</h5><select id="subject_cate_no"></select></th><!-- 과목 -->
		<th><h5>세부과목</h5><select id="detailed_subject_cate_no"></select></th><!-- 세부과목 -->
	</tr>
	<tr>
		<th colspan="4"><input type="text" id="quiz_content" placeholder="문제 내용을 입력해주세요"/></th>
		<th><input type="button" value="신규문제등록" onclick="location.href='adminRegistTest'"/></th>
	</tr>
</table>
</div>
<div>
<table>
	<thead>
		<tr>
			<th>문제ID</th>
			<th>연도</th>
			<th>월</th>
			<th>회차</th>
			<th>번호</th>
			<th>시험</th>
			<th>과목</th>
			<th>세부과목</th>
			<th>문제내용</th>
			<th>문제해설</th>
			<th>유형</th>
			<th>배점</th>
			<th>보기1</th>
			<th>보기2</th>
			<th>보기3</th>
			<th>보기4</th>
			<th>보기5</th>
			<th>정답</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id="quizList">
	</tbody>
	<tbody>
	<tr>
		<td colspan="19" id="paging">
            <div class="container">                           
               <nav aria-label="Page navigation" style="text-align:center">
                  <ul class="pagination" id="pagination"></ul>
               </nav>               
            </div>
		</td>
	</tr>	
	</tbody>
</table>
</div>
	
</body>
<script>
var currPage = 1;
var totalPage = 2;

testCategoryCall("0","test",$('#test_cate_no'));


$('#test_cate_no').change(function(){
	search(currPage,10);

	
});
$('#test_year').change(function(){
	search(currPage,10);

});
$('#test_count').change(function(){
	search(currPage,10);

});
$('#subject_cate_no').change(function(){
	search(currPage,10);

});
$('#detailed_subject_cate_no').change(function(){
	search(currPage,10);

});
$('#quiz_content').keyup(function(){
	search(currPage,10);

});
search(currPage,10);

function search(page,cnt){
	var search_info = {};
	search_info.test_cate_no = $('#test_cate_no').val();
	search_info.test_year = $('#test_year').val();
	search_info.test_count = $('#test_count').val();
	search_info.subject_cate_no = $('#subject_cate_no').val();
	search_info.detailed_subject_cate_no = $('#detailed_subject_cate_no').val();
	search_info.quiz_content = $('#quiz_content').val();
	search_info.page = page;
	search_info.cnt = cnt;
	
	console.log(search_info);
	$.ajax({
		url : 'adminSearchQuiz',
		type : 'get',
		data : search_info,
		dataType : 'json',
		success : function(data){
			console.log(data);
			totalPage = data.pages;
			listDraw(data.quiz_search_list);
            $('#pagination').twbsPagination({
                startPage: currPage,//현재 페이지
                totalPages: totalPage,//만들수 있는 총 페이지 수
                visiblePages:5, //[1][2][3]... 이걸 몇개 까지 보여줄 것인지
                onPageClick:function(evt,page){//해당 페이지 번호를 클릭했을때 일어날 일들
                   console.log(evt); //현재 일어나는 클릭 이벤트 관련 정보들
                   console.log(page);//몇 페이지를 클릭 했는지에 대한 정보
                   search(page,10);

                }
             });
			},
		error : function(e){
			console.log(e)
			}
	});	
}

function listDraw(list){
	var txt = '';
		list.forEach(function(item,idx){
			console.log(item);
			txt += '<tr>';
			txt += '<td>'+item.quiz_no+'</td>';
			txt += '<td>'+item.test_year+'</td>';
			txt += '<td>'+item.test_month+'</td>';
			txt += '<td>'+item.test_count+'</td>';
			txt += '<td>'+item.quiz_index+'</td>';
			txt += '<td>'+item.test_cate+'</td>';
			txt += '<td>'+item.subject_cate+'</td>';
			txt += '<td>'+item.detailed_subject_cate+'</td>';
			txt += '<td class="quiz_content"><a href="adminUpdateQuizForm?quiz_no='+item.quiz_no+'">'+item.quiz_content+'</a></td>';
			txt += '<td>'+item.quiz_explation+'</td>';
			txt += '<td>'+item.quiz_type+'</td>';
			txt += '<td>'+item.quiz_point+'</td>';
			txt += '<td>'+item.option1+'</td>';
			txt += '<td>'+item.option2+'</td>';
			txt += '<td>'+item.option3+'</td>';
			txt += '<td>'+item.option4+'</td>';
			txt += '<td>'+item.option5+'</td>';
			txt += '<td>'+item.quiz_answer+'</td>';
			txt += '<td>'+item.del_flag+'</td>';
			txt += '</tr>';
		});
		$('#quizList').empty();
		$('#quizList').append(txt);
}





test_time(new Date());
function test_time(date){
	var txt = '<option value="">전체</option>';
	for (var i = date.getFullYear(); i >= 2010; i--) {
		txt += '<option>'+i+'</option>';
	}
	console.log(txt);
	$('#test_year').append(txt);
}

//카테고리 불러오기. 상위카테고리 선택한거(value),부를 카테고리,선택자
function testCategoryCall(upperCate,Cate,id){
	var obj = {upperCate:upperCate,Cate:Cate};
	console.log(id.attr('id'));
	$.ajax({
		url : 'adminTestCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'json',
		success : function(data){
			console.log(data.Category);
			var txt = '<option value="">전체</option>';
			data.Category.forEach(function(item,idx){
				txt += '<option value="'+item.test_cate_no+'">'+item.test_cate+'</option>';
			});
			
			id.empty();
			id.append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
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
				txt += '<option value="'+item.subject_cate_no+'">'+item.subject_cate+'</option>';
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
				txt += '<option value="'+item.detailed_subject_cate_no+'">'+item.detailed_subject_cate+'</option>';
			});
			
			id.empty();
			id.append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
}
//1.시험카테고리 건들때
$('#test_cate_no').change(function(){
	console.log(this.value);
	subjectCategoryCall(this.value,"subject",$('#subject_cate_no'));
});
//2.과목 카테고리 건들때
$('#subject_cate_no').change(function(){
	console.log(this.value);
	detailSubjectCategoryCall(this.value,"detail",$('#detailed_subject_cate_no'));
});
//
$.ajax({  
	url : 'adminQuizListQuizCountList',
	type : 'get',
	data : '',
	dataType : 'json',
	success : function(data){
		console.log(data.test_count_list);
		var txt = '<option value="">전체</option>';
		for (var i = 0; i < data.test_count_list.length; i++) {
			txt += '<option>'+data.test_count_list[i]+'</option>';
		}
		$('#test_count').append(txt);
	},
	error : function(e){console.log(e)}	
});
subjectCategoryCall("0","subject",$('#subject_cate_no'));
detailSubjectCategoryCall("0","detail",$('#detailed_subject_cate_no'));
</script>
</html>