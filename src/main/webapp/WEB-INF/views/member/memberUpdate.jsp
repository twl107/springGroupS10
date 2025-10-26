<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="emailParts" value="${fn:split(vo.email, '@')}" />
<c:set var="telParts" value="${fn:split(vo.tel, '-')}" />
<c:set var="email1" value="${emailParts[0]}" />
<c:set var="email2" value="${emailParts[1]}" />
<c:set var="tel1" value="${telParts[0]}" />
<c:set var="tel2" value="${telParts[1]}" />
<c:set var="tel3" value="${telParts[2]}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>TWAUDIO</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container" style="margin-top: 5rem; margin-bottom: 5rem;">
	<div class="row justify-content-center">
		<div class="col-lg-6 col-md-8">
			<div class="card shadow-sm border-0">
				<div class="card-body p-4 p-md-5">
					<h2 class="card-title text-center fw-bold mb-4">회원정보 수정</h2>
					<form name="myform" id="myform" method="post" action="${ctp}/member/memberUpdate">

						<div class="mb-3">
							<label for="userId" class="form-label small ms-1">아이디</label>
							<input type="text" class="form-control" id="userId" name="userId" value="${vo.userId}" readonly disabled>
						</div>

						<div class="input-group mb-3">
							<div class="form-floating">
								<input type="text" class="form-control" id="nickName" name="nickName" placeholder="닉네임" value="${vo.nickName}" required>
								<label for="nickName">닉네임</label>
							</div>
							<button class="btn btn-outline-secondary" type="button" id="nickNameCheckBtn">중복확인</button>
						</div>

						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="name" name="name" placeholder="이름" value="${vo.name}" required>
							<label for="name">이름</label>
						</div>

						<div class="mb-3">
							<label class="form-label small ms-1">이메일</label>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="계정" name="email1" id="email1" value="${email1}" required>
								<span class="input-group-text">@</span>
								<input type="text" class="form-control" placeholder="도메인" name="email2" id="emailDomain" value="${email2}">
								<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
								<ul class="dropdown-menu dropdown-menu-end" id="domainDropdown">
									<li><a class="dropdown-item" href="javascript:void(0);">gmail.com</a></li>
									<li><a class="dropdown-item" href="javascript:void(0);">naver.com</a></li>
									<li><a class="dropdown-item" href="javascript:void(0);">hanmail.net</a></li>
									<li><a class="dropdown-item" href="javascript:void(0);">nate.com</a></li>
									<li><a class="dropdown-item" href="javascript:void(0);">yahoo.com</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item" href="javascript:void(0);">직접입력</a></li>
								</ul>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label small ms-1">연락처</label>
							<div class="input-group">
								<input type="text" class="form-control" id="tel1" title="전화번호 첫자리" value="${tel1}" maxlength="3" required>
								<span class="input-group-text">-</span>
								<input type="text" class="form-control" id="tel2" title="전화번호 중간자리" value="${tel2}" maxlength="4" required>
								<span class="input-group-text">-</span>
								<input type="text" class="form-control" id="tel3" title="전화번호 마지막자리" value="${tel3}" maxlength="4" required>
							</div>
							<input type="hidden" id="tel" name="tel">
						</div>

						<div class="form-floating mb-3">
							<input type="date" class="form-control" id="birthday" name="birthday" value="${vo.birthday}" required>
							<label for="birthday">생년월일</label>
						</div>

						<div class="mb-3">
							<label class="form-label small ms-1">성별</label>
							<div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="gender" id="genderM" value="M" ${vo.gender == 'M' ? 'checked' : ''}>
									<label class="form-check-label" for="genderM">남자</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="gender" id="genderF" value="F" ${vo.gender == 'F' ? 'checked' : ''}>
									<label class="form-check-label" for="genderF">여자</label>
								</div>
							</div>
						</div>

						<div class="input-group mb-2">
							<input type="text" class="form-control" id="postCode" name="postCode" placeholder="우편번호" value="${vo.postCode}" readonly>
							<button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
						</div>
						<div class="form-floating mb-2">
							<input type="text" class="form-control" id="address1" name="address1" placeholder="기본 주소" value="${vo.address1}" readonly>
							<label for="address1">기본 주소</label>
						</div>
						<div class="form-floating mb-4">
							<input type="text" class="form-control" id="address2" name="address2" placeholder="상세 주소" value="${vo.address2}">
							<label for="address2">상세 주소</label>
						</div>

						<div class="d-grid gap-2">
							<button type="submit" class="btn btn-primary btn-lg">수정하기</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='${ctp}/member/memberMain'">마이페이지로</button>
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
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
				document.getElementById("postCode").value = data.zonecode;
				document.getElementById("address1").value = addr;
				document.getElementById("address2").focus();
			}
		}).open();
	}

	$(function() {
		let nickCheckSw = false;
		const originalNickName = "${vo.nickName}";

		if ($('#nickName').val() === originalNickName) {
			nickCheckSw = true;
			$('#nickNameCheckBtn').prop("disabled", true).text("확인완료");
		}

		$('#nickNameCheckBtn').on('click', function() {
			const nickName = $('#nickName').val().trim();
			if (!/^[a-zA-Z가-힣0-9]{2,10}$/.test(nickName)) {
				alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다.");
				return;
			}
			if (nickName === originalNickName) {
				alert("기존 닉네임과 동일합니다. (사용 가능)");
				nickCheckSw = true;
				$(this).prop("disabled", true).text("확인완료");
				return;
			}

			$.ajax({
				url: '${ctp}/member/nickNameCheck',
				type: 'POST',
				data: { nickName: nickName },
				success: (res) => {
					if (res.trim() !== "") {
						alert("이미 사용 중인 닉네임입니다.");
						$('#nickName').focus();
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

		$('#nickName').on('input', () => {
			nickCheckSw = false;
			$('#nickNameCheckBtn').prop("disabled", false).text("중복확인");
		});

		$('#myform').on('submit', function(e) {
			e.preventDefault();

			const nickName = $("#nickName").val().trim();
			const name = $("#name").val().trim();
			const email1 = $("#email1").val().trim();
			const email2 = $("#emailDomain").val().trim();
			const tel1 = $("#tel1").val().trim();
			const tel2 = $("#tel2").val().trim();
			const tel3 = $("#tel3").val().trim();

			const email = email1 + '@' + email2;
			const tel = tel1 + "-" + tel2 + "-" + tel3;

			const regNickName = /^[a-zA-Z가-힣0-9]{2,10}$/;
			const regName = /^[a-zA-Z가-힣]+$/;
			const regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			const regTel = /^\d{2,3}-\d{3,4}-\d{4}$/;

			if (!regNickName.test(nickName)) { alert("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다."); return; }
			if (!regName.test(name)) { alert("이름은 한글 또는 영문만 사용 가능합니다."); return; }
			if (!email1 || !email2) { alert("이메일을 모두 입력해주세요."); return; }
			if (!regEmail.test(email)) { alert("올바른 이메일 형식을 입력해주세요."); return; }
			if (!tel1 || !tel2 || !tel3) { alert("연락처를 모두 입력해주세요."); return; }
			if (!regTel.test(tel)) { alert("전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)"); return; }
			if (!nickCheckSw && nickName !== originalNickName) { alert("닉네임 중복확인을 해주세요."); return; } // 닉네임 변경 시에만 중복 확인 필수

			$("#tel").val(tel);
			this.submit();
		});

		$('#domainDropdown').on('click', '.dropdown-item', function(event) {
			const selectedValue = $(this).text();
			if (selectedValue === '직접입력') {
				$('#emailDomain').val('').focus();
			} else {
				$('#emailDomain').val(selectedValue);
			}
		});

	});
</script>
</body>
</html>