<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="currentCategory" value="${param.mainCategory}" />
<c:set var="currentURI" value="${pageContext.request.requestURI}" />

<nav id="main-nav" class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm sticky-top py-1">
  <div class="container">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-nav-content" aria-controls="main-nav-content" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div id="main-nav-content" class="collapse navbar-collapse justify-content-between">
      
      <ul class="navbar-nav mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link ${empty currentCategory and fn:endsWith(currentURI, '/dbShop/dbProductList') ? 'active bg-primary text-white rounded' : ''}" aria-current="page" href="${ctp}/dbShop/dbProductList">상품 전체보기</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentCategory == 'A' ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/dbShop/dbProductList?mainCategory=A">헤드폰</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentCategory == 'B' ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/dbShop/dbProductList?mainCategory=B">이어폰</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentCategory == 'C' ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/dbShop/dbProductList?mainCategory=C">DAC/AMP</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentCategory == 'D' ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/dbShop/dbProductList?mainCategory=D">커스텀 케이블</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentCategory == 'E' ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/dbShop/dbProductList?mainCategory=E">액세서리</a>
        </li>
      </ul>
        
      <div class="d-flex align-items-center">
        
        <ul class="navbar-nav mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link ${fn:endsWith(currentURI, '/notice/noticeList') ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/notice/noticeList">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${fn:endsWith(currentURI, '/pds/pdsList') ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/pds/pdsList">자료실</a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${fn:endsWith(currentURI, '/inquiry/inquiryList') ? 'active bg-primary text-white rounded' : ''}" href="${ctp}/inquiry/inquiryList">1:1문의</a>
          </li>
        </ul>
          
        <form id="product-search-form" class="d-flex mb-2 mb-lg-0 ms-lg-3" method="get" action="${ctp}/dbShop/dbProductList">
          <input class="form-control" type="search" name="keyword" placeholder="상품 검색" aria-label="Search" style="min-width: 200px;">
          <button class="btn btn-outline-secondary" type="submit">🔍</button>
        </form>
          
      </div>
        
    </div>
  </div>
</nav>