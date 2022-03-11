<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
	
        <style>
            table,th,td{
                border-collapse: separate;
               
            }

            select{
                width: 100px;
                

            }
           

            textarea{
                width: 180px;
                height: 200px;
                border-radius: 5px;
                border : 1px solid gray;
            }

            select {
                border-bottom : 1px solid gray;
                border-top: none;
                border-left : none;
                width : 120px;
                height: 20px;
            }
            input {
                border-bottom : 1px solid gray;
                border-top: none;
                border-left : none;
                border-right: none;
                width : 200px;
                height: 20px;
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
            input[type="checkbox"]{
                width : 15px;
            }
		#allDiv{
			text-align : center;
			margin : 0 auto;
			width : auto;
		}
            input[type="file"]{
                border-color: gray;
                background-color : greenyellow;
                color : black;
                border-radius : 5px;
                width : 50px;
                height : 30px;
                
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
                height:100px;
                border : 1px solid gray;
                padding: 10px;            
            
            }
            .quiz_type{
            	width : 215px;
            }
           
        </style>
    </head>

    <body>
    	<div id="allDiv">
	    
	    	<h3>시험 문제 등록</h3>
	    	<h4>
	    		시험 : ${test_info.test_category_name }
	    	</h4>
	    	<h4>
	    		시행년도 : ${test_info.test_year } 
	    		회차 : ${test_info.test_count } 
	    		시험시간 : ${test_info.test_time } 
	    		만점 : ${test_info.test_fullscore }
	    	</h4>
	    	<hr/><br/>
	    	<input type="file" value="엑셀업로드" onchange="readExcel()"/>
	    	<br/><br/><br/>
	    	<div id="quiz_form">
	    	
    	</div>
	<div style="text-align : right;">
		<input type="button" id="QuizForm_plus" onclick="quizFormPlus()" value="추가"/>	
	</div>
	<!-- <input type="button" id="QuizForm_delete" onclick="quizFormDelete()" value="삭제"/> -->
	</div>
    </body>
<script>
console.log("${test_info.test_category}");
var test = "${test_info.test_category}";
var test_category_name = "${test_info.test_category_name}" 
var testCategoryObjList = {};
console.log(test);

var quizCnt = 0;
subjectCategory();
function subjectCategory(){
	var txt = '<select class="quiz_subject '+quizCnt+'" onchange="detailSubjectCategoryCall(this)">';
		txt += '<option value="none">선택하세요</option>';
		${subjectCategory}.forEach(function(item,idx){
		console.log(item);
		txt += '<option value="'+item.subject_cate_no+'">'+item.subject_cate+'</option>';
	});
	txt += '</select>';
	return txt;
}
function detailSubjectCategoryCall(e){

	var thisCnt = $(e)[0].classList[1];
	console.log("thisCnt : "+thisCnt);
	var obj = {upperCate:e.value,Cate:"detailed"};
	console.log(obj);
	$.ajax({
		url : 'adminDetailSubjectCategoryCall',
		type : 'get',
		data : obj,
		dataType : 'JSON',
		success : function(data){
			console.log(data);
			
			var txt = '';
			txt +='<option>선택하세요</option>'
			data.Category.forEach(function(item,idx){
				txt += '<option value="'+item.detailed_subject_cate_no+'">'+item.detailed_subject_cate+'</option>';
			});

			
			
			$('.quiz_detailed_subject.'+thisCnt).empty();
			$('.quiz_detailed_subject.'+thisCnt).append(txt);
			//$('#testCategory').empty();
			//$('#testCategory').append(txt);
		},
		error : function(e){
			console.log(e);
		}
	});
}

quizFormPlus();
//문제 form 추가
function quizFormPlus(){
	quizCnt += 1;
	var txt = '';
	txt += '<div class="quiz_form '+quizCnt+'">';
	txt += '<table>';
	txt += '<tr><td></td><td></td><td></td><td style="text-align : right;"><input type="button" class="quizFormDelete '+quizCnt+'" onclick="quizFormDelete(this)" value="삭제"/></td></tr>'
	txt += '<tr><td><h5>문제번호</h5><input type="number" min=1 class="quiz_no '+quizCnt+'" value="'+quizCnt+'"/></td>';
	txt += '<td><h5>배점</h5><input type="number" min=1 class="quiz_point '+quizCnt+'"/></td>';
	txt += '<td><h5>과목선택</h5>';
	txt += subjectCategory();
	txt += '</td>';
	txt += '<td><h5>세부과목선택</h5><select class="quiz_detailed_subject '+quizCnt+'"></select></td>';
	txt += '<tr><td><h5>문제내용</h5><textarea class="quiz_content '+quizCnt+'"></textarea></td>';
	txt += '<td><h5>해설</h5><textarea class="quiz_explation '+quizCnt+'"></textarea></td>';
	txt += '<td colspan="2" style="vertical-align:text-bottom;"><h5>문제유형선택</h5><select class="quiz_type '+quizCnt+'" onchange="selectQuizType(this)">';
	txt += '<option value="1">주관식</option>';
	txt += '<option value="2">2지선다</option>';
	txt += '<option value="3">3지선다</option>';
	txt += '<option value="4">4지선다</option>';
	txt += '<option value="5">5지선다</option>';
	txt += '</select><div></div></td></tr>';
	txt += '<tr><td colspan="4" class="photoArea" onclick="photoChildOpen(this)"><h5>사진없음</h5></td></tr>'
	txt += '</div>';
	$('#quiz_form').append(txt);
	console.log($('.quiz_form '+quizCnt+' select[class="select_subject"]' ));
	

}

function quizFormDelete(e){
	$(e).parents('.quiz_form').remove();
	quizCnt -= 1;
	console.log(quizCnt);
}


function selectQuizType(e){
	var inputTxt = '';
	console.log($(e).siblings('div'));
	
	if(e.value == 1){
		console.log(e.value);
		inputTxt += '<input type="text" class="option1 '+quizCnt+'"/>';
	} else {
		inputTxt += '<ol>';
		for (var i = 1; i <= e.value; i++) {
		inputTxt += '<li><input type="text" class="opiont'+i+' '+quizCnt+'"/><input type="checkbox" class="option'+i+' '+quizCnt+'" value="'+i+'"></li>';
		}
		inputTxt += '</ol>';		
	}
	$(e).siblings('div').empty(inputTxt);	
	$(e).siblings('div').append(inputTxt);
}


function readExcel() {
    let input = event.target;
    let reader = new FileReader();
    reader.onload = function () {
        let data = reader.result;
        let workBook = XLSX.read(data, { type: 'binary' });
        workBook.SheetNames.forEach(function (sheetName) {
            console.log('SheetName: ' + sheetName);
            let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
            console.log(rows);
            console.log(JSON.stringify(rows[0]));
            let array = [];
            let txt = '';
            
            //현재 양식 모두 삭제
            $('#quiz_form').empty();
            quizCnt = 0;
            rows.forEach(function(item,idx){
            	quizFormPlus();
            	$('.quiz_no.'+quizCnt).val(item.문제번호);
            	$('.quiz_point.'+quizCnt).val(item.배점);
            	$('.quiz_content.'+quizCnt).val(item.문제내용);
            	$('.quiz_explation.'+quizCnt).val(item.해설);

           		$('.quiz_subject.'+quizCnt).val(item.과목);
            	$('.quiz_detailed_subject'+quizCnt).val(item.세부과목);
            	
            });
            
            
        })
    };
    reader.readAsBinaryString(input.files[0]);
}


function photoChildOpen(e){
	var photoChild = window.open('adminPhotoChildOpen','사진첨부','width=300,height=300');
}






</script>
</html>