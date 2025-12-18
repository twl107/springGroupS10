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
  <title>dbShopContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <script>
  	'use strict';
    
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="row">
    <div class="col p-3 text-center" style="border:1px solid #ccc">
		  <div>
		    <img src="${ctp}/product/${productVO.FSName}" width="100%"/>
		  </div>
		</div>
		<div class="col p-3 text-right">
		  <div id="iteminfor">
		    <h3>${productVO.detail}</h3>
		    <h3><font color="orange"><fmt:formatNumber value="${productVO.mainPrice}"/>원</font></h3>
		    <h4>${productVO.productName}</h4>
		  </div>
		  <div class="form-group">
		    <form name="optionForm">
		      <select size="1" class="form-control" id="selectOption">
		        <option value="" disabled selected>상품옵션선택</option>
		        <option value="0:기본품목_${productVO.mainPrice}">기본품목</option>
		        <c:forEach var="vo" items="${optionVOS}">
		          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
		        </c:forEach>
		      </select>
		    </form>
		  </div>
		  <br/>
		  <div class="text-right p-2">
			  <c:url var="optionRegUrl" value="/dbShop/dbOption">
					<c:param name="productName" value="${productVO.productName}"/>
				</c:url>
  	    <input type="button" value="옵션등록" onclick="location.href='${optionRegUrl}';" class="btn btn-success"/>
		    <input type="button" value="돌아가기" onclick="location.href='${ctp}/dbShop/dbShopList';" class="btn btn-primary"/>
		  </div>
		</div>
  </div>
  <br/><br/>
  <div id="content" class="text-center"><br/>
    ${productVO.content}
  </div>
</div>
<p><br/></p>
</body>
</html>