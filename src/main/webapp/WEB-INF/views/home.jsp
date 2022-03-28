<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/header.css"/>
	
	<style>
	li{
		padding : 5px;
	}
	table,th,td{
		border-collapse : collapse;
	}
	
	#allDiv {
		height : 500px;
		margin-left : auto;
		margin-right : auto;
		/*
		border : 1px solid blue;
		*/
		padding-top: 200px;
	}
	#rankingDiv {
		margin-left : auto;
		margin-right : auto;
	

		width : 910px;
		height : 300px;
	}
	#boardDiv{
		margin-left : auto;
		margin-right : auto;
		width : 800px;
		/*
		border : 1px solid tomato;
		*/
	}
	
	#rankingDiv div{
		/*
		border : 1px solid red;
		*/
		width : 300px;
		height : 300px;
		float : left;
	}
	table{
		float : left;
		/*
		border : 1px solid yellow;
		*/
		text-align : center;
		width : 400px;
	}
	tbody th,tbody td{
		border-bottom : 1px solid lightGreen;
	}
	thead th{
		border-bottom : 2px solid lightGreen;
	}
	
	/*이벤트 슬라이더*/
	.animation_canvas {/*실제로 보여지는 위치*/
		overflow:hidden;/*보여지지 않는 부분을 가려라*/
		position: relative;/*옆 사진과 관계*/
		width :1887px;
		height :650px;
	}
	.slider_panel{
		width: 9435px;
		height: auto;
		position:relative
	}
	.slider_image{
		float : left;
		width: 1887px;
		height:650px;
	}
	.control_panel{
		position:absolute;
		top: 780px;
   		left: 880px;
		height :13px;
		overflow:hidden
	}
	.control_button{
		width :12px;
		height:46px; 
		position:relative;
		float: left;
		cursor:pointer;
		background: url('resources/img/point_button.png')
	}
	/*버튼이 원래 세로로 되어 있음 즉 버튼이 총 10개 보여지는 버튼은 5개*/
	.control_button:hover{top:-16px;}
	.control_button.select{top:-31px;}
	
	
	
	</style>
</head>
<body>
<%@ include file="./header.jsp" %>
	
	<!-- 이벤트 슬라이더 -->
	<div class="animation_canvas">
			<div class="slider_panel">
				<img src="resources/img/event1.jpg" class="slider_image" alt="event1_img"/>
				<img src="resources/img/event2.jpg" class="slider_image" alt="event2_img"/>
				<img src="resources/img/event3.png" class="slider_image" alt="event3_img"/>
				<img src="resources/img/event4.png" class="slider_image" alt="event4_img"/>
				<img src="resources/img/event5.png" class="slider_image" alt="event5_img"/>
			</div>
		</div>		
		<div class="control_panel">
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
			<div class="control_button"></div>
		</div>


<div id="allDiv">
	<div id="rankingDiv">
		<div>
			<h3>열심상</h3>
			<ol id="manyQuiz">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
		<div>
			<h3>다득점</h3>
			<ol id="manyCorrect">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
		<div>
			<h3>백발백중</h3>
			<ol id="manyCorrectPer">
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
			
	</div>
	
	<div id="boardDiv">
		<table>
			<thead>
				<tr><th colspan="2">공부게시판 인기 게시글</th></tr>
			</thead>
			<tbody id="studyBoardLike">
			</tbody>
		</table>
		<table>
			<thead>
				<tr><th colspan="2">자유게시판 인기 게시글</th></tr>
			</thead>
			<tbody id="freeBoardLike">
			</tbody>
		</table>
	</div>
</div>



<%@ include file="./footer.jsp" %>



</body>
<script>
setInterval(mainStatics(),5000);


function mainStatics(){
	$.ajax({
		url : 'mainStatics',
		type: 'get',
		data : '',
		dataType : 'json',
		success : function(data){
			console.log(data);
			var manyQuiz = '';
			data.manyQuiz.forEach(function(item,idx){
				manyQuiz += '<li>'+item.user_id+'  '+item.ccw+'개 </li>';
				});
			var manyCorrect = '';
			data.manyCorrect.forEach(function(item,idx){
				manyCorrect += '<li>'+item.user_id+'  '+item.scw+'개 </li>';	
				});
			var manyCorrectPer = '';
			data.manyCorrectPer.forEach(function(item,idx){
				manyCorrectPer += '<li>'+item.user_id+'  '+item.per*100+'% </li>';
				});
			
				
			$('#manyQuiz').empty();
			$('#manyQuiz').append(manyQuiz);
			$('#manyCorrect').empty();
			$('#manyCorrect').append(manyCorrect);
			$('#manyCorrectPer').empty();
			$('#manyCorrectPer').append(manyCorrectPer);
			var studyBoardLike = '';
			data.studyBoardLike.forEach(function(item,idx){
				studyBoardLike += '<tr>';
				studyBoardLike += '<td><img src="resources/img/like.png"/>'+item.like_cnt+'</td>';
				studyBoardLike += "<td>"+"<a onclick='goStudyBoard(\""+item.board_no+"\")'>"+item.title+"</a>"+"</td>";
				studyBoardLike += '</tr>';
			});
			
			
			$('#studyBoardLike').empty();
			$('#studyBoardLike').append(studyBoardLike);
			var freeBoardLike = '';
			data.freeBoardLike.forEach(function(item,idx){
				freeBoardLike += '<tr>';
				freeBoardLike += '<td><img src="resources/img/like.png"/>'+item.like_cnt+'</td>';
				freeBoardLike += "<td>"+"<a onclick='goFreeBoard(\""+item.board_no+"\")'>"+item.title+"</a>"+"</td>";
				freeBoardLike += '</tr>';
			});
			$('#freeBoardLike').empty();
			$('#freeBoardLike').append(freeBoardLike);
		},
		
		error : function(e){console.log(e);}
		
		
		
		
	});
	
	
	
}

function goStudyBoard(board_no){
	location.href='./studyBoard/detail?board_no='+board_no;
}

function goFreeBoard(board_no){
	location.href='freeBoardDetail?board_no='+board_no;
}




//이벤트 슬라이더

		$(".control_button").each(function(index){
			$(this).attr("idx",index); 
		});

		$(".control_button").click(function(){ 
			var sindex =$(this).attr("idx");
			moveSlider(sindex);
		});

		function moveSlider(sindex){
			var moveLeft= -(sindex *1887);
			$(".slider_panel").animate({left:moveLeft},'slow');
			$(".control_button[idx="+sindex+"]").addClass("select");
			$(".control_button[idx!="+sindex+"]").removeClass("select");
		}

		
		moveSlider(0);
		var idx=0;
		var inc=1;

		setInterval(function(){
			if(idx>=4){
				inc=-1;
			};

			if(idx<=0){
				inc=1;
			}

			idx+=inc;
			moveSlider(idx);
		},50000)//idx가 4면 inc는 -1을 넣어서 거꾸로 가게 | idx가 0이면 inc는 1을 넣어서 거꾸로 가게

</script>
</html>