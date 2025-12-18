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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		.product-content-body {
			text-align: center;
			line-height: 1.8;
		}
		.product-content-body img {
			max-width: 100%;
			height: auto;
			margin-top: 1rem;
			margin-bottom: 1rem;
		}
	</style>
	<script>
		$(document).ready(function() {
			function updateTotal() {
				const basePrice = parseInt('${productVO.mainPrice}');
				let optionPrice = 0;
				const selectedOption = $('#optionSelect').find('option:selected');
				if (selectedOption.length > 0 && selectedOption.val() !== "") {
					optionPrice = parseInt(selectedOption.data('price'));
				}
				const quantity = parseInt($('#quantity').val());
				const totalPrice = (basePrice + optionPrice) * quantity;
				$('#totalPrice').text(totalPrice.toLocaleString() + '원');
			}
			$('#optionSelect, #quantity').on('change', updateTotal);
			$('#btn-plus').on('click', function() {
				let currentVal = parseInt($('#quantity').val());
				$('#quantity').val(currentVal + 1).trigger('change');
			});
			$('#btn-minus').on('click', function() {
				let currentVal = parseInt($('#quantity').val());
				if (currentVal > 1) {
					$('#quantity').val(currentVal - 1).trigger('change');
				}
			});
			$('#add-to-cart-btn').on('click', function() {
				if ($('#optionSelect option').length > 1 && $('#optionSelect').val() === "") {
					alert("상품 옵션을 선택해주세요.");
					return;
				}
				const cartData = {
					productIdx: '${productVO.idx}',
					optionIdx: $('#optionSelect').val(),
					quantity: $('#quantity').val()
				};
				$.ajax({
					url: '${ctp}/dbShop/cartAdd',
					type: 'POST',
					data: cartData,
					success: function(res) {
						if (res === "1") {
							if (confirm("상품이 장바구니에 추가되었습니다. 장바구니로 이동하시겠습니까?")) {
								location.href = '${ctp}/dbShop/cartList';
							}
						} else if (res === "0") {
							alert("로그인이 필요한 서비스입니다.");
							location.href = '${ctp}/member/memberLogin';
						} else {
							alert("장바구니 추가에 실패했습니다. 다시 시도해주세요.");
						}
					},
					error: function() {
						alert("서버 통신 중 오류가 발생했습니다.");
					}
				});
			});
			$('#buy-now-btn').on('click', function() {
				if ($('#optionSelect option').length > 1 && $('#optionSelect').val() === "") {
					alert("상품 옵션을 선택해주세요.");
					return;
				}
				$('#buy-optionIdx').val($('#optionSelect').val());
				$('#buy-quantity').val($('#quantity').val());
				$('#buy-now-form').submit();
			});
			updateTotal();
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="row justify-content-center">
		<div class="col-lg-10">
			
			<div class="border rounded p-4 mb-5">
				<div class="row g-4">
					<div class="col-lg-8">
						<img src="${ctp}/product/${productVO.FSName.split('/')[0]}" class="img-fluid rounded border shadow-sm" alt="${productVO.productName}">
					</div>
					
					<div class="col-lg-4">
						<div class="card h-100 border-0">
							<div class="card-body d-flex flex-column p-0">
								<h2 class="h3 fw-bold mb-2">${productVO.productName}</h2>
								<p class="fs-6 text-muted mb-3">${productVO.detail}</p>
								<hr>
								
								<div class="mb-3">
									<span class="text-muted">판매가</span>
									<span class="fs-3 fw-bold ms-2 text-dark"><fmt:formatNumber value="${productVO.mainPrice}" pattern="#,##0" />원</span>
								</div>
								
								<c:if test="${not empty optionVOS}">
									<div class="mb-3">
										<label for="optionSelect" class="form-label">옵션 선택</label>
										<select class="form-select" id="optionSelect">
											<option value="" data-price="0" selected>-- 옵션을 선택하세요 --</option>
											<c:forEach var="option" items="${optionVOS}">
												<option value="${option.idx}" data-price="${option.optionPrice}">
													${option.optionName} (+<fmt:formatNumber value="${option.optionPrice}" pattern="#,##0"/>원)
												</option>
											</c:forEach>
										</select>
									</div>
								</c:if>
					
								<div class="mb-4">
									<label class="form-label">수량</label>
									<div class="input-group" style="max-width: 180px;">
										<button class="btn btn-outline-secondary" type="button" id="btn-minus">-</button>
										<input type="text" class="form-control text-center" id="quantity" value="1" readonly>
										<button class="btn btn-outline-secondary" type="button" id="btn-plus">+</button>
									</div>
								</div>
								
								<hr class="mt-auto">
								
								<div class="d-flex justify-content-end align-items-center mb-4">
									<span class="fs-6">총 상품 금액</span>
									<span id="totalPrice" class="fs-3 fw-bold text-danger ms-3"></span>
								</div>
								
								<div class="d-grid gap-2">
									<button class="btn btn-primary" id="add-to-cart-btn">장바구니 담기</button>
									<button class="btn btn-outline-dark" id="buy-now-btn">바로 구매</button>
								</div>
							</div>
						</div>
					</div>
				</div> </div> <form id="buy-now-form" action="${ctp}/dbShop/orderFormOne" method="POST" style="display: none;">
				<input type="hidden" name="productIdx" value="${productVO.idx}">
				<input type="hidden" id="buy-optionIdx" name="optionIdx">
				<input type="hidden" id="buy-quantity" name="quantity">
			</form>
			
			<div class="row justify-content-center mt-5 pt-4">
				<div class="col-12">
					<hr class="mb-5">
					<div class="product-content-body">
						${productVO.content}
					</div>
				</div>
			</div>
		
		</div> </div> </div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>