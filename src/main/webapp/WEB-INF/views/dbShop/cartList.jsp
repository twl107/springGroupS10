<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>cartList.jsp</title>
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
    .checkbox-col {
      flex: 0 0 auto;
      width: 50px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <h2 class="fw-bold mb-4">장바구니</h2>

  <c:if test="${empty vos}">
    <div class="card text-center shadow-sm border-0" style="padding: 5rem 0;">
      <div class="card-body">
        <h4 class="card-title">장바구니가 비어 있습니다.</h4>
        <p class="text-muted">마음에 드는 상품을 담아보세요!</p>
        <a href="${ctp}/" class="btn btn-primary mt-3">쇼핑 계속하기</a>
      </div>
    </div>
  </c:if>

  <c:if test="${not empty vos}">
    <div class="row g-5">
      <div class="col-lg-8">
        <div class="list-group shadow-sm" id="cart-list-container">
          
          <div class="list-group-item p-3 bg-light">
            <div class="row align-items-center">
              <div class="checkbox-col d-flex justify-content-center">
                <input class="form-check-input" type="checkbox" id="check-all" checked>
              </div>
              <div class="col">
                <label class="form-check-label fw-bold" for="check-all">
                  전체 선택
                </label>
              </div>
            </div>
          </div>
          
          <c:forEach var="vo" items="${vos}">
            <div class="list-group-item p-3 cart-item" data-cart-idx="${vo.idx}" data-unit-price="${vo.mainPrice + vo.optionPrice}">
              <div class="row align-items-center">
                
                <div class="checkbox-col d-flex justify-content-center">
                  <input class="form-check-input item-check" type="checkbox" checked>
                </div>
                
                <div class="col-md-2 text-center">
                  <img src="${ctp}/product/${vo.FSName.split('/')[0]}" class="img-fluid rounded product-img" alt="${vo.productName}">
                </div>
                
                <div class="col-md-3">
                  <h6 class="mb-1">${vo.productName}</h6>
                  <c:if test="${not empty vo.optionName}">
                    <small class="text-muted">옵션: ${vo.optionName} (+<fmt:formatNumber value="${vo.optionPrice}" pattern="#,##0" />원)</small>
                  </c:if>
                </div>
                
                <div class="col-md-3">
                  <div class="input-group">
                    <button class="btn btn-outline-secondary btn-sm btn-minus" type="button">-</button>
                    <input type="text" class="form-control form-control-sm text-center quantity-input" value="${vo.quantity}" readonly>
                    <button class="btn btn-outline-secondary btn-sm btn-plus" type="button">+</button>
                  </div>
                </div>
                
                <div class="col-md-2 text-end">
                  <span class="fw-bold item-subtotal"><fmt:formatNumber value="${vo.totalPrice}" pattern="#,##0" />원</span>
                </div>
                
                <div class="col-md-1 text-end">
                  <button type="button" class="btn-close btn-delete" aria-label="Close"></button>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
      
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
              <button class="btn btn-primary btn-lg" type="button" id="btn-order">주문하기</button>
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
      
      // 장바구니의 모든 상품을 순회
      $(".cart-item").each(function() {
        const unitPrice = parseFloat($(this).data('unit-price'));
        const quantity = parseInt($(this).find('.quantity-input').val());
        const subtotal = unitPrice * quantity;
        
        // 각 상품별 합계 금액은 항상 업데이트 (수량 변경 시 반영)
        $(this).find('.item-subtotal').text(subtotal.toLocaleString() + '원');
        
        // 체크된 상품의 합계만 계산
        if ($(this).find('.item-check').is(':checked')) {
          totalProductsPrice += subtotal;
        }
      });
      
      // 배송비 계산 (예: 5만원 이상 무료배송)
      //const shippingFee = totalProductsPrice >= 50000 || totalProductsPrice === 0 ? 0 : 3000;
      const shippingFee = 0;
      
      const grandTotal = totalProductsPrice + shippingFee;
      
      // 최종 결제 정보 업데이트
      $('#total-products-price').text(totalProductsPrice.toLocaleString() + '원');
      $('#shipping-fee').text(shippingFee.toLocaleString() + '원');
      $('#grand-total').text(grandTotal.toLocaleString() + '원');
      
      // 주문 버튼 활성화/비활성화
      const $orderButton = $('#btn-order');
      if (totalProductsPrice === 0) {
        $orderButton.prop('disabled', true).text('주문할 상품을 선택하세요');
      } else {
        $orderButton.prop('disabled', false).text('주문하기');
      }

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
      
      if ($item.length === 0) return; 
      
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
              $item.remove();
              updateTotals();
            },
            error: function() {
              alert("상품 삭제 중 오류가 발생했습니다.");
            }
          });
        }
      }
    });

    // --- 전체 선택 체크박스 클릭 이벤트 ---
    $('#check-all').on('click', function() {
      const isChecked = $(this).is(':checked');
      $('.item-check').prop('checked', isChecked);
      updateTotals();
    });
    
    // --- 개별 체크박스 클릭 이벤트 ---
    $('#cart-list-container').on('click', '.item-check', function() {
      const totalCheckboxes = $('.item-check').length;
      const checkedCheckboxes = $('.item-check:checked').length;
      
      $('#check-all').prop('checked', totalCheckboxes === checkedCheckboxes);
      
      updateTotals();
    });

    // --- 페이지 첫 로드 시 합계 금액 계산 ---
    <c:if test="${not empty vos}">
      updateTotals();
    </c:if>
    
    // 주문하기 버튼 클릭 이벤트
    $("#btn-order").on('click', function() {
        // 1. 버튼이 비활성화 상태면 중단
        if ($(this).prop('disabled')) {
            alert("주문할 상품을 선택해주세요.");
            return;
        }

        // 2. 선택된 상품들의 cartIdx를 담을 배열
        const selectedCartIds = [];

        // 3. 체크된(.item-check:checked) 항목들을 순회
        $(".item-check:checked").each(function() {
            // 4. 각 항목의 부모 .cart-item에서 data-cart-idx 값을 가져옴
            const cartIdx = $(this).closest('.cart-item').data('cart-idx');
            selectedCartIds.push(cartIdx);
        });

        // 5. 서버로 전송할 동적 <form> 생성
        //    GET 방식은 URL 길이에 제한이 있으므로, POST로 전송
        const $form = $('<form></form>');
        $form.attr("method", "POST");
        $form.attr("action", "${ctp}/dbShop/orderForm");

        // 6. 선택된 cartIdx들을 <input type="hidden">으로 추가
        selectedCartIds.forEach(function(cartIdx) {
            $form.append($('<input>', {
                type: 'hidden',
                name: 'cartIdxs', // 컨트롤러에서 @RequestParam("cartIdxs")로 받음
                value: cartIdx
            }));
        });

        // 7. 폼을 body에 추가하고 submit (페이지 이동)
        $('body').append($form);
        $form.submit();
    });
  });
</script>
</body>
</html>

