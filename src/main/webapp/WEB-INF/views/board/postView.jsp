<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
        <style>
            .container{
                margin: 50px auto;
                font-size: 20px;
                color: #910c0c;
                background-color: rgba(255, 228, 196, 0.26);
            }
            .container *{
                color: #910c0c;
            }
            .top{
                background-color: rgba(255, 38, 38, 0.22);
            }
            .under{
                border-bottom: 1px solid rgba(0, 0, 0, 0.15);
            }
            .row>*:not(.content){
            	text-align:center;
                padding: 0px;
            }
            .content{
            	padding: 0px;
            }
            .no{
                white-space: pre;
            }
            .title{
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
/*                 //text-overflow: ellipsis;는 white-space: nowrap;&& overflow: hidden,auto, 등일때 가능*/
            }
            .input-group>.form-control{
                background-color: transparent;
            }
            .input-group-text{
                background-color: rgba(89, 191, 255, 0.21);
            }
            #smNote{
            	text-align :left;
            }
            #summernote{
                height: 500px;
                word-break: break-all;
                font-size:20px;
                overflow : auto;
                width : 100%;
                background-color: transparent;
            }
            .btn{
                background-color: rgba(89, 191, 255, 0.21);
                color: #910c0c;
                border: 1px solid #910c0c;
                cursor:pointer;
                border-radius: 5px;
                padding:10px 15px;
                margin-top: 5px;
            }
            .btn:hover{
                background-color: rgba(203, 196, 255, 0.44);
                color: #910c0c;
            }
            #title{
           		font-size : 20px
           	}
        </style>
        <script>
        	$(function(){
        		var modify = false;
        		function sendFile(file,editor,welEditable){
                    data = new FormData();
                    data.append("file", file);
                    $.ajax({
                        data: data,
                        type: "POST",
                        url: "saveImageAjax.board",
                        cache: false,
                        contentType: false,
                        processData: false,
                        encType:"multipart/form-data",
                    	success: function (data) {
							alert(data);
							$(".note-editable").append("<img src='"+data+"'>");
                   		}
                    });
                };
                
        		$("#toMainBoard").on("click",function(){ //목록으로 돌아가기
        			if(${searchPage==null}){
//         				location.href="Toboard.board?currentPage="+${currentPage};
						$("#modifyPostForm").attr("action","toBoardList");
						$("#modifyPostForm").submit();
        			}else{
        				location.href="clickPage.board?searchPage=s&currentPage="+${currentPage};
        			}
        		});
        		$("#deletePost").on("click",function(){	//삭제하기
        			location.href="deletePost.board?seq="+${boardDTO.seq};
        		});
        		$("#modifyPost").on("click",function(){ //수정하기
    				if(modify==false){
    					$(".modify").prop("readonly",false);
    					$(".modify").css("background-color","rgba(178, 255, 89, 0.27)");
    					$('#summernote').summernote({
    	                    tabsize:2,
    	                    height: 500,
    	                    callbacks : {
    	                        onImageUpload: function(files, editor, welEditable) {
    	                            sendFile(files[0],editor,welEditable);
    	                        }
    	                    }
    	                });
    					$("#title").focus();
    					modify = true;
    				}else{
    					var result = confirm("이대로 수정하시겠습니까?");
    					if(result==true){
    						if($("#title").val()==""){
    							alert("제목을 입력해주세요.");
    							$("#title").focus();
    							return;
    						}else if ($('#summernote').summernote('isEmpty')) {
    							  alert('내용을 입력해주세요.');
    							  return;
    						}
    						$('textarea[name="contents"]').val($('#summernote').summernote('code'));
    						alert("val : "+$('textarea[name="contents"]').val());
    						$("#modifyForm").submit();
    					}
    				}
    			});
        	});
        </script>
</head>
<body>	
<form id="modifyPostForm" action="modifyPost" method="post">
<input type="hidden" name="seq" value="${boardDTO.seq }">
<input type="hidden" name="currentPage" value="${currentPage}">
        <div class="container">
            <div class="row top">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    post
                </div>
            </div>
            <div class="row under">
                <div class="input-group col-lg-8 col-md-8 col-sm-8">
                    <div class="input-group-prepend">
                        <span class="input-group-text no"> No </span>
                    </div>
                    <div class="ml-3">${boardDTO.seq }</div>
                </div>
                <div class="input-group col-lg-4 col-md-4 col-sm-4">
                    <div class="input-group-prepend">
                        <span class="input-group-text">조회수</span>
                    </div>
                    <div class="ml-3">${boardDTO.viewcount }</div>
                </div>
            </div>
            <div class="row under">
                <div class="input-group col-lg-12 col-md-12 col-sm-12">
                    <div class="input-group-prepend">
                        <span class="input-group-text title">제목</span>
                    </div>
                    <input id="title" name="title" type="text" class="form-control modify" placeholder="제목을 입력하세요" readonly value="${boardDTO.title }">
                </div>
            </div>
            <div class="row under">
                <div class="input-group col-lg-8 col-md-8 col-sm-8">
                    <div class="input-group-prepend">
                        <span class="input-group-text">날짜</span>
                    </div>
                    <div class="ml-3">${boardDTO.formWriterdate }</div>
                </div>
                <div class="input-group col-lg-4 col-md-4 col-sm-4">
                    <div class="input-group-prepend">
                        <span class="input-group-text">작성자</span>
                    </div>
                    <div class="ml-3">${boardDTO.writer }</div>
                </div>
            </div>
            <div class="row">
<!--                 <div class="content input-group col-lg-12 col-md-12 col-sm-12"> -->
<!--                     <div class="input-group-prepend"> -->
<!--                         <span class="input-group-text">내용</span> -->
<!--                     </div> -->
<%--                     <textarea style="display:none" name="contents">${boardDTO.contents }</textarea> --%>
<%--                     <div id="summernote" class="form-control modify">${boardDTO.contents }</div>  	 --%>
<!--                 </div> -->
                <div class="content input-group col-lg-12 col-md-12 col-sm-12">
                    <div class="input-group-prepend">
                        <span class="input-group-text">내용</span>
                    </div>
                </div>
                    <div id="smNote" class="col-lg-12 col-md-12 col-sm-12">
                        <textarea style="display:none" name="contents">${boardDTO.contents }</textarea>
                    	<div id="summernote" class="form-control modify">${boardDTO.contents }</div>
                   </div>
            </div>
            <div class="row p-1">
                <div class="col-lg-12 col-md-12 col-sm-12" id="bottom">
                    <button id="toMainBoard" type="button" class="btn">글 목록으로</button>
					<c:choose>
						<c:when test="${loginId==boardDTO.writer }">
                    		<button id="deletePost" type="button" class="btn">삭제하기</button>
                    		<button id="modifyPost" type="button" class="btn">수정하기</button>
                    	</c:when>
                   	 </c:choose>
                </div>
            </div>
        </div>
        </form>
    </body>
</html>