<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<link rel="stylesheet" href="resources/css/adminLefter.css"/>

	<style>
		#grid {
		min-height : 1000px;
		
		
		}	
			#mainPage{
			padding-right : 200px;
			padding-top : 10px;
			padding-left : 10px;
		}
		
	hr{
		border : 1px solid gray;
		margin : 10px 0px 10px 0px;
		width : 200px;
	}
	#ManageDePostList tr:nth-child(odd){
		background-color :  #e6ffe6;
		
	}
	#ManageDePostList tr:nth-child(odd) input{
		background-color :  #e6ffe6;	
	}
	#ManageDePostList tr:nth-child(even){
		background-color :  white;
		
	}
	#ManageDePostList tr:nth-child(even) input{
		background-color :  white;	
	}
	input[value="처리완료"]{
		border : none;
		color : skyblue;
	}
	input[value="처리대기"]{
		border : none;
		color : Tomato;	
	}
	td,th{
		height : 20px;
		font-size : 10px;
	}
		tr{
		height : 30px;
	}
	#pageTitle{
		text-align : left;
		width : 300px;
	}
	#pageTitle h3{
		font-weight : bold;
	}
	
	</style>
</head>
<body>
<%@ include file="../header.jsp" %>
	<div id="grid">
		<div>
			<iframe id="lefter" src="adminLefter"></iframe>			
		</div>
		<div id="mainPage" style="margin-left : auto;margin-right : auto;">
			<div id="pageTitle">
		<h3>신고 댓글</h3>
		<hr/>
		</div>	
	<div>
		<form action="ManagDeComentSearch" method="GET" name="ManagDeComentSearch" autocomplete="off">
			<select name ="SearchType">
				<option selected>출력 내용 선택</option>
				<option value="all">전체보기</option>
				<option value="ProcessWait">처리대기</option>
				<option value="ProcessCom">처리완료</option>
			</select>
			<input type="button" value="검색" id="btnSearch" onclick="SearchList()"/>
		</form>
	</div>
	<table>
		<thead>
			<tr>
				<th>게시글 종류</th>
				<th>댓글 번호</th>
				<!-- <th>게시글 제목</th> -->
				<th>신고자 ID</th>
				<th>신고 ID</th>
				<th>신고 사유</th>
				<th>신고 날짜</th>
				<th>처리 내용</th>
				<th>처리 여부</th>
			</tr>
		</thead>
		
		<tbody id = "ManageDeComentList">
 			
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
</div></div>
</body>
<script>

		//검색
		function SearchList(){
			$.ajax({
				type: 'GET',
				url : 'ManagDeComentSearch',
				data : $("form[name=ManagDeComentSearch]").serialize(),
				success : function(result){
					console.log("확인");
					//테이블 초기화
					$('#ManageDeComentList').empty();
					if(result.length>=1){
						var str = '';
						result.forEach(function(item){
							var date = new Date(item.reg_date);
							str="<tr>"
								if (item.board_name == 'study_board') {
									str+="<td>공부 게시판</td>";
								}else{
									str+="<td>자유 게시판</td>";
								}
							str+="<td>"+item.reply_no+"</td>";
							/* str+="<td>"+item.title+"</td>"; */
							str+="<td>"+item.report_user+"</td>";
							str+="<td>"+item.reported_user+"</td>";
							str+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
							str+="<td>"+item.report_processing +"</td>";
							
							if (item.report_state == 0){
								str+="<td>"+'<input type="button" id="Processing" onclick="manap('+item.report_no+')" value="처리대기"/>'+'</td>';					
							} else {
								str+="<td>"+'<input type="button" disabled="disabled" value="처리완료"/>'+'</td>';				
							}
							
							str+="</tr>";
							$('#ManageDeComentList').append(str);
							
			
		       		})				 
					} else{
						var str = '';
						str="<tr>"
						str+="<td><p>게시글이 존재하지 않습니다.</p></td>";
						str+="</tr>";
					}
				}
			})
			

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
				url:'ManagDeComentlist',
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
			list.forEach(function(item, report_no){
				
					var date = new Date(item.report_date);
					content+="<tr>";
						if (item.board_name == 'study_board') {
							content+="<td>공부 게시판</td>";
						}else{
							content+="<td>자유 게시판</td>";
						}
					content+="<td>"+item.reply_no+"</td>";
					/* content+="<td>"+item.title+"</td>"; */
					content+="<td>"+item.report_user+"</td>";
					content+="<td>"+item.reported_user+"</td>";
					content+="<td>"+item.report_reason+"</td>";
					content+="<td>"+date.getFullYear()+"-"+("0"+(date.getMonth()+1)).slice(-2)+"-"+("0" + date.getDate()).slice(-2)+"</td>";
					content+="<td>"+item.report_processing +"</td>";
					if (item.report_state == 0){
						content+="<td>"+'<input type="button" id="Processing" onclick="manap('+item.report_no+')" value="처리대기"/>'+'</td>';					
					} else {
						content+="<td>"+'<input type="button" disabled="disabled" value="처리완료"/>'+'</td>';				
					}			
					content+="</tr>";
					
				
			});
			//console.log(content);
			$('#ManageDeComentList').empty();
			$('#ManageDeComentList').append(content);
			
		}
		
		$('#L1').click(function(){
			location.href='./ManagDe' //어디로 갈지 링크 걸어주기
		});
		
		$('#L2').click(function(){
			location.href='./ManagDeComent'
		});
		
		
			function manap(e) {
			
			console.log("클릭 확인 : "+e);
			var inputOut = prompt("처리 내용을 입력해주세요.");
			//alert(inputOut1);

		     if(inputOut != null){
		    	 
		    	 $.ajax({
		    		 type: "GET", 
		    		 url: "ManagDeComUpdate", 
		    		 data: {"board_no":e, "inputOut":inputOut}, 
		    		 success: function(data){
		    			 console.log('처리 완료 : '+inputOut);
				    	 alert('처리 완료');
				    	 listCall(currPage,10);
		    		 }
		    	 });
		    	
		    		
		    	} 
		
			}
		
</script>
</html>