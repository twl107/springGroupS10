<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 - 새 배너 추가</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    function previewImage(event) {
      const reader = new FileReader();
      reader.onload = function(){
        const output = document.getElementById('imagePreview');
        output.src = reader.result;
        output.style.display = 'block';
      };
      if (event.target.files && event.target.files[0]) {
        reader.readAsDataURL(event.target.files[0]);
      } else {
        document.getElementById('imagePreview').src = '';
        document.getElementById('imagePreview').style.display = 'none';
      }
    }
  </script>
</head>
<body>
<div class="container my-4">
  <h2 class="fw-bold mb-4 border-bottom pb-2">새 배너 추가</h2>
  <form method="POST" action="${ctp}/admin/banner/bannerAdd" enctype="multipart/form-data">
    <div class="row g-3">
      <div class="col-md-6">
        <label for="bannerImage" class="form-label">배너 이미지 <span class="text-danger">*</span> (권장: 1920x500)</label>
        <input class="form-control" type="file" id="bannerImage" name="file" accept="image/*" onchange="previewImage(event)" required>
        <img id="imagePreview" src="#" alt="Image Preview" class="img-thumbnail mt-2" style="max-width: 100%; height: auto; display: none;"/>
      </div>
      <div class="col-md-6">
        <label for="linkUrl" class="form-label">링크 URL (선택)</label>
        <input type="url" class="form-control" id="linkUrl" name="linkUrl" placeholder="https://...">
      </div>
      <div class="col-md-6">
        <label for="displayOrder" class="form-label">표시 순서 (낮을수록 먼저)</label>
        <input type="number" class="form-control" id="displayOrder" name="displayOrder" value="0">
      </div>
      <div class="col-md-6">
        <label class="form-label">상태</label>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="isActive" name="isActive" value="true" checked>
          <label class="form-check-label" for="isActive">
            활성 (체크 시 메인 노출)
          </label>
        </div>
      </div>
    </div>
    <hr class="my-4">
    <div class="d-flex justify-content-end">
      <a href="${ctp}/admin/banner/bannerManagement" class="btn btn-secondary me-2">목록으로</a>
      <button type="submit" class="btn btn-primary">배너 등록</button>
    </div>
  </form>
</div>
</body>
</html>