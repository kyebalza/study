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
 
 <style>
 	table{
 		border: 2px solid green;
		text-align: center;
	}
	tr,td,th{
		border: 1px solid green;
	}
	input.button{
		text-align: center;
	}
	
	th{
		background-color: yellowgreen;
		text-align: center;
	}
	
	button{
		text-align: center;
		background-color : yellowgreen;
		color: white;
	}
		
 </style>
</head>
<body>

	<button onclick="location.href='inquiryWriteForm'">글쓰기</button>
	<div>
		<form action="InquiryBoardSearch" method="GET" name="InquiryBoardSearch" autocomplete="off">
		
			<select name = "ICateGoryType">
				<option selected>카테고리 선택</option>
				<option value="all">전체</option>
				<option value="account">계정문의</option>
				<option value="use">이용문의</option>
			</select>
		
		
			<select name ="SearchType">
				<option selected>검색 내용 선택</option>
				<option value="all">전체</option>
				<option value="tit">제목</option>
				<option value="user">작성자</option>
			</select>
			
			<input type="text" name="Keyword"/>
			<input type="button" value="검색" id="btnSearch" onclick="SearchList()"/>
		</form>
	</div>

	
	<table>
		<thead>
			<tr>
				<th style="color:white;">글번호</th>
				<th style="color:white;">제목</th>
				<th style="color:white;">카테고리</th>
				<th style="color:white;">작성자</th>
				<th style="color:white;">조회수</th>
				<th style="color:white;">작성일자</th>
				<th style="color:white;">답변여부</th>
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
</body>
<script>

	//검색
	function SearchList(){
		console.log("문의게시판 검색");
		$.ajax({
			type: 'GET',
			url : 'InquirySearchBoardList',
			data : $("form[name=InquiryBoardSearch]").serialize(),
			success : function(result){
				console.log("확인");
				//테이블 초기화
				$('#inquirylist').empty();
				if(result.length>=1){
					var str = '';
					result.forEach(function(item){
						var date = new Date(item.reg_date);
						str="<tr>"
						str+="<td>"+item.board_no+"</td>";
						str+="<td><a href='inquiryBoardDetail?board_no="+item.board_no+"'>"+item.title+"</a></td>";
						str+="<td>"+item.board_cate+"</td>";
						str+="<td>"+item.user_id+"</td>";
						str+="<td>"+item.bHit+"</td>";
						str+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
						
						if (item.answer == false) {
							str+="<td><div>답변대기</div></td>";
						}else{
							str+="<td><div>답변완료</div></td>";
						}
						
						str+="</tr>";
						$('#inquirylist').append(str);
						
		
	       		})				 
				}
			}
		})
	
	console.log($("form[name=InquirySearch]").serialize());
	console.log($("form[name=ICateGoryType]").serialize());
	console.log($("form[name=SearchType]").serialize());
}; 

	// 페이징 처리
	var currPage = 1;
	var totalPage = 2;
	
	listCall(currPage,10);
	
	/*
	function more(){
		currPage++;
		console.log('currPage',currPage);
		if(currPage>totalPage){
			$('button').attr('disabled',true);
		}else{
			listCall(currPage, 10);			
		}
	}
	*/
	
	
	function listCall(page, cnt){				
		
		$.ajax({
			type:'GET',
			url:'inquirylist',
			data:{'page':page,'cnt':cnt},
			dataTyps:'JSON',
			success: function(data){
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
						listCall(page, 10);
					}
				});
								
			},
			error:function(e){
				console.log(e);
			}
		});		
	}
	
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
					content+="<td><div>답변대기</div></td>";
				}else{
					content+="<td><div>답변완료</div></td>";
				}
				
				content+="</tr>";
		});
		//console.log(content);
		$('#inquirylist').empty();
		$('#inquirylist').append(content);
		
	}
  	


</script>
</html>