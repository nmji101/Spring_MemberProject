<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<title>회원로그인_Spring</title>
				<style>
					table{
						text-align: center;
						margin: 100px auto;
						color: #910c0c;
						background-color: rgba(255, 228, 196, 0.26);
						font-size: 25px;
						border-radius: 5px;
					}
					th{
						background-color: rgba(255, 38, 38, 0.22);
						height : 100px;
						border-radius: 5px;
						line-height: 150px;
					}
					.a{
						padding: 0px;
					}
					input{
						background-color: rgba(89, 191, 255, 0.21);
						color: #910c0c;
						border: #910c0c;
						cursor:pointer;
						border-radius: 5px;
					}
					input[class="a"]{
						padding: 20px 50px;
						font-size: 20px;
					}
					input[class="b"]{
						padding: 50px;
						font-size: 25px;
					}
					#bottom>input{
						padding: 30px 70px;
						font-size: 25px;
						font-weight:550;
					}
					.text{
						text-align: right;
					}
					input:hover{
						background-color: rgba(203, 196, 255, 0.44);
					}
					#loginNaver{
            			background-color : transparent;
            			border : none;
            			cursor : pointer;
            		}
            		#profile{
						width:50px;
						border-radius: 10px;
						position: relative;
						top:20px;
					}
				</style>
				<!-- 제이쿼리로 쓰면 if로 상황 안나누고 써도 가능함! $("") -->
				<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
				<script>
					window.onload = function() {
						//
						if(${loginId != null}){
							$("title").text("로그인성공");
							$("#logOutBtn").on("click",function(){
								location.href="logout";
							});
							document.getElementById("dropUser").onclick= function(){
								var result = confirm("정말 탈퇴하시겠습니까? 탈퇴하지 마세요..ㅠㅅㅠ");
								if(result==true){
									location.href = "/";
								}
							};
							$("#toMyPage").on("click",function(){
								location.href = "myPageProc";
							});
							$("#toModifyInfoProc").on("click",function(){
								location.href = "modifyInfo";
							});
							$("#toBoard").on("click",function(){
								location.href = "toBoard";
							});
						}else{
							//	
							document.getElementById("toJoinForm").onclick = function() {
								location.href = "joinForm";
							}
							document.getElementById("tologin").onclick = function() {
								var id = document.getElementById("id");
								var pw = document.getElementById("pw");
								if(id.value==""){
									alert("아이디를 입력해주세요.");
									return;
								}else if(pw.value==""){
									alert("비밀번호를 입력해주세요.");
									return;
								}
								document.getElementById("loginForm").submit();
							}
							document.getElementById("loginNaver").onclick = function(){
								alert("미구현 기능");
			        		}
						}
					};
				</script>
			</head>
			<body>
				<c:choose>
					<c:when test="${loginId !=null }">
						<table>
							<tr>
								<th colspan="5"><img id="profile" src="/image${profile}">⭐ ${ loginId }님 환영합니다. ⭐</th>
							</tr>
							<tr>
								<td><input id="toBoard" type="button" value="게시판으로" class="b"></td>
								<td><input id="toModifyInfoProc" type="button" value="정보수정" class="b"></td>
								<td><input id="toMyPage" type="button" value="마이페이지" class="b"></td>
								<td><input id="dropUser" type="button" value="회원탈퇴" class="b"></td>
								<td><input id="logOutBtn" type="button" value="로그아웃" class="b"></td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<form action="loginProc" method="post" id="loginForm">
							<table>
								<tr>
									<th colspan="2">회원로그인_Spring</th>
								</tr>
								<tr>
									<td class="text">아이디 :</td>
									<td class="a"><input type="text" id="id" name="id" class="a"></td>
								</tr>
								<tr>
									<td class="text">비밀번호 :</td>
									<td class="a"><input type="password" id="pw" name="pw" class="a"></td>
								</tr>
								<tr>
									<td colspan="2" id="bottom">
										<input type="button" value="로그인" id="tologin">
										<input type="button" value="회원가입" id="toJoinForm">
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button type="button" id="loginNaver"><img height="80px" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></button>
									</td>
								</tr>
							</table>
						</form>
					</c:otherwise>
				</c:choose>
			</body>
		</html>