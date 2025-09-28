<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<header class="bg-white">
  <%-- Top utility bar --%>
  <div class="bg-light border-bottom">
    <div class="container d-flex justify-content-end align-items-center" style="height: 2.5rem;">
      <div class="small">
        <c:if test="${empty sUserid}">
          <a href="${ctp}/member/memberLogin" class="text-decoration-none text-secondary">로그인</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/member/memberJoin" class="text-decoration-none text-secondary">회원가입</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/cart/cartList" class="text-decoration-none text-secondary">장바구니</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/support/qnaList" class="text-decoration-none text-secondary">고객센터</a>
        </c:if>
        <c:if test="${!empty sUserid}">
          <span class="fw-bold text-primary">${sUserid}님</span>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/member/myPage" class="text-decoration-none text-secondary">마이페이지</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/cart/cartList" class="text-decoration-none text-secondary">장바구니</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/support/qnaList" class="text-decoration-none text-secondary">고객센터</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/member/memberLogout" id="logoutLink" class="text-decoration-none text-secondary">로그아웃</a>
        </c:if>
      </div>
    </div>
  </div>

  <%-- Main header with logo and search --%>
  <div id="nav-sentinel" class="border-bottom">
    <div class="container">
      <div class="d-flex align-items-center justify-content-between" style="height: 5rem;">
        <div>
          <a href="${ctp}/" class="text-decoration-none">
            <h1 class="h2 fw-bold text-dark">Scheherazade</h1>
          </a>
        </div>
        <div class="w-50" style="max-width: 300px;">
          <div class="input-group">
            <input id="search" name="search" class="form-control" placeholder="검색" type="search">
            <button class="btn btn-outline-secondary" type="button">
              <i class="bi bi-search"></i>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>

<!-- Sticky Navigation을 위한 Placeholder -->
<div id="header-placeholder" class="d-none"></div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // 로그아웃 확인창 기능
    const logoutLink = document.getElementById('logoutLink');
    if (logoutLink) {
      logoutLink.addEventListener('click', function(event) {
        if (!confirm('정말 로그아웃 하시겠습니까?')) {
          event.preventDefault();
        }
      });
    }

    // 서버 메시지 알림창 기능
    <c:if test="${!empty message}">
      alert("${message}");
    </c:if>
  });
</script>

