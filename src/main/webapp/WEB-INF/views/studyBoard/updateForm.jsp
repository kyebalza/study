<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		table{
		/**/
			border: 1px solid #6AA84F;
			border-collapse: collapse;
			padding : 5px 10px;
		}
		th{
			height: 50px;
			background-color:#6AA84F;
			border: 1px solid #6AA84F;
			text-align: center;
			padding: 10px;
			margin:5px;
			color:white;
			
		}
		tr,td{
			border: 1px solid #6AA84F;
			text-align: center;
			padding: 10px;
			margin:5px;
			
		}
		input.button{
			text-align: center;
		}
		#sbListAll{
			/*
			max-width: 1200px;
            margin: 0 auto;
			padding: 10%,30%;
		*/
			min-width : 1150px;
			left: 20%;
		}
		.sbupdate{
			min-width : 1170px;
			border: 2px solid #6AA84F;
			padding : 15px;
			margin : auto;
		}
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<br/>
	<div id="sbListAll">
		<form id="sbupdate" action="update" method="post"  enctype="multipart/form-data">
			<table class="sbupdate">
				<tr>
					<th>제목</th>
					<td colspan="3">
		            	<input type="hidden" name="board_no" value="${dto.board_no}"/>
		            	<input type="text" class="title" name="title" value="${dto.title }"
		            		style="
								width: 230px;
								height: 30px;
								border-radius: 9px;
								border: 1px solid #6AA84F;
								text-align: center;
							"/>
				   </td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
		            	<input type="text" name="user_id" value="${dto.user_id }"
		            		style="
								width: 230px;
								height: 30px;
								border-radius: 9px;
								border: 1px solid #6AA84F;
								text-align: center;
							" readonly/>
				   </td>
				   <th>작성일자</th>
				   <td>
		            	<input type="text" name="user_id" value="${dto.reg_date}" 
		            		style="
								width: 230px;
								height: 30px;
								border-radius: 9px;
								border: 1px solid #6AA84F;
								text-align: center;
							"readonly/>
				   </td>
				</tr>
				<tr>
					<th style="width: 25px; text-align:center; padding : 15px;">문제</th>
					<td colspan="3">
						<!-- 문제 -->
						<div id="quiz">
						<p style="padding : 15px; text-align: left;">${Qinfo.quiz_index}번 문제.<br/> ${Qinfo.quiz_content}</p>
						<!-- 보기 -->
							<p class="option_num" style="padding : 5px; text-align: left;">보기1 : ${Qinfo.option1}</p>
							<p class="option_num" style="padding : 5px; text-align: left;">보기2 : ${Qinfo.option2}</p>
							<p class="option_num" style="padding : 5px; text-align: left;">보기3 : ${Qinfo.option3}</p>
							<p class="option_num" style="padding : 5px; text-align: left;">보기4 : ${Qinfo.option4}</p>
							<p class="option_num" style="padding : 5px; text-align: left;">보기5 : ${Qinfo.option5}</p>
						</div>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th style="width: 25px; text-align:center; padding : 15px;">내용</th>
					<td colspan="3" height="100px" style="padding : 15px;">
						<input name="content" value="${dto.content}"
							style="width: 603px; height: 112px; border-radius: 9px;
									border: 1px solid #6AA84F;
									text-align: center;
						"/>
					</td>
				</tr>
				<tr>
					<th>이미지</th>
					<td colspan="3" style="padding : 15px;" style="padding : 15px;">
						<c:if test="${photo != null}">
							<input class="pdel" type="hidden" name="photo_no" value="${photo.photo_no}"/>
							<img src="/photo/${photo.new_filename}" width="400px" height="400px"/>
							<a href="filedelete?photo_no=${photo.photo_no}&board_no=${dto.board_no}">삭제</a>
						</c:if>
					</td>
				</tr>
			</table>
			<br/>
			<input id="file" type="file" name="uploadFile" accept="image/jpg, image/jpeg, image/png"
							style="border: 1px solid #6AA84F;
										float:right;
										margin-right: 19%;"/>
			<br/>
			<div style="float: left;
							margin-left: 19%;">
				<input type="button" onclick="location.href='detail?board_no=${dto.board_no}'" value="취소"
					style="
							background-color : #6AA84F;
							color: white;
							border: none;
							margin: auto;
							width: 100px;
							height: 30px;
							border-radius: 11px;
					"/>
				<input class="update_submit" type="button" value="등록" 
					style="
							background-color : #6AA84F;
							color: white;
							border: none;
							margin: auto;
							width: 100px;
							height: 30px;
							border-radius: 11px;
					"/>
			</div>
		</form>
	</div>
	<%@ include file="../footer.jsp" %>
</body>
<script>

	
	
	$('.update_submit').click(function(){
		var title = $('input[name="title"]').val();
		var blank_pattern = /^\s+|\s+$/g;
		if(title.replace(blank_pattern, '') == ""){
			alert('제목은 필수입력 사항입니다.');
		}else{
			$('#sbupdate').submit();
		}
	});
</script>
</html>