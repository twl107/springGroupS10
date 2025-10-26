<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>TWAUDIO</title>
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
			<c:when test="${not empty mainCategoryCode}">
				<h2 class="fw-bold">카테고리 상품</h2>
			</c:when>
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
			
			<div class="d-flex justify-content-center mt-5">
				<ul class="pagination">
					<c:set var="urlParams" value="" />
					<c:if test="${not empty keyword}"><c:set var="urlParams" value="&keyword=${keyword}" /></c:if>
					<c:if test="${not empty mainCategoryCode}"><c:set var="urlParams" value="&mainCategory=${mainCategoryCode}" /></c:if>
					
					<c:set var="url" value="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}${urlParams}" />

					<c:if test="${pageVO.pag > 1}">
						<li class="page-item"><a class="page-link" href="${url}&pag=1">처음</a></li>
					</c:if>
					<c:if test="${pageVO.curBlock > 0}">
						<li class="page-item"><a class="page-link" href="${url}&pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}">이전</a></li>
					</c:if>
					
					<c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
						<c:if test="${i <= pageVO.totPage && i > 0}">
							<li class="page-item ${i == pageVO.pag ? 'active' : ''}">
								<a class="page-link" href="${url}&pag=${i}">${i}</a>
							</li>
						</c:if>
					</c:forEach>
					
					<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
						<li class="page-item"><a class="page-link" href="${url}&pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}">다음</a></li>
					</c:if>
					<c:if test="${pageVO.pag < pageVO.totPage}">
						<li class="page-item"><a class="page-link" href="${url}&pag=${pageVO.totPage}">마지막</a></li>
					</c:if>
				</ul>
			</div>
		</c:otherwise>
	</c:choose>

</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>