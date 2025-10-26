<%-- home.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>TWAUDIO</title>
  <style>
    .carousel-item img { height: 500px; object-fit: cover; width: 100%; }
    .carousel-control-prev, .carousel-control-next { background-color: rgba(0, 0, 0, 0.3); width: 5%; height: 20%; top: 50%; transform: translateY(-50%); border-radius: 0.25rem; }
    .carousel-control-prev { left: 1rem; }
    .carousel-control-next { right: 1rem; }
    .carousel-control-prev-icon, .carousel-control-next-icon { width: 1.5rem; height: 1.5rem; }
    .card-img-top { aspect-ratio: 1 / 1; object-fit: cover; }
  </style>
</head>
<body class="bg-white text-gray-800">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<main>
  <div id="mainBannerCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
    <div class="carousel-indicators">
      <c:forEach var="banner" items="${bannerList}" varStatus="status">
        <button type="button" data-bs-target="#mainBannerCarousel" data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}" aria-current="${status.first ? 'true' : 'false'}" aria-label="Slide ${status.count}"></button>
      </c:forEach>
    </div>
    <div class="carousel-inner">
      <c:choose>
        <c:when test="${empty bannerList}">
          <div class="carousel-item active"><img src="${ctp}/images/default_banner.jpg" class="d-block w-100" alt="Default Banner"></div>
        </c:when>
        <c:otherwise>
          <c:forEach var="banner" items="${bannerList}" varStatus="status">
            <div class="carousel-item ${status.first ? 'active' : ''}">
              <c:choose>
                <c:when test="${not empty banner.linkUrl}"><a href="${banner.linkUrl}" target="_blank"><img src="${ctp}/resources/data/banner/${banner.FSName}" class="d-block w-100" alt="Banner ${status.count}"></a></c:when>
                <c:otherwise><img src="${ctp}/resources/data/banner/${banner.FSName}" class="d-block w-100" alt="Banner ${status.count}"></c:otherwise>
              </c:choose>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="visually-hidden">Previous</span></button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="next"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="visually-hidden">Next</span></button>
  </div>

  <div class="container py-5">

    <h3 class="fw-bold mb-4">베스트 셀러</h3>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4 mb-5">
      <c:if test="${empty bestSellerList}">
        <div class="col-12"><p class="text-center text-muted">판매량 높은 상품이 없습니다.</p></div>
      </c:if>
      <c:forEach var="product" items="${bestSellerList}">
        <div class="col">
          <div class="card h-100 border-0 shadow-sm">
            <a href="${ctp}/dbShop/dbProductContent?idx=${product.idx}">
              <img src="${ctp}/product/${fn:split(product.FSName,'/')[0]}" class="card-img-top" alt="${product.productName}">
            </a>
            <div class="card-body">
              <h5 class="card-title fs-6">
                <a href="${ctp}/dbShop/dbProductContent?idx=${product.idx}" class="text-decoration-none text-dark stretched-link">${product.productName}</a>
              </h5>
              <p class="card-text text-muted small">${product.detail}</p>
            </div>
            <div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end align-items-center">
              <span class="fw-bold"><fmt:formatNumber value="${product.mainPrice}" pattern="#,##0" />원</span>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <h3 class="fw-bold mb-4">추천 상품</h3>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
      <c:if test="${empty recommendedProductList}">
        <div class="col-12"><p class="text-center text-muted">추천 상품이 없습니다.</p></div>
      </c:if>
      <c:forEach var="product" items="${recommendedProductList}">
        <div class="col">
          <div class="card h-100 border-0 shadow-sm">
            <a href="${ctp}/dbShop/dbProductContent?idx=${product.idx}">
              <img src="${ctp}/product/${fn:split(product.FSName,'/')[0]}" class="card-img-top" alt="${product.productName}">
            </a>
            <div class="card-body">
              <h5 class="card-title fs-6">
                <a href="${ctp}/dbShop/dbProductContent?idx=${product.idx}" class="text-decoration-none text-dark stretched-link">${product.productName}</a>
              </h5>
              <p class="card-text text-muted small">${product.detail}</p>
            </div>
            <div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
              <span class="fw-bold"><fmt:formatNumber value="${product.mainPrice}" pattern="#,##0" />원</span>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

  </div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>