<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <script src="resources/js/jquery.twbsPagination.js"></script>
 <style>
 </style>
</head>
<body>

	<form action="inquiryBoardList" method="get">
	<table>
		<tr>
			<td id="none"><button onclick="inquiryWrite()">글쓰기</button></td>
			<td id="none" colspan="5"></td>
		</tr>
		
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일자</th>
			<th>답변여부</th>
		</tr>
		
		<c:if test="${InquiryBoardList eq null || size == 0}">
			<tr><td colspan="1">해당 게시글은 존재하지 않습니다.</td></tr>
		</c:if>
		
		<c:forEach items="${InquiryBoardList}" var="InquiryBoardList">
		<tr>
			<td>${InquiryBoardList.board_no}</td>
			<td><a class="inquiry_title" href="inquiryBoardDetail?board_no=${InquiryBoardList.board_no}"><${InquiryBoardList.title}></a></td>
			<td>${InquiryBoardList.board_cate_no}</td>
			<td>${InquiryBoardList.user_id}</td>
			<td>${InquiryBoardList.bHit}</td>
			<td>${InquiryBoardList.reg_date}</td>
			
			<c:choose>
				<c:when test="${InquiryBoardList.answer eq 'Y'}">
					<td> <div class="icon" style="background-color: rgb(204, 41, 41)">답변완료</div></td>
				</c:when>
				<c:when test="${InquiryBoardList.answer eq 'N'}">
					<td> <div class="icon" style="background-color: rgb(53, 236, 181)">답변대기</div></td>
				</c:when>
			</c:choose>

		</tr>		
		</c:forEach>
		
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
	</form>

	

</body>
<script>

var session = "${sessionScope.loginId}";
console.log(session);

if(session == ''){
	console.log('비로그인');
}

   	function inqwrite(){
  		if(session == '') {
  			alert('로그인 후 이용해주세요!!');
  		} else{
	  		location.href='inquiryWriteForm';
  			
  		}
  		
  		
  	};
  	
  	var startpage = "${nowpage}";
    startpage = startpage*1;
    var totalpage = "${pages}";
    totalpage = (totalpage*1) -1 ;
    console.log(startpage);
    console.log(totalpage);
    
       /* 페이징에 관한 곳 */
       $('#pagination').twbsPagination({
          startPage : startpage,
          totalPages : totalpage,
          visiblePages : 5,
          onPageClick:function(evt,page){
             console.log(evt);
             console.log(page);
             if("${nowpage}" != page) {
                location.href="./inquiryBoardList"+"?currpage="+page;         
             }
          }
       
       });


</script>
</html>