<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<footer class="bg-dark text-white pt-5 pb-4">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 mb-4">
        <h2 class="h4 fw-bold">TWAUDIO</h2>
        <p class="mt-3">
          최고의 음향기기 전문 쇼핑몰.<br/>
          당신의 음악 생활을 업그레이드하세요.
        </p>
      </div>
      <div class="col-lg-8 mb-4">
        <div class="row">
          <div class="col-md-4 mb-4">
            <h5 class="text-uppercase fw-bold small">고객센터</h5>
            <ul class="list-unstyled mt-3">
              <li><a href="${ctp}/notice/noticeList" class="text-decoration-none">공지사항</a></li>
              <li class="mt-2"><a href="${ctp}/pds/pdsList" class="text-decoration-none">자료실</a></li>
              <li class="mt-2"><a href="${ctp}/inquiry/inquiryList" class="text-decoration-none">1:1 문의</a></li>
            </ul>
          </div>
          <div class="col-md-4 mb-4">
            <h5 class="text-uppercase fw-bold small">회사정보</h5>
            <ul class="list-unstyled mt-3">
              <li><a href="#" class="text-decoration-none">회사소개</a></li>
              <li class="mt-2"><a href="#" class="text-decoration-none">이용약관</a></li>
              <li class="mt-2"><a href="#" class="text-decoration-none">개인정보처리방침</a></li>
            </ul>
          </div>
          <div class="col-md-4 mb-4">
            <h5 class="text-uppercase fw-bold small">Contact</h5>
            <p class="mt-3">
              Email: ds1202kr@gmail.com<br>
              Phone: 043-123-4567
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="border-top border-secondary pt-4 mt-2">
      <p class="text-center small">&copy; 2025 TWAUDIO. All rights reserved.</p>
    </div>
  </div>
</footer>

