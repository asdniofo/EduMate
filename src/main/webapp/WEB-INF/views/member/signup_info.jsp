<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?��?���??�� | EduMate</title>

    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/signup_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">

    <!-- JavaScript -->
    <script src="/resources/js/member/signup_info.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>

<!-- Header -->
    <jsp:include page="../common/header.jsp" />

<!-- ?��?���??�� ?�� -->
<section class="login-container">
    <div class="login-box">
        <!-- ?���? ?��?�� -->
        <div class="login-left">
            <div class="login-icon">?��?</div>
            <h2>?��?���??��</h2>
            <p>?���? ?��?��</p>
        </div>

        <!-- ?��른쪽 ?��?�� -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

            <form action="/member/signup/info" method="post" id="signupForm">
                
                <!-- ?��?��?�� -->
                <input type="text" id="memberId" name="memberId" placeholder="?��?��?��" required>

                <!-- 비�?번호 -->
                <div style="display: flex; gap: 10px;">
                    <input type="password" id="memberPw" name="memberPw" placeholder="비�?번호" required style="flex:1;">
                    <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="비�?번호 ?��?��?��" required style="flex:1;">
                </div>

                <!-- 비�?번호 불일�? 경고 -->
                <div id="pw-error" style="color:red; font-size:13px; margin-top:5px; display:none;">
                    비�?번호�? ?��치하�? ?��?��?��?��.
                </div>

                <!-- ?��메일 -->
                <div class="email-input-group">
                    <input type="text" id="emailId" placeholder="?��메일 ?��?��?��" required>
                    <span class="email-separator">@</span>
                    <select id="emailDomain" required>
                        <option value="">?��메인 ?��?��</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="yahoo.com">yahoo.com</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="custom">직접?��?��</option>
                    </select>
                    <input type="text" id="customDomain" placeholder="?��메인 ?��?��" style="display: none;">
                    <button type="button" id="sendAuthBtn" class="btn-email-action btn-send">?���? ?���?</button>
                </div>
                <input type="hidden" id="memberEmail" name="memberEmail" required>
                
                <!-- ?��메일 ?��증번?�� -->
                <div id="authCodeArea" class="input-group" style="display: none;">
				    <input type="text" id="authCodeInput" placeholder="?���? 번호 6?���? ?��?��" maxlength="6" class="input-full">
				    <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">?���? ?��?��</button>
				</div>
	
				<div id="authStatusMessage" class="auth-message" style="display: none;"></div>
				
				<input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">
                <!-- ?���? -->
                <input type="text" id="memberName" name="memberName" placeholder="?���?" required>

                <!-- ?��?��?��?�� -->
                <input type="date" id="memberBirth" name="memberBirth" placeholder="?��?��?��?��" required>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <!-- ?���? 버튼 -->
                <button type="submit" id="next-btn" class="btn-login">?��?��</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

</body>
</html>
