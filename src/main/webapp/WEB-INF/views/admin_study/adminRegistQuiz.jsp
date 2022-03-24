<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
	<link rel="stylesheet" href="resources/css/adminLefter.css"/>
	
        <style>
            table,th,td{
                border-collapse: separate;               
            }

            select{
                width: 100px;
            }
           

            textarea{
                width: 300px;
                height: 100px;
                border-radius: 5px;
                border : 1px solid gray;
            }
/*             .photoArea{
                width: 300px;
                height: 200px;
                border-radius: 5px;
                border : 1px solid gray;
                padding : 0px;
                margin : 0px;
            } */

            select {
                border-bottom : 1px solid gray;
                border-top: none;
                border-left : none;
                width : 120px;
                height: 20px;
            }

/*             input {
                border-bottom : 1px solid gray;
                border-top: none;
                border-left : none;
                border-right: none;
                width : 200px;
                height: 20px;
            } */
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
		#allDiv{
			text-align : center;
			margin : 0 auto;
			width : auto;
		}
            input[type="file"]{
                border-color: gray;
                
                color : black;
                border-radius : 5px;
                
                
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
			#allDiv img{
				width : 250px;
				height : 200px;
			
			}            
           #quiz_all_button{
           	text-align : right;
           }
		#allDiv{
			padding-right : 20px;
			padding-top : 20px;
			padding-left : 20px;
		}

	           
        </style>
    </head>

    <body>
<%@ include file="../header.jsp" %>
	<div id="grid">    
	    <div>
			<iframe id="lefter" src="adminLefter"></iframe>			
		</div>
    	<div id="allDiv"  style="margin-left : auto;margin-right : auto;">
	    	<div id="quiz_header">
		    	<h3>시험 문제 등록</h3>
		    	<h4>
		    		시험 : ${test_info.test_category_name }
					&nbsp;&nbsp;&nbsp;
		    		${test_info.test_year }년 
		    		${test_info.test_month }월
		    		${test_info.test_count } 회
		    	</h4>
		    	<h4>
		    		시험시간 : ${test_info.test_time } 분 
		    		합격기준/만점 : ${test_info.test_pass_criterion }/${test_info.test_fullscore } 점
					합격률 : ${test_info.test_pass_rate }%
		    	</h4>
		    	<hr/><br/>
	    	</div>
	    	<div id="quiz_all_button">
	    		<input type="button" id="quiz_save" style="width:80px;" value="전체저장"/>
	    		<input type="button" id="excelBtn" style="width:90px;" value="엑셀업로드"/>
		    	<input type="file" id="excelFileBtn" style="display : none;"  onchange="readExcel()"/>
	    	</div>
	    	<br/><br/><br/>
	    	<div id="quiz_form">
	    	
    	</div>
	<div style="text-align : right;">
		<input type="button" id="QuizForm_plus" onclick="quizFormPlus()" value="추가"/>	
	</div>
	<!-- <input type="button" id="QuizForm_delete" onclick="quizFormDelete()" value="삭제"/> -->
	</div>
	</div>
    </body>
<script>
console.log("${test_info.test_category}");
var test = "${test_info.test_category}";
var test_category_name = "${test_info.test_category_name}" 
var subjectCategory_json = ${subjectCategory};
var detailedCategory_json = ${detailedSubjectCategory};
console.log(test);

var quizCnt = 0;
subjectCategory();
function subjectCategory(){
	var txt = '<select class="quiz_subject '+quizCnt+'" onchange="detailSubjectCategoryCall(this)">';
		txt += '<option value="none">선택하세요</option>';
		subjectCategory_json.forEach(function(item,idx){
		//console.log(item);
		txt += '<option value="'+item.subject_cate_no+'">'+item.subject_cate+'</option>';
	});
	txt += '</select>';
	return txt;
}
function detailSubjectCategoryCall(e){

	var thisCnt = $(e)[0].classList[1];
	var txt = '';
	txt +='<option>선택하세요</option>';
	detailedCategory_json.forEach(function(item,idx){
		if(e.value == item.subject_cate_no){
			txt += '<option value="'+item.detailed_subject_cate_no+'">'+item.detailed_subject_cate+'</option>';
		}
		
		});
	$('.quiz_detailed_subject.'+thisCnt).empty();
	$('.quiz_detailed_subject.'+thisCnt).append(txt);
}


quizFormPlus();
//문제 form 추가
function quizFormPlus(){
	quizCnt += 1;
	var txt = '';
	txt += '<div class="quiz_form '+quizCnt+'">';
	txt += '<table>';
	txt += '<tr><td></td><td></td><td></td><td style="text-align : right;"><input type="button" class="quizFormDelete '+quizCnt+'" onclick="quizFormDelete(this)" value="삭제"/></td></tr>'
	txt += '<tr><td><h5>문제번호</h5><input type="number" min=1 class="quiz_index '+quizCnt+'" value="'+quizCnt+'"/></td>';
	txt += '<td><h5>배점</h5><input type="number" min=1 class="quiz_point '+quizCnt+'"/></td>';
	txt += '<td><h5>과목선택</h5>';
	txt += subjectCategory();
	txt += '</td>';
	txt += '<td><h5>세부과목선택</h5><select class="quiz_detailed_subject '+quizCnt+'"></select></td>';
	txt += '<tr>';
	txt += '<td colspan="2"><h5>사진</h5><div class="photoArea '+quizCnt+'" onclick="photoChildOpen(this)"></div></td>';
	txt += '<td colspan="2" style="vertical-align:text-bottom;"><h5>문제유형선택</h5><select class="quiz_type '+quizCnt+'" onchange="selectQuizType(this)">';
	txt += '<option value="1">주관식</option>';
	txt += '<option value="2">2지선다</option>';
	txt += '<option value="3">3지선다</option>';
	txt += '<option value="4">4지선다</option>';
	txt += '<option value="5">5지선다</option>';
	txt += '</select><div class="quiz_type_opt_area '+quizCnt+'"></div></td></tr>';
	txt += '<tr>';
	txt += '<td colspan="2"><h5>문제내용</h5><textarea class="quiz_content '+quizCnt+'"></textarea></td>';
	txt += '<td colspan="2"><h5>해설</h5><textarea class="quiz_explation '+quizCnt+'"></textarea></td>';
	txt += '</tr>';
	txt += '</div>';
	$('#quiz_form').append(txt);
}

function quizFormDelete(e){
	
	$(e).parents('.quiz_form').remove();
}


function selectQuizType(e){
	var inputTxt = '';
	//console.log($(e).siblings('div'));
	console.log(e);
	console.log($(e)[0].classList[1]);
	if(e.value == 1){
		console.log(e.value);
		inputTxt += '<input type="text" class="option1 '+$(e)[0].classList[1]+'"/>';
	} else {
		inputTxt += '<ol>';
		for (var i = 1; i <= e.value; i++) {
		inputTxt += '<li><input type="text" class="option'+i+' '+$(e)[0].classList[1]+'"/><input type="checkbox" class="option_yn'+i+' '+$(e)[0].classList[1]+'" value="'+i+'"></li>';
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
            //console.log(rows);
            //console.log(JSON.stringify(rows[0]));
            let array = [];
            let txt = '';
            
            //현재 양식 모두 삭제
            $('#quiz_form').empty();
            	quizCnt = 0;
            
            rows.forEach(function(item,idx){
            	quizFormPlus();
            	$('.quiz_index.'+quizCnt).val(item.문제번호);
            	$('.quiz_point.'+quizCnt).val(item.배점);
            	$('.quiz_content.'+quizCnt).val(item.문제내용);
            	$('.quiz_explation.'+quizCnt).val(item.문제해설);

            	subjectCategory_json.forEach(function(item_json,idx){
            		if(item_json.subject_cate == item.과목){
            			//console.log(item_json.subject_cate+' / '+item.과목+' / '+item_json.subject_cate_no);
	            		$('.quiz_subject.'+quizCnt).val(item_json.subject_cate_no);            			
            		}
            		
            	});
            	
            	detailSubjectCategoryCall(document.querySelectorAll('.quiz_subject')[quizCnt-1]);
            	detailedCategory_json.forEach(function(item_json,idx){
					if(item_json.detailed_subject_cate == item.세부과목){
						$('.quiz_detailed_subject.'+quizCnt).val(item_json.detailed_subject_cate_no);						
					}            		
            		
            	});

            	$('.quiz_type.'+quizCnt).val(item.문제유형);
            	selectQuizType(document.querySelectorAll('.quiz_type')[quizCnt-1]);
            	for (var i = 1; i <= item.문제유형; i++) {
					$('.option'+i+'.'+item.문제번호).val(item["보기"+i]);
					if(i == item.정답){
						$('.option_yn'+i+'.'+item.문제번호).prop("checked",true);						
					}
					//console.log($('.option'+i+'.'+item.문제번호).val(item["보기"+i]));
				}
            	
            });
            
            
        })
    };
    reader.readAsBinaryString(input.files[0]);
}


function photoChildOpen(e){
	console.log(e.classList[1]);
	var photoChild = window.open('adminPhotoChildOpen?quizCnt='+e.classList[1],'사진첨부','width=300,height=300');
}



$('#excelBtn').click(function(){
	$('#excelFileBtn').click();
});


$('#quiz_save').click(function(){
	var testcomplete = false;
	var quizcomplete = false;
	
	
	var quiz_list = [];
	var all_quiz_cnt = $('div .quiz_form').length;//문제 양식의 갯수를 센다. quizCnt는 문제 있을 수 있음
	var test_obj = {};
	test_obj.test_category = "${test_info.test_category}";
	test_obj.test_year = "${test_info.test_year}";
	test_obj.test_count = "${test_info.test_count}";
	test_obj.test_time = "${test_info.test_time}";
	test_obj.test_fullscore = "${test_info.test_fullscore}";
	test_obj.test_month = "${test_info.test_month}";
	test_obj.test_pass_rate = "${test_info.test_pass_rate}";
	test_obj.test_pass_criterion = "${test_info.test_pass_criterion}";
	quiz_list.push(JSON.stringify(test_obj));
	if( test_obj.test_category == ''
		||test_obj.test_year == ''
		||test_obj.test_count == ''
		||test_obj.test_time == ''
		||test_obj.test_fullscore == ''
		||test_obj.test_month == ''
		||test_obj.test_pass_rate == ''
		||test_obj.test_pass_criterion == ''		
	) {
		testcomplete = false;
		} else{
		testcomplete = true;
	}

	
	for (var i = 0; i < all_quiz_cnt; i++) {
		
		var obj = {};
		var class_num = $('div.quiz_form')[i].classList[1];//클래스 번호	
		obj.quiz_index = $('.quiz_index.'+class_num).val();
		obj.quiz_point = $('.quiz_point.'+class_num).val();
		obj.quiz_subject = $('.quiz_subject.'+class_num).val();
		obj.quiz_detailed_subject = $('.quiz_detailed_subject.'+class_num).val();
		//var quiz_img;
		obj.quiz_type = $('.quiz_type.'+class_num).val();
		
		obj.option1 = '없음';
		obj.option2  = '없음';
		obj.option3  = '없음';
		obj.option4  = '없음';
		obj.option5  = '없음';
		for (var j = 1; j <= obj.quiz_type; j++) {
			obj["option"+j] = $('.option'+j+'.'+class_num).val();
		}
		
		
		var answer = '';
		//정답저장 : 주관식일때
		if(obj.quiz_type == 1){
			answer = obj.option1 = $('.option1.'+class_num).val();
		} else {
			for (var k = 1; k <= 5; k++) {
				if($('.option_yn'+k+'.'+class_num+':checked').val() > 0){
					answer += $('.option_yn'+k+'.'+class_num+':checked').val();							
				}
			}			
		}
		obj.answer = answer;
		
		
		obj.quiz_content = $('.quiz_content.'+class_num).val();
		obj.quiz_explation = $('.quiz_explation.'+class_num).val();
		obj.newPhotoName = $('.quiz_img_newName.'+class_num).val()
		obj.oriPhotoName = $('.quiz_img_oriName.'+class_num).val()
		
		
		quiz_list.push(JSON.stringify(obj));
		console.log(obj);
		if(obj.quiz_index == ''
			||obj.quiz_point == ''
			||obj.quiz_subject == ''
			||obj.quiz_detailed_subject == ''
			||obj.quiz_type == ''
			||obj.answer == ''
			||obj.quiz_content == ''
			||obj.quiz_explation == ''
			||obj.answer == ''
			||obj.option1 == ''
			||obj.option2 == ''
			||obj.option3 == ''
			||obj.option4 == ''		
			||obj.option5 == ''
					
		){
			quizcomplete = false;
		}else {
			quizcomplete = true;
		}
		
		
		
	}
	console.log(quiz_list);
	console.log(JSON.stringify(quiz_list));
	
	console.log(test_obj);
	if(testcomplete == true && quizcomplete == true){
		$.ajax({
			url : 'adminRegistTestAndQuiz',
			type : 'post',
			data : {
				//"test_info":JSON.stringify(test_obj),
				"params":quiz_list},
			dataType : 'JSON',
			success : function(data){
				console.log(data.msg);
				alert('문제 등록이 완료되었습니다.');
				location.href='adminQuizList';
				
			},
			error : function(e){}
		});
	} else {
		if(!testcomplete){
			alert('시험 항목 중 미등록 사항이 있습니다.');
		}
		if(!quizcomplete){
			alert('문제 항목 중 미등록 사항이 있습니다.');			
		}
	}
});



</script>
</html>