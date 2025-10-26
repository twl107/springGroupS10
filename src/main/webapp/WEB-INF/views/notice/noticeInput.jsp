<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>TWAUDIO</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let title = myform.title.value;
  		
  		if(title.trim() == "") {
  			alert("제목을 입력하세요.");
				myform.title.focus();
  			return false;
			}
  		else {
  			myform.submit();
			}
  	}
  </script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div id="notice">
    <h3>공지사항 등록</h3>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group">
      	<label for="title">제목</label>
      	<input type="text" name="title" id="title" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">내용</label>
      	<textarea rows="5" name="content" id="content" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/imageUpload",
		    	filebrowserUploadUrl: "${ctp}/imageUpload",
		    	height:600
		    });
		  </script>
		  <input type="button" value="등록" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
    </form>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

