<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/signup_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css" />
    <link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<!-- JavaScript -->
<script src="/resources/js/member/signup_info.js"></script>
<body>
<!-- Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- Login -->
<section class="login-container">
    <div class="login-box">
        <!-- 왼쪽 영역 -->
        <div class="login-left">
            <div class="login-icon">👤</div>
            <h2>회원가입</h2>
            <p>정보 입력</p>
        </div>

        <!-- 오른쪽 영역 -->
        <div class="login-right">
            <h1 class="login-logo">■ LOGO</h1>

            <form action="/member/signup/info" method="post" id="signupForm">
                <input type="text" id="userId" name="userId" placeholder="아이디" required>
                
                <div style="display: flex; gap: 10px;">
                    <input type="password" id="userPw" name="userPw" placeholder="비밀번호" required style="flex:1;">
                    <input type="password" id="userPwCheck" name="userPwCheck" placeholder="비밀번호 재입력" required style="flex:1;">
                </div>
                <div id="pw-error" style="color:red; font-size:13px; margin-top:5px; display:none;">
                비밀번호가 일치하지 않습니다.
                </div>

                <input type="email" id="userEmail" name="userEmail" placeholder="이메일" required>
                <input type="text" id="userName" name="userName" placeholder="이름" required>
                <input type="date" id="userBirth" name="userBirth" placeholder="생일" required>

                <div style="margin: 20px 0;">
                    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>
                <button type="submit" id="next-btn" class="btn-login">다음</button>
            </form>
        </div>
    </div>
</section>
<!-- Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
