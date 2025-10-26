<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>.jsp</title>
	<script>
		function inquiryReply() {
			var inquiryIdx = "${vo.idx}";
			var reContent = replyForm.reContent.value;
			if(reContent == "") {
				alert("답변을 입력하세요!");
				replyForm.reContent.focus();
				return false;
			}
			var query = {
					inquiryIdx : inquiryIdx,
					reContent : reContent
			}
			$.ajax({
				type : "post",
				url : "${ctp}/admin/inquiry/adInquiryReplyInput",
				data : query,
				success : function(res) {
					if(res != 0) {
						alert("답변글이 등록되었습니다.");
						location.reload();
					}
					else alert("답변글 등록 실패~");
				}
			});
		}
		
		function deleteReplyCheck() {
			var ans = confirm("답변글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			var reIdx = '${reVO.reIdx}';
			var inquiryIdx = '${reVO.inquiryIdx}';
			var query = {
					inquiryIdx : inquiryIdx,
					reIdx : reIdx
			}
			$.ajax({
				url  : "${ctp}/admin/inquiry/adInquiryReplyDelete",
				type : "post",
				data : query,
				success:function() {
					alert("삭제 되었습니다.");
					location.reload();
				}
			});
		}
		
		function adUpdateReplyCheck() {
			location.href = "${ctp}/admin/inquiry/adInquiryReply?idx=${vo.idx}&replySw=U";
		}
		 
		function deleteCheck() {
			var ans = confirm("삭제하시겠습니까?");
			if(!ans) return false;
			let reIdx = 0;
			if(${!empty reVO.reIdx}) reIdx = '${reVO.reIdx}';
			location.href="${ctp}/admin/inquiry/adInquiryDelete?idx=${vo.idx}&fSName=${vo.FSName}&reIdx="+reIdx+"&pag=${pag}";
		}
	</script>
	<style>
	  th {
	    background-color: #eee !important;
	    text-align:center;
	  }
	</style>
</head>
<body>

<p><br/></p>
<div class="container w3-main" style="margin-top:40px;">
  <h3>☞ 1:1문의 상세보기</h3>
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<td colspan="3">[${vo.part}] ${vo.title}</td>
		</tr>
		<tr>
			<th>작성ID</th>
			<td colspan="3">${vo.userId}</td>
		</tr>
		<tr>
			<th>상태</th>
			<td colspan="3">
				<c:if test="${vo.reply=='답변대기중'}">
					<span class="badge bg-secondary">${vo.reply}</span>						
				</c:if>
				<c:if test="${vo.reply=='답변완료'}">
					<span class="badge bg-danger">${vo.reply}</span>						
				</c:if>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td style="width:200px">${fn:substring(vo.WDate,0,10)}</td>
			<th>주문번호</th>
			<td>
				<c:if test="${!empty vo.orderId}">${vo.orderId}</c:if>
				<c:if test="${empty vo.orderId}">없음</c:if>	
			</td>
		</tr>
		<tr>
			<td colspan="4" class="view-content">
	      <c:if test="${!empty vo.FSName}"><img src="${ctp}/inquiry/${vo.FSName}" width="400px"/><br/></c:if>
	      <br/>
	      <p>${fn:replace(vo.content,newLine,"<br/>")}<br/></p>
		    <hr/>
			</td>
		</tr>
	</table>
	
	<div style="text-align: right">
		<c:if test="${sUserId==vo.userId || sLevel == 0}">
			<input type="button" value="원본글삭제" onclick="deleteCheck()" class="btn btn-danger btn-sm"/>
		</c:if>
		<input type="button" value="목록" onclick="location.href='${ctp}/admin/inquiry/adInquiryList?pag=${pag}'" class="btn btn-secondary btn-sm"/>
	</div>
	
	<hr/>
	<c:if test="${!empty reVO.reContent}">
		<form name="replyForm" method="post">
			<h5>답변내용</h5>
			<c:if test="${empty replySw || replySw != 'U'}">
				<textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="form-control" >${reVO.reContent}</textarea>
				<div style="text-align: right">
					<input type="button" value="수정" id="updateBtn" onclick="adUpdateReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
					<input type="button" value="답변글삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-danger btn-sm mt-2"/>
				</div>
			</c:if>
			<c:if test="${!empty replySw && replySw == 'U'}">
				<textarea name="reContent" rows="5"  id="reContent" class="form-control" >${reVO.reContent}</textarea>
				<div style="text-align: right">
					<input type="submit" value="수정완료처리" id="updateOkBtn" class="btn btn-success btn-sm mt-2"/>
					<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
				</div>
			</c:if>
			<input type="hidden" name="reIdx" value="${reVO.reIdx}"/>
			<input type="hidden" name="inquiryIdx" value="${reVO.inquiryIdx}"/>
		</form>
	</c:if>

	<c:if test="${empty reVO.reContent}">
		<form name="replyForm">
			<label for="reContent">답변글 작성하기</label>
			<textarea name="reContent" rows="5" class="form-control" placeholder="답변글을 작성해 주세요"></textarea>
			<div style="text-align: right">
				<input type="button" value="등록" onclick="inquiryReply()" class="btn btn-secondary btn-sm mt-2"/>
			</div>
		</form>
	</c:if>
</div>
<p><br/></p>

</body>
</html>