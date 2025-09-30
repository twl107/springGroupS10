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
	<h2 class="text-center">회 원 리 스 트</h2>
	<table class="table table-hover text-center">
		<tr class="table table-secondary">
			<th>번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>성명</th>
			<th>이메일</th>
			<th>연락처</th>
			<th>생일</th>
			<th>성별</th>
			<th>최종 방문일</th>
			<th>오늘 방문 횟수</th>
			<th>활동여부</th>
			<th>회원등급</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.userid}</td>
				<td>${vo.nickname}</td>
				<td>${vo.name}</td>
				<td>${vo.email}</td>
				<td>${vo.tel}</td>
				<td>${fn:substring(vo.birthday,0,10)}</td>
				<td>
					<c:if test="${vo.gender=='M'}">남자</c:if>
					<c:if test="${vo.gender=='F'}">여자</c:if>
				</td>
				<td>${fn:substring(vo.lastLoginAt,0,16)}</td>
				<td>${vo.visitCnt }</td>
				<td>
					<c:if test="${!vo.isDeleted()}">활동중</c:if>
					<c:if test="${vo.isDeleted()}">탈퇴신청중</c:if>
					<c:if test="${vo.isDeleted() && vo.deleteDiff < 30}">(<font color='red'>${vo.deleteDiff}일 경과</font>)</c:if>
					<c:if test="${vo.isDeleted() && vo.deleteDiff >= 30}">(<font color='red'>30일 경과</font>)</c:if>
				</td>
				<td>
					<c:if test="${vo.level=='0'}">관리자</c:if>
					<c:if test="${vo.level=='1'}">우수회원</c:if>
					<c:if test="${vo.level=='2'}">정회원</c:if>
					<c:if test="${vo.level=='3'}">준회원</c:if>
					<c:if test="${vo.level=='99'}">비회원</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
<p><br/></p>
</body>
</html>