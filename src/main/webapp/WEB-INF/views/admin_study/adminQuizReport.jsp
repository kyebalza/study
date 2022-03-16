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
		
	
	</style>
</head>
<body>
	<h3>문제 오류신고 관리</h3><hr/>
	<table>
		<thead>
			<tr>
				<td>신고No.</td>
				<td>문제ID</td>
				<td>신고한ID</td>
				<td>신고내용</td>
				<td>처리상태</td>
			</tr>
		</thead>
	
		<tbody id="quiz_report_list">
			
		</tbody>
	</table>
</body>
<script>
var currPage = 1;
var totalPage = 2;

function listCall(page,cnt,compl_yn){
	search_info.page = page;
	search_info.cnt = cnt;
	search_info.cnt = compl_yn;
	

	$.ajax({
		url : 'adminQuizReportCall',
		type : 'get',
		data : search_info,
		dataType : 'json',
		success : function(data){
			console.log(data);
			listDraw(data.quiz_report_list);
            $('#pagination').twbsPagination({
                startPage: currPage,//현재 페이지
                totalPages: totalPage,//만들수 있는 총 페이지 수
                visiblePages:5, //[1][2][3]... 이걸 몇개 까지 보여줄 것인지
                onPageClick:function(evt,page){//해당 페이지 번호를 클릭했을때 일어날 일들
                   console.log(evt); //현재 일어나는 클릭 이벤트 관련 정보들
                   console.log(page);//몇 페이지를 클릭 했는지에 대한 정보
                   listCall(page,10);

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
			txt += '<td>'+item.quiz_report_no+'</td>';
			txt += '<td>'+item.quiz_no+'</td>';
			txt += '<td>'+item.report_content+'</td>';
			txt += '<td>'+item.user_id+'</td>';
			if(item.compl_flag){
				txt += '<td>처리완료</td>';				
			} else{
				txt += '<td>처리대기</td>';				
			}
			txt += '</tr>';
		});
		$('#quiz_report_list').empty();
		$('#quiz_report_list').append(txt);
}

</script>
</html>