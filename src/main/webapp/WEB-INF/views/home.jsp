<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>home.jsp</title>
	
	<style>
		/* object-fit을 위한 추가 스타일 */
		.hero-img {
			width: 100%;
			height: 100%;
			object-fit: cover;
		}
		.card-img-top {
			aspect-ratio: 1 / 1;
			object-fit: cover;
		}
	</style>
	
</head>
<body class="bg-white text-gray-800">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<main>
	<!-- Hero Section (메인 배너) -->
	<div class="position-relative bg-dark text-white text-center" style="height: 500px; overflow: hidden;">
		<img src="https://placehold.co/1600x600/334155/e2e8f0?text=Main+Banner+Image" class="position-absolute top-0 start-0 hero-img" alt="Main Banner">
		<div class="position-absolute top-0 start-0 w-100 h-100" style="background-color: rgba(0, 0, 0, 0.5);"></div>
		<div class="position-relative d-flex align-items-center justify-content-center h-100">
			<div class="px-4">
				<h1 class="display-4 fw-bold">당신의 목소리만 남기다<br>KDT3000</h1>
				<p class="lead my-3">런칭 기념 20% 세일!</p>
			</div>
		</div>
	</div>
		
		<!-- 상품 목록 영역 -->
	<div class="container py-5">
		<h2 class="fw-bold mb-4">주요 상품 목록</h2>
		<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
			<!-- 상품 카드 1 -->
			<div class="col">
				<div class="card h-100 border-0 shadow-sm">
					<img src="https://placehold.co/400x400/e2e8f0/334155?text=Product+1" class="card-img-top" alt="Product 1">
					<div class="card-body">
						<h5 class="card-title fs-6">
							<a href="#" class="text-decoration-none text-dark stretched-link">고음질 유선 이어폰</a>
						</h5>
						<p class="card-text text-muted small">블랙</p>
					</div>
					<div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
						<span class="fw-bold">₩150,000</span>
					</div>
				</div>
			</div>
			
			<!-- 추가 상품 카드들을 여기에 복사해서 사용하세요 -->
			<div class="col">
				<div class="card h-100 border-0 shadow-sm">
					<img src="https://placehold.co/400x400/e2e8f0/334155?text=Product+2" class="card-img-top" alt="Product 2">
					<div class="card-body">
						<h5 class="card-title fs-6">
							<a href="#" class="text-decoration-none text-dark stretched-link">노이즈캔슬링 헤드폰</a>
						</h5>
						<p class="card-text text-muted small">화이트</p>
					</div>
					<div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
						<span class="fw-bold">₩320,000</span>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 border-0 shadow-sm">
					<img src="https://placehold.co/400x400/e2e8f0/334155?text=Product+3" class="card-img-top" alt="Product 3">
					<div class="card-body">
						<h5 class="card-title fs-6">
							<a href="#" class="text-decoration-none text-dark stretched-link">포터블 DAC</a>
						</h5>
						<p class="card-text text-muted small">실버</p>
					</div>
					<div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
						<span class="fw-bold">₩280,000</span>
					</div>
				</div>
			</div>

			<div class="col">
				<div class="card h-100 border-0 shadow-sm">
					<img src="https://placehold.co/400x400/e2e8f0/334155?text=Product+4" class="card-img-top" alt="Product 4">
					<div class="card-body">
						<h5 class="card-title fs-6">
							<a href="#" class="text-decoration-none text-dark stretched-link">커스텀 케이블</a>
						</h5>
						<p class="card-text text-muted small">동선</p>
					</div>
					<div class="card-footer bg-transparent border-0 pt-0 d-flex justify-content-end">
						<span class="fw-bold">₩180,000</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</body>
</html>
