<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정보찾기 | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/find_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>
<!-- JavaScript -->
<script src="/resources/js/member/find_info.js"></script>
<body>
<!-- Header -->
<jsp:include page="../common/header.jsp" />

<!-- Find Info -->
<section class="login-container">
    <div class="login-box">
        <!-- 왼쪽 영역 -->
        <div class="login-left">
            <div class="login-icon">🔍</div>
            <h2>정보 찾기</h2>
        </div>

        <!-- 오른쪽 영역 -->
        <div class="login-right">
            <img class="login-logo" src="${pageContext.request.contextPath}/resources/images/common/logo.png">

            <!-- 상단 탭 -->
            <div class="tab-container">
                <button class="tab-btn active" id="tab-id">아이디</button>
                <button class="tab-btn" id="tab-pw">비밀번호</button>
            </div>
            <c:choose>
        <c:when test="${empty foundId}">
            <p>${msg }</p>
        </c:when>
        <c:when test="${empty foundPw}">
            <p>${msg }</p>
        </c:when>
        </c:choose>

            <!-- 아이디 찾기 폼 -->
            <form id="find-id-form" class="form-section active" method="post" action="/member/findId">
                <input type="text" name="memberName" placeholder="이름" required>
                <input type="date" name="memberBirth" placeholder="생년월일" required>
                <input type="email" name="memberEmail" placeholder="이메일" required>
                <button type="submit" class="btn-login">찾기</button>
            </form>

            <!-- 비밀번호 찾기 폼 -->
            <form id="find-pw-form" class="form-section" method="post" action="/member/findPw">
                <input type="text" name="memberId" placeholder="아이디" required>
                <input type="email" name="memberEmail" placeholder="이메일" required>
                <button type="submit" class="btn-login">찾기</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>
