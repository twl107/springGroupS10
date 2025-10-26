<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>TWAUDIO인</title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <style>
    .btn-kakao {
      background-color: #FEE500;
      color: #191919;
      border-color: #FEE500;
      font-weight: bold;
      display: flex;
      align-items: center;
      justify-content: center; 
      gap: 0.5rem;
    }
    .btn-kakao:hover {
      background-color: #e5cd00;
      border-color: #e5cd00;
      color: #191919;
    }
    .btn-kakao img {
      width: 1.25rem;
      height: 1.25rem;
    }
  </style>
  <script>
    window.Kakao.init("a257d2d6af6f7865d576b07a9f309156");
    
    function kakaoLogin() {
      window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success:function(authObj) {
          console.log(authObj.access_token, "정상 토큰 발급됨...");
          
          location.href = "${ctp}/member/kakaoLogin?accessToken=" + authObj.access_token;
        },
        fail: function(err) {
          alert('카카오 로그인에 실패했습니다: ' + JSON.stringify(err));
        }
      });
    }   
  </script>
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
            
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" value="${userId}" required autofocus>
              <label for="userId">아이디</label>
            </div>

            <div class="form-floating mb-4">
              <input type="password" class="form-control" id="password" name="password" value="1234" placeholder="비밀번호" required>
              <label for="password">비밀번호</label>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-4">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" name="idCheck" id="idCheck" checked>
                <label class="form-check-label" for="idCheck">
                  아이디 저장
                </label>
              </div>
              <a href="${ctp}/member/memberFind" class="text-decoration-none small">아이디/비밀번호를 잊으셨나요?</a>
            </div>

            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-primary btn-lg">로그인</button>
            </div>
              
            <div class="d-grid mt-2">
	            <a href="javascript:kakaoLogin()">
	              <img src="${ctp}/images/kakaoLogin.png" alt="카카오 로그인" class="w-100" style="height: 48px; object-fit: contain; border-radius: 6px;">
	            </a>
	          </div>

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