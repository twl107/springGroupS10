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
	  
	  function downNumCheck(idx) {
	    $.ajax({
	        url: '${ctp}/pds/pdsDownNumCheck',
	        type: 'post',
	        data: {idx : idx},
	        success: () => console.log("다운로드 카운트 증가 완료"),
	        error: () => alert('전송오류')
	    });
	    return true; 
	  }
	  
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

<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="card border-0 shadow-sm">
        <div class="card-body p-4 p-md-5">
          <h2 class="card-title fw-bold border-bottom p-3 mb-4 bg-light rounded">${vo.title}</h2>
          
          <div class="d-flex justify-content-between align-items-center text-muted small mb-2">
            <div>
              <span class="fw-bold">작성자:</span>
              <span>${vo.nickName}</span>
            </div>
            <div>
              <span class="me-3">
                <span class="fw-bold">작성일:</span>
                <span><fmt:formatDate value="${vo.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
              </span>
              <span>
                <span class="fw-bold">공개여부:</span>
                <span>${vo.openSw}</span>
              </span>
            </div>
          </div>
          
          <div class="d-flex justify-content-between align-items-center text-muted small mb-4">
            <div>
              <span class="fw-bold">다운로드:</span>
              <span>${vo.downNum}</span>
            </div>
            <div>
              <span>
                <span class="fw-bold">파일 크기:</span>
                <span>${vo.formattedFSize}</span>
              </span>
            </div>
          </div>
          
          <div class="border rounded p-3 mb-4">
            <h6 class="mb-3">첨부 파일</h6>
            <c:if test="${empty fNames}">- 첨부 파일 없음 -</c:if>
            <c:if test="${!empty fNames}">
              <ul class="list-unstyled mb-0">
                <c:forEach var="fName" items="${fNames}" varStatus="st">
                  <li class="my-1">
                    <i class="bi bi-download me-2"></i>
                    <a href="${ctp}/pds/pdsDownload?idx=${vo.idx}&fName=${fName}&fSName=${fSNames[st.index]}" 
                       onclick="return downNumCheck(${vo.idx})">${fName}</a>
                  </li>
                </c:forEach>
              </ul>
            </c:if>
          </div>
          
          <div class="p-3" style="min-height:200px; line-height: 1.8;">
            ${vo.content.replace("<p>", "").replace("</p>", "<br/>")}
          </div>
        </div>
        
        <div class="card-footer bg-transparent border-0 pt-4 p-4 p-md-5">
          <div class="d-flex justify-content-between">
            <a href="${ctp}/pds/pdsList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${vo.part}" class="btn btn-secondary">목록으로</a>
            
            <c:if test="${sMemberIdx == vo.memberIdx || sLevel == 0}">
              <div>
                <a href="${ctp}/pds/pdsUpdate?idx=${vo.idx}" class="btn btn-info">수정</a>
                <button type="button" class="btn btn-danger" onclick="pdsDelete()">삭제</button>
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