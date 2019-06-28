<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>에러</title>
<style>
#wrapper {
	border: 1px solid #910c0c;
	box-sizing: border-box;
	background-color: rgba(255, 228, 196, 0.26);
	color: #910c0c;
	border-radius: 10px;
	margin: 100px auto;
	font-size: 20px;
	width: 700px;
	height: 180px;
	text-align: center;
	padding: 10px 10px;
}

#toIndex {
	background-color: rgba(89, 191, 255, 0.21);
	color: #910c0c;
	border: #910c0c;
	cursor: pointer;
	border-radius: 5px;
	border: 1px solid #910c0c;
	width: 200px;
	height: 50px;
	margin: 15px 0px;
	font-size: 15px;
}

#toIndex:hover {
	background-color: rgba(203, 196, 255, 0.44);
}

#footer {
	height: 150px;
}
</style>
<script>
				window.onload = function(){
					document.getElementById("toIndex").onclick = function(){
						location.href = "/";
						//하위 진입시 슬래시(/)는 안쓴다.
					}
				}
			</script>
</head>
<body>
	<div id="wrapper">
		<div>에러가 발생했습니다. 관리자에게 문의하세요.</div>
		<div>에러메세지 : ${error }</div>
		<div>(관리자메일:nmji101@naver.com)</div>
		<div id="footer">
			<button id="toIndex">
				<b>메인으로 돌아가기</b>
			</button>
		</div>
	</div>
</body>
</html>