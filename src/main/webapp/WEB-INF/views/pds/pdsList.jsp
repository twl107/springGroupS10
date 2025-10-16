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
	<title>자료실</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
		<h2 class="fw-bold">자료실</h2>
		<div>
			<select name="part" id="part" onchange="partCheck()" class="form-select">
        <option value="" ${pageVO.part=="" ? "selected" : ""}>전체</option>
        <option ${pageVO.part=="메뉴얼" ? "selected" : ""}>메뉴얼</option>
        <option ${pageVO.part=="펌웨어" ? "selected" : ""}>펌웨어</option>
        <option ${pageVO.part=="기타" ? "selected" : ""}>기타</option>
      </select>
		</div>
		<div>
			<a href="${ctp}/pds/pdsForm" class="btn btn-primary">자료 올리기</a>
		</div>
	</div>

	<!-- 자료실 목록 테이블 -->
	<table class="table table-hover text-center align-middle">
		<thead class="table-light">
			<tr>
				<th>번호</th>
				<th>자료명</th>
				<th>올린이</th>
				<th>파일 크기</th>
				<th>업로드일</th>
				<th>다운로드</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty vos}">
				<tr>
					<td colspan="6" class="text-center py-5">등록된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td class="text-start">
						<a href="${ctp}/pds/pdsContent?idx=${vo.idx}" class="text-decoration-none">
							<i class="bi bi-file-earmark-arrow-down"></i>
							${vo.title}
						</a>
					</td>
					<td>${vo.nickName}</td>
					<td>${vo.formattedFSize}</td>
					<td>${fn:substring(vo.createdAt, 0, 10)}</td>
					<td>${vo.downNum}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<script>
		'use strict';
		
		function partCheck() {
			let part = $("#part").val();
			location.href = "pdsList?part="+part+"&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}";
		}
		
	
	</script>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
