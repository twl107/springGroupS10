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
	<title>장바구니</title>
	
	<style>
		/* home.jsp와 동일한 이미지 비율 유지를 위한 스타일 */
		.cart-item-img {
			width: 100px;
			height: 100px;
			object-fit: cover;
		}
		
		/* 수량 조절 인풋 버튼 숨기기 */
		input[type="number"]::-webkit-inner-spin-button,
		input[type="number"]::-webkit-outer-spin-button {
		  -webkit-appearance: none;
		  margin: 0;
		}
		
		/* 결제 정보 영역이 스크롤을 따라다니도록 설정 */
		.sticky-top {
			top: 20px; /* 상단과의 간격 */
		}
	</style>
	
</head>
<body class="bg-light">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<main class="container py-5">
	<div class="p-4 p-md-5 mb-4 rounded text-body-emphasis bg-body-secondary">
		<div class="col-lg-8 px-0">
			<h1 class="display-4 fst-italic">장바구니</h1>
			<p class="lead my-3">주문하실 상품의 수량을 확인하고 변경할 수 있습니다.</p>
		</div>
	</div>

	<%-- 장바구니에 상품이 없을 경우 --%>
	<%-- <c:if test="${empty cartItems}">
		<div class="text-center py-5">
			<p class="fs-4">텅...</p>
			<p class="text-muted">장바구니에 담긴 상품이 없습니다.</p>
			<a href="${ctp}/" class="btn btn-dark mt-3">쇼핑 계속하기</a>
		</div>
	</c:if> --%>

	<%-- 장바구니에 상품이 있을 경우 (아래는 예시 데이터입니다) --%>
	<%-- <c:if test="${not empty cartItems}"> --%>
	<div class="row g-5">
		<div class="col-lg-8">
			<%-- 장바구니 상품 목록 --%>
			<div class="card shadow-sm border-0">
				<div class="card-header bg-white py-3">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="" id="checkAll" checked>
						<label class="form-check-label fw-bold" for="checkAll">
							전체 선택
						</label>
					</div>
				</div>
				<ul class="list-group list-group-flush">
					
					<%-- 
					// 나중에 Controller에서 cartItems(장바구니 목록)를 넘겨주시면
					// 아래 <c:forEach> 태그를 사용하여 동적으로 목록을 생성할 수 있습니다.
					<c:forEach var="item" items="${cartItems}">
						<li class="list-group-item d-flex align-items-center">
							...
						</li>
					</c:forEach>
					--%>

					<!-- 장바구니 아이템 예시 1 -->
					<li class="list-group-item d-flex align-items-center p-3">
						<div class="form-check me-3">
							<input class="form-check-input" type="checkbox" value="" checked>
						</div>
						<img src="https://placehold.co/100x100/e2e8f0/334155?text=Product+1" class="rounded cart-item-img" alt="Product 1">
						<div class="ms-3 flex-grow-1">
							<h6 class="mb-1">고음질 유선 이어폰</h6>
							<small class="text-muted">옵션: 블랙</small>
						</div>
						<div class="input-group" style="width: 120px;">
							<button class="btn btn-outline-secondary btn-sm" type="button">-</button>
							<input type="number" class="form-control form-control-sm text-center" value="1" min="1">
							<button class="btn btn-outline-secondary btn-sm" type="button">+</button>
						</div>
						<div class="text-end ms-3" style="width: 120px;">
							<span class="fw-bold">150,000원</span>
						</div>
						<button type="button" class="btn-close ms-3" aria-label="Close"></button>
					</li>

					<!-- 장바구니 아이템 예시 2 -->
					<li class="list-group-item d-flex align-items-center p-3">
						<div class="form-check me-3">
							<input class="form-check-input" type="checkbox" value="" checked>
						</div>
						<img src="https://placehold.co/100x100/e2e8f0/334155?text=Product+2" class="rounded cart-item-img" alt="Product 2">
						<div class="ms-3 flex-grow-1">
							<h6 class="mb-1">노이즈캔슬링 헤드폰</h6>
							<small class="text-muted">옵션: 화이트</small>
						</div>
						<div class="input-group" style="width: 120px;">
							<button class="btn btn-outline-secondary btn-sm" type="button">-</button>
							<input type="number" class="form-control form-control-sm text-center" value="1" min="1">
							<button class="btn btn-outline-secondary btn-sm" type="button">+</button>
						</div>
						<div class="text-end ms-3" style="width: 120px;">
							<span class="fw-bold">320,000원</span>
						</div>
						<button type="button" class="btn-close ms-3" aria-label="Close"></button>
					</li>
				</ul>
			</div>
		</div>

		<div class="col-lg-4">
			<%-- 결제 정보 요약 --%>
			<div class="card shadow-sm border-0 sticky-top">
				<div class="card-body">
					<h5 class="card-title fw-bold mb-4">결제 예정 금액</h5>
					<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-2">
							<span>총 상품 금액</span>
							<span>470,000원</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-2">
							<span>배송비</span>
							<span>+3,000원</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 fw-bold fs-5">
							<span>총 결제 예정 금액</span>
							<span>473,000원</span>
						</li>
					</ul>
					<button type="button" class="btn btn-dark btn-lg w-100 mt-4">주문하기</button>
				</div>
			</div>
		</div>
	</div>
	<%-- </c:if> --%>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	// 여기에 장바구니 수량 조절, 선택, 삭제 관련 JavaScript 로직을 추가할 수 있습니다.
</script>
</body>
</html>
