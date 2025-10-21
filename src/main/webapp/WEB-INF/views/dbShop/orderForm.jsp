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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<title>orderForm.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="text-center mb-5">
		<h2 class="fw-bold">주문서 작성</h2>
		<p class="text-muted">주문하실 상품과 배송 정보를 확인해주세요.</p>
	</div>

	<!-- 주문서 메인 폼 -->
	<form name="orderForm" id="orderForm" method="post" action="${ctp}/dbShop/createOrder">
		<div class="row g-5">
			
			<!-- 왼쪽: 배송 정보 입력 -->
			<div class="col-lg-7">
        <h4 class="mb-4 fw-bold border-bottom pb-2">배송 정보</h4>
        
        <div class="mb-2">
          <label for="recipientName" class="form-label small">받는 사람</label>
          <input type="text" class="form-control" id="recipientName" name="recipientName" placeholder="받는 사람" value="${memberVO.name}" required>
        </div>
        
        <div class="mb-2">
          <label class="form-label small">연락처</label>
          <div class="input-group">
            <input type="text" class="form-control" id="tel1" title="전화번호 첫자리" maxlength="3" required>
            <span class="input-group-text">-</span>
            <input type="text" class="form-control" id="tel2" title="전화번호 중간자리" maxlength="4" required>
            <span class="input-group-text">-</span>
            <input type="text" class="form-control" id="tel3" title="전화번호 마지막자리" maxlength="4" required>
          </div>
          <input type="hidden" id="tel" name="tel">
        </div>
        
        <div class="mb-2">
          <label for="postCode" class="form-label small">우편번호</label>
          <div class="input-group">
            <input type="text" class="form-control" id="postCode" name="postCode" placeholder="우편번호" readonly>
            <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
          </div>
        </div>
        
        <div class="mb-2">
          <label for="address1" class="form-label small">기본 주소</label>
          <input type="text" class="form-control" id="address1" name="address1" placeholder="기본 주소" readonly>
        </div>
        
        <div class="mb-2">
          <label for="address2" class="form-label small">상세 주소</label>
          <input type="text" class="form-control" id="address2" name="address2" placeholder="상세 주소">
        </div>
        
        <div class="mb-2">
          <label for="shippingMessage" class="form-label small">배송 요청사항 (선택)</label>
          <textarea class="form-control" placeholder="배송 요청사항" id="shippingMessage" name="shippingMessage" style="height: 100px"></textarea>
        </div>

      </div>
			
			<!-- 오른쪽: 주문 상품 및 결제 정보 요약 -->
			<div class="col-lg-5">
				<div class="card border-0 shadow-sm sticky-top" style="top: 2rem;">
					<div class="card-body p-4">
						<h4 class="mb-4 fw-bold border-bottom pb-2">주문 상품 정보</h4>
						
						<!-- 주문 상품 목록 -->
						<ul class="list-group list-group-flush mb-4">
							<c:forEach var="item" items="${orderItems}" varStatus="st">
								<li class="list-group-item d-flex align-items-center px-0">
									<img src="${ctp}/product/${item.FSName}" class="rounded" style="width: 60px; height: 60px; object-fit: cover;">
									<div class="ms-3 flex-grow-1">
										<div class="fw-bold small">${item.productName}</div>
										<c:if test="${not empty item.optionName}">
											<div class="text-muted small">옵션: ${item.optionName}</div>
										</c:if>
										<div class="text-muted small">${item.quantity}개</div>
									</div>
									<div class="fw-bold text-end">
										<fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />원
									</div>
								</li>
								<!-- 서버로 전송될 숨은 데이터 -->
								<input type="hidden" name="orderDetails[${st.index}].productIdx" value="${item.productIdx}">
								<input type="hidden" name="orderDetails[${st.index}].optionIdx" value="${item.optionIdx}">
								<input type="hidden" name="orderDetails[${st.index}].quantity" value="${item.quantity}">
								<input type="hidden" name="orderDetails[${st.index}].price" value="${item.totalPrice / item.quantity}">
							</c:forEach>
						</ul>

						<h4 class="mb-4 fw-bold border-bottom pb-2">결제 정보</h4>
						
						<ul class="list-group list-group-flush">
							<li class="list-group-item d-flex justify-content-between align-items-center px-0">
								<span>총 상품 금액</span>
								<span id="items-total-price"><fmt:formatNumber value="${totalOrderPrice}" pattern="#,###" />원</span>
							</li>
							<li class="list-group-item d-flex justify-content-between align-items-center px-0">
								<span>배송비</span>
								<span><fmt:formatNumber value="3000" pattern="#,###" />원</span>
							</li>
							<li class="list-group-item d-flex justify-content-between align-items-center px-0 fw-bold fs-5 border-top pt-3">
								<span>최종 결제 금액</span>
								<span class="text-danger" id="final-total-price">
									<%-- <fmt:formatNumber value="${totalOrderPrice + 3000}" pattern="#,###" />원 --%>
									<fmt:formatNumber value="${totalOrderPrice}" pattern="#,###" />원
								</span>
							</li>
						</ul>
						<%-- <input type="hidden" name="totalPrice" id="totalPrice" value="${totalOrderPrice + 3000}"> --%>
						<input type="hidden" name="totalPrice" id="totalPrice" value="${totalOrderPrice}">
						
						<div class="d-grid mt-4">
							<!-- type="submit"을 type="button"으로 변경하고 id를 부여합니다 -->
							<button type="button" id="paymentBtn" class="btn btn-primary btn-lg">결제하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 포트원 결제 후 서버로 전송할 추가 데이터 -->
		<input type="hidden" name="imp_uid" id="imp_uid">
		<input type="hidden" name="orderId" id="orderId">
	</form>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
        document.getElementById("postCode").value = data.zonecode;
        document.getElementById("address1").value = addr;
        document.getElementById("address2").focus();
      }
    }).open();
  }

	// 포트원 결제 로직
	$(document).ready(function() {
		const IMP = window.IMP; 
		IMP.init("imp50352711");

		// 2. '결제하기' 버튼 클릭 이벤트 처리
		$("#paymentBtn").on("click", function() {
			
			const tel1 = $("#tel1").val();
			const tel2 = $("#tel2").val();
			const tel3 = $("#tel3").val();
			if (tel1 && tel2 && tel3) {
				$("#tel").val(tel1 + "-" + tel2 + "-" + tel3);
			}
			
			if ($("#recipientName").val() === "" || tel1 === "" || tel2 === "" || tel3 === "" || $("#postCode").val() === "") {
				alert("배송 정보를 모두 입력해주세요.");
				return;
			}
			requestPay();
		});
	});
	
	function requestPay() {
		const orderId = "ORD" + new Date().getTime();
		
		const productName = "${orderItems[0].productName}<c:if test='${orderItems.size() > 1}'> 외 ${orderItems.size() - 1}건</c:if>";
		const buyerName = $("#recipientName").val();
		const buyerTel = $("#tel").val();
		const buyerPostcode = $("#postCode").val();
		const buyerAddr = $("#address1").val() + " " + $("#address2").val();
		
		IMP.request_pay({
			pg: "html5_inicis.INIpayTest",
			pay_method: "card",
			merchant_uid: orderId,
			name: productName,
			amount: parseInt($("#totalPrice").val()),
			buyer_email: "${memberVO.email}",
			buyer_name: buyerName,
			buyer_tel: buyerTel,
			buyer_addr: buyerAddr,
			buyer_postcode: buyerPostcode
		}, function(rsp) { // 5. 결제 후 콜백 함수
			if (rsp.success) {
				// 결제 성공 시, 서버에 최종적으로 주문 정보 전송 및 검증 요청
				$("#imp_uid").val(rsp.imp_uid);
				$("#orderId").val(rsp.merchant_uid);
				
				$("#orderForm").submit();
				
			} else {
				alert("결제에 실패했습니다. 에러 내용: " + rsp.error_msg);
			}
		});
	}
</script>
</body>
</html>

