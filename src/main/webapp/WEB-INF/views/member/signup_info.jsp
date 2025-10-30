<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?öå?õêÍ∞??ûÖ | EduMate</title>

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

<!-- ?öå?õêÍ∞??ûÖ ?èº -->
<section class="login-container">
    <div class="login-box">
        <!-- ?ôºÏ™? ?òÅ?ó≠ -->
        <div class="login-left">
            <div class="login-icon">?üë?</div>
            <h2>?öå?õêÍ∞??ûÖ</h2>
            <p>?†ïÎ≥? ?ûÖ?†•</p>
        </div>

        <!-- ?ò§Î•∏Ï™Ω ?òÅ?ó≠ -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

            <form action="/member/signup/info" method="post" id="signupForm">
                
                <!-- ?ïÑ?ù¥?îî -->
                <input type="text" id="memberId" name="memberId" placeholder="?ïÑ?ù¥?îî" required>

                <!-- ÎπÑÎ?Î≤àÌò∏ -->
                <div style="display: flex; gap: 10px;">
                    <input type="password" id="memberPw" name="memberPw" placeholder="ÎπÑÎ?Î≤àÌò∏" required style="flex:1;">
                    <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="ÎπÑÎ?Î≤àÌò∏ ?û¨?ûÖ?†•" required style="flex:1;">
                </div>

                <!-- ÎπÑÎ?Î≤àÌò∏ Î∂àÏùºÏπ? Í≤ΩÍ≥† -->
                <div id="pw-error" style="color:red; font-size:13px; margin-top:5px; display:none;">
                    ÎπÑÎ?Î≤àÌò∏Í∞? ?ùºÏπòÌïòÏß? ?ïä?äµ?ãà?ã§.
                </div>

                <!-- ?ù¥Î©îÏùº -->
                <div class="email-input-group">
                    <input type="text" id="emailId" placeholder="?ù¥Î©îÏùº ?ïÑ?ù¥?îî" required>
                    <span class="email-separator">@</span>
                    <select id="emailDomain" required>
                        <option value="">?èÑÎ©îÏù∏ ?Ñ†?Éù</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="kakao.com">kakao.com</option>
                        <option value="yahoo.com">yahoo.com</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="custom">ÏßÅÏ†ë?ûÖ?†•</option>
                    </select>
                    <input type="text" id="customDomain" placeholder="?èÑÎ©îÏù∏ ?ûÖ?†•" style="display: none;">
                    <button type="button" id="sendAuthBtn" class="btn-email-action btn-send">?ù∏Ï¶? ?öîÏ≤?</button>
                </div>
                <input type="hidden" id="memberEmail" name="memberEmail" required>
                
                <!-- ?ù¥Î©îÏùº ?ù∏Ï¶ùÎ≤à?ò∏ -->
                <div id="authCodeArea" class="input-group" style="display: none;">
				    <input type="text" id="authCodeInput" placeholder="?ù∏Ï¶? Î≤àÌò∏ 6?ûêÎ¶? ?ûÖ?†•" maxlength="6" class="input-full">
				    <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">?ù∏Ï¶? ?ôï?ù∏</button>
				</div>
	
				<div id="authStatusMessage" class="auth-message" style="display: none;"></div>
				
				<input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">
                <!-- ?ù¥Î¶? -->
                <input type="text" id="memberName" name="memberName" placeholder="?ù¥Î¶?" required>

                <!-- ?Éù?ÖÑ?õî?ùº -->
                <input type="date" id="memberBirth" name="memberBirth" placeholder="?Éù?ÖÑ?õî?ùº" required>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <!-- ?†úÏ∂? Î≤ÑÌäº -->
                <button type="submit" id="next-btn" class="btn-login">?ã§?ùå</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

</body>
</html>
