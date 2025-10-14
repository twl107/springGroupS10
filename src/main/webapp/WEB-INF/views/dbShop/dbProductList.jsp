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
			aspect-ratio: 1 / 1;
			object-fit: cover;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="text-center mb-5">
		<h2 class="fw-bold">All Products</h2>
		<p class="text-muted">~~~~~~~~~</p>
	</div>

	<!-- 상품 목록을 4열 그리드로 표시 -->
	<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
		<c:forEach var="vo" items="${vos}">
			<div class="col">
				<div class="card h-100 border-0 shadow-sm">
					<!-- 상품 상세페이지로 이동하는 링크 -->
					<a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
						<img src="${ctp}/product/${vo.FSName.split('/')[0]}" class="card-img-top" alt="${vo.productName}">
					</a>
					<div class="card-body">
						<h5 class="card-title fs-6">
							<a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}" class="text-decoration-none text-dark stretched-link">${vo.productName}</a>
						</h5>
						<p class="card-text text-muted small">${vo.detail}</p>
					</div>
					<div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
						<span class="fw-bold"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,##0" />원</span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
