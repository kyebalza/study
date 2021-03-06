<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
 <script src="resources/js/jquery.twbsPagination.js"></script>
 	<!-- 아래 요 친구가 있어야지 페이징이 깨지지 않아요 -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<link rel="stylesheet" href="resources/css/header.css"/>
	<script src="resources/js/.bootstrap.min.js"></script>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css"/>
 
 <style>
 
 	.List {
 		min-width : 1170px;
		border: 2px solid #6AA84F;
		text-align: center;
		padding : 10px;
		margin : auto;
 	}
	
	.List tr,th,td {
		border: 1px solid green;
		text-align: center;
		padding: 5px;
	}
	
	button {
		text-align: center;
		position: relative;
		background-color : #6AA84F;
		color: white;
		border: none;
		margin: auto;
		width: 100px;
		height: 30px;
		border-radius: 11px;
	}
	
	.inquirySearch {
		float: right;
		left: 40%;
	
	}
	
	.ilall{
		min-width : 1150px;
		display: flex;
	}
	
	.ilin{
		margin: auto;
	}
	

	.select{
		border: 1px solid #6AA84F;
		width: 100px;
		margin: 5px;
		height: 30px;	
		border-radius: 9px;
		text-align: center;
		background: #6AA84F;
		color: white;
	}
	
	
	.select option{
		background: white;
		color: black;
		border: 1px solid #6AA84F;
		border-radius: 9px;
	}
	
	.a{
		border: solid red;
		background-color: red;
		color: white;
		border-radius: 20px;
	}
	
	.b{
		border: solid blue;
		background-color: blue;
		color: white;
		border-radius: 20px;
	}
	
	
	
	
 </style>
</head>
<body>

	
	<%@ include file="../header.jsp" %>
	<br/><br/><br/><br/>
	
	<div class="ilall">
		<div class="ilin">
			<div>
				<button class="button" onclick="location.href='inquiryWriteForm'">글쓰기</button>
			
			<form class="inquirySearch" action="InquiryBoardSearch" method="GET" name="InquiryBoardSearch" autocomplete="off">
				<select class="select" name ="SearchType">
					<option value="all" selected>제목+내용</option>
					<option value="tit">제목</option>
					<option value="user">작성자</option>
				</select>
				
				<input type="text" name="Keyword" placeholder="검색할 내용을 입력해주세요." style="
					width: 230px;
					height: 30px;
					border-radius: 9px;
					border: 1px solid #6AA84F;
					text-align: center;"
				/>
				<input type="button" value="검색" id="btnSearch"
					style="
						background-color : #6AA84F;
						color: white;
						border: none;
						margin: auto;
						width: 100px;
						height: 30px;
						border-radius: 11px;
					"				
				/>
			</form>
		</div>

	
			<table class="List">
				<thead>
					<tr style="background: #6AA84F; color:white;">
						<th>글번호</th>
						<th>제목</th>
						<th>카테고리</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일자</th>
						<th>답변여부</th>
					</tr>
					</thead>
				
				<!--  
				
				<c:if test="${list eq null || size ==0}">
				<tr><td colspan="7">등록된 글이 없습니다.</td></tr>
				</c:if>
				
				-->	
				
				<tbody id= "inquirylist"></tbody>
					<tr>
						<td colspan="7" id="paging" >
							<div class="container" style="width:850px;">                           
					        	<nav aria-label="Page navigation" style="text-align:center;">
					            	<ul class="pagination" id="pagination"></ul>
					         	</nav>               
					        </div>
						</td>
					</tr>	
			</table>
	</div>
</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
	

	
	
</body>
<script>
// 페이징 처리
var currPage = 1;
var totalPage = 2;

SearchList(currPage,10);
$('#btnSearch').click(function(){
	
	$('#pagination').twbsPagination('destroy');
	SearchList(currPage,10);
	currPage = 1;
});

$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	    $('#btnSearch').click();
	  };
	});

	//검색
	function SearchList(page, cnt){
		console.log("문의게시판 검색");
		$.ajax({
			type: 'GET',
			url : 'InquirySearchBoardList',
			data : $("form[name=InquiryBoardSearch]").serialize() +"&page="+page+"&cnt="+cnt,
			success : function(data){
				console.log(data);
				totalPage = data.pages;
				listDraw(data.list);
				$('#pagination').twbsPagination({
					startPage: currPage,//현재 페이지
					totalPages: totalPage,//만들수 있는 총 페이지 수
					visiblePages:5, //[1][2][3]... 이걸 몇개 까지 보여줄 것인지
					onPageClick:function(evt,page){//해당 페이지 번호를 클릭했을때 일어날 일들
						console.log(evt); //현재 일어나는 클릭 이벤트 관련 정보들
						console.log(page);//몇 페이지를 클릭 했는지에 대한 정보
						currPage = page;
						SearchList(page, 10);
					}
				});

			}
		})
}; 



	
	// 리스트를 불러올 때 하단 생성
	function listDraw(list){ 
		console.log("리스트 호출 확인");
		var content = '';	
		list.forEach(function(item, board_no){
			
				var date = new Date(item.reg_date);
				content+="<tr>"
				content+="<td>"+item.board_no+"</td>"; // 글번호
				content+="<td><a href='inquiryBoardDetail?board_no="+item.board_no+"'>"+item.title+"</a></td>"; // 제목
				content+="<td>"+item.board_cate+"</td>"; // 카테고리
				content+="<td>"+item.user_id+"</td>"; // 작성자
				content+="<td>"+item.bHit+"</td>"; // 조회수
				content+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>"; // 작성일자
				
				if (item.answer == false) { // 답변여부
					content+="<td><div class='a'>답변대기</div></td>";
					
				}else{
					content+="<td><div class='b'>답변완료</div></td>";					
				}
				
				content+="</tr>";
		});
		//console.log(content);
		$('#inquirylist').empty();
		$('#inquirylist').append(content);
		
	}
  	


</script>
</html>