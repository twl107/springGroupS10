<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${vo.title} - 공지사항</title>
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
          <!-- 제목 -->
          <h2 class="card-title fw-bold border-bottom pb-3 mb-4">${vo.title}</h2>
          
          <!-- 메타 정보 (작성자, 작성일, 조회수) -->
          <div class="d-flex justify-content-between align-items-center text-muted small mb-4">
            <div>
              <span class="fw-bold">작성자:</span>
              <span>${vo.nickName}</span>
            </div>
            <div>
              <span class="me-3">
                <span class="fw-bold">작성일:</span>
                <span>${vo.WDate}</span>
              </span>
              <span>
                <span class="fw-bold">조회수:</span>
                <span>${vo.viewCnt}</span>
              </span>
            </div>
          </div>
          
          <!-- 본문 내용 -->
          <div class="p-3" style="min-height:250px; line-height: 1.8;">
            <%-- JSTL의 c:out 태그를 사용하면 HTML 태그가 이스케이프 처리됩니다. --%>	
            <%-- 만약 줄바꿈을 적용하려면, 서비스단에서 content의 \n을 <br>로 치환하거나 CSS를 사용해야 합니다. --%>
            ${vo.content}
          </div>
        </div>
        
        <!-- 버튼 (목록, 수정, 삭제) -->
        <div class="card-footer bg-transparent border-0 pt-4">
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

