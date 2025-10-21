<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재설정</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    function validateForm() {
      const newPassword = document.getElementById("newPassword").value;
      const newPasswordCheck = document.getElementById("newPasswordCheck").value;
      const regPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,20}$/;

      if (!regPassword.test(newPassword)) {
        alert("비밀번호는 6~20자 길이의 영문 대/소문자, 숫자, 특수문자(!@#$%^&*)를 모두 포함해야 합니다.");
        return false;
      }
      
      if (newPassword !== newPasswordCheck) {
        alert("새 비밀번호가 일치하지 않습니다.");
        return false;
      }
      
      return true; // 폼 제출
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div class="container my-5" style="max-width: 600px;">
  <h2 class="text-center mb-4">비밀번호 재설정</h2>
  <p class="text-center text-muted">인증이 완료되었습니다. (<b>${userId}</b>님)<br>새로 사용할 비밀번호를 입력해주세요.</p>
  
  <form method="POST" action="${ctp}/member/memberPwdReset" onsubmit="return validateForm();">
    <input type="hidden" name="userId" value="${userId}">
    
    <div class="form-floating mb-3">
      <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호">
      <label for="newPassword">새 비밀번호</label>
    </div>
    
    <div class="form-floating mb-3">
      <input type="password" class="form-control" id="newPasswordCheck" name="newPasswordCheck" placeholder="새 비밀번호 확인">
      <label for="newPasswordCheck">새 비밀번호 확인</label>
    </div>
    
    <div class="d-grid">
      <button type="submit" class="btn btn-primary btn-lg">비밀번호 변경</button>
    </div>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
