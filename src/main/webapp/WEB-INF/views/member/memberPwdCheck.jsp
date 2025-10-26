<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경 - 현재 비밀번호 확인</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
          <h4 class="mb-0">비밀번호 변경</h4>
        </div>
        <div class="card-body p-4">
          <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
              ${error}
            </div>
          </c:if>
          <p class="card-text mb-4">
            회원님의 정보를 안전하게 보호하기 위해 현재 비밀번호를 다시 한번 확인합니다.
          </p>
          <form method="POST" action="${ctp}/member/memberPwdCheck">
            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required autofocus>
              <label for="currentPassword">현재 비밀번호</label>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <a href="${ctp}/member/memberMain" class="btn btn-secondary me-md-2">취소</a>
              <button type="submit" class="btn btn-primary">확인</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>