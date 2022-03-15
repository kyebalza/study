<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		#r_controller{/*라이터 접었다폈다 버튼*/
			
		}
		#righter{/*라이터 전체*/
			border: 1px solid green;
			width: 300px;
			height: 100%;
			float: right;
			background-color: green;
			color: white;
			text-align: center;
		}
		#user{/*라이터 안 로그인,마이페이지,알림*/
			margin:60px 0px 0px 0px;
		}
		a:link{/*클릭전 링크가 걸려 있는 상태*/
                color: white;/*글자색상*/
                text-decoration: none;/*링크의 밑줄 등...*/
            }
        a:visited{/*클릭하여 이미 링크를 방문한 상태*/
                color:white;
                text-decoration: none;
            }
	</style>
</head>
<body>
	<div id="r_controller">
		<button id="close">접기>></button>
		
	</div>
	<div id="righter">
		<div id="user">
			<a href="login" id="login">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#" id="mypage">마이페이지</a><br/><br/>
			<a href="#" id="alarm">내 알림</a>
		</div>
	</div>
</body>
<script>

</script>
</html>