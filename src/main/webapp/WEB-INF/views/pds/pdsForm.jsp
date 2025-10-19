<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>자료 올리기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
	<div class="row justify-content-center">
		<div class="col-lg-8">
			<div class="card shadow-sm border-0">
				<div class="card-body p-4 p-md-5">
					<h2 class="card-title text-center fw-bold mb-4">자료 올리기</h2>
					
					<form name="pdsForm" method="post" action="${ctp}/pds/pdsUpload" enctype="multipart/form-data">
						
						<!-- 파일 선택 (multiple 속성 추가!) -->
						<div class="mb-3">
							<label for="files" class="form-label">파일 첨부 (여러 개 선택 가능)</label>
							<input class="form-control" type="file" id="files" name="files" required multiple>
						</div>

						<!-- 분류 -->
						<div class="mb-3">
							<label for="part" class="form-label">분류</label>
							<select class="form-select" id="part" name="part">
								<option value="매뉴얼">매뉴얼</option>
								<option value="펌웨어">펌웨어</option>
								<option value="기타">기타</option>
							</select>
						</div>
						
						<!-- 제목 -->
						<div class="form-floating mb-3">
							<input type="text" class="form-control" id="title" name="title" placeholder="제목" required>
							<label for="title">제목</label>
						</div>
						
						<!-- 상세 설명 -->
						<div class="form-floating mb-3">
							<textarea class="form-control" placeholder="상세 설명" id="content" name="content" style="height: 150px"></textarea>
							<label for="content">상세 설명</label>
						</div>
						
						<!-- 공개 여부 -->
						<div class="mb-4">
							<label class="form-label d-block">공개 여부</label>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="openSw" id="openSwPublic" value="공개" checked>
								<label class="form-check-label" for="openSwPublic">공개</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="openSw" id="openSwPrivate" value="비공개">
								<label class="form-check-label" for="openSwPrivate">비공개</label>
							</div>
						</div>
						
						<!-- 버튼 -->
						<div class="d-grid gap-2">
							<button type="submit" class="btn btn-primary btn-lg">업로드</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='${ctp}/pds/pdsList'">취소</button>
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

