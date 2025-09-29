<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>회원가입</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container" style="margin-top: 5rem; margin-bottom: 5rem;">
  <div class="row justify-content-center">
    <div class="col-lg-6 col-md-8">
      <div class="card shadow-sm border-0">
        <div class="card-body p-4 p-md-5">
          <h2 class="card-title text-center fw-bold mb-4">회원가입</h2>
          <form name="myform" method="post" action="${ctp}/member/memberJoin">
            
            <!-- 아이디 -->
            <div class="input-group mb-3">
              <div class="form-floating">
                <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디" required>
                <label for="userid">아이디</label>
              </div>
              <button class="btn btn-outline-secondary" type="button" id="useridCheck">중복확인</button>
            </div>

            <!-- 비밀번호 -->
            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
              <label for="password">비밀번호</label>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-floating mb-3">
              <input type="password" class="form-control" id="password_check" name="password_check" placeholder="비밀번호 확인" required>
              <label for="password_check">비밀번호 확인</label>
            </div>

            <!-- 닉네임 -->
            <div class="input-group mb-3">
              <div class="form-floating">
                <input type="text" class="form-control" id="nickName" name="nickName" placeholder="닉네임" required>
                <label for="nickName">닉네임</label>
              </div>
              <button class="btn btn-outline-secondary" type="button" id="nickNameCheck">중복확인</button>
            </div>
            
            <!-- 이름 -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
              <label for="name">이름</label>
            </div>
            
            <!-- 이메일 -->
            <div class="mb-3">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="이메일" name="email1" id="email1" required>
                <span class="input-group-text">@</span>
                <input type="text" class="form-control" placeholder="도메인" name="email2" id="emailDomain">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"></button>
                <ul class="dropdown-menu dropdown-menu-end" id="domainList">
                  <li><a class="dropdown-item" href="#">naver.com</a></li>
                  <li><a class="dropdown-item" href="#">hanmail.net</a></li>
                  <li><a class="dropdown-item" href="#">hotmail.com</a></li>
                  <li><a class="dropdown-item" href="#">gmail.com</a></li>
                  <li><a class="dropdown-item" href="#">nate.com</a></li>
                  <li><a class="dropdown-item" href="#">yahoo.com</a></li>
                </ul>
                <button id="certificationBtn" class="btn btn-success" type="button">인증번호받기</button>
              </div>
              <%-- 인증번호 입력 및 로딩 스피너가 표시될 영역 --%>
              <div id="demoSpin" class="mt-2"></div>
            </div>
            
            <!-- 연락처 -->
            <div class="mb-3">
              <label class="form-label small ms-1">연락처</label>
              <div class="input-group">
                <input type="text" class="form-control" id="tel1" title="전화번호 첫자리" maxlength="3" required>
                <span class="input-group-text">-</span>
                <input type="text" class="form-control" id="tel2" title="전화번호 중간자리" maxlength="4" required>
                <span class="input-group-text">-</span>
                <input type="text" class="form-control" id="tel3" title="전화번호 마지막자리" maxlength="4" required>
              </div>
              <input type="hidden" id="tel" name="tel">
            </div>

            <!-- 주소 -->
            <div class="input-group mb-2">
              <input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호" readonly>
              <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
            </div>
            <div class="form-floating mb-2">
              <input type="text" class="form-control" id="address1" name="address1" placeholder="기본 주소" readonly>
              <label for="address1">기본 주소</label>
            </div>
            <div class="form-floating mb-4">
              <input type="text" class="form-control" id="address2" name="address2" placeholder="상세 주소">
              <label for="address2">상세 주소</label>
            </div>
            
            <!-- 버튼 -->
            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-primary btn-lg">가입하기</button>
              <button type="button" class="btn btn-outline-secondary" onclick="location.href='${ctp}/'">취소</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  // 카카오 주소 API 로직 (전역 함수로 유지)
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        let addr = '';
        if (data.userSelectedType === 'R') {
          addr = data.roadAddress;
        } else {
          addr = data.jibunAddress;
        }
        document.getElementById("postcode").value = data.zonecode;
        document.getElementById("address1").value = addr;
        document.getElementById("address2").focus();
      }
    }).open();
  }

  // HTML 문서가 모두 로드된 후, 모든 스크립트를 여기서 실행합니다.
  document.addEventListener('DOMContentLoaded', function() {
    let idCheckSw = false;
    let nickCheckSw = false;
    
    // 아이디 중복확인
    document.getElementById("useridCheck").addEventListener("click", function() {
      const userid = $("#userid").val();
      const regUserid = /^[a-zA-Z0-9_]{4,20}$/;

      if (!regUserid.test(userid)) {
        alert("아이디는 4~20자의 영문, 숫자, 밑줄(_)만 사용 가능합니다.");
        return;
      }
      
      $.ajax({
        url: "${ctp}/member/useridCheck", type: "post", data: { userid: userid },
        success: (res) => {
          if(res != "") {
            alert("이미 사용 중인 아이디입니다.");
            document.myform.userid.focus();
            idCheckSw = false;
          } else {
            alert("사용 가능한 아이디입니다.");
            idCheckSw = true;
            this.disabled = true;
            this.innerText = "확인완료";
          }
        },
        error: () => { alert("서버와 통신 중 오류가 발생했습니다."); }
      });
    });
    
    // 닉네임 중복확인
    document.getElementById('nickNameCheck').addEventListener('click', function() {
      const nickName = $('#nickName').val();
      const regNickName = /^[a-zA-Z가-힣0-9]{2,10}$/;

      if (!regNickName.test(nickName)) {
        alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다.");
        return;
      }

      $.ajax({
        url: '${ctp}/member/nickNameCheck', type: 'POST', data: { nickName: nickName },
        success: (res) => {
          if(res != "") {
            alert("이미 사용 중인 닉네임입니다.");
            document.myform.nickName.focus();
            nickCheckSw = false;
          } else {
            alert("사용 가능한 닉네임입니다.");
            nickCheckSw = true;
            this.disabled = true;
            this.innerText = "확인완료";
          }
        },
        error: () => { alert("서버와 통신 중 오류가 발생했습니다."); }
      });
    });
    
    // 입력값 변경 시 중복확인 상태 초기화
    document.getElementById('userid').addEventListener('input', () => {
      idCheckSw = false;
      const useridCheckBtn = document.getElementById('useridCheck');
      useridCheckBtn.disabled = false;
      useridCheckBtn.innerText = "중복확인";
    });
    document.getElementById('nickName').addEventListener('input', () => {
      nickCheckSw = false;
      const nickNameCheckBtn = document.getElementById('nickNameCheck');
      nickNameCheckBtn.disabled = false;
      nickNameCheckBtn.innerText = "중복확인";
    });
    
    // 최종 회원가입 전 유효성 검사
    document.getElementById('myform').addEventListener('submit', function(e) {
      e.preventDefault();
      
      const userid = $("#userid").val().trim();
      const password = $("#password").val();
      const password_check = $("#password_check").val();
      const nickName = $("#nickName").val().trim();
      const name = $("#name").val().trim();
      const email1 = $("#email1").val().trim();
      const email2 = $("#emailDomain").val().trim();
      const tel1 = $("#tel1").val().trim();
      const tel2 = $("#tel2").val().trim();
      const tel3 = $("#tel3").val().trim();
      
      const email = email1 + '@' + email2;
      const tel = tel1 + "-" + tel2 + "-" + tel3;
      
      const reguserid = /^[a-zA-Z0-9_]{4,20}$/;
      const regpassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/;
      const regNickName = /^[a-zA-Z가-힣0-9]{2,10}$/;
      const regName = /^[a-zA-Z가-힣]+$/;
      const regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      const regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;

      if (!regUserid.test(userid)) { alert("아이디는 4~20자의 영문, 숫자, 밑줄(_)만 사용 가능합니다."); return; }
      if (!regpassword.test(password)) { alert("비밀번호는 8~20자 길이의 영문 대/소문자, 숫자, 특수문자(!@#$%^&*)를 모두 포함해야 합니다."); return; }
      if (password !== password_check) { alert("비밀번호가 일치하지 않습니다."); return; }
      if (!regNickName.test(nickName)) { alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다."); return; }
      if (!regName.test(name)) { alert("이름은 한글 또는 영문만 사용 가능합니다."); return; }
      if (!email1 || !email2) { alert("이메일을 모두 입력해주세요."); return; }
      if (!regEmail.test(email)) { alert("올바른 이메일 형식을 입력해주세요."); return; }
      if (!tel1 || !tel2 || !tel3) { alert("연락처를 모두 입력해주세요."); return; }
      if (!regTel.test(tel)) { alert("전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)"); return; }
      if (!idCheckSw) { alert("아이디 중복확인을 해주세요."); return; }
      if (!nickCheckSw) { alert("닉네임 중복확인을 해주세요."); return; }
      
      $("#tel").val(tel);
      this.submit();
    });

    // 도메인 선택 드롭다운 로직
    const domainInput = document.getElementById('emailDomain');
    const domainListItems = document.querySelectorAll('#domainList .dropdown-item');
    domainListItems.forEach(function(item) {
      item.addEventListener('click', function(event) {
        event.preventDefault(); 
        domainInput.value = this.textContent;
      });
    });

    // 이메일 인증번호 받기 버튼 로직
    document.getElementById('certificationBtn').addEventListener('click', function() {
      const email1 = $("#email1").val().trim();
      const email2 = $("#emailDomain").val().trim();
      
      if (!email1 || !email2) {
        alert("이메일 주소를 모두 입력해주세요.");
        return;
      }
      
      const email = email1 + "@" + email2;
      const regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      if(!regEmail.test(email)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return;
      }

      let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 메일 발송중입니다. 잠시만 기다려주세요...</div>";
      $("#demoSpin").html(spin);
      
      $.ajax({
        url: "${ctp}/member/memberEmailCheck",
        type: "post",
        data: { email: email },
        success: (res) => {
          if(res != "0") { // 인증번호(난수)가 정상적으로 돌아왔을 경우
            alert("인증번호가 발송되었습니다.\n메일 확인 후 인증번호를 입력해주세요.");
            let str = '<div class="input-group mb-3">';
            str += '<input type="text" name="checkKey" id="checkKey" class="form-control" placeholder="인증번호 6자리"/>';
            str += '<span id="timeLimit" class="input-group-text">3:00</span>';
            str += '<input type="button" value="인증번호확인" onclick="emailCertificationOk()" class="btn btn-primary"/>';
            str += '</div>';
            $("#demoSpin").html(str);
            // timer(); // timer() 함수가 정의되어야 합니다.
          } else {
            alert("메일 주소를 다시 확인해주세요!");
          }
        },
        error: () => {
          alert("전송 오류!");
          $("#demoSpin").html(''); // 오류 시 스피너 제거
        }
      });
    });
  });
</script>
</body>
</html>

