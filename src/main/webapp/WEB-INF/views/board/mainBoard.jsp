<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>자유게시판</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
                <style>
                    .container{
                        margin: 50px auto;
                        font-size: 20px;
                        color: #910c0c;
                        background-color: rgba(255, 228, 196, 0.26);
                    }
                    .header{
                        background-color: rgba(255, 38, 38, 0.22);
                        border-bottom: 1px solid #910c0c;
                    }
                    .topNavi{
                        background-color: rgba(255, 38, 38, 0.22);
                        cursor:default;
                    }
                    .row>*{
                        text-align: center;
                        padding: 0px;
                    }
                    .content{
                        height: 320px;
                    }
                    .btn{
                        color: #910c0c;
                        border: 1px solid #910c0c;
                        background-color: rgba(178, 255, 89, 0.27);
                        width : 50px;
                        margin-bottom : 5px;
                        font-size : 14px;
                        padding : 5px;
                    }
                    .btn:hover{
                        background-color: rgba(89, 191, 255, 0.21);
                    }
                    .footBtn{
                        background-color: rgba(89, 191, 255, 0.21);
                        color: #910c0c;
                        border: 1px solid #910c0c;
                        cursor:pointer;
                        border-radius: 5px;
                        padding: 10px 15px;
                        margin: 10px 0px;
                    }
                    .footText{
                    	margin: 10px 0px;
                    }
                    .footBtn:hover{
                        background-color: rgba(203, 196, 255, 0.44);
                    }
                    .lineContent{
                        cursor:pointer;
                        border-bottom: 1px solid #910c0c;
                    }
                    .lineContent:hover{
                        background-color: rgba(255, 201, 128, 0.24);
                    }
                    .title{
                		white-space: nowrap;
                		overflow: hidden;
                		text-overflow: ellipsis;
           			 }
           			 #searchSelect{
           			 	width : 200px;
           			 	margin : 0px;
           			 }
           		</style>
                <script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
                <script>
                    window.onload = function(){
                    	if(${boardList==null}){
                            $(".content").css("line-height","320px");
                        };
                        document.getElementById("toWriteBoard").onclick = function(){
                            location.href = "newWrite";
                        }
                        document.getElementById("toIndex").onclick = function(){
                            location.href = "/";
                        }
                        $(".lineContent").on("click",function(){
                            var seq = this.firstElementChild.innerHTML;
                            location.href = "clickPost.board?seq="+seq+"&currentPage="+${currentPage};
                        });
                        $(".btn").on("click",function(){
                        	var page = $(this).text();
                        	//alert(page); //확인용
                        		location.href = "clickPage.board?currentPage="+page;
                        	}
                        );
                        $(".btn").each(function(i,item){
                            if($(item).text()==${currentPage}){
                            	$(item).css("background-color","rgba(33, 105, 105, 0.38)");
                            }
                        });
                        $("#search").on("click",function(){//검색버튼 눌렀을때
                        	var select = document.getElementById("searchSelect");
                        	var way = select[select.selectedIndex].value;
                        	
                        	var search = $("#searchInput").val();
                        	var regex = /^.?$/;
                        	var result = regex.exec(search);
                        	
                        	if(way=="way"){
                        		alert("검색방법을 선택해주세요.");
                        		return;
                        	}else if(result!=null){//검색입력을 안했다면
                        		alert("검색할 내용을 1글자 이상 입력해주세요.");
                        		$("#searchInput").focus();
                        		return;
                        	}
                        	location.href = "search.board?way="+way+"&search="+$("#searchInput").val();
                        });
                    }
                </script>
            </head>
            <body>
                <div class="container border">
                    <div class="row header">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <span>자 유 게 시 판</span>
                        </div>
                    </div>
                    <!--					order-(size)-순서-->
                    <div class="row topNavi">
                        <!--			d-xs-none -> d-none -->
                        <div class="col-lg-1 col-md-1 col-sm-1 d-none d-sm-block">No</div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-12">Title</div>
                        <div class="col-lg-2 col-md-2 col-sm-2 d-none d-sm-block">Writer</div>
                        <div class="col-lg-2 col-md-2 col-sm-2 d-none d-sm-block">Date</div>
                        <div class="col-lg-1 col-md-1 col-sm-1 d-none d-sm-block">조회수</div>
                    </div>
                    <div class="row content">
                        <c:choose>
                            <c:when test="${boardList==null}">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <span>글이 없습니다.</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <c:forEach var="dto" items="${boardList}">
                                           	<div class="m-0 p-0 row lineContent">
                                                <div class="col-lg-1 col-md-1 col-sm-1 d-none d-sm-block">${dto.seq }</div>                                        
                                                <div class="col-lg-6 col-md-6 col-sm-6 col-12 title">${dto.title }</div>
                                                <div class="col-lg-2 col-md-2 col-sm-2 d-none d-sm-block">${dto.writer }</div>
                                                <div class="col-lg-2 col-md-2 col-sm-2 d-none d-sm-block">${dto.formTime }</div>
                                                <div class="col-lg-1 col-md-1 col-sm-1 d-none d-sm-block">${dto.viewcount}</div>
                                            </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="row bottomNavi">
                    	<div class="col-lg-3 col-md-3 col-sm-3"></div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <c:forEach var="n" items="${navi }">
                            	<button type="button" class="btn">${n}</button>
                            </c:forEach>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-3"></div>
                    </div>
                    <div class="row footer">
                        <div class="col-lg-3 col-md-3 col-sm-3">
                            <input id="toIndex"  class="footBtn" type="button" value="메인메뉴로">
                            <input id="toWriteBoard" class="footBtn" type="button" value="글쓰기">
                        </div>
                        <div class="col-lg-9 col-md-9 col-sm-9 text-right">
                        	<select id="searchSelect" class="custom-select mb-2">
  								<option selected value="way">검색방법</option>
  								<option value="title">제목</option>
 								<option value="writer">작성자</option>
  								<option value="contents">제목 + 내용</option>
							</select>
							<input id="searchInput" type="text" class="footText" placeholder="검색입력">
							<input id="search" class="footBtn" type="button" value="검색">
                        </div>
                    </div>
                </div>
            </body>
</html>