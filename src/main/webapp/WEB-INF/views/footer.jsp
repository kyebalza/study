<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
	<style>
		 #warp{
                min-height: 100vh;
                position: relative;
                width: 100%;
            }
            footer{
                background-color: #2b2b2b;
                color: white;
                width: 100%;
                bottom: 0px;
                position: absolute;
                font-size: 5px;
            }
            .test{
                /* background-color: blue; */
                width: 25%;
                position: relative;
                left: 3%;
                float: left;
            }
            .test2{
                /* background-color: blue; */
                width: 25%;
                position: relative;
                left: 15%;
                float: left;
            }
            .test3{
                /* background-color: blue; */
                width: 25%;
                position: relative;
                left: 20%;
                float: left;
            }
	</style>
</head>
<body>
        <div id="wrap">
            <footer>
                <div class="test">
                    <p style="font-size: 15px; font-weight: bold;">정보</p>
                    <p>상호명 : 구띠</br>
                        대표이사 : XXX</br>
                        사업자등록번호 : 222-22-222222</br>
                        주소 : 서울시 가산구</br>
                        통신판매업신고 : 2022-서울가산-0680</br>
                        개인정보처리방침</br>
                        이용약관</br>
                    </p>   
                </div>
                <div class="test2">
                    <p style="font-size: 15px; font-weight: bold;">브랜드</p>
                    <p>루비이통</br></br>
                        루이까또즈</br></br>
                        구찌</br></br>
                        상호명</br>
                    </p>
                </div>
                <div class="test3">
                    <p style="font-size: 15px; font-weight: bold;">문의사항</p>
                    <p>전화번호 : 02-XXX-XXXX</br></br>
                        이메일 : guddi@gmail.com</br></br>
                        Q&A</br></br>
                    </p>
                </div>
            </footer>
        </div>

</body>
<script>
	
</script>
</html>
