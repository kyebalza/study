<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<!-- 아래 요 친구가 있어야지 페이징이 깨지지 않아요 -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="resources/css/header.css"/>
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<script src="resources/js/.bootstrap.min.js"></script>
   <link rel="stylesheet" href="resources/css/bootstrap.min.css"/>
	<style>
		.List{
			min-width : 1170px;
			border: 2px solid #6AA84F;
			text-align: center;
			padding : 10px;
			margin : auto;
			
		}
		.List tr,td,th{
			border: 1px solid #6AA84F;
			text-align: center;
			padding: 5px;
		}
		input.button{
			text-align: center;
			background-color : #6AA84F;
			color: white;
		}
		button{
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
		.FreeSearch{
			 float: right;
			 left : 40%;
		}
		.flall{
			/* position: absolute; */
			/* background: blue; */
			min-width : 1150px;
			/* left: 30%; */
			display: flex;
		}
		.flin{
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
		
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	</br></br></br></br></br>
	<div class="flall">
		<div class="flin">
			<div>
				<c:if test="${loginId  != null}">
					<button class="button" onclick="location.href='freewriteForm'">글쓰기</button>
				</c:if>
				
				<!-- 카테고리 검색 -->
					<form class = "FreeSearch" action="FreeboardSearch" method="GET" name="FreeboardSearch" autocomplete="off">
						<!-- <select	name = "FBSearchType" class="select">
							<option value="fball" selected>전체</option>
							<option value="testim">시험 정보</option>
							<option value="worry">고민 상담</option>
							<option value="cert">자격증</option>
							<option value="jock">잡담</option>
						</select> -->
						
						<select name ="SearchType" class="select">
							<option value="all" selected>전체</option>
							<option value="tit">제목</option>
							<option value="user">작성자</option>
						</select>
						<input type="text" name="Keyword" placeholder="검색할 내용을 입력해주세요." style="
							width: 230px;
							height: 30px;
							border-radius: 9px;
							border: 1px solid #6AA84F;
							text-align: center;
						"/>
						<input type="button" value="검색" 
							onKeypress="javascript:if(event.keyCode == 13){fbSearchList()}"
							style="
								background-color : #6AA84F;
								color: white;
								border: none;
								margin: auto;
								width: 100px;
								height: 30px;
								border-radius: 11px;
						"/>
					</form>
			</div>	
				<!-- 카테고리 검색 -->
				
			<!-- 게시판 리스트 -->
			<table class="List">
				<thead style="background: #6AA84F; color:white;">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>카테고리</th>
					<th>작성자</th>
					<th>작성일자</th>
				</tr>
				</thead>
				<tbody id="Fboardlist"></tbody>
			</table>
			<table class="paging" style="border: none;">
				<tr style="border: none;">
					<td colspan="5" id="paging" style="border: none;">
						<div class="container">
							<nav aria-label="Page navigation" style="text-align:center">
								<ul class="pagenation" id="pagination"></ul>
							</nav>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
		<%@ include file="../footer.jsp" %>
	
</body>
<script>
//페이징
var currPage = 1;
var totalPage = 2;


$('input[value="검색"]').click(function(){
	$('#pagination').twbsPagination('destroy');
	fbSearchList(currPage,10);
	currPage = 1;
});

$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	    $('input[value="검색"]').click();
	  };
	});

	//검색
	function fbSearchList(page, cnt){
		console.log("검색");
		$.ajax({
			type:'GET',
			url:'FreeSearch',
			data: $("form[name=FreeboardSearch]").serialize() +"&page="+page+"&cnt="+cnt,
			success : function(result){
				console.log(result);
				totalPage = result.pages;
				//테이블 초기화
								
				var str = '';
				
				if(result.list.length>=1){
					result.list.forEach(function(item){
						var date = new Date(item.reg_date);
						str += '<tr>';
						str += '<td>'+item.board_no+'</td>';
						str += '<td><a href="freeBoardDetail?board_no='+item.board_no+'">'+item.title+'</a></td>';
						str += '<td>'+item.board_cate+'</td>';
						str += '<td>'+item.user_id+'</td>';
						str += "<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
						str += '</tr>';

					})
				} else {
					str += '<tr><td colspan="5">검색결과가 없습니다.</td></tr>';
				}
				console.log(str);
				$('#Fboardlist').empty();
				$('#Fboardlist').append(str);
					$('#pagination').twbsPagination({
						startPage: currPage,//현재 페이지
						totalPages: totalPage,//만들수 있는 총 페이지 수
						visiblePages:5, //[1][2][3]... 이걸 몇개 까지 보여줄 것인지
						onPageClick:function(evt,page){//해당 페이지 번호를 클릭했을때 일어날 일들
						console.log(evt); //현재 일어나는 클릭 이벤트 관련 정보들
						console.log(page);//몇 페이지를 클릭 했는지에 대한 정보
						currPage = page;
						fbSearchList(page, 10);
					}
				});
			}
		});
		/* console.log($("form[name=studyboardSearch]").serialize());
		console.log($("form[name=SearchType]").serialize()); */
	}; 



	
	listCall(currPage,10);
	
	function more(){ //다음 페이지로 넘겼을 때
		currPage++;
		console.log('currPage',currPage);
		if(currPage>totalPage){
			$('button').attr('disabled',true);
		}else{
			listCall(currPage, 10);			
		}
	}

	function listCall(page, cnt){
		
		$.ajax({
			type:'GET',
			url:'FBlistCall',
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
				content += '<td><a href="freeBoardDetail?board_no='+item.board_no+'">'+item.title+'</a></td>';
				content += '<td>'+item.board_cate+'</td>';
				content += '<td>'+item.user_id+'</td>';
				content += "<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
				content += '</tr>';
				
			
		});
		//console.log(content);
		$('#Fboardlist').empty();
	    $('#Fboardlist').append(content);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</html>