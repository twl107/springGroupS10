<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항 등록</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="card border-0">
        <div class="card-body p-4 p-md-5">
          <h2 class="card-title text-center fw-bold mb-4">공지사항 등록</h2>
          <form method="post">
            <div class="form-floating mb-3">
              <input type="text" name="title" id="title" class="form-control" placeholder="제목" required>
              <label for="title">제목</label>
            </div>
            <div class="form-floating mb-4">
              <textarea name="content" id="content" class="form-control" placeholder="내용" style="height: 250px" required></textarea>
              <label for="content">내용</label>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <a href="${ctp}/notice/noticeList" class="btn btn-outline-secondary">취소</a>
              <button type="submit" class="btn btn-primary">등록하기</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

