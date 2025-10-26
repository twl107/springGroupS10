<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TWAUDIO</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h2 class="fw-bold mb-0">주문 상세 내역</h2>
		<a href="${ctp}/dbShop/myOrders" class="btn btn-outline-secondary">목록으로</a>
	</div>

	<div class="row g-5">
		<!-- 왼쪽: 주문 상품 정보 -->
		<div class="col-lg-7">
			<div class="card shadow-sm">
				<div class="card-header"><h5 class="mb-0">주문 상품</h5></div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<c:forEach var="item" items="${detailsList}">
							<li class="list-group-item d-flex align-items-center">
								<img src="${ctp}/product/${item.FSName}" class="rounded" style="width: 80px; height: 80px; object-fit: cover;">
								<div class="ms-3 flex-grow-1">
									<div class="fw-bold">${item.productName}</div>
									<c:if test="${not empty item.optionName}">
										<div class="text-muted small">옵션: ${item.optionName}</div>
									</c:if>
									<div class="text-muted small">${item.quantity}개 / <fmt:formatNumber value="${item.price}" pattern="#,###"/>원</div>
								</div>
								<div class="fw-bold text-end fs-5">
									<fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" />원
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<!-- 오른쪽: 배송 및 결제 정보 -->
		<div class="col-lg-5">
			<div class="card shadow-sm mb-4">
				<div class="card-header"><h5 class="mb-0">배송 정보</h5></div>
				<div class="card-body">
					<p><strong>주문번호:</strong> ${orderVO.orderId}</p>
					<p><strong>받는 사람:</strong> ${orderVO.recipientName}</p>
					<p><strong>연락처:</strong> ${orderVO.recipientTel}</p>
					<p><strong>주소:</strong> (${orderVO.recipientPostCode}) ${orderVO.recipientAddress1} ${orderVO.recipientAddress2}</p>
					<p class="mb-0"><strong>요청사항:</strong> ${empty orderVO.shippingMessage ? '없음' : orderVO.shippingMessage}</p>
				</div>
			</div>

			<div class="card shadow-sm">
				<div class="card-header"><h5 class="mb-0">결제 정보</h5></div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between">
							<span>총 상품 금액</span>
							<span><fmt:formatNumber value="${orderVO.totalPrice - 3000}" pattern="#,###" />원</span>
						</li>
						<li class="list-group-item d-flex justify-content-between">
							<span>배송비</span>
							<span><fmt:formatNumber value="3000" pattern="#,###" />원</span>
						</li>
						<li class="list-group-item d-flex justify-content-between fw-bold fs-5">
							<span>최종 결제 금액</span>
							<span class="text-danger"><fmt:formatNumber value="${orderVO.totalPrice}" pattern="#,###" />원</span>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
