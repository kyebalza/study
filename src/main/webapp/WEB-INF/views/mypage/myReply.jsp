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
	<link rel="stylesheet" href="resources/css/myPage.css"/>
	<style>
			#header{
			width: 100%;
			height: 100px;
			/* border-style: none; */
			overflow: hidden;
		}
		.title{
			width : 500px;
		}
		.date{
			width : 100px;
		}
		td{
			text-align : left;
		}
		th{
			text-align : center;
		}
		td.title{
			padding-left : 30px;
		}	
body{
	margin : 0px;
		
}		
	</style>
</head>
<body>
<iframe id="header" src="header"></iframe>

<div id="all">
<div id="myPageHeader">
	<input type="button" value="내 알림" onclick="location.href='myNotice'"/>
	<input type="button" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" id="nowPage" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" value="회원정보" onclick="location.href='myInfo'"/>
</div>

<div id="boardBtn">
	<input type="button" id="studyReplyBtn" value="공부게시판"/>
	<input type="button" id="freeReplyBtn" value="자유게시판"/>
</div>		
<table style="text-align : center;margin-left: auto; margin-right: auto;">
	<thead id="list_head">
		<tr>
			<th class="title">제목</th>
			<th class="date">날짜</th>
		</tr>
	</thead>
	<tbody id="list_body"></tbody>
</table>
<div>
            <div class="container" style="width : 500px;text-align : center;margin-left: auto; margin-right: auto;">                           
               <nav aria-label="Page navigation" style="text-align:center">
                  <ul class="pagination" id="pagination"></ul>
               </nav>               
            </div>
</div>	.
</div>
</body>
<script>
var currPage = 1;
var totalPage = 2;
var now_board = '';

window.onload = function(){
	$('#studyReplyBtn').click();
	
}


$('#boardBtn input').click(function(){
	listCall(currPage,10,$(this).attr('id'));	
	now_board = $(this).attr('id');
	$('#boardBtn input[type="button"]').removeClass('onClk');
	$(this).addClass('onClk');
	
	
	
});


function listCall(page,cnt,board_name){

	$.ajax({
		url : 'myPageReplyListCall',
		type : 'get',
		data : {'page':page,'cnt':cnt,'board_name':board_name},
		dataType : 'json',
		success : function(data){
			console.log(data.replyList);
			console.log(board_name);
			totalPage = data.pages;
			if(board_name == 'studyReplyBtn'){
				studyReplyListCall(data.replyList);
			}
			if(board_name == 'freeReplyBtn'){
				freeReplyListCall(data.replyList);			
			}

            $('#pagination').twbsPagination({
                startPage: currPage,//현재 페이지
                totalPages: totalPage,//만들수 있는 총 페이지 수
                visiblePages:5, //[1][2][3]... 이걸 몇개 까지 보여줄 것인지
                onPageClick:function(evt,page){//해당 페이지 번호를 클릭했을때 일어날 일들
                   console.log(evt); //현재 일어나는 클릭 이벤트 관련 정보들
                   console.log(page);//몇 페이지를 클릭 했는지에 대한 정보
                   listCall(page,10,now_board);

                }
             });
			},
		error : function(e){
			console.log(e)
			}
	});	
}


function studyReplyListCall(list){
			var	txt = '';
			list.forEach(function(item,idx){
				var date = new Date(item.reg_date);
				txt += '<tr>';
				txt += '<td class="title"><a href="studyBoard/detail?board_no='+item.board_no+'"><h5>'+item.title+'</h5> ↳'+item.reply_content;
				if(item.answer_select){
					txt += '<span>[채택답변]</span>'
				}
				txt += '</a>';				
				txt += '</td>';
				txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '</tr>';
			});
			/*
			var txt_head = '<tr><td style="width : 300px;">제목</td><td>날짜</td></tr>';
			$('#list_head').empty();
			$('#list_head').append(txt_head);
			*/
			$('#list_body').empty();
			$('#list_body').append(txt);
}

function freeReplyListCall(data){
			var	txt = '';
			data.forEach(function(item,idx){
				var date = new Date(item.reg_date);
				txt += '<tr>';
				txt += '<td class="title"><a href="freeBoardDetail?board_no='+item.board_no+'"><h5>'+item.title+'</h5> ↳'+item.reply_content+'</a>';
				txt += '</td>';
				txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '</tr>';
			});
			/*
			var txt_head = '<tr><td>제목</td><td>날짜</td></tr>';
			$('#list_head').empty();
			$('#list_head').append(txt_head);
			*/
			$('#list_body').empty();
			$('#list_body').append(txt);
}




</script>
</html>