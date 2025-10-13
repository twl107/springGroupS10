<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원 리스트</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
    'use strict';
    function updateLevel(idx, obj) {
      let level = obj.value;
      let originalLevel = obj.dataset.originalLevel; // data 속성에서 원래 등급을 가져옴
      if (!confirm("해당 회원의 등급을 변경하시겠습니까?")) {
        obj.value = originalLevel; // 취소 시 원래 등급으로 복원
        return;
      }
      
      $.ajax({
        type: "POST",
        url: "${ctp}/admin/member/updateLevel",
        data: { idx: idx, level: level },
        success: function(res) {
          if (res != 0) {
            alert("등급이 변경되었습니다.");
            obj.dataset.originalLevel = level; // 변경 성공 시 data 속성도 업데이트
            if (level != ${pageVO.level} && ${pageVO.level} != 99) {
              location.reload();
            }
          } else {
            alert("등급 변경 실패. 다시 시도해주세요.");
            obj.value = originalLevel; // 실패 시 원래 등급으로 복원
          }
        },
        error: function() {
          alert("전송 오류가 발생했습니다.");
          obj.value = originalLevel; // 실패 시 원래 등급으로 복원
        }
      });
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">회 원 리 스 트</h2>
  
  <div class="row mb-3">
    <div class="col">
      <form name="filterForm" method="get" action="${ctp}/admin/member/adminMemberList" class="d-flex justify-content-between">
        <%-- 회원등급 필터 --%>
        <div class="d-flex align-items-center">
          <label for="levelSelect" class="me-2 fw-bold">회원등급 :</label>
          <select name="level" id="levelSelect" class="form-select" onchange="this.form.submit()" style="width: 150px;">
            <option value="99" ${pageVO.level == 99 ? 'selected' : ''}>전체회원</option>
            <option value="1"  ${pageVO.level == 1  ? 'selected' : ''}>우수회원</option>
            <option value="2"  ${pageVO.level == 2  ? 'selected' : ''}>정회원</option>
            <option value="3"  ${pageVO.level == 3  ? 'selected' : ''}>준회원</option>
            <option value="0"  ${pageVO.level == 0  ? 'selected' : ''}>관리자</option>
          </select>
        </div>
  
        <%-- 페이지당 회원 수 필터 --%>
        <div class="d-flex align-items-center">
          <label for="pageSizeSelect" class="me-2 fw-bold">페이지당 회원 수 :</label>
          <select name="pageSize" id="pageSizeSelect" class="form-select" onchange="this.form.submit()" style="width: 100px;">
            <option value="5" ${pageVO.pageSize == 5 ? 'selected' : ''}>5</option>
            <option value="10" ${pageVO.pageSize == 10 ? 'selected' : ''}>10</option>
            <option value="20" ${pageVO.pageSize == 20 ? 'selected' : ''}>20</option>
            <option value="30" ${pageVO.pageSize == 30 ? 'selected' : ''}>30</option>
          </select>
        </div>
      </form>
    </div>
  </div>
  
  <table class="table table-hover text-center align-middle">
    <tr class="table-secondary">
      <th>번호</th>
      <th>아이디</th>
      <th>닉네임</th>
      <th>성명</th>
      <th>이메일</th>
      <th>최종 방문일</th>
      <th>활동여부</th>
      <th>회원등급</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${vo.idx}</td>
        <td>${vo.userId}</td>
        <td>${vo.nickName}</td>
        <td>${vo.name}</td>
        <td>${vo.email}</td>
        <td>${fn:substring(vo.lastLoginAt,0,16)}</td>
        <td>
          <%-- ===== 탈퇴 경과 일수 표시 (수정된 부분) ===== --%>
          <c:if test="${!vo.isDeleted()}">활동중</c:if>
          <c:if test="${vo.isDeleted()}">
            탈퇴신청
            <c:if test="${vo.deleteDiff < 30}">(<font color='red'>${vo.deleteDiff}일 경과</font>)</c:if>
            <c:if test="${vo.deleteDiff >= 30}">(<font color='red'>30일 경과</font>)</c:if>
          </c:if>
        </td>
        <td>
          <select class="form-select form-select-sm" onchange="updateLevel(${vo.idx}, this)" data-original-level="${vo.level}">
            <option value="0" ${vo.level == 0 ? 'selected' : ''}>관리자</option>
            <option value="1" ${vo.level == 1 ? 'selected' : ''}>우수회원</option>
            <option value="2" ${vo.level == 2 ? 'selected' : ''}>정회원</option>
            <option value="3" ${vo.level == 3 ? 'selected' : ''}>준회원</option>
            <option value="99" ${vo.level == 99 ? 'selected' : ''}>비회원</option>
          </select>
        </td>
      </tr>
    </c:forEach>
  </table>

  <!-- 페이지네이션 (level 파라미터 및 '/admin' 경로 확인) -->
  <div class="d-flex justify-content-center">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/admin/member/adminMemberList?pag=1&level=${pageVO.level}">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/admin/member/adminMemberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&level=${pageVO.level}">이전블록</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage}">
          <li class="page-item ${i == pageVO.pag ? 'active' : ''}"><a class="page-link" href="${ctp}/admin/member/adminMemberList?pag=${i}&level=${pageVO.level}">${i}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/admin/member/adminMemberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&level=${pageVO.level}">다음블록</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/admin/member/adminMemberList?pag=${pageVO.totPage}&level=${pageVO.level}">마지막페이지</a></li></c:if>
    </ul>
  </div>
</div>
<p><br/></p>
</body>
</html>

