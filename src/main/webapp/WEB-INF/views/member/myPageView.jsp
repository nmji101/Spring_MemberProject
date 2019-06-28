<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
			table {
				width: 900px;
				margin: 100px auto;
				color: #910c0c;
				background-color: rgba(255, 228, 196, 0.26);
				font-size: 25px;
				border-radius: 5px;
			}
			th{
				background-color: rgba(255, 38, 38, 0.22);
				height : 50px;
				border-radius: 5px;
			}
			input{
				background-color: rgba(89, 191, 255, 0.21);
				color: #910c0c;
				border: #910c0c;
				cursor:pointer;
				border-radius: 5px;
				padding : 10px;
				font-size : 15px;
			}
			input[type=button]{
				cursor: pointer;
				border: 1px solid #910c0c;
				width: 80px;
				height: 40px;
				font-size: 15px;
			}
			input[type=button]:hover{
				background-color: rgba(203, 196, 255, 0.44);
			}
			td{
				height: 45px;
			}
			#footer{
				text-align: center;
			}
			.firstCol{
				text-align: right;
				width: 200px;
				font-size: 18px;
				padding: 0px;
				height: 40px;
			}
			.inputDirt{
				height: 90%;
				width: 220px;
			}
			#filsoo{
				height: 20px;
				background-color: rgba(255, 213, 38, 0.67);
				font-size: 15px;
				text-align: right;
			}
			input[readonly]{
				height: 90%;
				width: 220px;
				background-color: rgba(114, 214, 90, 0.19);
			}
			#footer>input{
				width: 200px;
			}
			#profile{
				width:50px;
				border-radius: 10px;
				position: relative;
				left: 150px;
			}
			#profile_Modify_Btn{
				width:180px;
				position: relative;
				left: 150px;
			}
		</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script>
	window.onload = function(){
		//되돌아가기
		document.getElementById("toIndex").onclick = function(){
			location.href = "/";
		};
	}
</script>
</head>
<body>
		<table>
			<tr>
				<th colspan="2">마이페이지</th>
			</tr>
			<tr>
				<td><img id="profile" src="/image${userInfo.profile }"></td>
				<td>${userInfo.name} 님 환영합니다~</td>
			</tr>
			<tr>
				<td class="firstCol">아이디 :</td>
				<td><input type="text" id="id" value="${userInfo.id}" name="id" readonly>
				</td>
			</tr>
			<tr>
				<td class="firstCol">이름 :</td>
				<td><input id="name" type="text" value="${userInfo.name}" class="inputDirt" readonly></td>
			</tr>
			<tr>
				<td class="firstCol">핸드폰번호 :</td>
				<td><input type="text" class="inputDirt" value="${userInfo.phone}" readonly
					placeholder="000-0000-0000"></td>
			</tr>
			<tr>
				<td class="firstCol">이메일 :</td>
				<td><input type="text" class="inputDirt" value="${userInfo.email}" readonly
					placeholder="이메일 형식"></td>
			</tr>
			<tr>
				<td class="firstCol">우편번호 :</td>
				<td><input type="text" id="postcode"
					name="zipcode" value="${userInfo.zipcode}" readonly>
				</td>
			</tr>
			<tr>
				<td class="firstCol">주소1 :</td>
				<td><input type="text" id="address1"
					name="address1" value="${userInfo.addr1}" readonly></td>
			</tr>
			<tr>
				<td class="firstCol">주소2 :</td>
				<td><input type="text" value="${userInfo.addr2}" class="inputDirt" readonly></td>
			</tr>
			<tr>
				<td class="firstCol">가입날짜 :</td>
				<td><input type="text" value="${userInfo.joindate}" readonly></td>
			</tr>
			<tr>
				<td colspan="2" id="footer">
					<input id="toIndex" type="button" value="메뉴선택으로 돌아가기">
				</td>
			</tr>
		</table>
</body>
</html>