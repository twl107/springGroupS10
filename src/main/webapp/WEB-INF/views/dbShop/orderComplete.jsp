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
	<div class="text-center p-5 border rounded-3 bg-light">
		<h1 class="display-4 fw-bold">주문이 완료되었습니다!</h1>
		<p class="lead my-4">고객님의 주문이 성공적으로 처리되었습니다.</p>
		<hr>
		<div class="my-4 text-start mx-auto" style="max-width: 400px;">
			<p><strong>주문번호:</strong> ${orderVO.orderId}</p>
			<p><strong>결제금액:</strong> <fmt:formatNumber value="${orderVO.totalPrice}" pattern="#,###" />원</p>
			<p><strong>배송지:</strong> ${orderVO.recipientAddress1} ${orderVO.recipientAddress2}</p>
		</div>
		<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
			<a href="${ctp}/" class="btn btn-outline-secondary btn-lg px-4 gap-3">쇼핑 계속하기</a>
			<a href="${ctp}/dbShop/myOrders" class="btn btn-primary btn-lg px-4">주문 내역 확인</a>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
