<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>?�� ?���? ?��?�� | EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/member/edit_info.css">
    <link rel="stylesheet" href="/resources/css/common/main_banner.css">
    <link rel="stylesheet" href="/resources/css/member/mypage.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />

        <section class="main-banner">
            <div class="banner-text">
                ?�� ?���? ?��?��
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/mypage.png" alt="?��보수?�� ?��?���?">
            </div>
        </section>

        <!-- 메인 콘텐�? -->
        <div class="main-content">
            <div class="mypage-content">
                <div class="edit-container">
        <div class="edit-content">
            <div class="note">
                ?��? 본인?�� 개인?��보만 ?��?��?�� ?�� ?��?��?��?��. ?��?��?��?�� �?경할 ?�� ?��?��?��?��.
            </div>
            
            <div id="alertMessage" style="display: none;"></div>
            
            <form id="editForm" class="edit-form">
                <div class="form-group">
                    <label for="memberId">?��?��?��</label>
                    <input type="text" id="memberId" value="${memberInfo.memberId}" readonly>
                </div>

                <div class="form-group">
                    <label for="memberPw">?�� 비�?번호</label>
                    <input type="password" id="memberPw" placeholder="?�� 비�?번호�? ?��?��?��?��?��" required>
                </div>

                <div class="form-group">
                    <label for="memberPwConfirm">비�?번호 ?��?��</label>
                    <input type="password" id="memberPwConfirm" placeholder="비�?번호�? ?��?�� ?��?��?��?��?��" required>
                </div>

                <!-- 비�?번호 불일�? 경고 -->
                <div id="pw-error" style="color: #e74c3c; font-size: 14px; margin-top: -15px; margin-bottom: 15px; display: none; font-weight: 500;">
                    ?���? 비�?번호�? ?��치하�? ?��?��?��?��.
                </div>

                <div class="form-group">
                    <label for="memberName">?���?</label>
                    <input type="text" id="memberName" value="${memberInfo.memberName}" required>
                </div>

                <div class="form-group">
                    <label for="memberEmail">?��메일</label>
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
                    <input type="hidden" id="memberEmail" value="${memberInfo.memberEmail}" required>
                </div>
                
                <!-- ?��메일 ?��증번?�� -->
                <div id="authCodeArea" class="form-group" style="display: none;">
                    <div class="label-with-message">
                        <label for="authCodeInput">?���? 번호</label>
                        <span id="authStatusMessage" class="auth-message-inline" style="display: none;"></span>
                    </div>
                    <div class="input-group">
                        <input type="text" id="authCodeInput" placeholder="?���? 번호 6?���? ?��?��" maxlength="6" class="input-full">
                        <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">?���? ?��?��</button>
                    </div>
                </div>
                
                <input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">

                <div class="form-group">
                    <label for="memberBirth">?��?��?��?��</label>
                    <input type="date" id="memberBirth" value="${memberInfo.memberBirth}" required>
                </div>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0; display: flex; justify-content: center;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">?���? ?��?��</button>
                    <a href="/member/mypage" class="btn btn-secondary">취소</a>
                </div>
            </form>
                </div>
            </div>
        </div>

    <script>
        $(document).ready(function() {
            // ?��?���? 비�?번호 ?���? �??��
            const pwInput = document.getElementById('memberPw');
            const pwConfirmInput = document.getElementById('memberPwConfirm');
            const pwError = document.getElementById('pw-error');

            function checkPasswordMatch() {
                const pw = pwInput.value;
                const pwConfirm = pwConfirmInput.value;

                if (pw && pwConfirm && pw !== pwConfirm) {
                    pwError.style.display = 'block';
                    pwConfirmInput.classList.add('input-error');
                } else {
                    pwError.style.display = 'none';
                    pwConfirmInput.classList.remove('input-error');
                }
            }

            pwInput.addEventListener('input', checkPasswordMatch);
            pwConfirmInput.addEventListener('input', checkPasswordMatch);

            // ?��메일 ?���? 기능
            const emailIdInput = document.getElementById('emailId');
            const emailDomainSelect = document.getElementById('emailDomain');
            const customDomainInput = document.getElementById('customDomain');
            const memberEmailHidden = document.getElementById('memberEmail');
            const sendAuthBtn = document.getElementById('sendAuthBtn');
            const authCodeArea = document.getElementById('authCodeArea');
            const authCodeInput = document.getElementById('authCodeInput');
            const verifyAuthBtn = document.getElementById('verifyAuthBtn');
            const authStatusMessage = document.getElementById('authStatusMessage');
            const emailAuthStatus = document.getElementById('emailAuthStatus');
            
            let isEmailVerified = false; // ?��메일 ?���? ?��?�� ?��?���?
            let originalEmail = memberEmailHidden.value; // ?��?�� ?��메일 ???��

            // ?��?���? 로드 ?�� 기존 ?��메일 분리?��?�� ?��?��
            function parseExistingEmail() {
                if (originalEmail) {
                    const [id, domain] = originalEmail.split('@');
                    emailIdInput.value = id;
                    
                    // ?��메인?�� ?��?���??�� ?��?���? ?��?��
                    const domainOptions = Array.from(emailDomainSelect.options).map(opt => opt.value);
                    if (domainOptions.includes(domain)) {
                        emailDomainSelect.value = domain;
                    } else {
                        emailDomainSelect.value = 'custom';
                        customDomainInput.style.display = 'block';
                        customDomainInput.value = domain;
                    }
                }
                updateEmailValue();
            }

            // ?��메일 �? ?��?��?��?�� ?��?��
            function updateEmailValue() {
                const emailId = emailIdInput.value.trim();
                let domain = '';
                
                if (emailDomainSelect.value === 'custom') {
                    domain = customDomainInput.value.trim();
                } else {
                    domain = emailDomainSelect.value;
                }
                
                if (emailId && domain) {
                    memberEmailHidden.value = emailId + '@' + domain;
                } else {
                    memberEmailHidden.value = '';
                }
            }

            // ?��메인 ?��?�� �?�? ?�� 처리
            emailDomainSelect.addEventListener('change', function() {
                if (this.value === 'custom') {
                    customDomainInput.style.display = 'block';
                    customDomainInput.required = true;
                } else {
                    customDomainInput.style.display = 'none';
                    customDomainInput.required = false;
                    customDomainInput.value = '';
                }
                updateEmailValue();
                checkEmailChange();
            });

            // ?��메일 ?��?�� ?�� �? ?��?��?��?��
            emailIdInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            customDomainInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            // ?��?���? 로드 ?�� 기존 ?��메일 ?��?��
            parseExistingEmail();

            function updateAuthMessage(message, color) {
                if (message) {
                    authStatusMessage.textContent = '(' + message + ')';
                    authStatusMessage.style.color = color;
                    authStatusMessage.style.display = 'inline';
                } else {
                    authStatusMessage.textContent = '';
                    authStatusMessage.style.display = 'none';
                }
            }

            // ?��메일 �?�? ?��?�� ?��?��
            function checkEmailChange() {
                const currentEmail = memberEmailHidden.value;
                
                if (currentEmail !== originalEmail) {
                    isEmailVerified = false;
                    emailAuthStatus.value = 'N';
                    authCodeArea.style.display = 'none';
                    updateAuthMessage('', '');
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '?���? ?���?';
                } else {
                    // ?��?�� ?��메일�? ?��?��?��?���? ?��증된 것으�? 간주
                    isEmailVerified = true;
                    emailAuthStatus.value = 'Y';
                    updateAuthMessage('기존 ?��메일', 'blue');
                }
            }

            // 1. '?���? ?���?' 버튼 ?���? ?��벤트
            sendAuthBtn.addEventListener('click', function() {
                updateEmailValue(); // 최신 ?��메일 값으�? ?��?��?��?��
                const email = memberEmailHidden.value.trim();
                
                if (!email || !email.includes('@')) {
                    alert('?��바른 ?��메일?�� ?��?��?��주세?��.');
                    return;
                }
                
                // ?��메일 ?��?�� ?��?��?���? 버튼 비활?��?�� (?��?���? 방�?)
                emailIdInput.disabled = true;
                emailDomainSelect.disabled = true;
                customDomainInput.disabled = true;
                sendAuthBtn.disabled = true;
                sendAuthBtn.textContent = '발송 �?...';

                fetch('/member/email/sendAuth', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ email: email })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        updateAuthMessage(data.message, '#5cb85c'); // ?���? ?�� 초록?��
                        authCodeArea.style.display = 'block'; // ?���? 번호 ?��?���? ?��?��
                    } else {
                        updateAuthMessage(data.message, 'red');
                        // ?��?�� ?�� ?��?�� ?��?��?��
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                        sendAuthBtn.disabled = false;
                    }
                    sendAuthBtn.textContent = '?���? ?���?';
                })
                .catch(error => {
                    updateAuthMessage('?��?��?��?�� ?��류로 발송?�� ?��?��?��?��?��?��.', 'red');
                    emailIdInput.disabled = false;
                    emailDomainSelect.disabled = false;
                    customDomainInput.disabled = false;
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '?���? ?���?';
                    console.error('Error:', error);
                });
            });

            // 2. '?���? ?��?��' 버튼 ?���? ?��벤트
            verifyAuthBtn.addEventListener('click', function() {
                const email = memberEmailHidden.value.trim();
                const authCode = authCodeInput.value.trim();

                if (!authCode || authCode.length !== 6) {
                    alert('6?���? ?���? 번호�? ?��?��?�� ?��?��?��주세?��.');
                    return;
                }

                verifyAuthBtn.disabled = true;
                verifyAuthBtn.textContent = '?��?�� �?...';

                fetch('/member/email/verifyAuth', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ 
                        email: email, 
                        authCode: authCode 
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // ?���? ?���? ?�� 처리
                        updateAuthMessage(data.message, 'blue');
                        emailAuthStatus.value = 'Y'; // Hidden ?��?�� �? �?�?
                        isEmailVerified = true;
                        authCodeInput.disabled = true;
                        verifyAuthBtn.style.display = 'none'; // ?���? ?��?�� 버튼 ?��기기
                        // ?��메일 ?��?��?�� ?��?�� ?��?��?��
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                    } else {
                        // ?���? ?��?�� ?�� 처리
                        updateAuthMessage(data.message, 'red');
                        emailAuthStatus.value = 'N'; 
                        isEmailVerified = false;
                        verifyAuthBtn.disabled = false;
                    }
                    verifyAuthBtn.textContent = '?���? ?��?��';
                })
                .catch(error => {
                    updateAuthMessage('?��?��?��?�� ?��류로 ?���? ?��?��?�� ?��?��?��?��?��?��.', 'red');
                    verifyAuthBtn.disabled = false;
                    verifyAuthBtn.textContent = '?���? ?��?��';
                    console.error('Error:', error);
                });
            });

            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
                updateEmailValue(); // 최신 ?��메일 값으�? ?��?��?��?��
                
                const memberData = {
                    memberId: $('#memberId').val(),
                    memberPw: $('#memberPw').val(),
                    memberName: $('#memberName').val(),
                    memberEmail: $('#memberEmail').val(),
                    memberBirth: $('#memberBirth').val()
                };

                const memberPwConfirm = $('#memberPwConfirm').val();

                // 비�?번호 ?���? ?��?��
                if (memberData.memberPw !== memberPwConfirm) {
                    showAlert('비�?번호�? ?��치하�? ?��?��?��?��.', 'error');
                    return;
                }

                // 비�?번호 ?��?�� ?��?��
                if (!memberData.memberPw) {
                    showAlert('비�?번호�? ?��?��?��주세?��.', 'error');
                    return;
                }

                // ?��메일 ?��?�� ?��?��
                if (!isValidEmail(memberData.memberEmail)) {
                    showAlert('?��바른 ?��메일 ?��?��?�� ?��?��?��주세?��.', 'error');
                    return;
                }

                // ?��메일?�� �?경된 경우 ?���? ?��?��
                if (memberData.memberEmail !== originalEmail && !isEmailVerified) {
                    showAlert('?��메일?�� �?경되?��?��?��?��. ?��메일 ?��증을 ?��료해주세?��.', 'error');
                    return;
                }

                // reCAPTCHA ?��?��
                const recaptchaResponse = grecaptcha.getResponse();
                if (!recaptchaResponse) {
                    showAlert('캡챠�? ?��료해주세?��.', 'error');
                    return;
                }

                // ?��버로 ?��?��?�� ?��?��?��?�� reCAPTCHA ?��?���? ?��메일 ?���? ?��?�� 추�?
                memberData.recaptchaResponse = recaptchaResponse;
                memberData.emailAuthStatus = emailAuthStatus.value;

                $.ajax({
                    url: '/member/update',
                    type: 'POST',
                    data: JSON.stringify(memberData),
                    contentType: 'application/json; charset=UTF-8',
                    success: function(response) {
                        if (response.success) {
                            showAlert(response.message, 'success');
                            setTimeout(function() {
                                window.location.href = '/member/mypage';
                            }, 2000);
                        } else {
                            showAlert(response.message, 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        showAlert('?��?�� �? ?��류�? 발생?��?��?��?��: ' + error, 'error');
                    }
                });
            });
        });

        function showAlert(message, type) {
            const alertDiv = $('#alertMessage');
            alertDiv.removeClass('alert-success alert-error');
            alertDiv.addClass('alert alert-' + type);
            alertDiv.text(message);
            alertDiv.show();
            
            // 3�? ?�� ?��?��?���? ?��기기
            setTimeout(function() {
                alertDiv.fadeOut();
            }, 3000);
        }

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>


    </div>
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />
</body>
</html>