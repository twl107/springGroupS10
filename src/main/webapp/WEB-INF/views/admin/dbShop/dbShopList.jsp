<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 목록</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script>
'use strict';
// 필터 제출 함수: 폼을 바로 제출하여 모든 체크된 항목을 URL 파라미터로 전송합니다.
function filterSubmit() {
	document.getElementById("filterForm").submit();
}
	</script>
	<style>
a { text-decoration: none; }
.category-box {	
	border: 1px solid #ddd;	
	padding: 15px;	
	border-radius: 5px;	
}
.list-title-highlight {
	color: brown;
	font-weight: bold;
}
.product-item a {
	color: inherit;
	text-decoration: none;
}
.product-item img {
	width: 200px;
	height: 180px;
	object-fit: cover;
	border-radius: 4px;
}
.product-name {
	font-size: 0.95rem;
	font-weight: 500;
	color: #333;
}
.product-price {
	font-size: 0.9rem;
	color: #fd7e14;
	font-weight: bold;
}
.product-detail {
	font-size: 0.85rem;
	color: #6c757d;
}
	</style>
</head>
<body>
<div class="container mt-4">
	<!-- 브라우저의 기본 폼 제출 기능 사용 -->
	<form method="get" action="${ctp}/dbShop/dbShopList" id="filterForm">	
		<div class="category-box mb-4">
			<h5>
				대분류	
				<a href="${ctp}/dbShop/dbShopList" class="btn btn-sm btn-outline-secondary ms-2">전체보기</a>
			</h5>
			<div class="d-flex flex-wrap">
				<c:forEach var="main" items="${mainCategoryVOS}">
					<c:set var="mainChecked" value="${not empty selectedMainCodes and fn:contains(selectedMainCodes, main.categoryMainCode)}"/>
					<div class="form-check me-3">
						<!-- name이 mainCategory이므로, 체크된 값들이 모두 서버로 전송됩니다. -->
						<input class="form-check-input" type="checkbox" name="mainCategory" value="${main.categoryMainCode}" id="main_${main.categoryMainCode}" onchange="filterSubmit()"
							<c:if test="${mainChecked}">checked</c:if> >
						<label class="form-check-label" for="main_${main.categoryMainCode}">${main.categoryMainName} (${main.categoryMainCode})</label>
					</div>
				</c:forEach>
			</div>
			<hr/>
			<h5>
				중분류
				<a class="btn btn-sm btn-outline-primary ms-2" data-bs-toggle="collapse" href="#middleCategoryCollapse" role="button">
					펼치기/접기
				</a>
			</h5>
			<div class="collapse ${not empty selectedMiddleCodes ? 'show' : ''}" id="middleCategoryCollapse">
				<div class="d-flex flex-wrap">
					<c:forEach var="middle" items="${middleCategoryVOS}">
						<c:set var="middleChecked" value="${not empty selectedMiddleCodes and fn:contains(selectedMiddleCodes, middle.categoryMiddleName)}"/>
						<div class="form-check me-3">
							<!-- value를 categoryMiddleName으로 설정하고, 체크 상태는 categoryMiddleName 기준으로 유지 -->
							<input class="form-check-input" type="checkbox" name="middleCategory" value="${middle.categoryMiddleName}" id="middle_${middle.categoryMiddleCode}" onchange="filterSubmit()"
								<c:if test="${middleChecked}">checked</c:if> >
							<label class="form-check-label" for="middle_${middle.categoryMiddleCode}">${middle.categoryMiddleName} (${middle.categoryMiddleCode})</label>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</form>
	<hr/>
	<div class="row">
		<div class="col">
			<h4>상품 리스트 :	
				<!-- JSTL 공백 오류 방지 적용된 상태 -->
				<span class="list-title-highlight"><c:choose><c:when test="${not empty selectedMiddleName}">${selectedMiddleName}</c:when><c:when test="${not empty selectedMainName}">${selectedMainName}</c:when><c:otherwise>전체 상품</c:otherwise></c:choose></span>
			</h4>
		</div>
		<div class="col text-end">
			<button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbProduct';">상품등록</button>
		</div>
	</div>
	<hr/>
	<c:if test="${fn:length(productVOS) == 0}">
		<h3 class="text-center text-muted my-5">표시할 상품이 없습니다.</h3>
	</c:if>
	<div class="row mt-4">
		<c:set var="cnt" value="0"/>
		<c:forEach var="vo" items="${productVOS}">
			<c:if test="${cnt > 0 && cnt % 3 == 0}">
			</div><div class="row mt-4">
			</c:if>
			<div class="col-md-4">
				<div class="product-item text-center mb-4">
					<a href="${ctp}/dbShop/dbShopContent?idx=${vo.idx}">
						<img src="${ctp}/resources/data/dbShop/product/${vo.FSName}" class="mb-2" alt="${vo.productName}"/>
						<div class="product-name">
							${vo.productName}
						</div>
						<div class="product-price">
							<fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원
						</div>
						<div class="product-detail">
							${fn:substring(vo.detail, 0, 20)}<c:if test="${fn:length(vo.detail) > 20}">...</c:if>
						</div>
					</a>
				</div>
			</div>
			<c:set var="cnt" value="${cnt+1}"/>
		</c:forEach>
	</div>
	
	<c:if test="${pageVO.totPage > 1}">
		<div class="d-flex justify-content-center mt-5">
			<ul class="pagination">

				<c:set var="urlParams" value=""/>
				<c:if test="${not empty selectedMainCodes}">
					<c:forEach var="mainCode" items="${selectedMainCodes}">
						<c:set var="urlParams" value="${urlParams}&mainCategory=${mainCode}"/>
					</c:forEach>
				</c:if>
				<c:if test="${not empty selectedMiddleCodes}">
					<c:forEach var="middleCode" items="${selectedMiddleCodes}">
						<c:set var="urlParams" value="${urlParams}&middleCategory=${middleCode}"/>
					</c:forEach>
				</c:if>

				<c:set var="url" value="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}${urlParams}" />

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
	</c:if>

	<hr/>
</div>
<p><br/></p>
</body>
</html>
