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
	<title>TWAUDIO</title>
	<script>
		'use strict';
		
		function partCheck() {
			let partSelect = document.getElementById("part");
			let part = partSelect.value;
			location.href = "${ctp}/pds/pdsList?part=" + encodeURIComponent(part) + "&pag=1&pageSize=${pageVO.pageSize}";
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
		<h2 class="fw-bold">자료실</h2>
		
		<div class="d-flex align-items-center">
			<div class="me-2">
				<select name="part" id="part" onchange="partCheck()" class="form-select">
					<option value="" ${pageVO.part=="" ? "selected" : ""}>전체</option>
					<option value="매뉴얼" ${pageVO.part=="매뉴얼" ? "selected" : ""}>매뉴얼</option>
					<option value="펌웨어" ${pageVO.part=="펌웨어" ? "selected" : ""}>펌웨어</option>
					<option value="기타" ${pageVO.part=="기타" ? "selected" : ""}>기타</option>
				</select>
			</div>
			
			<c:if test="${sLevel == 0}">
				<div>
					<a href="${ctp}/pds/pdsForm" class="btn btn-primary">자료 올리기</a>
				</div>
			</c:if>
		</div>
	</div>

	<table class="table table-hover text-center align-middle">
		<thead class="table-light">
			<tr>
				<th>번호</th>
				<th class="text-start">자료명</th>
				<th>올린이</th>
				<th>파일 크기</th>
				<th>업로드일</th>
				<th>다운로드 횟수</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty vos}">
				<tr>
					<td colspan="6" class="text-center py-5">등록된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<c:if test="${vo.openSw == '공개' || sLevel == 0}">
					<tr>
						<td>${pageVO.curScrStartNo - st.index}</td> 
						<td class="text-start">
							<a href="${ctp}/pds/pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="text-decoration-none text-dark">
								<i class="bi bi-file-earmark-arrow-down"></i>
								${vo.title}
								<c:if test="${vo.openSw == '비공개'}">
									<span class="badge bg-secondary ms-2">비공개</span>
								</c:if>
							</a>
						</td>
						<td>${vo.nickName}</td>
						<td>${vo.formattedFSize}</td>
						<td>${fn:substring(vo.createdAt, 0, 10)}</td>
						<td>${vo.downNum}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="d-flex justify-content-center mt-4">
		<ul class="pagination">
			<c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/pds/pdsList?part=${pageVO.part}&pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
			<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/pds/pdsList?part=${pageVO.part}&pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
			
			<c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize) + 1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st"><c:if test="${i <= pageVO.totPage}"><li class="page-item ${i == pageVO.pag ? 'active' : ''}"><a class="page-link" href="${ctp}/pds/pdsList?part=${pageVO.part}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if></c:forEach>
			
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/pds/pdsList?part=${pageVO.part}&pag=${(pageVO.curBlock+1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
			<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/pds/pdsList?part=${pageVO.part}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
		</ul>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>