<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 | EduMate</title>

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
            <img class="login-logo" src="${pageContext.request.contextPath}/resources/images/common/logo.png">

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
                <div class="email-input-group">
                    <input type="text" id="emailId" placeholder="이메일 아이디" required>
                    <span class="email-separator">@</span>
                    <select id="emailDomain" required>
                        <option value="">도메인 선택</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="yahoo.com">yahoo.com</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="custom">직접입력</option>
                    </select>
                    <input type="text" id="customDomain" placeholder="도메인 입력" style="display: none;">
                    <button type="button" id="sendAuthBtn" class="btn-email-action btn-send">인증 요청</button>
                </div>
                <input type="hidden" id="memberEmail" name="memberEmail" required>
                
                <!-- 이메일 인증번호 -->
                <div id="authCodeArea" class="input-group" style="display: none;">
				    <input type="text" id="authCodeInput" placeholder="인증 번호 6자리 입력" maxlength="6" class="input-full">
				    <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">인증 확인</button>
				</div>
	
				<div id="authStatusMessage" class="auth-message" style="display: none;"></div>
				
				<input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">
                <!-- 이름 -->
                <input type="text" id="memberName" name="memberName" placeholder="이름" required>

                <!-- 생년월일 -->
                <input type="date" id="memberBirth" name="memberBirth" placeholder="생년월일" required>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0;">
                    <div class="g-recaptcha" data-sitekey="6Lf8UAAsAAAAAK4TUsleSFanG_y2BtHknDwopgW4"></div>
                </div>

                <!-- 제출 버튼 -->
                <button type="submit" id="next-btn" class="btn-login">다음</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

</body>
</html>
