<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 확인 페이지</title>
<script>
	window.onload = function(){
		if(${result == 1}){
			document.getElementById("resultText").innerHTML="아이디가 중복입니다. 사용할수 없습니다.";
			opener.document.getElementById("id").value = "";
		}else{
			document.getElementById("resultText").innerHTML="사용하실수 있는 아이디입니다.";
			opener.document.getElementById("id").setAttribute("flag","true");
		}
		document.getElementById("close").onclick = function(){
			close(); 
		}
		//팝업창에서 opener 라고 부르면 해당 팝업창을 open 한 창을 지칭할수있다.
		//이 팝업창의 opener는 joinForm.jsp
		//opener.document.getElementById("id")
	}
</script>
</head>
<body>
	<br>
	<div id="resultText"></div>
	<br>
	<button id="close">닫기</button>
</body>
</html>