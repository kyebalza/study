<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
	<!-- 아래 요 친구가 있어야지 페이징이 깨지지 않아요 -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<style>
		table,tr,th,td{
			border:1px solid black;
			border-collapse : collapse ;
		}
	</style>
</head>
<body>
	<p onclick="location.href='adminPage'">관리자 페이지</p>
	</br>
	<p>게시물 관리 시스템</p>
	<div>
		<a target="_blank" id="L1" style="color: black; cursor:pointer;">공부 질문</a>
		<a target="_blank" id="L2" style="color: black; cursor:pointer;">자유</a>
		<a target="_blank" id="L3" style="color: black; cursor:pointer;">문의</a>
	</div>
	</br>
	<p>공부 게시판 관리</p>
	</br>
	</br>
	</br>
	<div>
		<form action="StudySearch" method="GET" name="StudySearch" autocomplete="off">
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
				<th>번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>작성자</th>
				<th>작성 날짜</th>
				<th>조회수</th>
				<th>삭제</th>
			</tr>
		</thead>
		
<%-- 			<c:if test="${studyboardlist eq null || size == 0}">
			<tr><td colspan="7">해당 게시글은 존재하지 않습니다.</td></tr>
			</c:if> --%>
		
		<tbody id = "studyboardlist">
 			
		</tbody>
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
		$.ajax({
			type: 'GET',
			url : 'StudySearchList',
			data : $("form[name=StudySearch]").serialize(),
			success : function(result){
				console.log("확인");
				//테이블 초기화
				$('#studyboardlist').empty();
				if(result.length>=1){
					var str = '';
					result.forEach(function(item){
						var date = new Date(item.reg_date);
						str="<tr>"
						str+="<td>"+item.board_no+"</td>";
						str+="<td><a href='detail?idx="+item.board_no+"'>"+item.title+"</a></td>";
						str+="<td>"+item.board_cate+"</td>";
						str+="<td>"+item.user_id+"</td>";
						str+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
						str+="<td>"+item.bHit+"</td>";
						
						if (item.del_flag == false){
							str+="<td>"+'<input type="button" class="why" onclick="studydel('+item.board_no+')" value="삭제"/>'+'</td>';					
						} else {
							str+="<td>"+'<input type="button" class="why" onclick="studydel('+item.board_no+')" value="복구"/>'+'</td>';				
						}
						
						str+="</tr>";
						$('#studyboardlist').append(str);
						
		
	        		})				 
				} else{
					var str = '';
					str="<tr>"
					str+="<td><p>게시글이 존재하지 않습니다.</p></td>";
					str+="</tr>";
				}
			}
		})
		
		console.log($("form[name=StudySearch]").serialize());
		console.log($("form[name=SearchType]").serialize());
	}; 
	
	
	//페이징 처리
	var currPage = 1;
	var totalPage = 10;

	
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
	
	//리스트를 불러올때 하단 생성
 	function listDraw(list){ 
		console.log("리스트 호출 확인");
		/* console.log(board_no,item); */
		var content = '';	
		list.forEach(function(item, board_no){
			
				var date = new Date(item.reg_date);
				content+="<tr>";
				content+="<td>"+item.board_no+"</td>";
				content+="<td><a href='detail?idx="+item.board_no+"'>"+item.title+"</a></td>";
				content+="<td>"+item.board_cate+"</td>";
				content+="<td>"+item.user_id+"</td>";
				content+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
				content+="<td>"+item.bHit+"</td>";
				if (item.del_flag == false){
					content+="<td>"+'<input type="button" class="why" onclick="studydel('+item.board_no+')" value="삭제"/>'+'</td>';					
				} else {
					content+="<td>"+'<input type="button" class="why" onclick="studydel('+item.board_no+')" value="복구"/>'+'</td>';				
				}				
				content+="</tr>";
				
			
		});
		//console.log(content);
		$('#studyboardlist').empty();
		$('#studyboardlist').append(content);
		
	}

		var me = this;
	
	//관리자 공부 게시글 삭제
	function studydel(e) {
		console.log(e);
		
		$.ajax({
			context: this,
			type:'POST',
			url:'studydel',
			data:{"board_no":e}, // {}안에 아무것도 안넣으면 다보여줘라 라는 뜻
			dataType:'JSON',
			success:function(studydel_check) {
				if (studydel_check == 0) {
					console.log("삭제 성공");
					listCall(currPage,10);
				}else {
					console.log("복구 성공");
					listCall(currPage,10);
				}
			},
			error:function(e) {
				console.log(e);
			}
		});
	}
	
	$('#L2').click(function(){
		location.href='./ManagPostFree'
	});
	
	$('#L3').click(function(){
		location.href='./ManagPostInquriy' //어디로 갈지 링크 걸어주기
	});
	

</script>
</html>
