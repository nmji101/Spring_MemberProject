<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script  src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<script>
		if(${result > 0}){
			alert("축하드립니다!! 회원가입되었습니다.");
		}else{
			alert("회원가입이 실패했습니다.");
		}
		location.href = "/";
	</script>
</body>
</html>