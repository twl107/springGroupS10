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
          <form name="myform" id="myform" method="post" action="${ctp}/member/memberJoin">
            
            <!-- 아이디 -->
            <div class="input-group mb-3">
              <div class="form-floating">
                <input type="text" class="form-control" id="userid" name="userid" placeholder="아이디" required>
                <label for="userid">아이디</label>
              </div>
              <button class="btn btn-outline-secondary" type="button" id="useridCheckBtn">중복확인</button>
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
                <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임" required>
                <label for="nickname">닉네임</label>
              </div>
              <button class="btn btn-outline-secondary" type="button" id="nicknameCheckBtn">중복확인</button>
            </div>
            
            <!-- 이름 -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
              <label for="name">이름</label>
            </div>
            
            <!-- 이메일 (최종 수정) -->
            <div class="mb-3">
              <label class="form-label small ms-1">이메일</label>
              <div class="input-group">
                <input type="text" class="form-control" placeholder="계정" name="email1" id="email1" required>
                <span class="input-group-text">@</span>
                <input type="text" class="form-control" placeholder="도메인" name="email2" id="emailDomain">
                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
                <ul class="dropdown-menu dropdown-menu-end" id="domainDropdown">
                  <li><a class="dropdown-item" href="javascript:void(0);">naver.com</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">hanmail.net</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">hotmail.com</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">gmail.com</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">nate.com</a></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">yahoo.com</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="javascript:void(0);">직접입력</a></li>
                </ul>
                <button class="btn btn-outline-secondary" type="button" id="certificationBtn">인증번호 받기</button>
              </div>
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

            <!-- 생년월일 -->
            <div class="form-floating mb-3">
              <input type="date" class="form-control" id="birthday" name="birthday" required>
              <label for="birthday">생년월일</label>
            </div>

            <!-- 성별 -->
            <div class="mb-3">
              <label class="form-label small ms-1">성별</label>
              <div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="gender" id="genderM" value="M" checked>
                  <label class="form-check-label" for="genderM">남자</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="gender" id="genderF" value="F">
                  <label class="form-check-label" for="genderF">여자</label>
                </div>
              </div>
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
  // 카카오 주소 API 로직은 전역에 둡니다.
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
        document.getElementById("postcode").value = data.zonecode;
        document.getElementById("address1").value = addr;
        document.getElementById("address2").focus();
      }
    }).open();
  }

  let interval; // 타이머를 제어하기 위한 변수 (전역으로 선언)
  let emailCheckSw = false;
  
  // --- 이메일 인증 확인 함수 (밖으로 분리) ---
  function emailCertificationOk() {
    const checkKey = $("#checkKey").val().trim();
    if (checkKey === "") {
      alert("인증키를 입력해주세요");
      $("#checkKey").focus();
      return;
    }
    $.ajax({
      url: "${ctp}/member/memberEmailCheckOk",
      type: "post",
      data: { checkKey: checkKey },
      success: (res) => {
        if (res == 1) {
          clearInterval(interval);
          emailCheckSw = true;
          $("#demoSpin").html("<p class='text-success fw-bold'>✅ 이메일 인증이 완료되었습니다.</p>");
        } else {
          alert("인증번호가 올바르지 않습니다. 다시 확인해주세요.");
        }
      },
      error: () => alert("서버 통신 오류")
    });
  }

  // --- 타이머 함수 (밖으로 분리) ---
  function timer() {
    let timeLimit = 180;
    
    // 만약 이전 타이머가 남아있다면 중지
    if (interval) {
        clearInterval(interval);
    }

    interval = setInterval(() => {
      if (timeLimit > 0) {
        timeLimit--;
        const minutes = String(Math.floor(timeLimit / 60)).padStart(2, '0');
        const seconds = String(timeLimit % 60).padStart(2, '0');
        $("#timeLimit").text(minutes + ":" + seconds);
      } else {
        clearInterval(interval);
        $("#demoSpin").html("");
        $.ajax({
          url: "${ctp}/member/memberEmailCheckNo",
          type: "post",
          success: () => alert("인증시간이 만료되었습니다.\n인증번호를 다시 받아주세요."),
          error: () => alert("서버 통신 오류")
        });
      }
    }, 1000);
  }
  
  
  $(function() {
    let idCheckSw = false;
    let nickCheckSw = false;
    
    
    // --- 아이디 중복확인 ---
    $("#useridCheckBtn").on("click", function() {
      const userid = $("#userid").val().trim();
      if (!/^[a-zA-Z0-9_]{4,20}$/.test(userid)) {
        alert("아이디는 4~20자의 영문, 숫자, 밑줄(_)만 사용 가능합니다.");
        return;
      }
      $.ajax({
        url: "${ctp}/member/useridCheck", type: "post", data: { userid: userid },
        success: (res) => {
          if (res.trim() !== "") {
            alert("이미 사용 중인 아이디입니다.");
            $("#userid").focus();
            idCheckSw = false;
          } else {
            alert("사용 가능한 아이디입니다.");
            idCheckSw = true;
            $(this).prop("disabled", true).text("확인완료");
          }
        },
        error: () => { alert("서버 통신 오류"); }
      });
    });
    
    // --- 닉네임 중복확인 ---
    $('#nicknameCheckBtn').on('click', function() {
      const nickname = $('#nickname').val().trim();
      if (!/^[a-zA-Z가-힣0-9]{2,10}$/.test(nickname)) {
        alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다.");
        return;
      }
      $.ajax({
        url: '${ctp}/member/nicknameCheck', type: 'POST', data: { nickname: nickname },
        success: (res) => {
          if (res.trim() !== "") {
            alert("이미 사용 중인 닉네임입니다.");
            $('#nickname').focus();
            nickCheckSw = false;
          } else {
            alert("사용 가능한 닉네임입니다.");
            nickCheckSw = true;
            $(this).prop("disabled", true).text("확인완료");
          }
        },
        error: () => { alert("서버 통신 오류"); }
      });
    });
    
    // --- 입력값 변경 시 중복확인 상태 초기화 ---
    $('#userid').on('input', () => {
      idCheckSw = false;
      $('#useridCheckBtn').prop("disabled", false).text("중복확인");
    });
    $('#nickname').on('input', () => {
      nickCheckSw = false;
      $('#nicknameCheckBtn').prop("disabled", false).text("중복확인");
    });
    $('#email1, #emailDomain').on('input', () => {
    	emailCheckSw = false;
      $('#demoSpin').html("");
    });
    
    // --- 최종 회원가입 전 유효성 검사 ---
    $('#myform').on('submit', function(e) {
      e.preventDefault();
      
      const userid = $("#userid").val().trim();
      const password = $("#password").val();
      const password_check = $("#password_check").val();
      const nickname = $("#nickname").val().trim();
      const name = $("#name").val().trim();
      const email1 = $("#email1").val().trim();
      const email2 = $("#emailDomain").val().trim();
      const tel1 = $("#tel1").val().trim();
      const tel2 = $("#tel2").val().trim();
      const tel3 = $("#tel3").val().trim();
      
      const email = email1 + '@' + email2;
      const tel = tel1 + "-" + tel2 + "-" + tel3;
      
      const regUserid = /^[a-zA-Z0-9_]{4,20}$/;
      const regPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,20}$/;
      const regNickname = /^[a-zA-Z가-힣0-9]{2,10}$/;
      const regName = /^[a-zA-Z가-힣]+$/;
      const regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      const regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;

      if (!regUserid.test(userid)) { alert("아이디는 4~20자의 영문, 숫자, 밑줄(_)만 사용 가능합니다."); return; }
      if (!regPassword.test(password)) { alert("비밀번호는 6~20자 길이의 영문 대/소문자, 숫자, 특수문자(!@#$%^&*)를 모두 포함해야 합니다."); return; }
      if (password !== password_check) { alert("비밀번호가 일치하지 않습니다."); return; }
      if (!regNickname.test(nickname)) { alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다."); return; }
      if (!regName.test(name)) { alert("이름은 한글 또는 영문만 사용 가능합니다."); return; }
      if (!email1 || !email2) { alert("이메일을 모두 입력해주세요."); return; }
      if (!regEmail.test(email)) { alert("올바른 이메일 형식을 입력해주세요."); return; }
      if (!tel1 || !tel2 || !tel3) { alert("연락처를 모두 입력해주세요."); return; }
      if (!regTel.test(tel)) { alert("전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)"); return; }
      if (!idCheckSw) { alert("아이디 중복확인을 해주세요."); return; }
      if (!nickCheckSw) { alert("닉네임 중복확인을 해주세요."); return; }
      if (!emailCheckSw) { alert("이메일 인증을 완료해주세요."); return; }
      
      $("#tel").val(tel);
      this.submit();
    });

    // --- 이메일 도메인 선택 로직 (jQuery 이벤트 위임 방식) ---
    // 이 코드는 '#domainDropdown' 안에서 '.dropdown-item'이 클릭되었을 때만 동작합니다.
    // 이 방식은 jQuery와 Bootstrap 환경에서 가장 안정적입니다.
    $('#domainDropdown').on('click', '.dropdown-item', function(event) {
      const selectedValue = $(this).text(); // 클릭된 항목의 텍스트를 가져옵니다.

      if (selectedValue === '직접입력') {
        $('#emailDomain').val('').focus(); // 입력창을 비우고 커서를 이동합니다.
      } else {
        $('#emailDomain').val(selectedValue); // 입력창에 선택한 도메인을 넣습니다.
      }
    });
    
    // --- 이메일 인증번호 받기 ---
    $('#certificationBtn').on('click', function() {
      const email1 = $("#email1").val().trim();
      const email2 = $("#emailDomain").val().trim();
      
      if (!email1 || !email2) {
        alert("이메일 주소를 모두 입력해주세요.");
        return;
      }
      
      const email = email1 + "@" + email2;
      if(!/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/.test(email)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return;
      }

      let spin = "<div class='text-center'><div class='spinner-border text-muted'></div> 메일 발송중...</div>";
      $("#demoSpin").html(spin);
      
      $.ajax({
        url: "${ctp}/member/memberEmailCheck",
        type: "post",
        data: { email: email },
        success: (res) => {
          if (res == 1) {
            alert("인증번호가 발송되었습니다. 메일을 확인해주세요.");
            let str = `<div class="input-group">
                         <input type="text" name="checkKey" id="checkKey" class="form-control" placeholder="인증번호 8자리"/>
                         <span id="timeLimit" class="input-group-text">3:00</span>
                         <button type="button" onclick="emailCertificationOk()" class="btn btn-primary">인증번호 확인</button>
                       </div>`;
            $("#demoSpin").html(str);
            timer();
          } 
          else {
            alert("메일 주소를 다시 확인해주세요.");
            $("#demoSpin").html('');
          }
        },
        error: () => {
          alert("메일 전송 중 오류가 발생했습니다.");
          $("#demoSpin").html('');
        }
      });
    });
    
  });
</script>
</body>
</html>

