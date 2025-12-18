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
    html, body {
      height: 100%;
      margin: 0;
      overflow: hidden;
    }
    .main-container {
      height: 100vh;
      padding-top: 56px;
    }
    .sidebar {
      height: calc(100vh - 56px);
      overflow-y: auto;
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
      <div class="col-lg-2 col-md-3 p-0">
        <div class="sidebar">
          <jsp:include page="/WEB-INF/views/admin/adminLeft.jsp" />
        </div>
      </div>

      <div class="col-lg-10 col-md-9 p-0">
        <iframe src="${ctp}/admin/adminContent" name="adminContent" class="content-frame"></iframe>
      </div>
    </div>
  </div>
</body>
</html>