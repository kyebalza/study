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
	<script src="resources/js/.bootstrap.min.js"></script>
   <link rel="stylesheet" href="resources/css/bootstrap.min.css"/>		
	<style>
	#header{
		width: 100%;
		height: 100px;
		/* border-style: none; */
		overflow: hidden;
	}
	body{
	margin : 0px;
	}	
	span{
		padding-left : 300px;
		font-size : 10px;
	}
	#list_body img{
		height : 10px;
		width : 10px;
	}
	
	.no{
		width : 80px;
	}	
	.cate{
		width : 100px;
	}
	.title{
		width : 500px;
	}
	.bhit{
		width : 100px;
	}
	.date{
		width : 150px;
	}



		
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>




	<div id="mainPage">
<div id="all">
<div id="myPageHeader">
<!-- 	<input type="button" value="내 알림" onclick="location.href='myNotice'"/> -->	
	<input type="button" id="nowPage" value="내가 쓴 게시글" onclick="location.href='myBoard'"/>
	<input type="button" value="내가 쓴 댓글" onclick="location.href='myReply'"/>
	<input type="button" value="응시한 시험" onclick="location.href='myTest'"/>
	<input type="button" value="회원정보" onclick="location.href='myInfo'"/>

</div>
<div id="boardBtn">
	<input type="button" id="studyBoardBtn" value="공부게시판"/>
	<input type="button" id="freeBoardBtn" value="자유게시판"/>
	<input type="button" id="inquiryBoardBtn" value="문의게시판"/>		
</div>		
<table style="text-align : center;margin-left: auto; margin-right: auto;">
	<thead id="list_head"></thead>
	<tbody id="list_body"></tbody>
</table>
	<div class="container" style="width : 500px;text-align : center;margin-left: auto; margin-right: auto;">                           
		<nav aria-label="Page navigation" style="text-align:center">
	    	<ul class="pagination" id="pagination"></ul>
		</nav>               
	</div>

<div>
</div>		
</div>	
</div>	
</body>
<script>
var currPage = 1;
var totalPage = 2;
var now_board = '';
//listCall(currPage,10,'studyBoardBtn');
window.onload = function(){
	$('#studyBoardBtn').click();
	
}

$('#boardBtn input').click(function(){
	listCall(currPage,10,$(this).attr('id'));	
	now_board = $(this).attr('id');
	$('#boardBtn input[type="button"]').removeClass('onClk');
	$(this).addClass('onClk');
	
	
	
});


function listCall(page,cnt,board_name){

	$.ajax({
		url : 'myPageBoardListCall',
		type : 'get',
		data : {'page':page,'cnt':cnt,'board_name':board_name},
		dataType : 'json',
		success : function(data){
			console.log(data.boardList);
			console.log(board_name);
			totalPage = data.pages;
			if(board_name == 'studyBoardBtn'){
				studyBoardListCall(data.boardList);
			}
			if(board_name == 'freeBoardBtn'){
				freeBoardListCall(data.boardList);			
			}
			if(board_name == 'inquiryBoardBtn'){
				inquiryBoardListCall(data.boardList);
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


function studyBoardListCall(list){
			var	txt = '';
			list.forEach(function(item,idx){
				var date = new Date(item.reg_date);
				txt += '<tr>';
				txt += '<td class="no">'+item.board_no+'</td>';
				txt += '<td class="cate">'+item.board_cate+'</td>';
				txt += '<td class="title"><a href="studyBoard/detail?board_no='+item.board_no+'">'+item.title+'</a><br/><span><img src="resources/img/reply.png"/>'+item.like_cnt+'<img src="resources/img/like.png"/>'+item.reply_cnt+'</span></td>';
				txt += '<td class="bhit">'+item.bHit+'</td>';
				txt += '<td class="date">'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '</tr>';
			});
			var txt_head = '<tr><td class="no">번호</td>'
			+'<td class="cate">자격증</td>'
			+'<td class="subject">게시글 제목</td>'
			+'<td class="bhit">조회수</td>'
			+'<td class="date">날짜</td></tr>';
			
			
			$('#list_head').empty();
			$('#list_head').append(txt_head);
			
			$('#list_body').empty();
			$('#list_body').append(txt);
}

function freeBoardListCall(data){
			var	txt = '';
			data.forEach(function(item,idx){
				var date = new Date(item.reg_date);
				txt += '<tr>';
				txt += '<td>'+item.board_no+'</td>';
				txt += '<td>'+item.board_cate+'</td>';
				txt += '<td ><a href="freeBoardDetail?board_no='+item.board_no+'">'+item.title+'</a><br/><span><img src="resources/img/reply.png"/>'+item.like_cnt+'<img src="resources/img/like.png"/>'+item.reply_cnt+'</span></td>';
				txt += '<td>'+item.bHit+'</td>';
				txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '</tr>';
			});
			var txt_head = '<tr><td class="no">번호</td>'
			+'<td class="cate">카테고리</td>'
			+'<td class="title">게시글 제목</td>'
			+'<td class="bhit">조회수</td>'
			+'<td class="date">날짜</td></tr>';
	
			$('#list_head').empty();
			$('#list_head').append(txt_head);
			
			$('#list_body').empty();
			$('#list_body').append(txt);
}

function inquiryBoardListCall(data){
			var	txt = '';
			data.forEach(function(item,idx){
				var date = new Date(item.reg_date);
				txt += '<tr>';
				txt += '<td>'+item.board_no+'</td>';
				txt += '<td>'+item.board_cate+'</td>';
				txt += '<td><a href="inquiryBoardDetail?board_no='+item.board_no+'">'+item.title+'</a><br/><span><img src="resources/img/reply.png"/>'+item.like_cnt+'<img src="resources/img/like.png"/>'+item.reply_cnt+'</span></td>';
				txt += '<td>'+item.bHit+'</td>';
				txt += '<td>'+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+'</td>';
				txt += '</tr>';
			});
			var txt_head = '<tr><td class="no">번호</td>'
				+'<td class="cate">카테고리</td>'
				+'<td class="title">게시글 제목</td>'
				+'<td class="bhit">조회수</td>'
				+'<td class="date">날짜</td></tr>';
				
			$('#list_head').empty();
			$('#list_head').append(txt_head);
			
			$('#list_body').empty();
			$('#list_body').append(txt);
}



</script>
</html>