<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>  
	<script src="resources/js/jquery.twbsPagination.js"></script>
	<script src="resources/js/.bootstrap.min.js"></script>
	<link rel="stylesheet" href="resources/bootstrap.min.css"/>
	<!-- <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script> -->
	<style>
		table,th,td{
			border : 1px solid black;
			border-collapse : collapse ;
			padding : 5px;
		}
		iframe{
			width: 100%;
			height: 210px;
			border-style: none;
		} 
		
		.myMenu{
			cursor: pointer;
			padding: 20px;
		}
		.myMenu:hover{
			background-color: beige;
		}
		#myMenuBar{
			text-align: center;
		}		
		table{
	         margin-left: auto;
	         margin-right: auto;
	         min-width: 1296px;
    	}
	     .board_title{
		    display: block;
	        color: black;
	        width: 350px;
	        font-weight: bolder !important;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        white-space: nowrap;
		}
		.etc{
			display: block;
	        color: black;
	        width: 245px;
	        font-weight: bolder !important;
	        overflow: hidden;
	        text-overflow: ellipsis;
	        white-space: nowrap;
		}
	</style>
</head>
<body>
  	
  	<div id = "myMenuBar">  
		<img style="background-color: beige" class="myMenu" src="resources/img/my주문내역.png"  alt="my주문내역" loc="myorderList?currpage=1">
        <img class="myMenu" src="resources/img/my문의글.png" alt="my문의글" loc="myInquire?currpage=1">
        <img class="myMenu" src="resources/img/my요청글.png" alt="my요청글" loc="myRequire?currpage=1">
        <img class="myMenu" src="resources/img/my찜리스트.png" alt="my찜리스트" loc="myWish?currpage=1">
        <img class="myMenu" src="resources/img/my회원정보수정.png" alt="my회원정보" loc="myProfile">
    </div>
<!-- 	<div>
		<a href="myorderList">내 주문 내역</a>
		<a href="myWish">찜리스트</a>
		<a href="myRequire">내가 쓴 요청글</a>
		<a href="myInquire">내가 쓴 문의글</a>
		<a href="myProfile">회원정보수정</a>
	</div> -->
	<table>
		<tr>
			<th>주문번호</th>
			<th>주문날짜</th>
			<th>게시글제목</th>
			<th>게시글상태</th>
			<th>주문상태</th>
			<th>주문수량</th>
			<th>비고</th>
		</tr>
		
		
		<c:if test="${orderList eq null || size == 0}">
		<tr><td colspan="7">등록된 글이 없습니다.</td></tr>
		</c:if>
		<c:forEach var="orl" items="${orderList}" >
		<tr>
			<th><a href="orderDetail?order_no=${orl.order_no}&frompage=myorderList">${orl.order_no}</a></th>
			<th><fmt:formatDate value="${orl.order_date}" pattern="yyyy. MM. dd"/></th>
			<th><div class="board_title"><a href="groupbuydetail?board_no=${orl.board_no}&frompage=myorderList">${orl.board_title}</a></div></th>		
			<th>${orl.groupbuy_state}</th>	
			<th>${orl.order_state}</th>		
			<th>${orl.order_quantity }</th>
			<th><div class="etc">${orl.order_etc}</div></th>		
		</tr>			
		</c:forEach>
		
		<!-- 페이징 영역 -->
		<tr>
			<td colspan="7">
				<div class="container">
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</td>
		</tr>
		<!-- 페이징 영역 -->
	</table>
	<div>

	
	</div>

   <iframe src="footer"></iframe>
	
</body>
<script>
	//console.log("${orderList}");
	
	$(".myMenu").click(function(){
	    location.href=$(this).attr("loc");
	});

	
	var totalpage = "${pages}";
	console.log("totalpage : "+totalpage);
	/* 페이징에 관한 곳 */
	$('#pagination').twbsPagination({
		startPage : "${nowpage}",
		totalPages : totalpage,
		visiblePages : 5,
		onPageClick:function(evt,page){
			console.log(evt);
			console.log(page);
			if("${nowpage}" != page) {
				location.href="./myorderList?currpage="+page;			
			}
		}

	});
	
	
	
</script>
</html>