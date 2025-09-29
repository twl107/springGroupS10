<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>adminContent.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>관리자 메인화면</h3>
  <hr/>
  <!-- 
    - 방명록에 올린 최근글(1주일) 리스트 ? 개 게시
    - 게시판-------------
    - 신규회원(level=3) 리스트(건수)
    - 탈퇴신청회원 리스트(건수)
  -->
  <p>방명록 새글 : 건</p>
  <p>게시판 새글 : 건</p>
  <p>신고글 새글 : 건</p>
  <%-- <p>신규회원 : <a href="${ctp}/admin/member/adMemberList?level=3" class="badge bg-secondary text-decoration-none">${memberLevelCount}</a>건</p> --%>
  <p>탈퇴회원 : 건</p>
</div>
<p><br/></p>
</body>
</html>