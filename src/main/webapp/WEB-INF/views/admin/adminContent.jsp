<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 메인</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<style>
		.dashboard-card { transition: all 0.2s ease-in-out; }
		.dashboard-card:hover { transform: translateY(-5px); box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
		.dashboard-card a { text-decoration: none; color: inherit; }
		.card-icon { font-size: 2.5rem; }
	</style>
</head>
<body>
<div class="container p-4">
	<h2 class="fw-bold mb-4 border-bottom pb-2">관리자 메인 현황</h2>
	
	<div class="row">
		<div class="col-md-6 col-lg-3 mb-4">
			<div class="card h-100 shadow-sm border-primary dashboard-card">
				<a href="${ctp}/admin/dbShop/adminOrderList?orderStatus=결제완료" target="adminContent">
					<div class="card-body text-primary d-flex align-items-center">
						<div class="flex-grow-1">
							<h5 class="card-title">신규 주문</h5>
							<h2 class="fw-bold">${newOrders} <span class="fs-6 fw-normal">건</span></h2>
						</div>
						<div class="card-icon opacity-50">
							<i class="fa-solid fa-file-invoice-dollar"></i>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="col-md-6 col-lg-3 mb-4">
			<div class="card h-100 shadow-sm border-warning dashboard-card">
				<a href="${ctp}/admin/dbShop/adminOrderList?orderStatus=배송준비중" target="adminContent">
					<div class="card-body text-warning d-flex align-items-center">
						<div class="flex-grow-1">
							<h5 class="card-title">배송 준비중</h5>
							<h2 class="fw-bold">${preparingShipment} <span class="fs-6 fw-normal">건</span></h2>
						</div>
						<div class="card-icon opacity-50">
							<i class="fa-solid fa-box-open"></i>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="col-md-6 col-lg-3 mb-4">
			<div class="card h-100 shadow-sm border-danger dashboard-card">
				<a href="${ctp}/admin/inquiry/adInquiryList?part=답변대기중" target="adminContent">
					<div class="card-body text-danger d-flex align-items-center">
						<div class="flex-grow-1">
							<h5 class="card-title">답변 대기 문의</h5>
							<h2 class="fw-bold">${pendingInquiries} <span class="fs-6 fw-normal">건</span></h2>
						</div>
						<div class="card-icon opacity-50">
							<i class="fa-solid fa-headset"></i>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="col-md-6 col-lg-3 mb-4">
			<div class="card h-100 shadow-sm border-success dashboard-card">
				<a href="${ctp}/admin/member/adminMemberList" target="adminContent">
					<div class="card-body text-success d-flex align-items-center">
						<div class="flex-grow-1">
							<h5 class="card-title">오늘 신규 회원</h5>
							<h2 class="fw-bold">${newMembers} <span class="fs-6 fw-normal">명</span></h2>
						</div>
						<div class="card-icon opacity-50">
							<i class="fa-solid fa-user-plus"></i>
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>

	<h4 class="fw-bold mt-4 mb-3">매출 현황</h4>
	<div class="row">
		<div class="col-md-6 mb-4">
			<div class="card h-100 shadow-sm border-info">
				<div class="card-body text-info d-flex align-items-center">
					<div class="flex-grow-1">
						<h5 class="card-title">오늘 발생 매출</h5>
						<h2 class="fw-bold">
							<fmt:formatNumber value="${todaySales}" pattern="#,##0" />
							<span class="fs-6 fw-normal">원</span>
						</h2>
					</div>
					<div class="card-icon opacity-50">
						<i class="fa-solid fa-sack-dollar"></i>
					</div>
				</div>
			</div>
		</div>
		
		<div class="col-md-6 mb-4">
			<div class="card h-100 shadow-sm border-secondary">
				<div class="card-body text-secondary d-flex align-items-center">
					<div class="flex-grow-1">
						<h5 class="card-title">이번 달 총 매출</h5>
						<h2 class="fw-bold">
							<fmt:formatNumber value="${monthSales}" pattern="#,##0" />
							<span class="fs-6 fw-normal">원</span>
						</h2>
					</div>
					<div class="card-icon opacity-50">
						<i class="fa-solid fa-chart-line"></i>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
</body>
</html>