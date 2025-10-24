<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>1:1 문의</title>
	<script>
		function updateCheck() {
			var ans = confirm("수정하시겠습니까?");
			if(ans) {
				location.href="${ctp}/inquiry/inquiryUpdate?idx=${vo.idx}&pag=${pageVO.pag}";
			}
			return false;
		}
		
		function deleteCheck() {
			var ans = confirm("삭제하시겠습니까?");
			if(ans) {
				location.href="${ctp}/inquiry/inquiryDelete?idx=${vo.idx}&fSName=${vo.FSName}";
			}
			return false;
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
          <h2 class="card-title fw-bold border-bottom p-3 mb-4 bg-light rounded">[${vo.part}] ${vo.title}</h2>
          
          <div class="d-flex justify-content-between align-items-center text-muted small mb-2">
            <div>
              <span class="fw-bold">상태:</span>
              <c:choose>
                <c:when test="${vo.reply=='답변완료'}">
                  <span class="badge bg-success">${vo.reply}</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-warning text-dark">${vo.reply}</span>
                </c:otherwise>
              </c:choose>
            </div>
            <div>
              <span class="me-3">
                <span class="fw-bold">작성일:</span>
                <span>${fn:substring(vo.WDate,0,16)}</span>
              </span>
              <span>
                <span class="fw-bold">주문번호:</span>
                <c:if test="${!empty vo.orderId}"><span>${vo.orderId}</span></c:if>
                <c:if test="${empty vo.orderId}"><span>없음</span></c:if>
              </span>
            </div>
          </div>
          
          <hr class="mb-4"/>

          <div class="p-3" style="min-height:200px; line-height: 1.8;">
            <c:if test="${!empty vo.FSName}"><img src="${ctp}/inquiry/${vo.FSName}" class="img-fluid rounded mb-3" style="max-width: 400px;"/><br/></c:if>
            ${fn:replace(vo.content,newLine,"<br/>")}
          </div>
          
          <c:if test="${!empty reVO.reContent}">
            <hr/>
            <div class="mt-4">
              <h5 class="fw-bold mb-3">관리자 답변</h5>
              <textarea name="reContent" rows="5" id="reContent" readonly="readonly" class="form-control bg-light">${reVO.reContent}</textarea>
            </div>
          </c:if>
          
        </div>
        
        <div class="card-footer bg-transparent border-0 pt-4 p-4 p-md-5">
          <div class="d-flex justify-content-between">
            <a href="${ctp}/inquiry/inquiryList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="btn btn-secondary">목록으로</a>
            
            <c:if test="${empty reVO.reContent && sUserId == vo.userId}">
              <div>
                <button type="button" onclick="updateCheck()" class="btn btn-info">수정</button>
                <button type="button" onclick="deleteCheck()" class="btn btn-danger">삭제</button>
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