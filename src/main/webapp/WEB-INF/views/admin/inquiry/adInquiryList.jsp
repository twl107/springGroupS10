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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
	<title>1:1 문의 관리</title>
	<script>
	  'use strict';
	  $(document).ready(function() {
	    $('.wDate').each(function(index) {
	      var wDateValue = $(this).val();
	      var fromNow = moment(wDateValue).fromNow();
	      $('.inputDate').eq(index).text(fromNow);
	    });
	  });

		function categoryCheck() {
			let part = document.categoryForm.part.value;
			location.href="${ctp}/admin/inquiry/adInquiryList?part="+part+"&pag=1";
		}
	</script>
</head>
<body>
<div class="container my-4 w3-main">
	<div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
		<h2 class="fw-bold">1:1 문의 관리 <span class="fs-5 text-muted">(${part})</span></h2>
		<form name="categoryForm" style="width:200px;" onchange="categoryCheck()">
			<select class="form-select" name="part">
				<option value="전체" <c:if test="${part=='전체'}">selected</c:if>>전체 문의</option>
				<option value="답변대기중" <c:if test="${part=='답변대기중'}">selected</c:if>>답변 대기중</option>
				<option value="답변완료" <c:if test="${part=='답변완료'}">selected</c:if>>답변 완료</option>
			</select>
		</form>
	</div>

	<table class="table table-hover text-center align-middle">
		<thead class="table-light">
			<tr>
				<th style="width:10%;">번호</th>
				<th class="text-start" style="width:50%;">제목</th>
				<th style="width:15%;">작성자ID</th>
				<th style="width:15%;">작성일</th>
				<th style="width:10%;">답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty vos}">
				<tr>
					<td colspan="5" class="text-center py-5">등록된 문의가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${pageVO.curScrStartNo - st.index}</td>
					<td class="text-start">
						<a href="${ctp}/admin/inquiry/adInquiryReply?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${part}" class="text-decoration-none text-dark">[${vo.part}] ${vo.title}</a>
					</td>
					<td>${vo.userId}</td>
					<td>
						<span class="inputDate small text-muted"></span>
						<input type="hidden" class="wDate" value="${fn:substring(vo.WDate,0,10)}"/>
					</td>
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
		</tbody>
	</table>

	<c:if test="${pageVO.totRecCnt > 0}">
		<div class="d-flex justify-content-center mt-4">
			<ul class="pagination">
				<c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/admin/inquiry/adInquiryList?part=${part}&pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
				<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/admin/inquiry/adInquiryList?part=${part}&pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
				<c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st"><c:if test="${i <= pageVO.totPage}"><li class="page-item ${i == pageVO.pag ? 'active' : ''}"><a class="page-link" href="${ctp}/admin/inquiry/adInquiryList?part=${part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if></c:forEach>
				<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/admin/inquiry/adInquiryList?part=${part}&pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
				<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/admin/inquiry/adInquiryList?part=${part}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
			</ul>
		</div>
	</c:if>

</div>
</body>
</html>