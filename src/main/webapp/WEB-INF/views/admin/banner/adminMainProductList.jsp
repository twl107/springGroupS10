<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 - 메인 상품 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script>
    function toggleRecommend(checkbox, idx) {
      const isRecommended = checkbox.checked;

      if (isRecommended) {
        const checkedCount = $('input[id^="recommendSwitch_"]:checked').length;

        if (checkedCount > 4) {
          alert('추천 상품은 최대 4개까지만 설정할 수 있습니다.');
          checkbox.checked = false;
          return;
        }
      }

      $.ajax({
        url: '${ctp}/admin/banner/toggleRecommendation',
        type: 'POST',
        data: {
          idx: idx,
          isRecommended: isRecommended
        },
        success: function(res) {
          if (res === 'SUCCESS') {
            const feedbackEl = $(checkbox).closest('td').find('.recommend-feedback');
          } else if (res === 'AUTH_ERROR') {
            alert('권한이 없습니다.');
            checkbox.checked = !isRecommended;
          } else {
            alert('추천 상태 변경에 실패했습니다.');
            checkbox.checked = !isRecommended;
          }
        },
        error: function() {
          alert('서버 통신 오류가 발생했습니다.');
          checkbox.checked = !isRecommended;
        }
      });
    }
  </script>
  <style>
    .recommend-feedback {
      display: none;
      font-size: 0.8em;
      color: green;
      margin-left: 5px;
      vertical-align: middle;
    }
    .form-switch .form-check-input {
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="container my-4">
  <h2 class="fw-bold mb-4 border-bottom pb-2">메인 상품 관리 (추천 설정)</h2>

  <table class="table table-hover align-middle text-center">
    <thead class="table-light">
      <tr>
        <th>번호</th>
        <th>이미지</th>
        <th class="text-start">상품명</th>
        <th>가격</th>
        <th>추천 설정 (최대 4개)</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${empty productList}">
        <tr>
          <td colspan="6" class="text-center p-5">등록된 상품이 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="product" items="${productList}" varStatus="st">
        <tr>
          <td>${product.idx}</td>
          <td>
            <img src="${ctp}/product/${fn:split(product.FSName,'/')[0]}" alt="${product.productName}" style="width: 60px; height: 60px; object-fit: cover;">
          </td>
          <td class="text-start">${product.productName}</td>
          <td><fmt:formatNumber value="${product.mainPrice}" pattern="#,##0"/>원</td>
          <td>
            <div class="form-check form-switch d-flex justify-content-center align-items-center">
              <input class="form-check-input" type="checkbox" role="switch"
                     id="recommendSwitch_${product.idx}"
                     ${product.isRecommended ? 'checked' : ''}
                     onchange="toggleRecommend(this, ${product.idx})">
              <span class="recommend-feedback"></span>
            </div>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

<div class="d-flex justify-content-center mt-4">
    <ul class="pagination">
      <c:set var="url" value="${ctp}/admin/banner/adminMainProductList" />

      <c:if test="${pageVO.pag > 1}">
        <li class="page-item"><a class="page-link" href="${url}?pag=1&pageSize=${pageVO.pageSize}">처음</a></li>
      </c:if>
      <c:if test="${pageVO.curBlock > 0}">
        <li class="page-item"><a class="page-link" href="${url}?pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li>
      </c:if>
      
      <c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage}">
          <li class="page-item ${i == pageVO.pag ? 'active' : ''}">
            <a class="page-link" href="${url}?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a>
          </li>
        </c:if>
      </c:forEach>
      
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
        <li class="page-item"><a class="page-link" href="${url}?pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음</a></li>
      </c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}">
        <li class="page-item"><a class="page-link" href="${url}?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li>
      </c:if>
    </ul>
  </div>
  </div>

</div>
</body>
</html>