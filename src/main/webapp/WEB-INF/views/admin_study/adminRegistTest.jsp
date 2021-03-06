<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/adminLefter.css"/>
	
	<style>
	body{
		margin : 0px;
	}
	
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
            #registTest h5{
            	margin : 10px 0px;
            	font-size : 1px;
            
            }
            
		#grid {
		min-height : 1000px;
		
		
		}
		#mainPage{
			padding-right : 200px;
			padding-top : 5px;
			padding-left : 10px;
		}
		

		hr{
			border : 1px solid gray;
			margin : 10px 0px 10px 0px;
			width : 300px;
		}
        
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div id="grid">
	<div id="lefter"><iframe id="lefter" src="adminLefter"></iframe>		</div>
    <div id="mainPage" style="margin-left : auto;margin-right : auto;">
        <div id="registCategory">
            <h3>?????? ?????? ???????????? ??????</h3>
        <hr/><br/>
            <select id="testCategory"><option value="none">??????????????????</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteTestCategory" value="??????"/>
        <br/><br/>
            <select id="subjectCategory"><option value="none">??????????????????</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteSubjectCategory" value="??????"/>
        <br/><br/>
            <select id="detailSubjectCategory"><option  value="none">????????????????????????</option></select>&nbsp;&nbsp;&nbsp;<input type="button" id="deleteDetailedSubjectCategory" value="??????"/>
        <br/><br/>
        <h5 id="addCategory">?????? ??? ???????????? : ??????</h5>
        <input id="registCategoryText" type="text" placeholder="?????? ??? ???????????? ????????? ???????????????."/>&nbsp;&nbsp;&nbsp;<input id="registCategoryBtn" type="button" value="??????"/>
        </div>
        <br/><br/>
        <h3>?????? ??????</h3>
        <hr/><br/>
        <div id="registTest">
        	<form action="adminRegistQuizForm" id="toRegistQuizForm" method="get">
	            <table>
	                <tr>
	                    <td>
	                        <select id="testCategory_2" name="test_category">
	                        	<option>??????</option>
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
	                    	<h5>?????????</h5>
	                        <input type="number" id="test_month" name="test_month" min='1' placeholder="?????????"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                    	<h5>??????</h5>
	                        <input type="number" id="test_count" name="test_count" min='1' placeholder="????????????"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                    	<h5>????????????</h5>
	                        <input type="number" id="test_time" name="test_time" min='1' placeholder="????????????"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                    	<h5>????????????</h5>
	                        <input type="number" id="test_fullscore" name="test_fullscore" min='1' placeholder="????????????"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                    	<h5>????????????</h5>
	                        <input type="number" id="test_pass_criterion" name="test_pass_criterion" min='0' placeholder="????????????"/>
	                    </td>
	                </tr>	             	                
	                <tr>
	                    <td>
	                    	<h5>?????????</h5>
	                        <input type="number" id="test_pass_rate" name="test_pass_rate" min='1' placeholder="?????????"/>
	                    </td>
	                </tr>	    
	                <tr>
	                    <td style="text-align : center">
	                        <input type="button" id="registTestBtn" value="????????????"/>
	                    </td>
	                </tr>
	            </table>
        	</form>

            <br/>
        </div>


    </div>	
</div>    
</body>
<script>
var addCate = '';
var $testCategory = '';
var $subjectCategory = '';
var $detailSubjectCategory = '';
//0.?????????????????? ?????? ????????? ?????????
testCategoryCall("0","test",$('#testCategory'));
testCategoryCall("0","test",$('#testCategory_2'));

//
$('#registCategory select').change(function(){
	var a = $('#registCategory select')[0].value;
	var b = $('#registCategory select')[1].value;
	var c = $('#registCategory select')[2].value;

	if(a!='addCate' && b!='addCate' && c!='addCate'){
		addCate = '';
		$('#addCategory').html('?????? ??? ???????????? : ??????');
		
	}
	
});



//1.?????????????????? ?????????
$('#testCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'test';
		$('#addCategory').html('?????? ??? ???????????? : ?????? ????????????');
		subjectCategoryCall("0","subject",$('#subjectCategory'));
	}
	console.log(this.value);
	subjectCategoryCall(this.value,"subject",$('#subjectCategory'));
	detailSubjectCategoryCall("none","detail",$('#detailSubjectCategory'));

	$testCategory = this.value;
});
//2.?????? ???????????? ?????????
$('#subjectCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'subject';
		$('#addCategory').html('?????? ??? ???????????? : ?????? ????????????');
		detailSubjectCategoryCall("0","detail",$('#detailSubjectCategory'));

	}
	console.log(this.value);
	detailSubjectCategoryCall(this.value,"detail",$('#detailSubjectCategory'));
	$subjectCategory = this.value;
});
//3.???????????? ???????????? ?????????
$('#detailSubjectCategory').change(function(){
	if(this.value=='addCate'){
		addCate = 'detailSubject';
		$('#addCategory').html('?????? ??? ???????????? : ???????????? ????????????');
	}
	console.log(this.value);
	$detailSubjectCategory = this.value;
});
//4.???????????? ????????????
$('#registCategoryBtn').click(function(){
	
	var $registCategoryText = $('#registCategoryText');
	
	if($registCategoryText == ''){
		alert('???????????? ??????????????? ????????? ??????????????????');
	} else if (addCate == ''){
		alert('?????? ??? ???????????? ????????? ??????????????????');
	} else {
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
			url : 'adminRegistCategory',
			type : 'GET',
			data : obj,
			dataType : 'JSON',
			success : function(data){
				alert(data.msg);
				if(addCate == 'test'){
					testCategoryCall("0","test",$('#testCategory'));
					testCategoryCall("0","test",$('#testCategory_2'));
					$('#testCategory').val('addCate').prop("selected",true);
				}
				if(addCate == 'subject'){
					subjectCategoryCall($testCategory,"subject",$('#subjectCategory'));
					//$('#subjectCategory').val('addCate').prop("selected",true);
				}
				if(addCate == 'detailSubject'){
					detailSubjectCategoryCall($subjectCategory,"detail",$('#detailSubjectCategory'));
					//('#detailSubjectCategory').val('addCate').prop("selected",true);
				}	
				},
			error : function(e){}
		});
		
	}
	
	
	
});
//?????? ????????????
$('#deleteTestCategory').click(function(){
	var obj = {};
	obj.test_cate_no = $('#testCategory').val();
	console.log(obj);
	var yn = confirm('????????? ?????????????????????????');
	if(obj.test_cate_no == 'none' || obj.test_cate_no == 'addCate'){
		alert('???????????? ????????? ??????????????????');
		yn = false;
	}
	
	if(yn){
		$.ajax({
			url : 'adminDeleteTestCategory',
			type : 'get',
			data : obj,
			dataType : 'json',		
			success : function(data){
				console.log(data);
				testCategoryCall("0","test",$('#testCategory'));
				subjectCategoryCall("0","subject",$('#subjectCategory'));
				detailSubjectCategoryCall("0","detail",$('#detailSubjectCategory'));
			},
			error : function(e){
				console.log(e);
			}
		});		
	}
	
});
//?????? ????????????
$('#deleteSubjectCategory').click(function(){
	var obj = {};
	obj.subject_cate_no = $('#subjectCategory').val();
	console.log(obj);
	var yn = confirm('????????? ?????????????????????????');
	if(obj.subject_cate_no == 'none' || obj.subject_cate_no == 'addCate'){
		alert('???????????? ????????? ??????????????????');
		yn = false;
	}
	
	
	if(yn){
		$.ajax({
			url : 'adminDeleteSubjectCategory',
			type : 'get',
			data : obj,
			dataType : 'json',		
			success : function(data){
				console.log(data);
				//testCategoryCall("0","test",$('#testCategory'));
				subjectCategoryCall($testCategory,"subject",$('#subjectCategory'));
				detailSubjectCategoryCall($subjectCategory,"detail",$('#detailSubjectCategory'));
			},
			error : function(e){
				console.log(e);
			}
		});		
	}
});
//???????????? ????????????
$('#deleteDetailedSubjectCategory').click(function(){
	var obj = {};
	obj.detailed_subject_cate_no = $('#detailSubjectCategory').val();
	console.log(obj);
	var yn = confirm('??????????????? ?????????????????????????');
	if(obj.detailed_subject_cate_no == 'none' || obj.detailed_subject_cate_no == 'addCate'){
		alert('???????????? ????????? ??????????????????');
		yn = false;
	}
	if(yn){
		$.ajax({
			url : 'adminDeleteDetailedSubjectCategory',
			type : 'get',
			data : obj,
			dataType : 'json',		
			success : function(data){
				console.log(data);
				//testCategoryCall("0","test",$('#testCategory'));
				//subjectCategoryCall("0","subject",$('#subjectCategory'));
				detailSubjectCategoryCall($subjectCategory,"detail",$('#detailSubjectCategory'));
			},
			error : function(e){
				console.log(e);
			}
		});
	}
});



//5.?????????????????? ????????? : 
//$('#testCategory_2')
	
//???????????? ????????????. ?????????????????? ????????????(value),?????? ????????????,?????????
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
			if(id.attr('id') == 'testCategory'){
				var txt = '<option value="none">??????????????????</option>';
				txt += '<option value="addCate">+ ????????????</option>';				
			}
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
			console.log(data);
			
			var txt = '<option value="none">-- ?????????????????? --</option>';
			if(upperCate != 'addCate'){
				if(upperCate != 'none'){
					txt += '<option value="addCate">+ ????????????</option>';				
				}
			}
			
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
		url : 'adminDetailSubjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			
			var txt = '<option value="none">-- ???????????? ???????????? --</option>';
			if(upperCate != 'addCate'){
				if(upperCate != 'none'){
					txt += '<option value="addCate">+ ????????????</option>';				
				}				
			}
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


//???????????? ??????
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
	var $test_month = $('#test_month');
	var $test_pass_criterion = $('#test_pass_criterion');
	var $test_pass_rate = $('#test_pass_rate');
	
	if($test_year.val() == '' 
			|| $test_count.val() == '' 
			|| $test_time.val() == '' 
			|| $test_fullscore.val() == ''
			|| $test_month.val() == ''
			|| $test_pass_rate.val() == ''
			|| $test_pass_criterion.val() == ''
	){
		alert('???????????? ????????? ????????????.');
	} else{
		console.log('???????????? ??????');
		$('#toRegistQuizForm').submit();
	}
});



</script>
</html>