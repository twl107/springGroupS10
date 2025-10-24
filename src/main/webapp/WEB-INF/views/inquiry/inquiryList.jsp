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
	<title>1:1 문의</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
		<h2 class="fw-bold">1:1 문의</h2>
		<div>
			<c:choose>
				<c:when test="${!empty sUserId}">
					<a href="${ctp}/inquiry/inquiryInput?pag=${pageVO.pag}" class="btn btn-primary btn-sm">1:1 문의쓰기</a>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="alert('로그인 후 이용해주세요'); location.href='${ctp}/member/memberLogin';" class="btn btn-primary btn-sm">1:1 문의쓰기</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<table class="table table-hover text-center align-middle">
		<thead class="table-light">
			<tr>
				<th class="text-start" style="width: 55%;">제목</th>
				<th style="width: 15%;">문의자</th>
				<th style="width: 15%;">작성일</th>
				<th style="width: 15%;">답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty vos}">
				<tr>
					<td colspan="4" class="text-center py-5">
						1:1문의 내역이 존재하지 않습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty vos}">
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td class="text-start">
							<a href="${ctp}/inquiry/inquiryContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}" class="text-decoration-none text-dark">[${vo.part}] ${vo.title}</a>
						</td>
						<td>${vo.userId}</td>
						<td>${fn:substring(vo.WDate,0,16)}</td>
						<td>
							<c:choose>
								<c:when test="${vo.reply=='답변완료'}">
									<span class="badge bg-success">${vo.reply}</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-warning text-dark">${vo.reply}</span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>

	<c:if test="${!empty vos}">
		<div class="d-flex justify-content-center mt-4">
			<c:if test="${pageVO.totPage != 0}">
				<ul class="pagination">
					<c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=1&pageSize=${pageVO.pageSize}" class="page-link">처음</a></li></c:if>
					<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link">이전</a></li></c:if>
					
					<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st"><c:if test="${i <= pageVO.totPage}"><li class="page-item ${i == pageVO.pag ? 'active' : ''}"><a href='${ctp}/inquiry/inquiryList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link">${i}</a></li></c:if></c:forEach>
					
					<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link">다음</a></li></c:if>
					<c:if test="${pageVO.pag != pageVO.totPage}"><li class="page-item"><a href="${ctp}/inquiry/inquiryList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link">마지막</a></li></c:if>
				</ul>
			</c:if>
		</div>
	</c:if>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>