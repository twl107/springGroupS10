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
	<!-- jQuery 추가 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- 포트원 결제 API 라이브러리 추가 -->
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<title>주문서 작성</title>
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
				
				<!-- 받는 사람 -->
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="recipientName" name="recipientName" placeholder="받는 사람" value="${memberVO.name}" required>
					<label for="recipientName">받는 사람</label>
				</div>
				
				<!-- 연락처 -->
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="recipientTel" name="recipientTel" placeholder="연락처" value="${memberVO.tel}" required>
					<label for="recipientTel">연락처</label>
				</div>
				
				<!-- 주소 -->
				<div class="input-group mb-2">
					<input type="text" class="form-control" id="recipientPostCode" name="recipientPostCode" placeholder="우편번호" value="${memberVO.postCode}" readonly required>
					<button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
				</div>
				<div class="form-floating mb-2">
					<input type="text" class="form-control" id="recipientAddress1" name="recipientAddress1" placeholder="기본 주소" value="${memberVO.address1}" readonly required>
					<label for="recipientAddress1">기본 주소</label>
				</div>
				<div class="form-floating mb-4">
					<input type="text" class="form-control" id="recipientAddress2" name="recipientAddress2" placeholder="상세 주소" value="${memberVO.address2}">
					<label for="recipientAddress2">상세 주소</label>
				</div>
				
				<!-- 배송 요청사항 -->
				<div class="form-floating">
					<textarea class="form-control" placeholder="배송 요청사항" id="shippingMessage" name="shippingMessage" style="height: 100px"></textarea>
					<label for="shippingMessage">배송 요청사항 (선택)</label>
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
									<img src="${ctp}/product/${item.fSName}" class="rounded" style="width: 60px; height: 60px; object-fit: cover;">
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
									<fmt:formatNumber value="${totalOrderPrice + 3000}" pattern="#,###" />원
								</span>
							</li>
						</ul>
						<input type="hidden" name="totalPrice" id="totalPrice" value="${totalOrderPrice + 3000}">
						
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 카카오 주소 API
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
				document.getElementById("recipientPostCode").value = data.zonecode;
				document.getElementById("recipientAddress1").value = addr;
				document.getElementById("recipientAddress2").focus();
			}
		}).open();
	}

	// 포트원 결제 로직
	$(document).ready(function() {
		const IMP = window.IMP; 
		IMP.init("imp50352711");

		// 2. '결제하기' 버튼 클릭 이벤트 처리
		$("#paymentBtn").on("click", function() {
			if ($("#recipientName").val() === "" || $("#recipientTel").val() === "" || $("#recipientPostCode").val() === "") {
				alert("배송 정보를 모두 입력해주세요.");
				return;
			}
			requestPay();
		});
	});
	
	function requestPay() {
		const orderId = "ORD" + new Date().getTime();
		
		const productName = "${orderItems[0].productName}" <c:if test="${orderItems.size() > 1}"> 외 ${orderItems.size() - 1}건</c:if>;

		IMP.request_pay({
			pg: "html5_inicis.INIpayTest",
			pay_method: "card",
			merchant_uid: orderId,
			name: productName,
			amount: parseInt($("#totalPrice").val()),
			buyer_email: "${memberVO.email}",
			buyer_name: "${memberVO.name}",
			buyer_tel: "${memberVO.tel}",
			buyer_addr: "${memberVO.address1} ${memberVO.address2}",
			buyer_postcode: "${memberVO.postCode}"
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

