<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>주문 내역</title>
  <script>
    'use strict';
    
    function searchOrders() {
      let orderStatus = document.getElementById("orderStatus").value;
      let startJumun = document.getElementById("startJumun").value;
      let endJumun = document.getElementById("endJumun").value;
      
      if (startJumun > endJumun) {
        alert("시작 날짜가 종료 날짜보다 늦을 수 없습니다.");
        return;
      }
      
      let query = "orderStatus=" + encodeURIComponent(orderStatus);
      query += "&startJumun=" + encodeURIComponent(startJumun);
      query += "&endJumun=" + encodeURIComponent(endJumun);
      query += "&pag=1&pageSize=5"; // pageSize=5 고정
      
      location.href = "${ctp}/dbShop/myOrders?" + query;
    }
  </script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <h2 class="fw-bold mb-4">주문 내역</h2>
  
  <div class="row mb-3 g-2 align-items-center">
    <div class="col-md-2">
      <select class="form-select" id="orderStatus" name="orderStatus">
        <option value="전체" ${orderStatus == '전체' ? 'selected' : ''}>전체</option>
        <option value="결제완료" ${orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
        <option value="배송준비중" ${orderStatus == '배송준비중' ? 'selected' : ''}>배송준비중</option>
        <option value="배송중" ${orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
        <option value="배송완료" ${orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
        <option value="구매확정" ${orderStatus == '구매확정' ? 'selected' : ''}>구매확정</option>
        <option value="주문취소" ${orderStatus == '주문취소' ? 'selected' : ''}>주문취소</option>
      </select>
    </div>
    <div class="col-md-auto">
      <input type="date" class="form-control" name="startJumun" id="startJumun" value="${startJumun}"/>
    </div>
    <div class="col-md-auto">~</div>
    <div class="col-md-auto">
      <input type="date" class="form-control" name="endJumun" id="endJumun" value="${endJumun}"/>
    </div>
    <div class="col-md-auto">
      <button class="btn btn-primary" onclick="searchOrders()">검색</button>
    </div>
  </div>
  
  <c:if test="${empty orderList}">
    <div class="text-center p-5 border rounded">
      <p class="fs-5 text-muted">주문 내역이 없습니다.</p>
    </div>
  </c:if>
  
  <c:forEach var="order" items="${orderList}">
    <div class="card shadow-sm mb-4">
      <div class="card-header bg-light d-flex justify-content-between align-items-center flex-wrap">
        <div>
          <span class="fw-bold">주문번호:</span> ${order.orderId}
          <br>
          <span class="small text-muted">주문일: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></span>
        </div>
        <a href="${ctp}/dbShop/orderDetail?orderId=${order.orderId}" class="btn btn-outline-secondary btn-sm mt-1 mt-md-0">
          주문 상세 보기
        </a>
      </div>
      <div class="card-body p-4">
        <h5 class="card-title">배송 상태: 
          <c:choose>
            <c:when test="${order.orderStatus == '결제완료'}"><span class="badge bg-primary">${order.orderStatus}</span></c:when>
            <c:when test="${order.orderStatus == '배송준비중'}"><span class="badge bg-info">${order.orderStatus}</span></c:when>
            <c:when test="${order.orderStatus == '배송중'}"><span class="badge bg-warning text-dark">${order.orderStatus}</span></c:when>
            <c:when test="${order.orderStatus == '배송완료'}"><span class="badge bg-success">${order.orderStatus}</span></c:when>
            <c:otherwise><span class="badge bg-secondary">${order.orderStatus}</span></c:otherwise>
          </c:choose>
        </h5>
        <ul class="list-group list-group-flush">
          <li class="list-group-item px-0">
            <strong>주문 상품:</strong> ${order.mainProductName}
          </li> 
          <li class="list-group-item px-0"><strong>받는 사람:</strong> ${order.recipientName}</li>
          <li class="list-group-item px-0"><strong>총 결제 금액:</strong> <fmt:formatNumber value="${order.totalPrice}" pattern="#,###" />원</li>
        </ul>
      </div>
    </div>
  </c:forEach>

  <div class="d-flex justify-content-center mt-4">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/dbShop/myOrders?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/dbShop/myOrders?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      
      <c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st"><c:if test="${i <= pageVO.totPage}"><li class="page-item ${i == pageVO.pag ? 'active' : ''}"><a class="page-link" href="${ctp}/dbShop/myOrders?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if></c:forEach>
      
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/dbShop/myOrders?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/dbShop/myOrders?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
    </ul>
  </div>
  
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>