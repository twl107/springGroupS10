<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>상품 목록</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <script>
    'use strict';
    // 체크박스 클릭 시 자동으로 폼을 제출하는 함수
    function filterSubmit() {
      document.getElementById("filterForm").submit();
    }
  </script>
  <style>
    .category-box { border: 1px solid #ddd; padding: 15px; border-radius: 5px; }
    
    a  {text-decoration: none}
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <form method="get" action="${ctp}/dbShop/dbShopList" id="filterForm">
    <div class="category-box mb-4">
      <h5>대분류 <a href="${ctp}/dbShop/dbShopList" class="btn btn-sm btn-outline-secondary ms-2">전체보기</a></h5>
      <div class="d-flex flex-wrap">
        <c:forEach var="main" items="${mainCategoryVOS}">
          <div class="form-check me-3">
            <input class="form-check-input" type="checkbox" name="mainCategory" value="${main.categoryMainCode}" id="main_${main.categoryMainCode}" onchange="filterSubmit()"
              <c:if test="${not empty selectedMainCodes and fn:contains(selectedMainCodes, main.categoryMainCode)}">checked</c:if> >
            <label class="form-check-label" for="main_${main.categoryMainCode}">${main.categoryMainName}</label>
          </div>
        </c:forEach>
      </div>
      
      <hr/>
      
      <h5>
        중분류
        <a class="btn btn-sm btn-outline-primary ms-2" data-bs-toggle="collapse" href="#middleCategoryCollapse" role="button">
          펼치기/접기
        </a>
      </h5>
      <div class="collapse ${not empty selectedMiddleCodes ? 'show' : ''}" id="middleCategoryCollapse">
        <div class="d-flex flex-wrap">
          <c:forEach var="middle" items="${middleCategoryVOS}">
            <div class="form-check me-3">
              <input class="form-check-input" type="checkbox" name="middleCategory" value="${middle.categoryMiddleCode}" id="middle_${middle.categoryMiddleCode}" onchange="filterSubmit()"
                <c:if test="${not empty selectedMiddleCodes and fn:contains(selectedMiddleCodes, middle.categoryMiddleCode)}">checked</c:if> >
              <label class="form-check-label" for="middle_${middle.categoryMiddleCode}">${middle.categoryMiddleName}</label>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </form>
  
  <hr/>
  <div class="row">
    <div class="col">
      <h4>상품 리스트 : 
        <font color="brown"><b>
          <c:choose>
            <c:when test="${not empty selectedMiddleName}">${selectedMiddleName}</c:when>
            <c:when test="${not empty selectedMainName}">${selectedMainName}</c:when>
            <c:otherwise>전체 상품</c:otherwise>
          </c:choose>
        </b></font>
      </h4>
    </div>
    <div class="col text-end">
      <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbProduct';">상품등록</button>
    </div>
  </div>
  <hr/>
  
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:if test="${fn:length(productVOS) == 0}"><h3 class="text-center text-muted">표시할 상품이 없습니다.</h3></c:if>
    <c:forEach var="vo" items="${productVOS}">
      <div class="col-md-4">
        <div style="text-align:center" class="mt-1">
          <a href="${ctp}/dbShop/dbShopContent?idx=${vo.idx}">
            <img src="${ctp}/resources/data/dbShop/product/${vo.FSName}" width="200px" height="180px"/>
            <div><font size="2">${vo.productName}</font></div>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></div>
            <div><font size="2">${vo.detail}</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
  </div>
  <hr/>
</div>
<p><br/></p>
</body>
</html>