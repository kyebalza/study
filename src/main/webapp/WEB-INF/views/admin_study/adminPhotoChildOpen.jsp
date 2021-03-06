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
 	<form action="adminQuizPhotoUpload" method="post" enctype="multipart/form-data">
		<input type="file" name="photos"/>
		<input type="hidden" name="quizCnt" value="${quizCnt }"/>
		<button>저장</button>
		<h5>*파일을 첨부하지 않고 저장버튼을 누르면, 기존 사진만 삭제됩니다.</h5>
	</form>
	<c:if test="${newPhotoName ne null }">
		<div id="image_container">
				<img src="/photo/${newPhotoName}" class="${newPhotoName}" width="250px"/>
				<a href="#" class="${newPhotoName}" onclick="delPhoto()">삭제</a>
				<br/><br/>
		</div>	
	</c:if>
</body>
<script>
console.log("${quizCnt}")

console.log("${newPhotoName}");
var newPhotoName = "${newPhotoName}";
var oriPhotoName = "${oriPhotoName}";
var quizCnt = "${quizCnt}";
var index = "${index}";


if(newPhotoName == ''){
	console.log('null입니다!');

} else {
	console.log('부모창의 quizCnt에 newPhotoName 을 보냅니다.');
	$('.photoArea.'+quizCnt,opener.document).empty();
	var txt = '';
	txt += '<img src="/photo/'+newPhotoName+'" class="quiz_img "'+quizCnt+'"/>';
	txt += '<input type="hidden" class="quiz_img_newName '+quizCnt+'" value="'+newPhotoName+'"/>';
	txt += '<input type="hidden" class="quiz_img_oriName '+quizCnt+'" value="'+oriPhotoName+'"/>';
	$('.photoArea.'+quizCnt,opener.document).append(txt);
	window.close();
	
}
if(index == '-1'){
	$('.photoArea.'+quizCnt,opener.document).empty();
	
	window.close();
}


</script>
</html>