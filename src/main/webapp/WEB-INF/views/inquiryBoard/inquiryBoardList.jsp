<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
 <meta charset="UTF-8">
 <title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
 <style>
 </style>
</head>
<body>
<table>
		<tr>
			<td id="none"><button onclick="inqwrite()">글쓰기</button></td>
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
	   
	   <c:if test="${InquiryList eq null || size == 0}">
	   <tr><td colspan="5"> 등록된 글이 없습니다.</td></tr>
	   </c:if>
	   <c:forEach items="${InquiryList}" var="InquiryList">
	   <tr>
	      <td>${InquiryList.board_no}</td>
	      <td>${InquiryList.inquiry_category_name}</td>
	      <td><a class="board_title" href="inquireBoardDetail?board_no=${InquiryList.board_no}">${InquiryList.board_title}</a></td>
	      <td>${InquiryList.user_id}</td>
	      <td><fmt:formatDate value="${InquiryList.board_date}" pattern="yyyy. MM. dd"/></td>
	      
	      
	    <c:choose>
			<c:when test="${InquiryList.inquiry_answer eq 'Y'}">
				<td> <div class="icon" style="background-color: rgb(204, 41, 41)">답변완료</div></td>
			</c:when>
			<c:when test="${InquiryList.inquiry_answer == 'N'}">
				<td> <div class="icon" style="background-color: rgb(53, 236, 181)">답변대기</div></td>
			</c:when>
		</c:choose>
	       
	   </tr>
	   </c:forEach>
	</table>

</body>
<script>



</script>
</html>