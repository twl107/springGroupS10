<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>자료실 상세 보기</title>
	<script>
	  'use strict';
	  
	  // 다운로드 수 증가
	  function downNumCheck(idx) {
		  $.ajax({
				url 	: '${ctp}/pds/pdsDownNumCheck',
				type	: 'post',
				data	: {idx : idx},
				success	: () => location.reload(),
				error	: () => alert('전송오류')
		  });
	  }
	  
	  
	  // 게시글 삭제 함수
	  function pdsDelete() {
	    let ans = confirm("현재 게시글을 삭제하시겠습니까?");
	    if (ans) {
        location.href = '${ctp}/pds/pdsDelete?idx=${vo.idx}';
	    }
	  }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-4">
	<h2 class="text-center mb-4">자료실 상세 내용</h2>
	
	<table class="table table-bordered">
	  <tr>
	    <th style="width:15%;" class="text-center table-secondary">글 제목</th>
	    <td colspan="3">${vo.title}</td>
	  </tr>
	  <tr>
	    <th class="text-center table-secondary">작성자</th>
	    <td style="width:35%;">${vo.nickName}</td>
	    <th style="width:15%;" class="text-center table-secondary">작성일</th>
	    <td style="width:35%;"><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
	  </tr>
	  <tr>
      <th class="text-center table-secondary">다운로드 횟수</th>
      <td>${vo.downNum}</td>
      <th class="text-center table-secondary">총 파일 크기</th>
      <td>${vo.formattedFSize}</td>
	  </tr>
	  <tr>
      <th class="text-center table-secondary">공개 여부</th>
      <td colspan="3">${vo.openSw}</td>
	  </tr>
	  <tr>
	    <th class="text-center table-secondary">첨부 파일</th>
	    <td colspan="3">
	      <c:if test="${empty fNames}">- 첨부 파일 없음 -</c:if>
	      <c:if test="${!empty fNames}">
          <c:forEach var="fName" items="${fNames}" varStatus="st">
            <p class="my-1">
            	<a href="${ctp}/pds/pdsDownload?idx=${vo.idx}&fName=${fName}&fSName=${fSNames[st.index]}" onclick="downNumCheck(${vo.idx})">${fName}</a>
            </p>
          </c:forEach>
	      </c:if>
	    </td>
	  </tr>
	  <tr>
	    <td colspan="4" style="height:200px;" class="p-3">
	      <%-- JSTL의 c:out을 사용하면 HTML 태그가 그대로 출력됩니다. 만약 에디터를 사용했다면 vo.content를 그대로 출력해야 합니다. --%>
	      ${vo.content.replace("<p>", "").replace("</p>", "<br/>")}
	    </td>
	  </tr>
	</table>
	
	<div class="text-center">
	  <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/pds/pdsList';">목록으로</button>
	  
	  <%-- 로그인한 사용자가 글 작성자이거나, 관리자(예: level 0)일 경우에만 수정/삭제 버튼을 보여줍니다. --%>
	  <c:if test="${sMemberIdx == vo.memberIdx || sLevel == 0}">
	    <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/pds/pdsUpdate?idx=${vo.idx}';">수정</button>
	    <button type="button" class="btn btn-danger" onclick="pdsDelete()">삭제</button>
	  </c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>