<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>상품 전체보기</title>
  <style>
    .card-img-top {
      height: 250px;
      object-fit: cover; /* 이미지가 카드 영역에 맞게 잘리거나 채워짐 */
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container my-5">
  <h2 class="text-center mb-4">상품 전체보기</h2>
  
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
    <c:forEach var="vo" items="${vos}">
      <div class="col">
        <div class="card h-100">
          <a href="${ctp}/product/detail?productId=${vo.productId}">
            <%-- 이미지가 없을 경우를 대비한 기본 이미지 처리 --%>
            <c:if test="${empty vo.thumbnail}">
              <img src="${ctp}/images/default_product.png" class="card-img-top" alt="기본 이미지">
            </c:if>
            <c:if test="${!empty vo.thumbnail}">
              <img src="${ctp}/resources/images/product/${vo.thumbnail}" class="card-img-top" alt="${vo.name}">
            </c:if>
          </a>
          <div class="card-body">
            <h5 class="card-title">${vo.name}</h5>
            <p class="card-text text-muted small">${vo.categoryName}</p>
            <p class="card-text fw-bold fs-5">
              <fmt:formatNumber value="${vo.price}" pattern="#,###" />원
            </p>
          </div>
          <div class="card-footer bg-white border-top-0 pb-3">
             <a href="${ctp}/product/detail?productId=${vo.productId}" class="btn btn-primary w-100">상세보기</a>
          </div>
        </div>
      </div>
    </c:forEach>
    
    <c:if test="${empty vos}">
      <div class="col-12">
        <p class="text-center text-muted py-5">등록된 상품이 없습니다.</p>
      </div>
    </c:if>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>