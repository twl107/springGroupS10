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
	<title>adminMemberList.jsp</title>
</head>
<body>

<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">회 원 리 스 트</h2>
  <div class="row mb-2">
    <div class="col-8">
      <div class="input-group">
	      <select name="levelItem" id="levelItem" onchange="levelItemCheck()" class="form-select me-3">
	        <option value="99"  ${pageVO.level == 99  ? 'selected' : ''}>전체회원</option>
	        <option value="1"   ${pageVO.level == 1   ? 'selected' : ''}>우수회원</option>
	        <option value="2"   ${pageVO.level == 2   ? 'selected' : ''}>정회원</option>
	        <option value="3"   ${pageVO.level == 3   ? 'selected' : ''}>준회원</option>
	        <option value="999" ${pageVO.level == 999 ? 'selected' : ''}>탈퇴신청회원</option>
	        <option value="0"   ${pageVO.level == 0   ? 'selected' : ''}>관리자</option>
	      </select>
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-1"/>
        <select name="levelSelect" id="levelSelect" class="form-select">
          <option value="2" selected>정회원</option>
          <option value="3">준회원</option>
          <option value="1">우수회원</option>
        </select>
        <input type="button" value="선택항목등급변경" onclick="levelSelectCheck()" class="btn btn-success btn-sm"/>
      </div>
    </div>
    <div class="col-4 text-end">
      <c:if test="${pageVO.pag > 1}">
        <a href="adMemberList?pag=1&level=${pageVO.level}" title="첫페이지" class="text-decoration-none text-dark link-primary">◁</a>
        <a href="adMemberList?pag=${pageVO.pag-1}&level=${pageVO.level}" title="이전페이지" class="text-decoration-none text-dark link-primary">◀</a>
      </c:if>
      ${pageVO.pag}/${pageVO.totPage}
      <c:if test="${pageVO.pag < pageVO.totPage}">
        <a href="adMemberList?pag=${pageVO.pag+1}&level=${pageVO.level}" title="다음페이지" class="text-decoration-none text-dark link-primary">▶</a>
        <a href="adMemberList?pag=${pageVO.totPage}&level=${pageVO.level}" title="마지막페이지" class="text-decoration-none text-dark link-primary">▷</a>
      </c:if>
    </div>
  </div>
  <form name="myform">
  	<table class="table table-hover text-center">
	    <tr class="table-secondary">
	      <th>번호</th>
	      <th>아이디</th>
	      <th>닉네임</th>
	      <th>성명</th>
	      <th>생일</th>
	      <th>생별</th>
	      <th>최종방문일</th>
	      <th>오늘방문횟수</th>
	      <th>활동여부</th>
	      <th>회원등급</th>
	    </tr>
	    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	        <td>
	          <c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
	          <c:if test="${vo.level == 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
	          ${curScrStartNo}
	        </td>
	        <td>
	          <c:set var="level" value="${vo.level==0?'관리자':vo.level==1?'우수회원':vo.level==2?'정회원':'준회원'}"/>
	          <c:set var="content" value="${fn:replace(fn:replace(vo.content, CRLF, '<br/>'),LF, '<br/>')}"/>
	          <a href="#" onclick="modalCheck('${vo.mid}','${vo.nickName}','${vo.name}','${pageVO.level}','${fn:substring(vo.birthday,0,10)}','${vo.gender}','${vo.userDel=='NO'?'활동중':'탈퇴신청중'}','${vo.visitCnt}','${vo.photo}','${content}')" data-bs-toggle="modal" data-bs-target="#myModal">${vo.mid}</a>
	        </td>
	        <td>
	          <a href="#" data-bs-toggle="modal" data-bs-target="#memberModal${vo.idx}">${vo.nickName}</a>
	        </td>
	        <td>${vo.name}</td>
	        <td>${fn:substring(vo.birthday,0,10)}</td>
	        <td>${vo.gender}</td>
	        <td>${fn:substring(vo.lastDate,0,16)}</td>
	        <td>${vo.todayCnt}</td>
	        <td>
	          <c:if test="${vo.userDel == 'NO'}">활동중</c:if>
	          <c:if test="${vo.userDel == 'OK'}">탈퇴신청중</c:if>
	          <c:if test="${vo.userDel == 'OK' && vo.deleteDiff < 30}">(<font color='red'>${vo.deleteDiff}</font>)</c:if>
	          <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
	            (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')"><font color='red'>30일경과</font></a>)
	          </c:if>
	        </td>
	        <td>
	          <select name="level" id="level" onchange="levelChange(this)">
	            <option value="1/${vo.idx}" ${vo.level==1 ? 'selected' : ''}>우수회원</option>
	            <option value="2/${vo.idx}" ${vo.level==2 ? 'selected' : ''}>정회원</option>
	            <option value="3/${vo.idx}" ${vo.level==3 ? 'selected' : ''}>준회원</option>
	            <option value="0/${vo.idx}" ${vo.level==0 ? 'selected' : ''}>관리자</option>
	            <option value="999/${vo.idx}" ${vo.level==999 ? 'selected' : ''}>탈퇴신청회원</option>
	          </select>
	        </td>
	      </tr>
	      
				<!-- memberModal 시작(회원 개수만큼 생성) -->
			  <div class="modal fade" id="memberModal${vo.idx}">
			    <div class="modal-dialog modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title">회원정보: ${vo.mid}</h5>
		          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		        </div>
		        <div class="modal-body">
		          <p>닉네임: ${vo.nickName}</p>
		          <p>이름: ${vo.name}</p>
		          <p>생일: ${fn:substring(vo.birthday,0,10)}</p>
		          <p>성별: ${vo.gender}</p>
		          <p>전화번호: ${vo.tel}</p>
		          <p>이메일: ${vo.email}</p>
		          <p>주소: ${vo.address}</p>
		          <p>회원등급: 
		            <c:choose>
		              <c:when test="${vo.level == 0}">관리자</c:when>
		              <c:when test="${vo.level == 1}">우수회원</c:when>
		              <c:when test="${vo.level == 2}">정회원</c:when>
		              <c:when test="${vo.level == 3}">준회원</c:when>
		              <c:otherwise>탈퇴신청회원</c:otherwise>
		            </c:choose>
		          </p>
		          <p>사진 : <img src="${ctp}/member/${vo.photo}" width="200px"/></p>
		          <div>자기소개: <div class="ms-3">${fn:replace(vo.content, newLine, "<br/>")}</div></div>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        </div>
			    </div>
			  </div>
			  <!-- modal 끝 -->
	      
	      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
	    </c:forEach>
	  </table>
  </form>
  
<!-- 블록페이지 시작 -->
	<div class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}"><a href="adMemberList?pag=1&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">첫페이지</a></c:if>
	  <c:if test="${pageVO.curBlock > 0}"><a href="adMemberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">이전블록</a></c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
	  	<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><a href="adMemberList?pag=${i}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link active text-decoration-none bg-secondary border-secondary">${i}</a></c:if>
	  	<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><a href="adMemberList?pag=${i}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">${i}</a></c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><a href="adMemberList?pag=${(pageVO.curBlock+1)*blockSize + 1}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">다음블록</a></c:if>
	  <c:if test="${pageVO.pag < pageVO.totPage}"><a href="adMemberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&level=${pageVO.level}" class="page-item page-link text-decoration-none text-dark link-primary">마지막페이지</a></c:if>
	</div>
<!-- 블록페이지 끝 -->
  
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 id="modal-title" class="modal-title">회원 상세정보</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <table class="table table-bordered text-center">
          <tr><th>아이디</th><td id="modalMid"></td></tr>
          <tr><th>닉네임</th><td><span id="modalNickName"></span></td></tr>
          <tr><th>성명</th><td><span id="modalName"></span></td></tr>
          <tr><th>등급</th><td><span id="modalLevel"></span></td></tr>
          <tr><th>생일</th><td><span id="modalBirthday"></span></td></tr>
          <tr><th>성별</th><td><span id="modalGender"></span></td></tr>
          <tr><th>활동여부</th><td><span id="modalUserDel"></span></td></tr>
          <tr><th>총 방문수</th><td><span id="modalVisitCnt"></span></td></tr>
          <tr><th>회원사진</th><td><span id="modalPhoto"></span></td></tr>
          <tr><th>회원소개</th><td><span id="modalContent"></span></td></tr>
        </table>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>