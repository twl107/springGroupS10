<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<div class="list-group list-group-flush">
  <a href="${ctp}/" target="_top" class="list-group-item list-group-item-action fw-bold">
    <i class="fa-solid fa-house me-2"></i>사이트 홈
  </a>
  
  <a href="#memberMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-users me-2"></i>회원관리
  </a>
  <div class="collapse" id="memberMenu">
    <a href="${ctp}/admin/member/adminMemberList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 회원리스트</a>
    <a href="${ctp}/admin/complaint/complaintList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 신고리스트</a>
    <a href="${ctp}/admin/complaint/complaintList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 쿠폰발행</a>
  </div>

  <a href="#productMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-box-open me-2"></i>쇼핑몰관리
  </a>
  <div class="collapse" id="productMenu">
    <a href="${ctp}/dbShop/dbCategory" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품카테고리</a>
    <a href="${ctp}/dbShop/dbProduct" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품등록관리</a>
    <a href="${ctp}/dbShop/dbShopList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 상품리스트</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· 주문/배송관리</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· 결제처리</a>
  </div>

  <a href="#boardMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-clipboard-list me-2"></i>게시판관리
  </a>
  <div class="collapse" id="boardMenu">
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· Q&A</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· FAQ</a>
    <a href="${ctp}/admin/inquiry/adInquiryList" target="adminContent" class="list-group-item list-group-item-action ps-4">· 1:1문의</a>
  </div>

  <a href="#boardMenu" class="list-group-item list-group-item-action fw-bold" data-bs-toggle="collapse">
    <i class="fa-solid fa-clipboard-list me-2"></i>기타
  </a>
  <div class="collapse" id="boardMenu">
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· 웹메세지</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· DB채팅</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· 웹채팅(실시간)</a>
    <a href="#" target="adminContent" class="list-group-item list-group-item-action ps-4">· 구글번역</a>
  </div>
</div>