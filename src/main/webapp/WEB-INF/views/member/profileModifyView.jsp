<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정하기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#wrapper {
	width: 300px;
	margin: auto;
	margin-top: 50px;
}
/* input { */
/* 	background-color: rgba(89, 191, 255, 0.21); */
/* 	color: #910c0c; */
/* 	border: #910c0c; */
/* 	cursor: pointer; */
/* 	border-radius: 5px; */
/* 	padding: 10px; */
/* 	font-size: 15px; */
/* 	margin-bottom: 10px; */
/* } */
#modify_OK_Btn {
	cursor: pointer;
	border: 1px solid #910c0c;
	width: 250px;
	height: 40px;
	font-size: 15px;
	margin-top: 10px;
}

#modify_OK_Btn:hover {
	background-color: rgba(203, 196, 255, 0.44);
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #910c0c;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}
/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

/* -- */
/* imaged preview */
.filebox .upload-display { /* 이미지가 표시될 지역 */
	margin-bottom: 5px;
}

@media ( min-width : 768px) {
	.filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap {
	/* 추가될 이미지를 감싸는 요소 */
	display: inline-block;
	width: 54px;
	padding: 2px;
	vertical-align: middle;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
}

.filebox .upload-display img {
	/* 추가될 이미지 */
	display: block;
	max-width: 100%;
	width: 100% \9;
	height: auto;
}
</style>
<script>
	$(function() {
		$("#modify_OK_Btn").on("click", function() {
			var modi_form = $("#profile_modi_form")[0];
			var form = new FormData(modi_form);
			alert(form);
			$.ajax({
				url: "modifyProfile",
				data: form, 
// 				dataType: 'json',
				processData: false,
				contentType: false,
				async : false,
				type: 'POST',
				success: function (response) {
					alert(response);
					var time = new Date().getTime();
					opener.document.getElementById("profile").setAttribute("src","/image"+response+"?time="+time);
// 					$(opener.document).find("#profile").after("<img src='/image"+response+"'>");
					alert("프로필 사진 변경완료!");
					close();
				},
				error: function (jqXHR) {
					alert(jqXHR.responseText); 
				} 
			});
		});
		var fileTarget = $('.filebox .upload-hidden');
		fileTarget.on('change',
				function() {
					// 값이 변경되면 
					if (window.FileReader) {
						// modern browser 
						var filename = $(this)[0].files[0].name;
					} else { // old IE 
						var filename = $(this).val().split('/').pop().split(
								'\\').pop();
						// 파일명만 추출 
					} // 추출한 파일명 삽입 
					$(this).siblings('.upload-name').val(filename);
				});
		//preview image 
		var imgTarget = $('.preview-image .upload-hidden');
		imgTarget
				.on(
						'change',
						function() {
							var parent = $(this).parent();
							parent.children('.upload-display').remove();
							if (window.FileReader) { //image 파일만
								if (!$(this)[0].files[0].type.match(/image/)) {
									alert('이미지 파일만 선택할 수 있습니다.');
									return;
								}
								var reader = new FileReader();
								reader.onload = function(e) {
									var src = e.target.result;
									parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+
											src+'" class="upload-thumb"></div></div>');
								}
								reader.readAsDataURL($(this)[0].files[0]);
							} else {
								$(this)[0].select();
								$(this)[0].blur();
								var imgSrc = document.selection.createRange().text;
								parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');
								var img = $(this).siblings('.upload-display').find('img');
								img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
										+ imgSrc + "\")";
							}
						});
	})
</script>
</head>
<body>
	<div id="wrapper">
		<form action="modifyProfile" method="post" id="profile_modi_form"
			enctype="multipart/form-data">
			<div class="filebox preview-image">
				<input class="upload-name" value="파일선택" disabled="disabled">
				<label for="input-file">업로드</label> 
				<input type="file" id="input-file" class="upload-hidden" name="newProfileImg">
			</div>
			<!-- 			<input type="file" accept=".jpg, .png, .gif" -->
			<!-- 				onchange="chk_file_type(this)" name="profileImg"><br>  -->
			<input type="button" value="위 사진으로 프로필 사진 수정하기" id="modify_OK_Btn">
		</form>
	</div>
</body>
</html>