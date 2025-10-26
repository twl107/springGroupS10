<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<div class="list-group list-group-flush">
  <a href="${ctp}/" target="_top" class="list-group-item list-group-item-action fw-bold mb-2 bg-light">
    <i class="fa-solid fa-house fa-fw me-2"></i>사이트 홈
  </a>

  <a href="${ctp}/admin/adminContent" target="adminContent" class="list-group-item list-group-item-action fw-bold">
    <i class="fa-solid fa-tachometer-alt fa-fw me-2"></i>관리자 메인
  </a>

  <a href="${ctp}/admin/member/adminMemberList" target="adminContent" class="list-group-item list-group-item-action fw-bold">
    <i class="fa-solid fa-users fa-fw me-2"></i>회원 리스트
  </a>

  <a href="#productMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-store fa-fw me-2"></i>쇼핑몰 관리
  </a>
  <div class="collapse" id="productMenu">
    <a href="${ctp}/dbShop/dbCategory" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품 카테고리</a>
    <a href="${ctp}/dbShop/dbProduct" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품 등록/관리</a>
    <a href="${ctp}/dbShop/dbShopList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품 리스트</a>
    <a href="${ctp}/admin/dbShop/adminOrderList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 주문/배송 관리</a>
  </div>

  <a href="${ctp}/admin/inquiry/adInquiryList" target="adminContent" class="list-group-item list-group-item-action fw-bold">
    <i class="fa-solid fa-headset fa-fw me-2"></i>1:1 문의 관리
  </a>

  <a href="#siteMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-desktop fa-fw me-2"></i>사이트 관리
  </a>
  <div class="collapse" id="siteMenu">
    <a href="${ctp}/admin/banner/adminBannerList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 메인 배너 관리</a>
    <a href="${ctp}/admin/banner/adminMainProductList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 메인 상품 관리</a>
  </div>

</div>