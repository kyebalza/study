<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
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
	<p>회원 관리 시스템</p>
	</br>
	</br>
	</br>
	<div>
		<form action="MemSearch" method="GET" name="MemSearch" autocomplete="off">
			<select name ="SearchType">
				<option selected>검색 내용 선택</option>
				<option value="all">전체</option>
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="email">이메일</option>
			</select>
			<input type="text" name="Keyword"/>
			<input type="button" value="검색" id="btnSearch" onclick="SearchList()"/>
		</form>
	</div>
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>핸드폰</th>
				<th>관리자여부</th>
				<th>계정상태</th>
			</tr>
		</thead>
		<tbody id = "Memlist">
 			
		</tbody>
			<tr>
				<td colspan="6" id="paging" >
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
			url : 'MemSearchList',
			data : $("form[name=MemSearch]").serialize(),
			success : function(result){
				console.log("확인");
				//테이블 초기화
				$('#Memlist').empty();
				if(result.length>=1){
					var str = '';
					result.forEach(function(item){
						str="<tr>"
						str+="<td><a href='ADdetail?idx="+item.user_id+"'>"+item.user_id+"</a></td>";
						str+="<td>"+item.user_name+"</td>";
						str+="<td>"+item.user_email+"</td>";
						str+="<td>"+item.use_phone+"</td>";
						str+="<td>"+item.user_admin+"</td>";
						str+="<td>"+item.ser_state+"</td>";
						str+="</tr>";
						$('#"Memlist"').append(str);
						
		
	        		})				 
				}
			}
		})
		
		console.log($("form[name=MemSearch]").serialize());
		console.log($("form[name=SearchType]").serialize());
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
			listCall(currPage, 10);			
		}
	}
	
	 function listCall(page, cnt){				
	
		$.ajax({
			type:'GET',
			url:'Memlist',
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
		list.forEach(function(item, user_id){
				content+="<tr>"
				content+="<td><a href='ADdetail?user_id="+item.user_id+"'>"+item.user_id+"</a></td>";
				content+="<td>"+item.user_name+"</td>";
				content+="<td>"+item.user_email+"</td>";
				content+="<td>"+item.user_phone+"</td>";
				content+="<td>"+item.user_admin+"</td>";				
				content+="<td>"+item.user_state+"</td>";	
				content+="</tr>";
		});
		//console.log(content);
		$('#Memlist').empty();
		$('#Memlist').append(content);
		
	}
	
	
</script>
</html>
