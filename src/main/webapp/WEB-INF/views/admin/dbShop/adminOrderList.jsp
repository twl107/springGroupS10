<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 - 주문 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
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
      
      location.href = "${ctp}/admin/dbShop/adminOrderList?" + query;
    }
    
    function changeOrderStatus(selectElement, orderId) {
      let newStatus = selectElement.value;
      let originalStatus = selectElement.dataset.originalStatus; 

      if (confirm("주문번호 " + orderId + "의 상태를 '" + newStatus + "'(으)로 변경하시겠습니까?")) {
        
        const url = "${ctp}/admin/dbShop/updateStatus";
        
        const formData = new URLSearchParams();
        formData.append('orderId', orderId);
        formData.append('orderStatus', newStatus);

        fetch(url, {
          method: 'POST',
          body: formData,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.text();
        })
        .then(text => {
          if (text === "OK") {
            alert("상태가 변경되었습니다.");
            location.reload();
          } else {
            alert("상태 변경에 실패했습니다: " + text);
            selectElement.value = originalStatus;
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert("오류가 발생하여 상태를 변경할 수 없습니다.");
          selectElement.value = originalStatus;
        });
        
      } else {
        selectElement.value = originalStatus;
      }
    }
  </script>
</head>
<body>

<div class="container my-4">
  <h2 class="fw-bold mb-3">주문/배송 관리</h2>
  
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

  <table class="table table-hover text-center align-middle">
    <thead class="table-light">
      <tr>
        <th><input type="checkbox" class="form-check-input" id="checkAll"></th>
        <th>주문번호</th>
        <th>주문일</th>
        <th>주문자(회원idx)</th>
        <th>받는사람</th>
        <th>총 결제금액</th>
        <th>주문상태</th>
        <th>배송현황 변경</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${empty vos}">
        <tr>
          <td colspan="8" class="text-center p-5">주문 내역이 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="vo" items="${vos}">
        <tr>
          <td><input type="checkbox" class="form-check-input chk" name="orderIds" value="${vo.orderId}"></td>
          <td title="주문상세보기">${vo.orderId}</td>
          <td><fmt:formatDate value="${vo.orderDate}" pattern="yyyy-MM-dd"/></td>
          <td>${vo.memberIdx}</td>
          <td>${vo.recipientName}</td>
          <td><fmt:formatNumber value="${vo.totalPrice}" pattern="#,###" />원</td>
          <td>
            <c:choose>
              <c:when test="${vo.orderStatus == '결제완료'}"><span class="badge bg-primary">${vo.orderStatus}</span></c:when>
              <c:when test="${vo.orderStatus == '배송준비중'}"><span class="badge bg-info">${vo.orderStatus}</span></c:when>
              <c:when test="${vo.orderStatus == '배송중'}"><span class="badge bg-warning text-dark">${vo.orderStatus}</span></c:when>
              <c:when test="${vo.orderStatus == '배송완료'}"><span class="badge bg-success">${vo.orderStatus}</span></c:when>
              <c:otherwise><span class="badge bg-secondary">${vo.orderStatus}</span></c:otherwise>
            </c:choose>
          </td>
          <td>
            <c:choose>
              <c:when test="${vo.orderStatus == '구매확정' or vo.orderStatus == '주문취소'}">
                 <select class="form-select form-select-sm" disabled>
                   <option>${vo.orderStatus}</option>
                 </select>
              </c:when>
              <c:otherwise>
                <select class="form-select form-select-sm" 
                    onchange="changeOrderStatus(this, '${vo.orderId}')" 
                    data-original-status="${vo.orderStatus}">
                  <option value="결제완료" ${vo.orderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
                  <option value="배송준비중" ${vo.orderStatus == '배송준비중' ? 'selected' : ''}>배송준비중</option>
                  <option value="배송중" ${vo.orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
                  <option value="배송완료" ${vo.orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
                  <option value="주문취소" ${vo.orderStatus == '주문취소' ? 'selected' : ''}>주문취소</option>
                </select>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  
  <div class="d-flex justify-content-center">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/admin/dbShop/adminOrderList?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/admin/dbShop/adminOrderList?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      
      <c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage}">
          <li class="page-item ${i == pageVO.pag ? 'active' : ''}">
            <a class="page-link" href="${ctp}/admin/dbShop/adminOrderList?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a>
          </li>
        </c:if>
      </c:forEach>
      
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/admin/dbShop/adminOrderList?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/admin/dbShop/adminOrderList?orderStatus=${orderStatus}&startJumun=${startJumun}&endJumun=${endJumun}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
    </ul>
  </div>

</div>
</body>
</html>