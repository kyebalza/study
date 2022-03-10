<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
		<script src="resources/js/jquery.twbsPagination.js"></script>
	<style>
		table,tr,th,td{
			border:1px solid black;
			border-collapse : collapse ;
		}
	</style>
</head>
<body>
	<p>게시물 관리 시스템</p>
	<p>공부 질문</p>
	<p>자유</p>
	<p>문의</p>
	</br>
	</br>
	</br>
	<div>
		<form action="StudySearch" method="GET" name="search_study">
			<select id ="searchType" id="type">
				<option selected value="all">전체보기</option>
				<option value="tit">제목</option>
				<option value="user">작성자</option>
			</select>
			<input type="text" name="keyword"/>
			<input type="button" value="검색" id="searchBtn" onclick="SearchList()"/>
		</form>
	</div>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>작성자</th>
				<th>작성 날짜</th>
				<th>조회수</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody id = "studyboardlist">
			<c:if test="${list eq null || size == 0}">
				<tr>
					<td colspan="7"> 해당하는 게시글이 존재하지 않습니다. </td>
				</tr>
			</c:if>
			<!-- 데이터 삽임 후 출력 안되면 itmes를 list로 변경해볼것 -->
			<c:forEach items="${list}" var="item">
				<tr>
					<td>${item.board_no}</td>
					<td><a href="detail?idx=${studylist.board_no}">${item.title}</a></td>
					<td>${item.board_cate}</td>
					<td>${item.user_id}</td>
					<td>${item.reg_date}</td>
					<td>${item.bHit}</td>
					<td><input type="button" value="삭제"/></td>
				</tr>
			</c:forEach>
		</tbody>
			<tr>
				<td colspan="5" id="paging" >
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

function SearchList(){
	
	console.log($("form[name=search_study]").serialize());
	//검색
	
	$.ajax({
		type: 'GET',
		url : 'StudySearchList',
		data : $("form[name=search_study]").serialize(),
		success : function(result){
			console.log("확인");
			//테이블 초기화
			$('#studyboardlist').empty();
			if(result.length>=1){
				var str = '';
				result.forEach(function(item){
					str="<tr>"
					str+="<td style='width:15%'>"+item.board_no+"</td>";
					str+="<td style='width:15%'>"+item.title+"</td>";
					str+="<td style='width:40%'>"+item.board_cate+"</td>";
					str+="<td style='width:15%'>"+item.user_id+"</td>";
					str+="<td style='width:15%'>"+item.reg_date+"</td>";
					str+="<td style='width:15%'>"+item.bHit+"</td>";
					str+="<td style='width:15%'>"+"<input type='button' value='삭제'/>"+"</td>";
					str+="</tr>";
					$('#studyboardlist').append(str);
					
	
        		})				 
			}
		}
	})
};


//페이징 처리
var currPage = 1;
var totalPage = 2;

listCall(currPage,10);

function more(){ //다음 페이지로 넘겼을 때
	currPage++;
	console.log('currPage',currPage);
	if(currPage>totalPage){
		$('button').attr('disabled',true);
	}else{
		listCall(currPage, 100);			
	}
}

/* function listCall(page, cnt){				
	
	$.ajax({
		type:'GET',
		url:'studylist',
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


function listDraw(list){ //리스트를 불러올때 하단 생성
	var content = '';	
	list.forEach(function(item, mem_id){
		var date = new Date(item.mem_date);
		content += "<tr>";
		content += "<td style='width:15%'>"+item.board_no+"</td>";
		content += "<td style='width:15%'>"+item.title+"</td>";
		content += "<td style='width:40%'>"+item.board_cate+"</td>";
		content += "<td style='width:15%'>"+item.user_id+"</td>";
		content += "<td style='width:15%'>"+item.reg_date+"</td>";
		content += "<td style='width:15%'>"+item.bHit+"</td>";
		content += "<td style='width:15%'>"+"<input type='button' value='삭제'/>"+"</td>";
		content += "</tr>";	
	});
	//console.log(content);
	$('#studyboardlist').empty();
	$('#studyboardlist').append(content);		
} */


</script>
</html>
