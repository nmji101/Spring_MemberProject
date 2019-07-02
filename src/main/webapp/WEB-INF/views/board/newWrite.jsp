<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 메뉴summer note</title>
        <!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"> -->
        <script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
            .container{
                margin: 50px auto;
                font-size: 20px;
                color: #910c0c;
                background-color: rgba(255, 228, 196, 0.26);
            }
            .top{
                background-color: rgba(255, 38, 38, 0.22);
            }
            .row>*{
                text-align: center;
                padding: 0px;
            }
            .input-group>.form-control{
                background-color: transparent;
            }
            .input-group{
                text-align: center;
            }
            .input-group-text{
                background-color: rgba(89, 191, 255, 0.21);
            }
            #smNote{
            	text-align :left;
            }
            #summernote{
                height: 500px;
                width : 100%;
            }
            .btn{
                background-color: rgba(89, 191, 255, 0.21);
                color: #910c0c;
                border: 1px solid #910c0c;
                cursor:pointer;
                border-radius: 5px;
                padding: 10px 15px;
                margin-top: 5px;
            }
            .btn:hover{
                background-color: rgba(203, 196, 255, 0.44);
            }
            #smContents{
                width: 100%;
                background-color: rgba(89, 191, 255, 0.21);
                color: #675b5b;
                font-size: 19px;
                border-left: 1px solid #a8a8a8;
                border-right: 1px solid #a8a8a8;
            }
        </style>
        <script>
        function sendFile(file,el){
            data = new FormData();
            data.append("file", file);
//             alert(file);
            $.ajax({
                data: data,
                type: "POST",
                url: "saveImageAjax.board",
                cache: false,
                contentType: false,
                processData: false,
                enctype:"multipart/form-data",
            	success: function (data) {
// 					alert(data);
					$(el).summernote('editor.insertImage', 'image'+data);
// 					$(".note-editable").append("<img src='image/"+data+"'>");
           		}
            });
       	 };
            window.onload = function(){
                document.getElementById("toMainBoard").onclick = function(){
                    location.href = "toBoard";
                }
                document.getElementById("writeComplete").onclick = function(){
                    var title= $("#title");
//                     var contents = document.getElementById("contents");
                    if(title.val()==""){
                        alert("제목을 입력해주세요.");
                        title.focus();
                        return;
                    }
                    if ($('#summernote').summernote('isEmpty')) {
						  alert('내용을 입력해주세요.');
						  return;
					}
//                     if(contents.value==""){
//                         alert("내용을 입력해주세요.");
//                         contents.focus();
//                         return;
//                     }
					$('textarea[name="contents"]').val($('#summernote').summernote('code'));
// 					alert("val : "+$('textarea[name="contents"]').val());
                    document.getElementById("writeForm").submit();
                }
                $('#summernote').summernote({
                    placeholder: '내용을 입력해주세요.',
                    tabsize:2,
                    height: 500,
                    callbacks : {
                        onImageUpload: function(files, editor, welEditable) {
                            sendFile(files[0],this);
                        }
                    }
                });
            }
        </script>
    </head>
    <body>	
        <form id="writeForm" action="inputBoard" method="post">
        <textarea name="contents" style="display:none"></textarea>
            <div class="container">
                <div class="row top">
                    <div class="col-lg-12 col-md-12 col-sm-12">게시판 글쓰기</div>
                </div>
                <div class="row">
                    <div class="input-group col-lg-12 col-md-12 col-sm-12">
                        <div class="input-group-prepend">
                            <span class="input-group-text">제목</span>
                        </div>
                        <input id="title" name="title" type="text" class="form-control" placeholder="제목을 입력하세요">
                    </div>
                </div>
                <div class="row">
                    <!--
<div class="input-group col-lg-12 col-md-12 col-sm-12">
<div class="input-group-prepend">
<span id="smContents" class="input-group-text">내용</span>
</div>
</div>
-->
                    <div class="col-lg-12 col-md-12 d-md-block d-none">
                        <div id="smContents">
                            <span>내용</span>
                        </div>
                    </div>
                    <div id="smNote" class="col-lg-12 col-md-12 col-sm-12">
                        <div id="summernote"></div>
                    </div>
                </div>
                <div class="row p-1">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <button id="writeComplete" type="button" class="btn">작성하기</button>
                        <button id="toMainBoard" type="button" class="btn">글 목록으로</button>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>