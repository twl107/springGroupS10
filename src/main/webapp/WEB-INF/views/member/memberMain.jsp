<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>TWAUDIO</title>
	<script>
		'use strict';
		
		function userDelete() {
			if(confirm("회원에서 탈퇴하시겠습니까?\n탈퇴 시 일부 데이터는 복구되지 않을 수 있습니다.")){
				location.href = '${ctp}/member/userDelete';
			}
			else alert("회원 탈퇴가 취소되었습니다.");
		}
		
	</script>
  <style>
    .list-group-item-action:hover {
      background-color: #f8f9fa;
    }
    .cart-thumbnail {
      width: 60px;
      height: 60px;
      object-fit: cover;
      margin-right: 1rem;
    }
    .card {
      display: flex;
      flex-direction: column;
    }
    .card-body {
      flex: 1 1 auto;
      padding: 1rem 1rem;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="fw-bold mb-4">${sNickName}님의 마이페이지</h2>
  <div class="row">
    <div class="col-lg-6 mb-4">
      <div class="card h-100 shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h5 class="my-0 fw-normal">회원님 안녕하세요!</h5>
          <div class="dropdown">
            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="myInfoDropdown" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-gear-fill"></i> 내 정보 관리
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="myInfoDropdown">
              <li>
                <a class="dropdown-item" href="${ctp}/member/memberUpdate">
                  <i class="bi bi-person-fill-gear"></i> 회원정보 수정
                </a>
              </li>
              <li>
                <a class="dropdown-item" href="${ctp}/member/memberPwdCheck">
                  <i class="bi bi-lock-fill"></i> 비밀번호 변경
                </a>
              </li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <a class="dropdown-item text-danger" href="#" onclick="userDelete(); return false;" >
                  <i class="bi bi-person-x-fill"></i> 회원 탈퇴
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="card-body">
          <ul class="list-group list-group-flush">
            <li class="list-group-item d-flex justify-content-between align-items-center">
              회원 등급
              <span class="badge bg-primary rounded-pill fs-6">${strLevel}</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              가용 포인트
              <span class="fw-bold fs-6"><fmt:formatNumber value="${memberVO.point}" pattern="#,##0" /> P</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              총 방문 횟수
              <span>${memberVO.visitCnt} 회</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              마지막 방문일
              <span>${fn:substring(sLastLoginAt,0,10)}</span>
            </li>
          </ul>
          <c:if test="${sLevel == 3}">
            <div class="alert alert-info mt-3 mb-0" role="alert">
              <strong>준회원</strong> 등업 조건 : 회원로그인 4일 이상 (정회원부터 1일 1회 10포인트, 최대 50포인트 증정)
            </div>
          </c:if>
        </div>
      </div>
    </div>
    
    <div class="col-lg-6 mb-4">
      <div class="card h-100 shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h5 class="mb-0">장바구니</h5>
          <a href="${ctp}/dbShop/cartList" class="btn btn-sm btn-outline-secondary">장바구니 이동 &gt;</a>
        </div>
        <div class="card-body">
          <c:if test="${empty myCartList}">
            <p class="text-center text-muted mt-3">장바구니가 비어있습니다.</p>
          </c:if>
          <c:if test="${not empty myCartList}">
            <ul class="list-group list-group-flush">
              <c:forEach var="cart" items="${myCartList}">
                <li class="list-group-item px-0 d-flex align-items-center">
                  <img src="${ctp}/data/dbShop/product/${cart.FSName}" alt="${cart.FSName}" class="cart-thumbnail rounded">
                  <div class="flex-grow-1">
                    <div class="d-flex w-100 justify-content-between">
                      <h6 class="mb-1">${cart.productName}</h6>
                      <small class="text-muted">${cart.quantity}개</small>
                    </div>
                    <small class="text-muted d-block">${cart.optionName}</small>
                    <span class="fw-bold"><fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0" /> 원</span>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:if>
        </div>
      </div>
    </div>

    <div class="col-lg-6 mb-4">
      <div class="card h-100 shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h5 class="mb-0">최근 주문 내역</h5>
          <a href="${ctp}/dbShop/myOrders" class="btn btn-sm btn-outline-secondary">전체보기 &gt;</a>
        </div>
        <div class="card-body">
          <c:if test="${empty myOrderList}">
            <p class="text-center text-muted mt-3">최근 주문 내역이 없습니다.</p>
          </c:if>
          <c:if test="${not empty myOrderList}">
            <ul class="list-group list-group-flush">
              <c:forEach var="order" items="${myOrderList}">
                <li class="list-group-item px-0">
                  <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">${order.orderId}</h6>
                    <small class="text-muted"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></small>
                  </div>
                  <p class="mb-1 text-muted">
                    ${order.mainProductName} <c:if test="${order.itemCount > 1}">등 ${order.itemCount}건</c:if>
                  </p>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-primary"><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0" /> 원</span>
                    <c:choose>
                      <c:when test="${order.orderStatus == '배송완료'}"><span class="badge bg-success">${order.orderStatus}</span></c:when>
                      <c:when test="${order.orderStatus == '배송중'}"><span class="badge bg-info">${order.orderStatus}</span></c:when>
                      <c:when test="${order.orderStatus == '결제완료' || order.orderStatus == '배송준비중'}"><span class="badge bg-primary">${order.orderStatus}</span></c:when>
                      <c:otherwise><span class="badge bg-secondary">${order.orderStatus}</span></c:otherwise>
                    </c:choose>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:if>
        </div>
      </div>
    </div>

    <div class="col-lg-6 mb-4">
      <div class="card h-100 shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h5 class="mb-0">1:1 문의 내역</h5>
          <a href="${ctp}/inquiry/inquiryList" class="btn btn-sm btn-outline-secondary">전체보기 &gt;</a>
        </div>
        <div class="card-body">
          <c:if test="${empty myInquiryList}">
            <p class="text-center text-muted mt-3">작성한 문의 내역이 없습니다.</p>
          </c:if>
          <c:if test="${not empty myInquiryList}">
            <ul class="list-group list-group-flush">
              <c:forEach var="inquiry" items="${myInquiryList}">
                <li class="list-group-item px-0">
                  <div class="d-flex w-100 justify-content-between">
                    <h6 class="mb-1">${inquiry.title}</h6>
                    <small class="text-muted">${fn:substring(inquiry.WDate,0,10)}</small>
                  </div>
                  <p class="mb-1 text-muted">분류: ${inquiry.part}</p>
                  <c:choose>
                    <c:when test="${inquiry.reply == '답변완료'}"><span class="badge bg-success">${inquiry.reply}</span></c:when>
                    <c:otherwise><span class="badge bg-warning text-dark">${inquiry.reply}</span></c:otherwise>
                  </c:choose>
                </li>
              </c:forEach>
            </ul>
          </c:if>
        </div>
      </div>
    </div>
    
  </div> </div> <p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>