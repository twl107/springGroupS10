<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>장바구니</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
		.product-img {
			width: 100px;
			height: 100px;
			object-fit: cover;
		}
		.quantity-input {
			width: 50px;
			text-align: center;
		}
		.summary-card {
			position: sticky;
			top: 2rem;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<h2 class="fw-bold mb-4">장바구니</h2>

	<!-- 장바구니가 비어있을 경우 -->
	<c:if test="${empty vos}">
		<div class="card text-center shadow-sm border-0" style="padding: 5rem 0;">
			<div class="card-body">
				<h4 class="card-title">장바구니가 비어 있습니다.</h4>
				<p class="text-muted">마음에 드는 상품을 담아보세요!</p>
				<a href="${ctp}/" class="btn btn-primary mt-3">쇼핑 계속하기</a>
			</div>
		</div>
	</c:if>

	<!-- 장바구니에 상품이 있을 경우 -->
	<c:if test="${not empty vos}">
		<div class="row g-5">
			<!-- 상품 목록 -->
			<div class="col-lg-8">
				<div class="list-group shadow-sm" id="cart-list-container">
					<c:forEach var="vo" items="${vos}">
						<div class="list-group-item p-3 cart-item" data-cart-idx="${vo.idx}" data-unit-price="${vo.mainPrice + vo.optionPrice}">
							<div class="row align-items-center">
								<div class="col-md-2 text-center">
									<!-- 상품 썸네일 -->
									<img src="${ctp}/product/${vo.FSName.split('/')[0]}" class="img-fluid rounded product-img" alt="${vo.productName}">
								</div>
								<div class="col-md-4">
									<!-- 상품명 및 옵션 -->
									<h6 class="mb-1">${vo.productName}</h6>
									<c:if test="${not empty vo.optionName}">
										<small class="text-muted">옵션: ${vo.optionName} (+<fmt:formatNumber value="${vo.optionPrice}" pattern="#,##0" />원)</small>
									</c:if>
								</div>
								<div class="col-md-3">
									<!-- 수량 변경 -->
									<div class="input-group">
										<button class="btn btn-outline-secondary btn-sm btn-minus" type="button">-</button>
										<input type="text" class="form-control form-control-sm text-center quantity-input" value="${vo.quantity}" readonly>
										<button class="btn btn-outline-secondary btn-sm btn-plus" type="button">+</button>
									</div>
								</div>
								<div class="col-md-2 text-end">
									<!-- 상품별 합계 금액 -->
									<span class="fw-bold item-subtotal"><fmt:formatNumber value="${vo.totalPrice}" pattern="#,##0" />원</span>
								</div>
								<div class="col-md-1 text-end">
									<!-- 삭제 버튼 -->
									<button type="button" class="btn-close btn-delete" aria-label="Close"></button>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<!-- 결제 정보 요약 -->
			<div class="col-lg-4">
				<div class="card shadow-sm border-0 summary-card">
					<div class="card-body">
						<h5 class="card-title mb-3">결제 예정 금액</h5>
						<ul class="list-group list-group-flush">
							<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
								총 상품 금액
								<span id="total-products-price">0원</span>
							</li>
							<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
								배송비
								<span id="shipping-fee">0원</span>
							</li>
							<li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 fw-bold fs-5">
								총 결제 예정 금액
								<span id="grand-total">0원</span>
							</li>
						</ul>
						<div class="d-grid mt-3">
							<button class="btn btn-primary btn-lg" type="button" onclick="location.href='#'">주문하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		// --- 합계 금액을 계산하고 화면에 업데이트하는 함수 ---
		function updateTotals() {
			let totalProductsPrice = 0;
			
			// 장바구니의 모든 상품을 순회하며 합계 계산
			$(".cart-item").each(function() {
				const unitPrice = parseFloat($(this).data('unit-price'));
				const quantity = parseInt($(this).find('.quantity-input').val());
				const subtotal = unitPrice * quantity;
				totalProductsPrice += subtotal;
				
				// 각 상품별 합계 금액 업데이트
				$(this).find('.item-subtotal').text(subtotal.toLocaleString() + '원');
			});
			
			// 배송비 계산 (예: 5만원 이상 무료배송)
			const shippingFee = totalProductsPrice >= 50000 || totalProductsPrice === 0 ? 0 : 3000;
			
			const grandTotal = totalProductsPrice + shippingFee;
			
			// 최종 결제 정보 업데이트
			$('#total-products-price').text(totalProductsPrice.toLocaleString() + '원');
			$('#shipping-fee').text(shippingFee.toLocaleString() + '원');
			$('#grand-total').text(grandTotal.toLocaleString() + '원');
			
			// 장바구니가 비게 되면 '비어있음' 화면으로 새로고침
			if ($(".cart-item").length === 0) {
				location.reload();
			}
		}

		// --- 수량 변경 또는 상품 삭제 시 서버에 업데이트 요청하는 함수 ---
		function updateCart(cartIdx, quantity) {
			$.ajax({
				url: "${ctp}/dbShop/cartUpdateQuantity",
				type: "POST",
				data: { cartIdx: cartIdx, quantity: quantity },
				success: function() {
					updateTotals(); // 서버 업데이트 성공 시 화면에도 합계 반영
				},
				error: function() {
					alert("수량 변경 중 오류가 발생했습니다.");
				}
			});
		}

		// --- 이벤트 위임을 사용하여 +, -, x 버튼 클릭 처리 ---
		$('#cart-list-container').on('click', function(e) {
			const $target = $(e.target);
			const $item = $target.closest('.cart-item');
			const cartIdx = $item.data('cart-idx');
			const $quantityInput = $item.find('.quantity-input');
			let quantity = parseInt($quantityInput.val());

			// 수량 증가(+) 버튼
			if ($target.hasClass('btn-plus')) {
				quantity++;
				$quantityInput.val(quantity);
				updateCart(cartIdx, quantity);
			}
			
			// 수량 감소(-) 버튼
			if ($target.hasClass('btn-minus')) {
				if (quantity > 1) {
					quantity--;
					$quantityInput.val(quantity);
					updateCart(cartIdx, quantity);
				}
			}
			
			// 삭제(x) 버튼
			if ($target.hasClass('btn-delete')) {
				if (confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")) {
					$.ajax({
						url: "${ctp}/dbShop/cartDelete",
						type: "POST",
						data: { cartIdx: cartIdx },
						success: function() {
							$item.remove();   // 화면에서 해당 상품 행 제거
							updateTotals(); // 합계 다시 계산
						},
						error: function() {
							alert("상품 삭제 중 오류가 발생했습니다.");
						}
					});
				}
			}
		});

		// --- 페이지 첫 로드 시 합계 금액 계산 ---
		// vos 객체가 비어있지 않을 때만(즉, 장바구니에 상품이 있을 때만) 최초 합계 계산을 실행합니다.
		<c:if test="${not empty vos}">
		  updateTotals();
		</c:if>
	});
</script>
</body>
</html>

