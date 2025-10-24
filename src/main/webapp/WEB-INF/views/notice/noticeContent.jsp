<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${vo.title} - 공지사항</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
  	.notice-content-body img {
  		max-width: 100%;
  		height: auto;
  	}
  
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="card border-0 shadow-sm">
        <div class="card-body p-4 p-md-5">
          <h2 class="card-title fw-bold border-bottom p-3 mb-4 bg-light rounded">${vo.title}</h2>
          
          <div class="d-flex justify-content-between align-items-center text-muted small mb-4">
            <div>
              <span class="fw-bold">작성자:</span>
              <span>${vo.nickName}</span>
            </div>
            <div>
              <span class="me-3">
                <span class="fw-bold">작성일:</span>
                <span>${fn:substring(vo.WDate,0,16)}</span>
              </span>
              <span>
                <span class="fw-bold">조회수:</span>
                <span>${vo.viewCnt}</span>
              </span>
            </div>
          </div>
          
          <div class="p-3 notice-content-body" style="min-height:250px; line-height: 1.8;">
            ${vo.content}
          </div>
        </div>
        
        <div class="card-footer bg-transparent border-0 pt-4 p-4 p-md-5">
          <div class="d-flex justify-content-between">
            <a href="${ctp}/notice/noticeList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="btn btn-secondary">목록으로</a>
            <c:if test="${sLevel == 0}">
              <div>
                <a href="${ctp}/notice/noticeUpdate?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="btn btn-info">수정</a>
                <a href="${ctp}/notice/noticeDelete?idx=${vo.idx}" class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>