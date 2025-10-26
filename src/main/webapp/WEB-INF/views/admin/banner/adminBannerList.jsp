<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 - 메인 배너 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    function deleteBanner(idx) {
      if (confirm("배너 #" + idx + "를 삭제하시겠습니까?\n이미지 파일도 함께 삭제됩니다.")) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${ctp}/admin/banner/bannerDelete';
        const hiddenField = document.createElement('input');
        hiddenField.type = 'hidden';
        hiddenField.name = 'idx';
        hiddenField.value = idx;
        form.appendChild(hiddenField);
        document.body.appendChild(form);
        form.submit();
      }
    }
  </script>
</head>
<body>
<div class="container my-4">
  <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
    <h2 class="fw-bold">메인 배너 관리</h2>
    <a href="${ctp}/admin/banner/bannerAdd" class="btn btn-primary">새 배너 추가</a>
  </div>
  <table class="table table-hover align-middle text-center">
    <thead class="table-light">
      <tr>
        <th>순서</th>
        <th>이미지 미리보기</th>
        <th>링크 URL</th>
        <th>상태</th>
        <th>등록일</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${empty bannerList}">
        <tr>
          <td colspan="6" class="text-center p-5">등록된 배너가 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="banner" items="${bannerList}">
        <tr>
          <td>${banner.displayOrder}</td>
          <td>
            <img src="${ctp}/resources/data/banner/${banner.FSName}" alt="배너 이미지" style="width: 150px; height: auto; max-height: 80px; object-fit: contain;">
          </td>
          <td>
            <c:if test="${not empty banner.linkUrl}">${banner.linkUrl}</c:if>
            <c:if test="${empty banner.linkUrl}"><span class="text-muted">-</span></c:if>
          </td>
          <td>
            <c:if test="${banner.isActive}"><span class="badge bg-success">활성</span></c:if>
            <c:if test="${!banner.isActive}"><span class="badge bg-secondary">비활성</span></c:if>
          </td>
          <td><fmt:formatDate value="${banner.createdAt}" pattern="yyyy-MM-dd"/></td>
          <td>
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteBanner(${banner.idx})">삭제</button>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>