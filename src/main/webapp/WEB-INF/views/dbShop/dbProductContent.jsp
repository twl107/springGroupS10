<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${productVO.productName} - 상세 정보</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			// --- 최종 가격 계산 함수 ---
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

			// --- 옵션 또는 수량 변경 시 최종 가격 업데이트 ---
			$('#optionSelect, #quantity').on('change', updateTotal);

			// --- 수량 증가/감소 버튼 ---
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

			// --- 장바구니 담기 버튼 클릭 (AJAX) ---
			$('#add-to-cart-btn').on('click', function() {
				// 옵션이 있는 상품인데 옵션을 선택하지 않은 경우 방지
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
			
			// 페이지 첫 로드 시 가격 초기화
			updateTotal();
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="row g-5">
		<!-- 상품 이미지 -->
		<div class="col-lg-6">
			<img src="${ctp}/product/${productVO.FSName.split('/')[0]}" class="img-fluid rounded" alt="${productVO.productName}">
		</div>
		
		<!-- 상품 정보 및 구매 옵션 -->
		<div class="col-lg-6">
			<h2 class="fw-bold">${productVO.productName}</h2>
			<p class="text-muted">${productVO.detail}</p>
			<hr>
			
			<div class="mb-3">
				<span class="fs-5">판매가</span>
				<span class="fs-3 fw-bold ms-3"><fmt:formatNumber value="${productVO.mainPrice}" pattern="#,##0" />원</span>
			</div>
			
			<!-- 옵션 선택 (옵션이 있을 경우에만 표시) -->
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

			<!-- 수량 선택 -->
			<div class="mb-4">
				<label class="form-label">수량</label>
				<div class="input-group" style="max-width: 150px;">
					<button class="btn btn-outline-secondary" type="button" id="btn-minus">-</button>
					<input type="text" class="form-control text-center" id="quantity" value="1" readonly>
					<button class="btn btn-outline-secondary" type="button" id="btn-plus">+</button>
				</div>
			</div>
			
			<hr>
			
			<!-- 최종 주문 금액 -->
			<div class="d-flex justify-content-end align-items-center mb-4">
				<span class="fs-5">총 상품 금액</span>
				<span id="totalPrice" class="fs-2 fw-bold text-danger ms-3"></span>
			</div>
			
			<!-- 구매 버튼 -->
			<div class="d-grid gap-2">
				<button class="btn btn-primary btn-lg" id="add-to-cart-btn">장바구니 담기</button>
				<button class="btn btn-outline-secondary btn-lg">바로 구매</button>
			</div>
		</div>
	</div>
	
	<!-- 상품 상세 내용 (CKEditor 내용) -->
	<div class="row mt-5">
		<div class="col">
			<hr class="mb-5">
			<div>
				${productVO.content}
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
