<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<header class="bg-white">
  <div class="bg-light border-bottom">
    <div class="container d-flex justify-content-end align-items-center" style="height: 2.5rem;">
      <div class="small">
        <c:if test="${empty sUserId}">
          <a href="${ctp}/member/memberLogin" class="text-decoration-none text-secondary">로그인</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/member/memberJoin" class="text-decoration-none text-secondary">회원가입</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/dbShop/myOrders" class="text-decoration-none text-secondary">주문내역</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/dbShop/cartList" class="text-decoration-none text-secondary">장바구니</a>
        </c:if>
        <c:if test="${!empty sUserId}">
          <span class="fw-bold text-primary">${sUserId}님</span>
          <span class="mx-2 text-muted">|</span>
          <c:if test="${sLevel != 0 }">
            <a href="${ctp}/member/memberMain" class="text-decoration-none text-secondary">마이페이지</a>
          </c:if>
          <c:if test="${sLevel == 0 }">
            <a href="${ctp}/admin/adminMain" class="text-decoration-none text-secondary">관리자페이지</a>
          </c:if>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/dbShop/myOrders" class="text-decoration-none text-secondary">주문내역</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/dbShop/cartList" class="text-decoration-none text-secondary">장바구니</a>
          <span class="mx-2 text-muted">|</span>
          <a href="${ctp}/member/memberLogout" id="logoutLink" class="text-decoration-none text-secondary">로그아웃</a>
        </c:if>
      </div>
    </div>
  </div>

  <div id="nav-sentinel" class="border-bottom">
    <div class="container">
      <div class="d-flex align-items-center justify-content-between" style="height: 7rem;">
        <div>
          <h1 class="h2 fw-bold mb-0">
            <a href="${ctp}/" class="text-decoration-none text-dark">
              Scheherazade
            </a>
          </h1>
        </div>
        <div id="header-search-slot" class="d-flex">
        </div>
      </div>
    </div>
  </div>

  <style>
    #product-search-form .form-control,
    #product-search-form .btn {
      padding: 0.25rem 0.5rem; 
      font-size: 0.875rem;
      line-height: 1.5;
    }

    #product-search-form.d-flex .form-control {
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
    }
    
    #product-search-form.d-flex .btn {
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
      margin-left: -1px; 
    }
  </style>
</header>

<div id="header-placeholder" class="d-none"></div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const logoutLink = document.getElementById('logoutLink');
    if (logoutLink) {
      logoutLink.addEventListener('click', function(event) {
        if (!confirm('정말 로그아웃 하시겠습니까?')) {
          event.preventDefault();
        }
      });
    }

    <c:if test="${!empty message}">
      alert("${message}");
    </c:if>

    const searchForm = document.getElementById('product-search-form'); 
    const headerSearchSlot = document.getElementById('header-search-slot');
    const navContainer = document.getElementById('main-nav-content');
    const navSentinel = document.getElementById('nav-sentinel');
    
    if (searchForm && headerSearchSlot && navContainer && navSentinel) {
      
      const updateSearchFormPosition = () => {
        const sentinelBottom = navSentinel.getBoundingClientRect().bottom;

        if (sentinelBottom <= 0) {
          if (searchForm.parentElement !== navContainer) {
            navContainer.appendChild(searchForm);
          }
        } else {
          if (searchForm.parentElement !== headerSearchSlot) {
            headerSearchSlot.appendChild(searchForm);
          }
        }
      };

      updateSearchFormPosition();

      window.addEventListener('scroll', updateSearchFormPosition);
    }
  });
</script>