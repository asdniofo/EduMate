<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 | EduMate</title>

    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/signup_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css" />
    <link rel="stylesheet" href="/resources/css/common/footer.css" />

    <!-- JavaScript -->
    <script src="/resources/js/member/signup_info.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>

<!-- Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 회원가입 폼 -->
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
                
                <!-- 아이디 -->
                <input type="text" id="memberId" name="memberId" placeholder="아이디" required>

                <!-- 비밀번호 -->
                <div style="display: flex; gap: 10px;">
                    <input type="password" id="memberPw" name="memberPw" placeholder="비밀번호" required style="flex:1;">
                    <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="비밀번호 재입력" required style="flex:1;">
                </div>

                <!-- 비밀번호 불일치 경고 -->
                <div id="pw-error" style="color:red; font-size:13px; margin-top:5px; display:none;">
                    비밀번호가 일치하지 않습니다.
                </div>

                <!-- 이메일 -->
                <input type="email" id="memberEmail" name="memberEmail" placeholder="이메일" required>

                <!-- 이름 -->
                <input type="text" id="memberName" name="memberName" placeholder="이름" required>

                <!-- 생년월일 -->
                <input type="date" id="memberBirth" name="memberBirth" placeholder="생년월일" required>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <!-- 제출 버튼 -->
                <button type="submit" id="next-btn" class="btn-login">다음</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>
