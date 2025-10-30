<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>?‚´ ? •ë³? ?ˆ˜? • | EduMate</title>
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
                ?‚´ ? •ë³? ?ˆ˜? •
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/mypage.png" alt="? •ë³´ìˆ˜? • ?•„?´ì½?">
            </div>
        </section>

        <!-- ë©”ì¸ ì½˜í…ì¸? -->
        <div class="main-content">
            <div class="mypage-content">
                <div class="edit-container">
        <div class="edit-content">
            <div class="note">
                ?Ÿ“? ë³¸ì¸?˜ ê°œì¸? •ë³´ë§Œ ?ˆ˜? •?•  ?ˆ˜ ?ˆ?Šµ?‹ˆ?‹¤. ?•„?´?””?Š” ë³?ê²½í•  ?ˆ˜ ?—†?Šµ?‹ˆ?‹¤.
            </div>
            
            <div id="alertMessage" style="display: none;"></div>
            
            <form id="editForm" class="edit-form">
                <div class="form-group">
                    <label for="memberId">?•„?´?””</label>
                    <input type="text" id="memberId" value="${memberInfo.memberId}" readonly>
                </div>

                <div class="form-group">
                    <label for="memberPw">?ƒˆ ë¹„ë?ë²ˆí˜¸</label>
                    <input type="password" id="memberPw" placeholder="?ƒˆ ë¹„ë?ë²ˆí˜¸ë¥? ?…? ¥?•˜?„¸?š”" required>
                </div>

                <div class="form-group">
                    <label for="memberPwConfirm">ë¹„ë?ë²ˆí˜¸ ?™•?¸</label>
                    <input type="password" id="memberPwConfirm" placeholder="ë¹„ë?ë²ˆí˜¸ë¥? ?‹¤?‹œ ?…? ¥?•˜?„¸?š”" required>
                </div>

                <!-- ë¹„ë?ë²ˆí˜¸ ë¶ˆì¼ì¹? ê²½ê³  -->
                <div id="pw-error" style="color: #e74c3c; font-size: 14px; margin-top: -15px; margin-bottom: 15px; display: none; font-weight: 500;">
                    ?š ï¸? ë¹„ë?ë²ˆí˜¸ê°? ?¼ì¹˜í•˜ì§? ?•Š?Šµ?‹ˆ?‹¤.
                </div>

                <div class="form-group">
                    <label for="memberName">?´ë¦?</label>
                    <input type="text" id="memberName" value="${memberInfo.memberName}" required>
                </div>

                <div class="form-group">
                    <label for="memberEmail">?´ë©”ì¼</label>
                    <div class="email-input-group">
                        <input type="text" id="emailId" placeholder="?´ë©”ì¼ ?•„?´?””" required>
                        <span class="email-separator">@</span>
                        <select id="emailDomain" required>
                            <option value="">?„ë©”ì¸ ?„ ?ƒ</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="kakao.com">kakao.com</option>
                            <option value="yahoo.com">yahoo.com</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="custom">ì§ì ‘?…? ¥</option>
                        </select>
                        <input type="text" id="customDomain" placeholder="?„ë©”ì¸ ?…? ¥" style="display: none;">
                        <button type="button" id="sendAuthBtn" class="btn-email-action btn-send">?¸ì¦? ?š”ì²?</button>
                    </div>
                    <input type="hidden" id="memberEmail" value="${memberInfo.memberEmail}" required>
                </div>
                
                <!-- ?´ë©”ì¼ ?¸ì¦ë²ˆ?˜¸ -->
                <div id="authCodeArea" class="form-group" style="display: none;">
                    <div class="label-with-message">
                        <label for="authCodeInput">?¸ì¦? ë²ˆí˜¸</label>
                        <span id="authStatusMessage" class="auth-message-inline" style="display: none;"></span>
                    </div>
                    <div class="input-group">
                        <input type="text" id="authCodeInput" placeholder="?¸ì¦? ë²ˆí˜¸ 6?ë¦? ?…? ¥" maxlength="6" class="input-full">
                        <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">?¸ì¦? ?™•?¸</button>
                    </div>
                </div>
                
                <input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">

                <div class="form-group">
                    <label for="memberBirth">?ƒ?…„?›”?¼</label>
                    <input type="date" id="memberBirth" value="${memberInfo.memberBirth}" required>
                </div>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0; display: flex; justify-content: center;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">? •ë³? ?ˆ˜? •</button>
                    <a href="/member/mypage" class="btn btn-secondary">ì·¨ì†Œ</a>
                </div>
            </form>
                </div>
            </div>
        </div>

    <script>
        $(document).ready(function() {
            // ?‹¤?‹œê°? ë¹„ë?ë²ˆí˜¸ ?¼ì¹? ê²??‚¬
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

            // ?´ë©”ì¼ ?¸ì¦? ê¸°ëŠ¥
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
            
            let isEmailVerified = false; // ?´ë©”ì¼ ?¸ì¦? ?ƒ?ƒœ ?”Œ?˜ê·?
            let originalEmail = memberEmailHidden.value; // ?›?˜ ?´ë©”ì¼ ???¥

            // ?˜?´ì§? ë¡œë“œ ?‹œ ê¸°ì¡´ ?´ë©”ì¼ ë¶„ë¦¬?•´?„œ ?‘œ?‹œ
            function parseExistingEmail() {
                if (originalEmail) {
                    const [id, domain] = originalEmail.split('@');
                    emailIdInput.value = id;
                    
                    // ?„ë©”ì¸?´ ?„ ?ƒì§??— ?ˆ?Š”ì§? ?™•?¸
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

            // ?´ë©”ì¼ ê°? ?—…?°?´?Š¸ ?•¨?ˆ˜
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

            // ?„ë©”ì¸ ?„ ?ƒ ë³?ê²? ?‹œ ì²˜ë¦¬
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

            // ?´ë©”ì¼ ?…? ¥ ?‹œ ê°? ?—…?°?´?Š¸
            emailIdInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            customDomainInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            // ?˜?´ì§? ë¡œë“œ ?‹œ ê¸°ì¡´ ?´ë©”ì¼ ?ŒŒ?‹±
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

            // ?´ë©”ì¼ ë³?ê²? ?™•?¸ ?•¨?ˆ˜
            function checkEmailChange() {
                const currentEmail = memberEmailHidden.value;
                
                if (currentEmail !== originalEmail) {
                    isEmailVerified = false;
                    emailAuthStatus.value = 'N';
                    authCodeArea.style.display = 'none';
                    updateAuthMessage('', '');
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '?¸ì¦? ?š”ì²?';
                } else {
                    // ?›?˜ ?´ë©”ì¼ë¡? ?˜?Œ? ¸?‹¤ë©? ?¸ì¦ëœ ê²ƒìœ¼ë¡? ê°„ì£¼
                    isEmailVerified = true;
                    emailAuthStatus.value = 'Y';
                    updateAuthMessage('ê¸°ì¡´ ?´ë©”ì¼', 'blue');
                }
            }

            // 1. '?¸ì¦? ?š”ì²?' ë²„íŠ¼ ?´ë¦? ?´ë²¤íŠ¸
            sendAuthBtn.addEventListener('click', function() {
                updateEmailValue(); // ìµœì‹  ?´ë©”ì¼ ê°’ìœ¼ë¡? ?—…?°?´?Š¸
                const email = memberEmailHidden.value.trim();
                
                if (!email || !email.includes('@')) {
                    alert('?˜¬ë°”ë¥¸ ?´ë©”ì¼?„ ?…? ¥?•´ì£¼ì„¸?š”.');
                    return;
                }
                
                // ?´ë©”ì¼ ?…? ¥ ?•„?“œ?“¤ê³? ë²„íŠ¼ ë¹„í™œ?„±?™” (?¬?š”ì²? ë°©ì?)
                emailIdInput.disabled = true;
                emailDomainSelect.disabled = true;
                customDomainInput.disabled = true;
                sendAuthBtn.disabled = true;
                sendAuthBtn.textContent = 'ë°œì†¡ ì¤?...';

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
                        updateAuthMessage(data.message, '#5cb85c'); // ?„±ê³? ?‹œ ì´ˆë¡?ƒ‰
                        authCodeArea.style.display = 'block'; // ?¸ì¦? ë²ˆí˜¸ ?…? ¥ì°? ?‘œ?‹œ
                    } else {
                        updateAuthMessage(data.message, 'red');
                        // ?‹¤?Œ¨ ?‹œ ?‹¤?‹œ ?™œ?„±?™”
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                        sendAuthBtn.disabled = false;
                    }
                    sendAuthBtn.textContent = '?¸ì¦? ?š”ì²?';
                })
                .catch(error => {
                    updateAuthMessage('?„¤?Š¸?›Œ?¬ ?˜¤ë¥˜ë¡œ ë°œì†¡?— ?‹¤?Œ¨?–ˆ?Šµ?‹ˆ?‹¤.', 'red');
                    emailIdInput.disabled = false;
                    emailDomainSelect.disabled = false;
                    customDomainInput.disabled = false;
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '?¸ì¦? ?š”ì²?';
                    console.error('Error:', error);
                });
            });

            // 2. '?¸ì¦? ?™•?¸' ë²„íŠ¼ ?´ë¦? ?´ë²¤íŠ¸
            verifyAuthBtn.addEventListener('click', function() {
                const email = memberEmailHidden.value.trim();
                const authCode = authCodeInput.value.trim();

                if (!authCode || authCode.length !== 6) {
                    alert('6?ë¦? ?¸ì¦? ë²ˆí˜¸ë¥? ? •?™•?ˆ ?…? ¥?•´ì£¼ì„¸?š”.');
                    return;
                }

                verifyAuthBtn.disabled = true;
                verifyAuthBtn.textContent = '?™•?¸ ì¤?...';

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
                        // ?¸ì¦? ?„±ê³? ?‹œ ì²˜ë¦¬
                        updateAuthMessage(data.message, 'blue');
                        emailAuthStatus.value = 'Y'; // Hidden ?•„?“œ ê°? ë³?ê²?
                        isEmailVerified = true;
                        authCodeInput.disabled = true;
                        verifyAuthBtn.style.display = 'none'; // ?¸ì¦? ?™•?¸ ë²„íŠ¼ ?ˆ¨ê¸°ê¸°
                        // ?´ë©”ì¼ ?•„?“œ?“¤ ?‹¤?‹œ ?™œ?„±?™”
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                    } else {
                        // ?¸ì¦? ?‹¤?Œ¨ ?‹œ ì²˜ë¦¬
                        updateAuthMessage(data.message, 'red');
                        emailAuthStatus.value = 'N'; 
                        isEmailVerified = false;
                        verifyAuthBtn.disabled = false;
                    }
                    verifyAuthBtn.textContent = '?¸ì¦? ?™•?¸';
                })
                .catch(error => {
                    updateAuthMessage('?„¤?Š¸?›Œ?¬ ?˜¤ë¥˜ë¡œ ?¸ì¦? ?™•?¸?— ?‹¤?Œ¨?–ˆ?Šµ?‹ˆ?‹¤.', 'red');
                    verifyAuthBtn.disabled = false;
                    verifyAuthBtn.textContent = '?¸ì¦? ?™•?¸';
                    console.error('Error:', error);
                });
            });

            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
                updateEmailValue(); // ìµœì‹  ?´ë©”ì¼ ê°’ìœ¼ë¡? ?—…?°?´?Š¸
                
                const memberData = {
                    memberId: $('#memberId').val(),
                    memberPw: $('#memberPw').val(),
                    memberName: $('#memberName').val(),
                    memberEmail: $('#memberEmail').val(),
                    memberBirth: $('#memberBirth').val()
                };

                const memberPwConfirm = $('#memberPwConfirm').val();

                // ë¹„ë?ë²ˆí˜¸ ?¼ì¹? ?™•?¸
                if (memberData.memberPw !== memberPwConfirm) {
                    showAlert('ë¹„ë?ë²ˆí˜¸ê°? ?¼ì¹˜í•˜ì§? ?•Š?Šµ?‹ˆ?‹¤.', 'error');
                    return;
                }

                // ë¹„ë?ë²ˆí˜¸ ?…? ¥ ?™•?¸
                if (!memberData.memberPw) {
                    showAlert('ë¹„ë?ë²ˆí˜¸ë¥? ?…? ¥?•´ì£¼ì„¸?š”.', 'error');
                    return;
                }

                // ?´ë©”ì¼ ?˜•?‹ ?™•?¸
                if (!isValidEmail(memberData.memberEmail)) {
                    showAlert('?˜¬ë°”ë¥¸ ?´ë©”ì¼ ?˜•?‹?„ ?…? ¥?•´ì£¼ì„¸?š”.', 'error');
                    return;
                }

                // ?´ë©”ì¼?´ ë³?ê²½ëœ ê²½ìš° ?¸ì¦? ?™•?¸
                if (memberData.memberEmail !== originalEmail && !isEmailVerified) {
                    showAlert('?´ë©”ì¼?´ ë³?ê²½ë˜?—ˆ?Šµ?‹ˆ?‹¤. ?´ë©”ì¼ ?¸ì¦ì„ ?™„ë£Œí•´ì£¼ì„¸?š”.', 'error');
                    return;
                }

                // reCAPTCHA ?™•?¸
                const recaptchaResponse = grecaptcha.getResponse();
                if (!recaptchaResponse) {
                    showAlert('ìº¡ì± ë¥? ?™„ë£Œí•´ì£¼ì„¸?š”.', 'error');
                    return;
                }

                // ?„œë²„ë¡œ ? „?†¡?•  ?°?´?„°?— reCAPTCHA ?‘?‹µê³? ?´ë©”ì¼ ?¸ì¦? ?ƒ?ƒœ ì¶”ê?
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
                        showAlert('?ˆ˜? • ì¤? ?˜¤ë¥˜ê? ë°œìƒ?–ˆ?Šµ?‹ˆ?‹¤: ' + error, 'error');
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
            
            // 3ì´? ?›„ ??™?œ¼ë¡? ?ˆ¨ê¸°ê¸°
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