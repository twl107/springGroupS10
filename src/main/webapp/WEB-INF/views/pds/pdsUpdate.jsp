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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="row justify-content-center">
		<div class="col-lg-8">
			<div class="card shadow-sm border-0">
				<div class="card-body p-4 p-md-5">
					<h2 class="card-title text-center fw-bold mb-4">자료 수정하기</h2>
					
					<form name="pdsUpdateForm" method="post" action="${ctp}/pds/pdsUpdate" enctype="multipart/form-data">
						<%-- 컨트롤러에 vo객체로 넘기기 위해 기존 파일정보를 hidden으로 담아둔다. --%>
						<input type="hidden" name="idx" value="${vo.idx}">
						<input type="hidden" name="fName" value="${vo.FName}">
						<input type="hidden" name="fSName" value="${vo.FSName}">
						<input type="hidden" name="fSize" value="${vo.FSize}">
						
						<!-- 기존 파일 목록 (삭제 가능) -->
						<div class="mb-4">
							<label class="form-label fw-bold">현재 첨부된 파일 (삭제할 파일을 체크하세요)</label>
							<div class="p-3 border rounded bg-light">
								<c:if test="${empty fNames || fn:length(fNames) == 0}">
									<p class="text-muted mb-0">첨부된 파일이 없습니다.</p>
								</c:if>
								<c:forEach var="fName" items="${fNames}" varStatus="st">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="deleteFiles" value="${fSNames[st.index]}" id="delFile${st.index}">
										<label class="form-check-label" for="delFile${st.index}">
											${fName}
										</label>
									</div>
								</c:forEach>
							</div>
						</div>
						
						<!-- 파일 추가 -->
						<div class="mb-3">
							<label for="newFiles" class="form-label">새 파일 추가 (선택)</label>
							<input class="form-control" type="file" id="newFiles" name="newFiles" multiple>
						</div>

						<!-- 분류 -->
						<div class="mb-3">
							<label for="part" class="form-label">분류</label>
							<select class="form-select" id="part" name="part">
								<option ${vo.part == '매뉴얼' ? 'selected' : ''}>매뉴얼</option>
								<option ${vo.part == '펌웨어' ? 'selected' : ''}>펌웨어</option>
								<option ${vo.part == '기타' ? 'selected' : ''}>기타</option>
							</select>
						</div>
						
						<!-- 제목 -->
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="title" name="title" value="${vo.title}" required>
							<label for="title">제목</label>
						</div>
						
						<!-- 상세 설명 -->
						<div class="form-floating mb-3">
							<textarea class="form-control" id="content" name="content" style="height: 150px">${vo.content}</textarea>
							<label for="content">상세 설명</label>
						</div>
						
						<!-- 공개 여부 -->
						<div class="mb-4">
							<label class="form-label d-block">공개 여부</label>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="openSw" id="openSwPublic" value="공개" ${vo.openSw == '공개' ? 'checked' : ''}>
								<label class="form-check-label" for="openSwPublic">공개</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="openSw" id="openSwPrivate" value="비공개" ${vo.openSw == '비공개' ? 'checked' : ''}>
								<label class="form-check-label" for="openSwPrivate">비공개</label>
							</div>
						</div>
						
						<div class="d-grid gap-2">
							<button type="submit" class="btn btn-primary btn-lg">수정 완료</button>
							<button type="button" class="btn btn-outline-secondary" onclick="history.back()">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

