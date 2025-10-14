<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<nav id="main-nav" class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm">
  <div class="container">
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link active" aria-current="page" href="${ctp}/dbShop/dbProductList">상품 전체보기</a></li>
        <li class="nav-item"><a class="nav-link" href="#">브랜드별</a></li>
        <li class="nav-item"><a class="nav-link" href="#">이어폰</a></li>
        <li class="nav-item"><a class="nav-link" href="#">헤드폰</a></li>
        <li class="nav-item"><a class="nav-link" href="#">DAC/AMP</a></li>
        <li class="nav-item"><a class="nav-link" href="#">커스텀 케이블</a></li>
        <li class="nav-item"><a class="nav-link" href="#">액세서리</a></li>
      </ul>
    </div>
  </div>
</nav>