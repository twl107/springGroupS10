<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>전체 상품</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
    .card-img-top {
      transition: transform 0.2s ease-in-out;
    }
    .card:hover .card-img-top {
      transform: scale(1.05);
    }
    .card-img-wrapper {
        overflow: hidden;
        border-top-left-radius: var(--bs-card-inner-border-radius);
        border-top-right-radius: var(--bs-card-inner-border-radius);
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">

  <div class="text-center mb-5">
    <c:choose>
      <c:when test="${not empty keyword}">
        <h2 class="fw-bold">
          "<span class="text-primary">${keyword}</span>" 검색 결과
        </h2>
      </c:when>
      <c:otherwise>
        <h2 class="fw-bold">전체 상품 목록</h2>
      </c:otherwise>
    </c:choose>
  </div>

  <c:choose>
    <c:when test="${empty vos}">
      <div class="card text-center shadow-sm border-0" style="padding: 5rem 0;">
        <div class="card-body">
          <h4 class="card-title">등록된 상품이 없습니다.</h4>
          <c:if test="${not empty keyword}">
            <p class="text-muted">다른 검색어로 다시 시도해보세요.</p>
          </c:if>
          <a href="${ctp}/dbShop/dbProductList" class="btn btn-primary mt-3">전체 상품 보기</a>
        </div>
      </div>
    </c:when>
    
    <c:otherwise>
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="vo" items="${vos}">
          <div class="col">
            <div class="card h-100 shadow-sm border-0">
              <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}" class="card-img-wrapper">
                <img src="${ctp}/product/${vo.FSName.split('/')[0]}" class="card-img-top" alt="${vo.productName}" style="aspect-ratio: 1 / 1; object-fit: cover;">
              </a>
              <div class="card-body">
                <h6 class="card-title text-truncate">${vo.productName}</h6>
                <p class="card-text text-muted small text-truncate">${vo.detail}</p>
                <h5 class="card-text fw-bold text-danger text-end">
                  <fmt:formatNumber value="${vo.mainPrice}" pattern="#,##0" />원
                </h5>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>