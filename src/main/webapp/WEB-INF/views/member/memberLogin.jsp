<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>로그인</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container" style="margin-top: 5rem; margin-bottom: 5rem;">
  <div class="row justify-content-center">
    <div class="col-lg-5 col-md-8">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4 p-md-5">
          <h2 class="card-title text-center fw-bold mb-4">로그인</h2>
          <form name="loginForm" method="post" action="${ctp}/member/memberLogin">
            
            <!-- 아이디 (id, name, value 수정) -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" value="${userId}" required autofocus>
              <label for="userId">아이디</label>
            </div>

            <!-- 비밀번호 -->
            <div class="form-floating mb-4">
              <input type="password" class="form-control" id="password" name="password" value="1234" placeholder="비밀번호" required>
              <label for="password">비밀번호</label>
            </div>

            <!-- 아이디 저장 및 비밀번호 찾기 -->
            <div class="d-flex justify-content-between align-items-center mb-4">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="idCheck" id="idCheck" checked>
                <label class="form-check-label" for="idCheck">
                  아이디 저장
                </label>
              </div>
              <a href="#" class="text-decoration-none small">비밀번호를 잊으셨나요?</a>
            </div>

            <!-- 로그인 버튼 -->
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-primary btn-lg">로그인</button>
            </div>

            <!-- 회원가입 링크 -->
            <div class="text-center mt-4">
              <span class="small">계정이 없으신가요? </span>
              <a href="${ctp}/member/memberJoin" class="text-decoration-none fw-bold">회원가입</a>
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

