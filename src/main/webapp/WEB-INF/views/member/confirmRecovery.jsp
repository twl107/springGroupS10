<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TWAUDIO</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5 text-center">
	<div class="card shadow-sm mx-auto" style="max-width: 500px;">
	  <div class="card-body p-5">
	    <h2 class="card-title mb-4">계정 복구</h2>
	    <p class="fs-5 mb-4">
	      <strong>${userId}</strong> 계정은 이전에 탈퇴 처리되었습니다.<br>
	      계정을 복구하시겠습니까?
	    </p>
	    <div>
	      <a href="${ctp}/member/recoverAccount?userId=${userId}" class="btn btn-primary btn-lg me-2">예, 복구합니다</a>
	      <a href="${ctp}/member/memberLogin" class="btn btn-secondary btn-lg">아니요</a>
	    </div>
	  </div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>