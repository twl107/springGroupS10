<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 - 비밀번호 확인</title>
    <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-danger text-white">
                    <h4 class="mb-0">회원 탈퇴 확인</h4>
                </div>
                <div class="card-body p-4">
                    <p class="card-text mb-4">
                        회원 탈퇴를 계속하려면 본인 확인을 위해 비밀번호를 입력해주세요.<br>
                        <strong class="text-danger">탈퇴 후에는 계정 및 관련 데이터 복구가 불가능할 수 있습니다.</strong>
                    </p>
                    <form method="POST" action="${ctp}/member/userDelete">
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-control" id="password" name="password" required autofocus>
                        </div>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${ctp}/member/memberMain" class="btn btn-secondary me-md-2">취소</a>
                            <button type="submit" class="btn btn-danger">회원 탈퇴 진행</button>
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