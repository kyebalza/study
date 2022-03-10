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
               
            }

            select{
                width: 100px;
                

            }
           

            textarea{
                width: 180px;
                height: 170px;
                border-radius: 5px;
                border : 1px solid lightgray;
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
                border : 1px solid lightgray;
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
                border : 1px solid lightgray;
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
	    		시험 : ${test_info.test_category } 
	    		시행년도 : ${test_info.test_year } 
	    		회차 : ${test_info.test_count } 
	    		시험시간 : ${test_info.test_time } 
	    		만점 : ${test_info.test_fullscore }
	    	</h4>
	    	<hr/><br/>
	    	<input type="file" value="엑셀업로드"/>
	    	<br/><br/><br/>
	    	<div id="quiz_form">
	    	
    	</div>

	<input type="button" id="QuizForm_plus" onclick="quizFormPlus()" value="추가"/>
	<input type="button" id="QuizForm_delete" onclick="quizFormDelete()" value="삭제"/>
	</div>
    </body>
<script>

var test = "${test_info.test_category}";
console.log(test);

var quizCnt = 1;


quizFormPlus();
//문제 form 추가
function quizFormPlus(){
	var txt = '';
	txt += '<div class="quiz_form '+quizCnt+'">';
	txt += '<table>';
	txt += '<tr><td><h5>문제번호</h5><input type="number" min=1 name="quiz_no" value="'+quizCnt+'"/></td>';
	txt += '<td><h5>배점</h5><input type="number" min=1 name="quiz_no"/></td>';
	txt += '<td><h5>과목선택</h5><select></select></td>';
	txt += '<td><h5>세부과목선택</h5><select></select></td>';
	txt += '<tr><td><h5>문제내용</h5><textarea></textarea></td>';
	txt += '<td><h5>해설</h5><textarea></textarea></td>';
	txt += '<td colspan="2"><h5>문제유형선택</h5><select class="quiz_type">';
	txt += '<option value="1">주관식</option>';
	txt += '<option value="2">2지선다</option>';
	txt += '<option value="3">3지선다</option>';
	txt += '<option value="4">4지선다</option>';
	txt += '<option value="5">5지선다</option>';
	txt +='</select></td></tr>';
	txt += '<tr><td colspan="4" class="photoArea"><h5>사진없음</h5></td></tr>'
	txt += '</div>';
	$('#quiz_form').append(txt);

	quizCnt += 1;
	
}
function quizFormDelete(){
	$('.quiz_form').remove();
	
}



</script>
</html>