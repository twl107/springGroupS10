<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>관리자 페이지</title>
  <style>
    /* 화면 전체를 차지하도록 높이 설정 */
    html, body {
      height: 100%;
      margin: 0;
      overflow: hidden; /* 스크롤바는 각 영역에서 개별 처리 */
    }
    .main-container {
      height: 100vh; /* 뷰포트 높이만큼 설정 */
      padding-top: 56px; /* 헤더 높이만큼 이격 (Bootstrap 기본 헤더 높이) */
    }
    .sidebar {
      height: calc(100vh - 56px);
      overflow-y: auto; /* 메뉴가 길어지면 스크롤바 생성 */
      background-color: #f8f9fa;
    }
    .content-frame {
      height: calc(100vh - 56px);
      width: 100%;
      border: none;
    }
  </style>
</head>
<body>
  <div class="container-fluid main-container">
    <div class="row">
      <%-- 1. 왼쪽 메뉴 영역 --%>
      <div class="col-lg-2 col-md-3 p-0">
        <div class="sidebar">
          <jsp:include page="/WEB-INF/views/admin/adminLeft.jsp" />
        </div>
      </div>

      <%-- 2. 오른쪽 컨텐츠 영역 (iframe) --%>
      <div class="col-lg-10 col-md-9 p-0">
        <iframe src="${ctp}/admin/adminContent" name="adminContent" class="content-frame"></iframe>
      </div>
    </div>
  </div>
</body>
</html>