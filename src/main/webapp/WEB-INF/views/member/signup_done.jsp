<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/signup_done.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>
<!-- JavaScript -->
<script src="/resources/js/member/signup_info.js"></script>
<body>
<!-- Header -->
    <jsp:include page="../common/header.jsp" />
<!-- Login -->
<section class="login-container">
    <div class="login-box">
        <!-- 왼쪽 영역 -->
        <div class="login-left">
            <div class="login-icon">👤</div>
            <h2>회원가입</h2>
            <p>가입 완료</p>
        </div>
        <!-- 오른쪽 영역 -->
        <div class="login-right">
            <h1 class="login-logo">■ LOGO</h1>
            <div class="complete-icon">🐵</div>
            <h2>회원가입이 완료되었어요</h2>
            <p>저희 학생이 되어주신걸 환영해요</p>
            <button class="btn-login" onclick="location.href = '/member/login'">로그인</button>
            <button class="btn-main" onclick="location.href = '/'">메인화면</button>
        </div>
    </div>
</section>
<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
