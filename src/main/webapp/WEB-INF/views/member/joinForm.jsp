<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입하기_spring</title>
<style>
table {
	width: 900px;
	font-size: 25px;
	margin: 100px auto;
	background-color: rgba(255, 228, 196, 0.26);
	color: #910c0c;
	border-radius: 5px;
}

input {
	background-color: rgba(89, 191, 255, 0.21);
	color: #910c0c;
	border: #910c0c;
	border-radius: 5px;
}

input[type=button], input[type=reset] {
	cursor: pointer;
	border: 1px solid #910c0c;
	width: 80px;
	height: 40px;
}

input[type=button]:hover, input[type=reset]:hover {
	background-color: rgba(203, 196, 255, 0.44);
}

th {
	background-color: rgba(255, 38, 38, 0.22);
	border-radius: 5px;
	height: 50px;
}

td {
	height: 30px;
}

#footer {
	text-align: center;
}

.firstCol {
	text-align: right;
	width: 200px;
	font-size: 18px;
	padding: 0px;
	height: 40px;
	margin: 0px;
}

.inputDirt {
	height: 90%;
	width: 220px;
}

.idCondition {
	font-size: 12px;
}

#filsoo {
	height: 20px;
	font-size: 15px;
	text-align: left;
}

#footer {
	padding: 10px 0px;
}

#footer>input {
	width: 200px;
}
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script>
function chk_file_type(obj) {
	 var file_kind = obj.value.lastIndexOf('.');
	 var file_name = obj.value.substring(file_kind+1,obj.length);
	 var file_type = file_name.toLowerCase();
	 var check_file_type=['jpg','gif','png','jpeg','bmp'];

	 if(check_file_type.indexOf(file_type)==-1){
	  alert('이미지 파일만 선택할 수 있습니다.');
// 	  var parent_Obj=obj.parentNode
// 	  var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
		$(obj).val("");
	  return false;
	 }
}
            window.onload = function(){
            	
                $(".inputDirt").on("focus",function(){
                        $(this).parent().css("background-color","rgba(215, 250, 216, 0.81)");
                });
                $(".inputDirt").on("focusout",function(){
                        $(this).parent().css("background-color","transparent");
                });
                
                $("#id").on("input",function(){
                	$("#id").attr("flag","false");
                });
                
//                 //중복확인버튼
//                 $("#toOverLap").on("click",function(){
//                 	var id = $("#id").val();
//                 	var regex = /^[a-zA-Z][a-zA-Z0-9]{4,19}$/;
//                 	var result = regex.exec(id);
//                 	if(id==""){
//                 		alert("ID를 입력해주세요.");
//                 		$("#id").focus();
//                 	}else if(result==null){
//                 		alert("ID조건에 맞는 값을 입력해주세요.\r\n->첫글자는 영어, 영어대소문자,숫자 조합 5자 이상 20자 이내");
//                 		$("#id").focus();
//                 	}else{
//                         window.open("IdDuplCheck?id="+id,"","width=500px,height=500px");
//                      //id칸에 입력한 값을 넘겨주기위해서  "idDuplCheck.jsp?id=" get방식으로 url호출하기.
//                 	}
//                	});

				//id검사를 중복확인 버튼 없이 ajax로 만들어보기.
				
                $("#id").on("input",function(){ //id입력될때,
                	$("#id").attr("flag","false");
                	var id = $(this).val();
                	var regex = /^[a-z][a-zA-Z0-9]{4,19}$/;
                	var result = regex.exec(id);
                	if(result==null){
                		$("#idResult").text("1.첫글자는 영어소문자  2.영어대소문자,숫자 조합 5자 이상 20자 이내");
                	}else{
                		$.ajax({
                			url:"IdDuplCheck.ajax",
                			type:"post",
        					data:{ //ajax로 보낼 값
        						id:id
        					}
                	}).done(function(resp){
                		if(resp=="0"){
                			$("#id").attr("flag","true");
                		}
                		//alert($("#id").attr("flag"));
                		if($("#id").attr("flag") == "true"){
                    		$("#idResult").text("사용가능한 아이디입니다.");
                    	}else{
                    		$("#idResult").text("사용 불가능한 아이디입니다.");
                    	}
                	})
                	}
                	
                });
					
                //패스워드
                $(".pwCheck").on("input",function(){
                	//flag는 pw확인 일치하는지.
                	$("#pw2").attr("flag","false");
                	var input1 = $("#pw1").val();
                	var input2 = $("#pw2").val();
                	var result = $("#result");
                	if(input1==""&&input2==""){
                		result.text("");
                	}else if(input1==""){
                		alert("패스워드를 입력해주세요.");
                		$("#pw2").val("");
                		$("#pw1").focus();
                	}else if(input2==""){
                		//
                	}else{
                        if(input1==input2){
                        	$("#pw2").attr("flag","true");
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
                	var nameRegex = /^.{0,6}$/;
                	if(nameRegex.exec($(this).val())==null){
                		alert("이름은 1~6글자를 입력해주세요.");
                			var cut = $(this).val().substr(0,6);
                			$(this).prop("value",cut);
                		}
                });
                
                document.getElementById("search").onclick = searchAddress;
				
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
             
                $("#toInputProc").on("click",function(){
                	if($("#id").attr("flag")=="false"){
                		//id확인
                		//alert("ID중복확인 버튼을 눌러주세요.");
                		alert("사용가능한 ID가 아닙니다. \r\n [1.첫글자는 영어  2.영어대소문자,숫자 조합 5자 이상 20자 이내]");
                		$("#id").focus();
                		return;
                	}
                	var pwRegex = /^[a-zA-Z0-9!@#]{6,20}$/;
                	var pwResult = pwRegex.exec($("#pw1").val());
                	if(pwResult==null){
                		//pw확인
                		alert("pw조건에 맞춰 적어주세요.\r\n -> 대소문자,숫자,!@# 조합 6자~20자");
                		return;
                	}else if($("#pw2").attr("flag")=="false"){
                		alert("비밀번호 확인을 정확히 입력해주세요.");
                		return;
                	}
                	
                	if($("#name").val()==""){
                		alert("이름은 필수입력입니다.\r\n이름을 1~6글자로 입력해주세요.");
                		return;
                	}
                	$("#joinFrom").submit();
                });
                $("#toIndex").on("click", function(){
                	location.href = "/";
                });
            }
        </script>
</head>
<body>
	<form action="inputProc" method="post" id="joinFrom" enctype="multipart/form-data">
		<table>
			<tr>
				<th colspan="2">회원 가입 정보</th>
			</tr>
			<tr>
				<th id="filsoo" colspan="2">*표시는 필수입력</th>
			</tr>
			<tr>
				<td class="firstCol">*아이디 :</td>
				<td><input type="text" id="id" class="inputDirt"
					placeholder="ID입력" required flag="false" name="id"> 
					<!-- 						<input type="button" value="중복확인" id="toOverLap"> -->
					<span id="idResult" class="idCondition">1.첫글자는 영어
						2.영어대소문자,숫자 조합 5자 이상 20자 이내</span></td>
			</tr>
			<tr>
				<td class="firstCol">*프로필사진 :</td>
				<td>
				<input type="file"
					accept=".jpg, .png, .gif" onchange="chk_file_type(this)" name="profileImg">
					 <span id="profileImg"></span>
<!-- 			<div class="filebox preview-image"> -->
<!-- 				<input class="upload-name" value="파일선택" disabled="disabled"> -->
<!-- 				<label for="input-file">업로드</label>  -->
<!-- 				<input type="file" id="input-file" class="upload-hidden"> -->
<!-- 			</div> -->
					 </td>
			</tr>
			<tr>
				<td class="firstCol">*비밀번호 :</td>
				<td><input type="password" id="pw1" class="inputDirt pwCheck"
					name="pw" placeholder="대소문자,숫자,!@# 조합 6자~20자"> <span
					id="RegexResult"></span></td>
			</tr>
			<tr>
				<td class="firstCol">*비밀번호확인 :</td>
				<td><input type="password" id="pw2" class="inputDirt pwCheck"
					flag="false"> <span id="result"></span></td>
			</tr>
			<tr>
				<td class="firstCol">*이름 :</td>
				<td><input id="name" type="text" class="inputDirt" name="name"
					placeholder="6글자 이내"></td>
			</tr>
			<tr>
				<td class="firstCol">핸드폰번호 :</td>
				<td><input type="text" class="inputDirt" name="phone"
					placeholder="000-0000-0000"></td>
			</tr>
			<tr>
				<td class="firstCol">이메일 :</td>
				<td><input type="text" class="inputDirt" name="email"
					placeholder="이메일 형식"></td>
			</tr>
			<tr>
				<td class="firstCol">우편번호 :</td>
				<td><input type="text" id="postcode" class="inputDirt"
					name="zipcode" readonly placeholder="찾기 버튼을 눌러주세요." required>
					<input type="button" value="찾기" id="search"></td>
			</tr>
			<tr>
				<td class="firstCol">주소1 :</td>
				<td><input type="text" id="address1" class="inputDirt"
					name="addr1" readonly placeholder="찾기 버튼을 눌러주세요." required></td>
			</tr>
			<tr>
				<td class="firstCol">주소2 :</td>
				<td><input type="text" class="inputDirt" name="addr2"
					placeholder="나머지 주소를 입력하세요."></td>
			</tr>
			<tr>
				<td colspan="2" id="footer"><input type="button" value="회원가입"
					id="toInputProc"> <input type="reset" value="다시입력">
					<input id="toIndex" type="button" value="로그인화면으로 돌아가기"></td>
			</tr>
		</table>
	</form>
</body>
</html>