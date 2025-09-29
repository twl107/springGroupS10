<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>adminLeft.jsp</title>
	<style>
	  a:link {
	    text-decoration: none;
	  }
	  h5 {
	  	background-color: #eee;
	  	padding: 10px;
	  	margin: 0px;
	  	font-weight: bolder;
	  }
	  h5:hover {
	  	background-color: #999;
	  }
	
		.accordion {
		  background-color: #eee;
		  color: #444;
		  cursor: pointer;
		  padding: 10px;
		  width: 100%;
		  border: none;
		  outline: none;
		  font-size: 15px;
		  transition: 0.4s;
		}
		
		.active, .accordion:hover {
		  background-color: #aaa;
		  display: inline-block;
		}
		
		.panel {
		  text-align: center;
		  /* padding: 2px 10px 0px; */
		  background-color: #ddd;
		  max-height: 0;
		  overflow: hidden;
		  transition: max-height 0.2s ease-out;
		  font-size: 13px;
		}
		
		.a-bg {
			background-color: #ddd;
			display: block;
			padding: 6px;
			width: 100%;
		}
		.a-bg:hover {
			background-color: #ccc;
		}
	</style>
</head>
<body bgcolor="#ccc">
<div class="text-center">
  <h5><a href="${ctp}/admin/adminMain" target="_top">관리자메뉴</a></h5>
  <h5><a href="${ctp}/" target="_top">홈으로</a></h5>
  <hr class="m-0 p-0">
  <div>
    <div class="accordion"><b>게시글관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/guest/adGuestList" target="adminContent" class="a-bg">방명록리스트</a></p>
      <p><a href="" class="a-bg">게시판리스트</a></p>
      <p><a href="" class="a-bg">자료실리스트</a></p>
    </div>
  </div>
  <div>
    <div class="accordion"><b>회원관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/member/adminMemberList" target="adminContent" class="a-bg">회원리스트</a></p>
      <p><a href="${ctp}/admin/complaint/complaintList" target="adminContent" class="a-bg">신고리스트</a></p>
    </div>
  </div>
  <div>
    <div class="accordion"><b>일정관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/schedule/adScheduleList" target="adminContent" class="a-bg">일정등록/보기</a></p>
      <p><a href="#" class="a-bg">전체일정리스트</a></p>
    </div>
  </div>
  <div>
    <div class="accordion"><b>설문조사관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/guest/adminGuestList" target="adminContent" class="a-bg">설문조사등록</a></p>
      <p><a href="" class="a-bg">설문조사리스트</a></p>
      <p><a href="" class="a-bg">설문조사분석</a></p>
    </div>
  </div>
  <div>
    <div class="accordion"><b>상품관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/guest/adminGuestList" target="adminContent" class="a-bg">상품분류등록</a></p>
      <p><a href="" class="a-bg">상품등록관리</a></p>
      <p><a href="" class="a-bg">상품등록조회</a></p>
      <p><a href="" class="a-bg">옵션등록관리</a></p>
      <p><a href="" class="a-bg">주문관리</a></p>
      <p><a href="" class="a-bg">반품관리</a></p>
      <p><a href="" class="a-bg">1:1문의</a></p>
      <p><a href="" class="a-bg">상품메인이미지관리</a></p>
    </div>
  </div>
  <div>
    <div class="accordion"><b>기타관리</b></div>
    <div class="panel">
      <p><a href="${ctp}/admin/guest/adminGuestList" class="a-bg">공지사항관리</a></p>
      <p><a href="" class="a-bg">FAQ관리</a></p>
      <p><a href="" class="a-bg">QnA관리</a></p>
      <p><a href="" class="a-bg">쿠폰관리</a></p>
      <p><a href="" class="a-bg">임시파일관리</a></p>
      <p><a href="" class="a-bg">실시간상담</a></p>
      <p><a href="" class="a-bg">1:1문의</a></p>
      <p><a href="" class="a-bg">상품메인이미지관리</a></p>
    </div>
  </div>
</div>
<p><br/></p>
<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.maxHeight) {
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    } 
	  });
	}
</script>
</body>
</html>