<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그?�� | EduMate</title>
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
        <!-- ?���? ?��?�� -->
        <div class="login-left">
            <div class="login-icon">?��?</div>
            <h2>?��?���??��</h2>
            <p>�??�� ?���?</p>
        </div>
        <!-- ?��른쪽 ?��?�� -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">
            <div class="complete-icon">?��?</div>
            <h2>?��?���??��?�� ?��료되?��?��?��</h2>
            <p>???�� ?��?��?�� ?��?��주신�? ?��?��?��?��</p>
            <button class="btn-login" onclick="location.href = '/member/login'">로그?��</button>
            <button class="btn-main" onclick="location.href = '/'">메인?���?</button>
        </div>
    </div>
</section>
<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
