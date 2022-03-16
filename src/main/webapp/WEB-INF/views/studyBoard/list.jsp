<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
	<!-- 아래 요 친구가 있어야지 페이징이 깨지지 않아요 -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="/bank/resources/js/jquery.twbsPagination.js"></script>
	<style>
		table{
			border: 2px solid green;
			text-align: center;
			padding : 10px;
		}
		tr,td,th{
			border: 1px solid green;
			text-align: center;
			
		}
		input.button{
			text-align: center;
			background-color : green;
			color: white;
		}
		button{
			text-align: center;
			background-color : green;
			color: white;
		}
	</style>
</head>
<body>
	<button class="button" onclick="location.href='writeForm'">글쓰기</button>
	
	<!-- 카테고리 검색 -->
	<form action="studyboardSearch" method="GET" name="studyboardSearch" autocomplete="off">
			<select name ="SearchType">
				<option selected>검색 내용 선택</option>
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="user">작성자</option>
			</select>
			<input type="text" name="Keyword"/>
			<input type="button" value="검색" onclick="studySearch()"/>
		</form>
		<!-- 카테고리 검색 -->
		
	<!-- 게시판 리스트 -->
	<table>
		<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>작성일자</th>
		</tr>
		</thead>
		<tbody id="boardlist"></tbody>
		<tr>
			<td colspan="5" id="paging">
				<div class="container">
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagenation" id="pagination"></ul>
					</nav>
				</div>
			</td>
		</tr>
	</table>
</body>
<script>


	//검색
	function studySearch(){
		//console.log("검색");
		$.ajax({
			type:'GET',
			url:'studySearch',
			data: $("form[name=studyboardSearch]").serialize(),
			success : function(result){
				console.log("확인");
				//테이블 초기화
				$('#boardlist').empty();
				if(result.length>0){
					var str = '';
					result.forEach(function(item){
						var date = new Date(item.reg_date);
						str += '<tr>';
						str += '<td>'+item.board_no+'</td>';
						str += '<td><a href="detail?board_no='+item.board_no+'">'+item.title+'</a></td>';
						str += '<td>'+item.board_cate+'</td>';
						str += '<td>'+item.user_id+'</td>';
						str += "<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
						str += '</tr>';
						
						$('#boardlist').append(str);
					
					})
				}
			}
		});
		console.log($("form[name=studyboardSearch]").serialize());
		console.log($("form[name=SearchType]").serialize());
	}; 


	//페이징
	var currPage = 1;
	var totalPage = 2;
	
	listCall(currPage,10);
	
	function listCall(page, cnt){
		
		$.ajax({
			type:'GET',
			url:'listCall',
			data:{'page':page, 'cnt':cnt},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				totalPage = data.pages;
				listDraw(data.list);
				
				$('#pagination').twbsPagination({
					startPage: currPage,//현재페이지
					totalPages: totalPage,//만들 수 있는 총 페이지 수
					visiblePages: 5,//[1],[2],[3]...이걸 몇개까지 보여줄 것인지
					onPageClick: function(evt,page){//해당 페이지 번호를 클릭했을 때 일어날 일들
						console.log(evt);//현재 일어나는 클릭 이벤트 관련 정보들
						console.log(page);//몇 페이지를 클릭했는지에 대한 정보
						listCall(page, 10);
					}
				});
			},
			error:function(e){
				console.log(e);
			}
		});
		
	}
	/*
	function listDraw(list){
		console.log("리스트 호출 확인");
		var content = "";
		
		for(var i = 0; i < list.length; i++){
			console.log(list[i]);
			content += '<tr>';
			content += '<td>'+list[i].board_no+'</td>';
			content += '<td><a href="studyBoard/detail?board_no='+list[i].board_no+'">'+list[i].title+'</a></td>';
			content += '<td>'+list[i].board_cate_no+'</td>';
			content += '<td>'+list[i].user_id+'</td>';
			content += '<td>'+list[i].reg_date+'</td>';
			content += '</tr>';
		}
		$('#list').empty();
		$('#list').append(content);
	}
	*/
	function listDraw(list){ 
		console.log("리스트 호출 확인");
		var content = '';	
		list.forEach(function(item, board_no){
			
				var date = new Date(item.reg_date);
				content += '<tr>';
				content += '<td>'+item.board_no+'</td>';
				content += '<td><a href="detail?board_no='+item.board_no+'">'+item.title+'</a></td>';
				content += '<td>'+item.board_cate_no+'</td>';
				content += '<td>'+item.user_id+'</td>';
				content += "<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
				content += '</tr>';
				
			
		});
		//console.log(content);
		$('#boardlist').empty();
	    $('#boardlist').append(content);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</html>