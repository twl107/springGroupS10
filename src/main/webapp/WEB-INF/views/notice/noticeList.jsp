<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
    <h2 class="fw-bold">공지사항</h2>
    <c:if test="${sLevel == 0}">
      <a href="${ctp}/notice/noticeInput" class="btn btn-primary">글쓰기</a>
    </c:if>
  </div>

  <table class="table table-hover text-center align-middle">
    <thead class="table-light">
      <tr>
        <th style="width:10%">번호</th>
        <th style="width:50%" class="text-start">제목</th>
        <th style="width:15%">작성자</th>
        <th style="width:15%">작성일</th>
        <th style="width:10%">조회수</th>
      </tr>
    </thead>
    <tbody>
      <c:if test="${empty vos}">
        <tr>
          <td colspan="5" class="text-center py-5">등록된 공지사항이 없습니다.</td>
        </tr>
      </c:if>
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr>
          <td>${pageVO.curScrStartNo - st.index}</td>
          <td class="text-start">
            <a href="${ctp}/notice/noticeContent?idx=${vo.idx}&pag=${pageVO.pag}" class="text-decoration-none text-dark">${vo.title}</a>
          </td>
          <td>${vo.nickName}</td>
          <td>${vo.WDate}</td>
          <td>${vo.viewCnt}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- 페이징 블록 (생략) -->

</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

