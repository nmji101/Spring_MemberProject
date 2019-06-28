<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정보수정</title>
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
				border-radius: 5px;
				padding : 10px;
				font-size : 15px;
			}
			input[type=button],input[type=reset]{
				cursor: pointer;
				border: 1px solid #910c0c;
				width: 80px;
				height: 40px;
				font-size: 15px;
			}
			input[type=button]:hover,input[type=reset]:hover{
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
				width: 300px;
			}
			#result{
				font-size : 18px;
				margin : 0px 7px;
			}
			#filsoo{
				height: 20px;
				background-color: rgba(255, 213, 38, 0.67);
				font-size: 15px;
				text-align: right;
			}
			input[readonly]{
				height: 90%;
				width: 300px;
				background-color: rgba(255, 104, 10, 0.13);
			}
			#footer>input{
				width: 200px;
			}
			.imgDiv{
				text-align: center;
				position: relative;
				left:50px;
			}
			#imgWrapper{
				display: inline-block;
				overflow: hidden;
				border-radius: 10px;
				width: 80px;
				height: 80px;
			}
			#profile{
				height: 80px;
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
		$("#toIndex").on("click",function(){
			location.href = "/";
		});
		$("#profile_Modify_Btn").on("click",function(){
			window.open("profileModify","","width=500px,height=500px");
		});
        $(".inputDirt").on("focus",function(){
            $(this).parent().css("background-color","rgba(215, 250, 216, 0.81)");
   	 	});
    	$(".inputDirt").on("focusout",function(){
            $(this).parent().css("background-color","transparent");
    	});
		
		$(".pwCheck").on("input",function(){
        	//flag는 pw확인 일치하는지.
        	$("#pw3").attr("flag","false");
        	var input1 = $("#pw2").val();
        	var input2 = $("#pw3").val();
        	var result = $("#result");
        	if(input1==""&&input2==""){
        		result.text("");
        	}else if(input1==""){
        		alert("패스워드를 입력해주세요.");
        		$("#pw3").val("");
        		$("#pw2").focus();
        	}else if(input2==""){
        		//
        	}else{
                if(input1==input2){
                	$("#pw3").attr("flag","true");
                    result.text("비밀번호가 일치합니다.");
                    result.css("color","#17b755");
                }else{
                    result.text("비밀번호가 일치하지 않습니다.");
                    result.css("color","#ce3535");
                }
        	}	
        });
		//이름 갯수 검사
        $("#name").on("input",function(){
        	var nameRegex = /^.{1,6}$/;
        	if(nameRegex.exec($(this).val())==null){
        		alert("이름은 1~6글자를 입력해주세요.");
        			var cut = $(this).val().substr(0,6);
        			$(this).prop("value",cut);
        		}
        });
		
		$("#search").on("click", searchAddress);
		//주소API
        function searchAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraRoadAddr !== ''){
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address1").value = roadAddr;
                    //document.getElementById("address2").value = data.jibunAddress;
                }
            }).open();
        };
        var count=0;
        $("#toModify").on("click",function(){
        	var modiResult = confirm("이대로 수정하시겠습니까?");
        	if(modiResult){
        		if($("#pw1").val()==""){	//비밀번호 제대로 입력했는지.
        			alert("기존 비밀번호를 입력해주세요."); 
        			$("#pw1").focus();
        			return;
        		}

        		$.ajax({
        			url:"pwCheck",
        			data : $("#pw1").val(),
        			type: 'POST',
        		}).done(function(resp){
        			if(resp!="ok"){
        				alert("비밀번호를 확인하세요.\r\n (비밀번호틀린횟수:"+(++count)+"/3)");
            			if(count==3){
        					alert("비밀번호 입력이 3회 틀렸습니다. 로그아웃됩니다.");
        					location.href = "LogoutProc.mem";
        				}
        				return;
        			}
        			if($("#pw2").val()!=""){ //비밀번호 변경시
            			//폼 제출..?
                		var pwRegex = /^[a-zA-Z0-9!@#]{6,20}$/;
                    	var pwResult = pwRegex.exec($("#pw2").val());
                    	if(pwResult==null){
                    		//pw확인
                    		alert("pw조건에 맞춰 적어주세요.\r\n -> 대소문자,숫자,!@# 조합 6자~20자");
                    		$("#pw2").focus();
                    		return;
                    	}else if($("#pw3").attr("flag")=="false"){
                    		alert("비밀번호 확인을 정확히 입력해주세요.");
                    		return;
                    	}
                    	$("#pw2").prop("name","pw");
                    	$("#pw1").prop("name",false);
            		}

            		
                	if($("#name").val()==""){
                		alert("이름은 필수입력입니다.\r\n이름을 1~6글자로 입력해주세요.");
                		return;
                	}
                	
                	$("#modifyForm").submit();
        			
        		})
//         		else if($("#pw1").val()!="${sessionScope.loginPw}"){ //비밀번호잘못입력하면..
//         			alert("비밀번호를 확인하세요.\r\n (비밀번호틀린횟수:"+(++count)+"/3)");
//         			if(count==3){
//         				alert("비밀번호 입력이 3회 틀렸습니다. 로그아웃됩니다.");
//         				location.href = "LogoutProc.mem";
//         			}
//         			return;
//         		}
        		
//         		if($("#pw2").val()!=""){ //비밀번호 변경시
//         			//폼 제출..?
//             		var pwRegex = /^[a-zA-Z0-9!@#]{6,20}$/;
//                 	var pwResult = pwRegex.exec($("#pw2").val());
//                 	if(pwResult==null){
//                 		//pw확인
//                 		alert("pw조건에 맞춰 적어주세요.\r\n -> 대소문자,숫자,!@# 조합 6자~20자");
//                 		$("#pw2").focus();
//                 		return;
//                 	}else if($("#pw3").attr("flag")=="false"){
//                 		alert("비밀번호 확인을 정확히 입력해주세요.");
//                 		return;
//                 	}
//                 	$("#pw2").prop("name","pw");
//                 	$("#pw1").prop("name",false);
//         		}

        		
//             	if($("#name").val()==""){
//             		alert("이름은 필수입력입니다.\r\n이름을 1~6글자로 입력해주세요.");
//             		return;
//             	}
            	
//             	$("#modifyForm").submit();
        	}
        });
		
	}
</script>
</head>
<body>
	<form action="ModifyInfoProc" id="modifyForm">
		<table>
			<tr>
				<th colspan="2">정보수정</th>
			</tr>
			<tr>
				<td><div class="imgDiv"><span id="imgWrapper"><img id="profile" src="/image${userInfo.profile }"></span></div></td>
				<td>${userInfo.name} 님 환영합니다~</td>
			</tr>
			<tr>
				<td colspan="2"><input id="profile_Modify_Btn" type="button" value="프로필사진 수정하기"></td>
			</tr>
			<tr>
				<td class="firstCol">아이디 :</td>
				<td><input type="text" id="id" value="${userInfo.id}"  name="id" readonly>
				</td>
			</tr>
			<tr>
				<td class="firstCol">*비밀번호 확인 :</td>
				<td><input type="password" id="pw1" class="inputDirt pwCheck"
					name="pw"></td>
			</tr>
			<tr>
				<td class="firstCol">변경할 비밀번호 :</td>
				<td><input type="password" id="pw2" class="inputDirt pwCheck"
					></td>
			</tr>
			<tr>
				<td class="firstCol">변경할 비밀번호확인 :</td>
				<td><input type="password" id="pw3" class="inputDirt pwCheck"
					flag="false"><span id="result"></span></td>
			</tr>
			<tr>
				<td class="firstCol">이름 :</td>
				<td><input id="name" type="text" value="${userInfo.name}" class="inputDirt" name="name"></td>
			</tr>
			<tr>
				<td class="firstCol">핸드폰번호 :</td>
				<td><input type="text" class="inputDirt" name="phone"
					placeholder="000-0000-0000" value="${userInfo.phone}"></td>
			</tr>
			<tr>
				<td class="firstCol">이메일 :</td>
				<td><input type="text" class="inputDirt" name="email"
					placeholder="이메일 형식" value="${userInfo.email}"></td>
			</tr>
			<tr>
				<td class="firstCol">우편번호 :</td>
				<td><input type="text" id="postcode"
					name="zipcode" value="${userInfo.zipcode}" readonly placeholder="찾기 버튼을 눌러주세요.">
					<input type="button" value="찾기" id="search">
				</td>
			</tr>
			<tr>
				<td class="firstCol">주소1 :</td>
				<td><input type="text" id="address1"
					name="addr1" value="${userInfo.addr1}" readonly required></td>
			</tr>
			<tr>
				<td class="firstCol">주소2 :</td>
				<td><input type="text" class="inputDirt" name="addr2" value="${userInfo.addr2}"></td>
			</tr>
			<tr>
				<td class="firstCol">가입날짜 :</td>
				<td><input type="text" value="${userInfo.joindate}" readonly></td>
			</tr>
			<tr>
				<td colspan="2" id="footer">
					<input id="toModify" type="button" value="수정하기"> 
					<input type="reset" value="다시입력">
					<input id="toIndex" type="button" value="메뉴선택으로 돌아가기">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>