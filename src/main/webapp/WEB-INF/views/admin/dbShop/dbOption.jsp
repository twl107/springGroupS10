<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOption.jsp(상품의 옵션 등록)</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <script>
  	'use strict';
    let cnt = 1;
    
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'" class="option-group"><hr class="border-1 border-dark">';
    	strOption += '<font size="4"><b class="mb-2">상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<div class="input-group mb-2">';
    	strOption += '<div class="input-group-text">상품옵션이름</div>';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm remove-option-btn"/>';
    	strOption += '</div>';
    	strOption += '<div class="input-group mb-2">';
    	strOption += '<div class="input-group-text">상품옵션가격</div>';
    	strOption += '<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    $(document).ready(function() {
  	  $('#optionType').on('click', '.remove-option-btn', function() {
  	    $(this).closest('.option-group').remove();
  	  });
  	});
    
    function fCheck() {
    	for(let i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("optionPrice"+i).value=="") {
    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
    			return false;
    		}
    	}
    	
    	
    	if(document.getElementById("optionName").value=="") {
    		alert("상품 옵션이름을 등록하세요");
    		return false;
    	}
    	if(document.getElementById("optionPrice").value=="") {
    		alert("상품 옵션가격을 등록하세요");
    		return false;
    	}
    	if(document.getElementById("productName").value=="") {
    		alert("상품명을 선택하세요");
    		return false;
    	}
    	
    	let productIdx = document.myform.productIdx.value;
    	if(productIdx === "" || productIdx === "0") {
    		alert("상품 정보가 올바르지 않습니다. 상품을 다시 선택해주세요.");
    		return false;
    	}
    	
			let formData = $("#myForm").serialize();
    		
  		$.ajax({
    		type	: "post",
    		url		:	"${ctp}/dbShop/dbOption",
    		data	: formData,
    		success:function(data) {
      
   				if(data === "1") {
   					alert("옵션이 등록되었습니다.");

   					location.reload(); 
   				} else {
   					alert("옵션 등록에 실패했거나, 이미 등록된 옵션입니다.");
   				}
   			},

   			error: function(xhr, status, error) {
   				console.log("AJAX Error:", error);
   				alert("서버와 통신 중 오류가 발생했습니다. 다시 시도해 주세요.");
   			}
	 		});
    }
    
    function categoryMainChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryMiddleName",
				data : {categoryMainCode : categoryMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
					}
					$("#categoryMiddleCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    function categoryMiddleChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryProductName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode,
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    <c:if test="${!empty productVO}">productNameCheck('${productVO.productName}')</c:if>
    
    function productNameCheck(productName) {
    	if(productName == "") productName = document.getElementById("productName").value;
    	
    	$.ajax({
    		type:"post",
    		url : "${ctp}/dbShop/getProductInfor",
    		data: {productName : productName},
    		success:function(vo) {
    			let str = '<hr/>';
    			str += '<table class="table table-bordered">';
    			str += '<tr><th>대분류명</th><td>'+vo.categoryMainName+'</td>';
    			str += '<td rowspan="6" class="text-center"><img src="${ctp}/product/'+vo.fsname+'" width="160px"/></td></tr>';
    			str += '<tr><th>중분류명</th><td>'+vo.categoryMiddleName+'</td></tr>';
    			str += '<tr><th>상 품 명</th><td>'+vo.productName+'</td></tr>';
    			str += '<tr><th>상품제목</th><td>'+vo.detail+'</td></tr>';
    			str += '<tr><th>상품가격</th><td>'+numberWithCommas(vo.mainPrice)+'원</td></tr>';
    			str += '<tr><td colspan="3" class="text-center"><input type="button" value="등록된옵션보기(삭제)" onclick="optionShow('+vo.idx+')" class="btn btn-info btn-sm"/></td></tr>';
    			str += '</table>';
    			str += '<hr/>';
    			str += '<div id="optionDemo"></div>';
    			$("#demo").html(str);
    			document.myform.productIdx.value = vo.idx;
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function optionShow(productIdx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/getOptionList",
    		data : {productIdx : productIdx},
    		success:function(vos) {
    			let str = '';
    			if(vos.length != 0) {
						str = "옵션 : / ";
	    			for(let i=0; i<vos.length; i++) {
	    				str += '<a href="javascript:optionDelete('+vos[i].idx+')">';
							str += vos[i].optionName + "</a> / ";
	    			}
    			}
    			else {
    				str = "<div class='text-center'><font color='red'>현 상품에 등록된 옵션이 없습니다.</font></div>";
    			}
					$("#optionDemo").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function optionDelete(idx) {
    	let ans = confirm("현재 선택한 옵션을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/optionDelete",
    		data : {idx : idx},
    		success:function() {
    			alert("삭제되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function numberWithCommas(x) {
		  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
  </script>
  <style>
    th {
      text-align: center;
      background-color: #eee !important;
    }
    a {
      color: #00f;
      text-decoration: none;
    }
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>상품에 따른 옵션 등록</h2>
  <form name="myform" id="myForm" method="post">
    <div class="input-group mb-2">
      <label for="categoryMainCode" class="input-group-text">대분류</label>
      <select id="categoryMainCode" name="categoryMainCode" class="form-select" onchange="categoryMainChange()">
        <option value="">대분류를 선택하세요</option>
        <c:forEach var="mainVo" items="${mainVos}">
        	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
        </c:forEach>
        <c:if test="${!empty productVO}"><option value="${productVO.categoryMainCode}" selected>${productVO.categoryMainName}</option></c:if>
      </select>
    </div>
    <div class="input-group mb-2">
      <label for="categoryMiddleCode" class="input-group-text">중분류</label>
      <select id="categoryMiddleCode" name="categoryMiddleCode" class="form-select" onchange="categoryMiddleChange()">
        <option value="">중분류명</option>
        <c:if test="${!empty productVO}"><option value="${productVO.categoryMiddleCode}" selected>${productVO.categoryMiddleName}</option></c:if>
      </select>
    </div>
    <div class="input-group mb-2">
      <label for="productName" class="input-group-text">상품명(모델명)</label>
      <!-- <select name="productName" id="productName" class="form-control" onchange="productNameCheck('')"> -->
      <select name="productCode" id="productName" class="form-select" onchange="productNameCheck('')">
        <option value="">상품선택</option>
        <c:if test="${!empty productVO}"><option value="${productVO.productCode}" selected>${productVO.productName}</option></c:if>
        <%-- <c:if test="${!empty productVO}"><option value="${productVO.productName}" selected>${productVO.productName}</option></c:if> --%>
      </select>
    </div>
    <div id="demo"></div>
    <hr class="border-1 border-dark">
    <div class="mb-2">
	    <font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;
	    <input type="button" value="옵션박스추가하기" onclick="addOption()" class="btn btn-secondary btn-sm"/><br/>
    </div>
    <div class="input-group mb-2">
      <label for="optionName" class="input-group-text">상품옵션이름</label>
      <input type="text" name="optionName" id="optionName" class="form-control"/>
    </div>
    <div class="input-group mb-2">
      <label for="optionPrice" class="input-group-text">상품옵션가격</label>
      <input type="text" name="optionPrice" id="optionPrice" class="form-control"/>
    </div>
    <div id="optionType"></div>
    <hr class="border-1 border-dark">
    <div class='text-end'>
      <input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-primary"/>
      <input type="button" value="상품리스트" onclick="location.href='dbShopList'" class="btn btn-warning"/>
    </div>
    <input type="hidden" name="productIdx">
  </form>
</div>
<p><br/></p>
</body>
</html>