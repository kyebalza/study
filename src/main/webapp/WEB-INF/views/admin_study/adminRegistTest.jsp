<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		#registCategory select{
                width : 300px;
                height : 30px;
                border-top : none;
                border-left : none;
                border-radius : 5px;
                
            }
            #registCategory input[type="text"]{
                width : 300px;
                height : 30px;    
                border-top : none;
                border-left : none;
                border-right : 1px solid gray;
                border-bottom: 1px solid gray;
                border-radius : 5px;
                
            }
            #registTest select{
                width : 300px;
                height : 30px;
                border-top : none;
                border-left : none;
                border-radius : 5px;
            }
            #registTest input[type="number"]{
                width : 300px;
                height : 30px;
                border-top : none;
                border-left : none;
                border-right : 1px solid gray;
                border-bottom: 1px solid gray;
                border-radius : 5px;
            }
            #registTest input[type="button"]{
                width : 80px;
                border-radius : 5px;
            }
            table,th,td {
                padding : 5px;
                /* border : 1px solid gray;
                border-collapse : collapse; */
            }
            input[type="button"]{
                border-color: gray;
                background-color : greenyellow;
                color : black;
                border-radius : 5px;
                
            }
	</style>
</head>
<body>
<div id="lefter"></div>
    <div>
        <div id="registCategory">
            <h3>시험 과목 카테고리 관리</h3>
        <hr/><br/>
            <select id="testCategory"><option>시험카테고리</option><option>asdasd</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteTestCategory" value="삭제"/>
        <br/><br/>
            <select id="subjectCategory"><option>과목카테고리</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteSubjectCategory" value="삭제"/>
        <br/><br/>
            <select id="detailSubjectCategory"><option>세부과목카테고리</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteDetailTestCategory" value="삭제"/>
        <br/><br/>
        <h5 id="addCategory">추가 할 카테고리 : </h5>
        <input id="registCategoryText" type="text" placeholder="저장 할 카테고리 이름을 입력하세요."/>&nbsp;&nbsp;&nbsp;<input id="registCategoryBtn" type="button" value="저장"/>
        </div>
        <br/><br/>
        <h3>시험 등록</h3>
        <hr/><br/>
        <div id="registTest">
        	<form action="toRegistQuizForm" id="toRegistQuizForm" method="get">
	            <table>
	                <tr>
	                    <td>
	                        <select id="testCategory_2" name="test_category">
	                        	<option>시험</option>
	                        	<option>asd</option>
	                        </select>                  
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <select id="test_year" name="test_year">
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <input type="number" id="test_count" name="test_count" min='1' placeholder="회차입력"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <input type="number" id="test_time" name="test_time" min='1' placeholder="시간입력"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <input type="number" id="test_fullscore" name="test_fullscore" min='1' placeholder="만점기준"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td style="text-align : center">
	                        <input type="button" id="registTestBtn" value="시험등록"/>
	                    </td>
	                </tr>
	            </table>
        	</form>

            <br/>
        </div>


    </div>	
</body>
<script>
var addCate = '';
var $testCategory = '';
var $subjectCategory = '';
var $detailSubjectCategory = '';
//0.시작하자마자 시험 리스트 뿌리기
testCategoryCall("0","test",$('#testCategory'));
testCategoryCall("0","test",$('#testCategory_2'));

//1.시험카테고리 건들때
$('#testCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'test';
		$('#addCategory').html('추가 할 카테고리 : 시험 카테고리');
		subjectCategoryCall("0","subject",$('#subjectCategory'));
	}
	console.log(this.value);
	subjectCategoryCall(this.value,"subject",$('#subjectCategory'));
	$testCategory = this.value;
});
//2.과목 카테고리 건들때
$('#subjectCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'subject';
		$('#addCategory').html('추가 할 카테고리 : 과목 카테고리');
		detailSubjectCategoryCall("0","detail",$('#detailSubjectCategory'));

	}
	console.log(this.value);
	detailSubjectCategoryCall(this.value,"detail",$('#detailSubjectCategory'));
	$subjectCategory = this.value;
});
//3.세부과목 카테고리 건들때
$('#detailSubjectCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'detailSubject';
		$('#addCategory').html('추가 할 카테고리 : 세부과목 카테고리');
	}
	console.log(this.value);
	$detailSubjectCategory = this.value;
});
//4.카테고리 저장버튼
$('#registCategoryBtn').click(function(){
	
	var $registCategoryText = $('#registCategoryText');
	var obj = {};
	if(addCate == 'test'){
		obj.registCategory = $registCategoryText.val();
		obj.upperCateNo = '0';
		obj.nowCate = 'test';
	}
	if(addCate == 'subject'){
		obj.registCategory = $registCategoryText.val();
		obj.upperCateNo = $('#testCategory').val();
		obj.nowCate = 'subject';
	}
	if(addCate == 'detailSubject'){
		obj.registCategory = $registCategoryText.val();
		obj.upperCateNo = $('#subjectCategory').val();
		obj.nowCate = 'detailSubject';
	}
	$.ajax({
		url : 'registCategory',
		type : 'GET',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			alert(data.msg);
			},
		error : function(e){}
	});
	if(addCate == 'test'){
		testCategoryCall("0","test",$('#testCategory'));
		testCategoryCall("0","test",$('#testCategory_2'));
		$('#testCategory').val('addCate').prop("selected",true);
	}
	if(addCate == 'subject'){
		subjectCategoryCall($testCategory,"subject",$('#subjectCategory'));
		$('#subjectCategory').val('addCate').prop("selected",true);
	}
	if(addCate == 'detailSubject'){
		detailSubjectCategoryCall($subjectCategory,"detail",$('#detailSubjectCategory'));
		$('#detailSubjectCategory').val('addCate').prop("selected",true);
	}	
});
//시험 삭제버튼
$('#deleteTestCategory').click(function(){
	var obj = {};
	obj.test_cate_no = $('#testCategory').val();
	console.log(obj);
	
	$.ajax({
		url : 'deleteTestCategory',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			//testCategoryCall("0","test",$('#testCategory'));
			//subjectCategoryCall("0","subject",$('#subjectCategory'));
			//detailSubjectCategoryCall("0","detail",$('#detailSubjectCategory'));
		},
		error : function(e){
			console.log(e);
		}
	});
});
//과목 삭제버튼

//세부과목 삭제버튼




//5.시험카테고리 건들때 : 
//$('#testCategory_2')
	
//카테고리 불러오기. 상위카테고리 선택한거(value),부를 카테고리,선택자
function testCategoryCall(upperCate,Cate,id){
	var obj = {upperCate:upperCate,Cate:Cate};
	console.log(obj);
	$.ajax({
		url : 'testCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data.Category);
			
			var txt = '<option value="none" style="text-align : center">-- 시험카테고리 --</option>';
			
			txt += '<option value="addCate">+ 추가하기</option>';
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
		url : 'subjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			
			var txt = '<option value="none" style="text-align : center">-- 과목카테고리 --</option>';
			txt += '<option value="addCate">+ 추가하기</option>';
			data.Category.forEach(function(item,idx){
				txt += '<option value="'+item.subject_cate_no+'">'+item.subject_cate+'</option>';
			});
			
			id.empty();
			id.append(txt);
			//$('#testCategory').empty();
			//$('#testCategory').append(txt);
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
		url : 'detailSubjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			
			var txt = '<option value="none" style="text-align : center">-- 시험과목 카테고리 --</option>';
			txt += '<option value="addCate">추가하기</option>';
			data.Category.forEach(function(item,idx){
				txt += '<option value="'+item.detailed_subject_cate_no+'">'+item.detailed_subject_cate+'</option>';
			});
			
			id.empty();
			id.append(txt);
			//$('#testCategory').empty();
			//$('#testCategory').append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
}


//시험등록 부분
//var date = new Date();

test_time(new Date());
function test_time(date){
	var txt = '';
	for (var i = date.getFullYear(); i >= 2010; i--) {
		txt += '<option>'+i+'</option>';
	}
	console.log(txt);
	$('#test_year').append(txt);
}


$('#registTestBtn').click(function(){
	var $test_year = $('#test_year');
	var $test_count = $('#test_count');
	var $test_time = $('#test_time');
	var $test_fullscore = $('#test_fullscore');
	if($test_year.val() == '' || $test_count.val() == '' || $test_time.val() == '' || $test_fullscore.val() == ''){
		alert('미입력된 항목이 있습니다.');
	} else{
		console.log('시험정보 전송');
		$('#toRegistQuizForm').submit();
	}
});

</script>
</html>