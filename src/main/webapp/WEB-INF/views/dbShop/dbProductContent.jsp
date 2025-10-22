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
	
		function myOrderStatus() {
    	var startDateJumun = new Date(document.getElementById("startJumun").value);
    	var endDateJumun = new Date(document.getElementById("endJumun").value);
    	var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	let startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	let endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="dbMyOrderStatus?pag=${pageVO.pag}&startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus;
    }
	
	
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
				
				const optionIdx = $('#optionSelect').val();
				const quantity = $('#quantity').val();
				
				$('#buy-optionIdx').val(optionIdx);
				$('#buy-quantity').val(quantity);
				
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
	<div class="row g-5">
		<div class="col-lg-6">
			<img src="${ctp}/product/${productVO.FSName.split('/')[0]}" class="img-fluid rounded" alt="${productVO.productName}">
		</div>
		
		<div class="col-lg-6">
			<h2 class="fw-bold">${productVO.productName}</h2>
			<p class="text-muted">${productVO.detail}</p>
			<hr>
			
			<div class="mb-3">
				<span class="fs-5">판매가</span>
				<span class="fs-3 fw-bold ms-3"><fmt:formatNumber value="${productVO.mainPrice}" pattern="#,##0" />원</span>
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
				<div class="input-group" style="max-width: 150px;">
					<button class="btn btn-outline-secondary" type="button" id="btn-minus">-</button>
					<input type="text" class="form-control text-center" id="quantity" value="1" readonly>
					<button class="btn btn-outline-secondary" type="button" id="btn-plus">+</button>
				</div>
			</div>
			
			<hr>
			
			<div class="d-flex justify-content-end align-items-center mb-4">
				<span class="fs-5">총 상품 금액</span>
				<span id="totalPrice" class="fs-2 fw-bold text-danger ms-3"></span>
			</div>
			
			<div class="d-grid gap-2">
				<button class="btn btn-primary btn-lg" id="add-to-cart-btn">장바구니 담기</button>
				<button class="btn btn-outline-secondary btn-lg" id="buy-now-btn">바로 구매</button>
			</div>
		</div>
	</div>
	
	<form id="buy-now-form" action="${ctp}/dbShop/orderFormOne" method="POST" style="display: none;">
		<input type="hidden" name="productIdx" value="${productVO.idx}">
		<input type="hidden" id="buy-optionIdx" name="optionIdx">
		<input type="hidden" id="buy-quantity" name="quantity">
	</form>
	
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
