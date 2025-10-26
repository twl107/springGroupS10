<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>TWAUDIO</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    .find-result {
      display: none;
      margin-top: 15px;
      padding: 15px;
      background-color: #f8f9fa;
      border-radius: 5px;
    }
    .timer {
      color: #dc3545;
      font-weight: bold;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div class="container my-5" style="max-width: 600px;">
  <h2 class="text-center mb-4">아이디/비밀번호 찾기</h2>

  <ul class="nav nav-tabs nav-fill" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
      <button class="nav-link active" id="find-id-tab" data-bs-toggle="tab" data-bs-target="#find-id" type="button" role="tab" aria-controls="find-id" aria-selected="true">아이디 찾기</button>
    </li>
    <li class="nav-item" role="presentation">
      <button class="nav-link" id="find-pw-tab" data-bs-toggle="tab" data-bs-target="#find-pw" type="button" role="tab" aria-controls="find-pw" aria-selected="false">비밀번호 찾기</button>
    </li>
  </ul>

  <div class="tab-content p-4 border border-top-0 rounded-bottom">
    
    <div class="tab-pane fade show active" id="find-id" role="tabpanel" aria-labelledby="find-id-tab">
      <p>가입 시 사용한 이메일 주소를 입력해주세요.</p>
      <div class="input-group mb-3">
        <input type="email" class="form-control" id="findIdEmail" placeholder="이메일 주소 (example@domain.com)">
        <button class="btn btn-secondary" type="button" id="btnSendAuthId">인증번호 발송</button>
      </div>
      <div class="input-group mb-3" id="authBoxId" style="display: none;">
        <input type="text" class="form-control" id="authKeyId" placeholder="인증키 8자리">
        <span class="input-group-text timer" id="timerId">03:00</span>
        <button class="btn btn-primary" type="button" id="btnVerifyId">아이디 찾기</button>
      </div>
      <div id="findIdResult" class="find-result"></div>
    </div>
    
    <div class="tab-pane fade" id="find-pw" role="tabpanel" aria-labelledby="find-pw-tab">
      <p>가입 시 사용한 <b>아이디</b>와 <b>이메일 주소</b>를 입력해주세요.</p>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id="findPwUserId" placeholder="아이디">
      </div>
      <div class="input-group mb-3">
        <input type="email" class="form-control" id="findPwEmail" placeholder="이메일 주소 (example@domain.com)">
        <button class="btn btn-secondary" type="button" id="btnSendAuthPw">인증번호 발송</button>
      </div>
      <div class="input-group mb-3" id="authBoxPw" style="display: none;">
        <input type="text" class="form-control" id="authKeyPw" placeholder="인증키 8자리">
        <span class="input-group-text timer" id="timerPw">03:00</span>
        <button class="btn btn-primary" type="button" id="btnVerifyPw">인증 확인</button>
      </div>
    </div>
    
  </div>
</div>

<script>
  let timerInterval;

  function startTimer(duration, displayElement) {
    let timer = duration, minutes, seconds;
    
    clearInterval(timerInterval);

    timerInterval = setInterval(function () {
      minutes = parseInt(timer / 60, 10);
      seconds = parseInt(timer % 60, 10);

      minutes = minutes < 10 ? "0" + minutes : minutes;
      seconds = seconds < 10 ? "0" + seconds : seconds;

      displayElement.text(minutes + ":" + seconds);

      if (--timer < 0) {
        clearInterval(timerInterval);
        displayElement.text("시간만료");
        displayElement.siblings('input').prop('disabled', true);
        displayElement.siblings('button').prop('disabled', true);
      }
    }, 1000);
  }

  $(function() {
    $("#btnSendAuthId").click(function() {
      const email = $("#findIdEmail").val();
      if(email === "") { alert("이메일을 입력하세요."); return; }
      
      $.ajax({
        url: "${ctp}/member/sendAuthCodeForFind", 
        type: "POST", data: { email: email },
        success: function(res) {
          if(res === "1") {
            alert("인증키가 발송되었습니다. 3분 이내에 입력해주세요.");
            $("#authBoxId").show();
            const fiveMinutes = 60 * 3;
            const display = $('#timerId');
            display.siblings('input').prop('disabled', false);
            display.siblings('button').prop('disabled', false);
            startTimer(fiveMinutes, display);
          } else if(res === "0") {
            alert("가입되지 않은 이메일 주소입니다.");
          } else {
            alert("메일 발송 중 오류가 발생했습니다.");
          }
        }
      });
    });
    
    $("#btnVerifyId").click(function() {
      const email = $("#findIdEmail").val();
      const authKey = $("#authKeyId").val(); 
      if(authKey === "") { alert("인증키를 입력하세요."); return; }
      
      $.ajax({
        url: "${ctp}/member/findId", type: "POST", data: { email: email, authKey: authKey },
        success: function(res) {
          if(res === "0") {
            alert("인증키가 일치하지 않습니다.");
          } else {
            clearInterval(timerInterval);
            $("#findIdResult").html("해당 이메일로 가입된 아이디는 <b>" + res + "</b> 입니다.");
            $("#findIdResult").show();
          }
        }
      });
    });
    
    $("#btnSendAuthPw").click(function() {
      const userId = $("#findPwUserId").val();
      const email = $("#findPwEmail").val();
      
      if(userId === "") { alert("아이디를 입력하세요."); return; }
      if(email === "") { alert("이메일을 입력하세요."); return; }
      
      $.ajax({
        url: "${ctp}/member/sendAuthCodeForPwReset",
        type: "POST", data: { userId: userId, email: email },
        success: function(res) {
          if(res === "1") {
            alert("인증키가 발송되었습니다. 3분 이내에 입력해주세요.");
            $("#authBoxPw").show();
            const fiveMinutes = 60 * 3;
            const display = $('#timerPw');
            display.siblings('input').prop('disabled', false);
            display.siblings('button').prop('disabled', false);
            startTimer(fiveMinutes, display);
          } else if(res === "0") {
            alert("아이디가 존재하지 않거나, 이메일 정보가 일치하지 않습니다.");
          } else {
            alert("메일 발송 중 오류가 발생했습니다.");
          }
        }
      });
    });
    
    $("#btnVerifyPw").click(function() {
      const authKey = $("#authKeyPw").val(); 
      if(authKey === "") { alert("인증키를 입력하세요."); return; }
      
      $.ajax({
        url: "${ctp}/member/verifyForPwReset", 
        type: "POST", data: { authKey: authKey },
        success: function(res) {
          if(res === "1") {
            clearInterval(timerInterval);
            alert("인증에 성공했습니다. 비밀번호 변경 페이지로 이동합니다.");
            location.href = "${ctp}/member/memberPwdReset";
          } else {
            alert("인증키가 일치하지 않습니다.");
          }
        }
      });
    });
  });
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>