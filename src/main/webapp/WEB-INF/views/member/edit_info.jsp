<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정 | EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/member/edit_info.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

</head>
<body>
    <!-- Header Include -->
    <jsp:include page="../common/header.jsp" />

    <div class="edit-container">
        <a href="/member/mypage" class="back-btn">← 마이페이지로 돌아가기</a>
        
        <h1 class="edit-title">내 정보 수정</h1>
        
        <div class="edit-content">
            <div class="note">
                📝 본인의 개인정보만 수정할 수 있습니다. 아이디는 변경할 수 없습니다.
            </div>
            
            <div id="alertMessage" style="display: none;"></div>
            
            <form id="editForm" class="edit-form">
                <div class="form-group">
                    <label for="memberId">아이디</label>
                    <input type="text" id="memberId" value="${memberInfo.memberId}" readonly>
                </div>

                <div class="form-group">
                    <label for="memberPw">새 비밀번호</label>
                    <input type="password" id="memberPw" placeholder="새 비밀번호를 입력하세요" required>
                </div>

                <div class="form-group">
                    <label for="memberPwConfirm">비밀번호 확인</label>
                    <input type="password" id="memberPwConfirm" placeholder="비밀번호를 다시 입력하세요" required>
                </div>

                <!-- 비밀번호 불일치 경고 -->
                <div id="pw-error" style="color: #e74c3c; font-size: 14px; margin-top: -15px; margin-bottom: 15px; display: none; font-weight: 500;">
                    ⚠️ 비밀번호가 일치하지 않습니다.
                </div>

                <div class="form-group">
                    <label for="memberName">이름</label>
                    <input type="text" id="memberName" value="${memberInfo.memberName}" required>
                </div>

                <div class="form-group">
                    <label for="memberEmail">이메일</label>
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
                    <input type="hidden" id="memberEmail" value="${memberInfo.memberEmail}" required>
                </div>
                
                <!-- 이메일 인증번호 -->
                <div id="authCodeArea" class="form-group" style="display: none;">
                    <div class="label-with-message">
                        <label for="authCodeInput">인증 번호</label>
                        <span id="authStatusMessage" class="auth-message-inline" style="display: none;"></span>
                    </div>
                    <div class="input-group">
                        <input type="text" id="authCodeInput" placeholder="인증 번호 6자리 입력" maxlength="6" class="input-full">
                        <button type="button" id="verifyAuthBtn" class="btn-email-action btn-verify">인증 확인</button>
                    </div>
                </div>
                
                <input type="hidden" id="emailAuthStatus" name="emailAuthStatus" value="N">

                <div class="form-group">
                    <label for="memberBirth">생년월일</label>
                    <input type="date" id="memberBirth" value="${memberInfo.memberBirth}" required>
                </div>

                <!-- reCAPTCHA -->
                <div style="margin: 20px 0; display: flex; justify-content: center;">
                    <div class="g-recaptcha" data-sitekey="6LdI9OorAAAAABmbABAsztSQECtECqsw1NhUgXuk"></div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">정보 수정</button>
                    <a href="/member/mypage" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 실시간 비밀번호 일치 검사
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

            // 이메일 인증 기능
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
            
            let isEmailVerified = false; // 이메일 인증 상태 플래그
            let originalEmail = memberEmailHidden.value; // 원래 이메일 저장

            // 페이지 로드 시 기존 이메일 분리해서 표시
            function parseExistingEmail() {
                if (originalEmail) {
                    const [id, domain] = originalEmail.split('@');
                    emailIdInput.value = id;
                    
                    // 도메인이 선택지에 있는지 확인
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

            // 이메일 값 업데이트 함수
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

            // 도메인 선택 변경 시 처리
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

            // 이메일 입력 시 값 업데이트
            emailIdInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            customDomainInput.addEventListener('input', function() {
                updateEmailValue();
                checkEmailChange();
            });

            // 페이지 로드 시 기존 이메일 파싱
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

            // 이메일 변경 확인 함수
            function checkEmailChange() {
                const currentEmail = memberEmailHidden.value;
                
                if (currentEmail !== originalEmail) {
                    isEmailVerified = false;
                    emailAuthStatus.value = 'N';
                    authCodeArea.style.display = 'none';
                    updateAuthMessage('', '');
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '인증 요청';
                } else {
                    // 원래 이메일로 되돌렸다면 인증된 것으로 간주
                    isEmailVerified = true;
                    emailAuthStatus.value = 'Y';
                    updateAuthMessage('기존 이메일', 'blue');
                }
            }

            // 1. '인증 요청' 버튼 클릭 이벤트
            sendAuthBtn.addEventListener('click', function() {
                updateEmailValue(); // 최신 이메일 값으로 업데이트
                const email = memberEmailHidden.value.trim();
                
                if (!email || !email.includes('@')) {
                    alert('올바른 이메일을 입력해주세요.');
                    return;
                }
                
                // 이메일 입력 필드들과 버튼 비활성화 (재요청 방지)
                emailIdInput.disabled = true;
                emailDomainSelect.disabled = true;
                customDomainInput.disabled = true;
                sendAuthBtn.disabled = true;
                sendAuthBtn.textContent = '발송 중...';

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
                        updateAuthMessage(data.message, '#5cb85c'); // 성공 시 초록색
                        authCodeArea.style.display = 'block'; // 인증 번호 입력창 표시
                    } else {
                        updateAuthMessage(data.message, 'red');
                        // 실패 시 다시 활성화
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                        sendAuthBtn.disabled = false;
                    }
                    sendAuthBtn.textContent = '인증 요청';
                })
                .catch(error => {
                    updateAuthMessage('네트워크 오류로 발송에 실패했습니다.', 'red');
                    emailIdInput.disabled = false;
                    emailDomainSelect.disabled = false;
                    customDomainInput.disabled = false;
                    sendAuthBtn.disabled = false;
                    sendAuthBtn.textContent = '인증 요청';
                    console.error('Error:', error);
                });
            });

            // 2. '인증 확인' 버튼 클릭 이벤트
            verifyAuthBtn.addEventListener('click', function() {
                const email = memberEmailHidden.value.trim();
                const authCode = authCodeInput.value.trim();

                if (!authCode || authCode.length !== 6) {
                    alert('6자리 인증 번호를 정확히 입력해주세요.');
                    return;
                }

                verifyAuthBtn.disabled = true;
                verifyAuthBtn.textContent = '확인 중...';

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
                        // 인증 성공 시 처리
                        updateAuthMessage(data.message, 'blue');
                        emailAuthStatus.value = 'Y'; // Hidden 필드 값 변경
                        isEmailVerified = true;
                        authCodeInput.disabled = true;
                        verifyAuthBtn.style.display = 'none'; // 인증 확인 버튼 숨기기
                        // 이메일 필드들 다시 활성화
                        emailIdInput.disabled = false;
                        emailDomainSelect.disabled = false;
                        customDomainInput.disabled = false;
                    } else {
                        // 인증 실패 시 처리
                        updateAuthMessage(data.message, 'red');
                        emailAuthStatus.value = 'N'; 
                        isEmailVerified = false;
                        verifyAuthBtn.disabled = false;
                    }
                    verifyAuthBtn.textContent = '인증 확인';
                })
                .catch(error => {
                    updateAuthMessage('네트워크 오류로 인증 확인에 실패했습니다.', 'red');
                    verifyAuthBtn.disabled = false;
                    verifyAuthBtn.textContent = '인증 확인';
                    console.error('Error:', error);
                });
            });

            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
                updateEmailValue(); // 최신 이메일 값으로 업데이트
                
                const memberData = {
                    memberId: $('#memberId').val(),
                    memberPw: $('#memberPw').val(),
                    memberName: $('#memberName').val(),
                    memberEmail: $('#memberEmail').val(),
                    memberBirth: $('#memberBirth').val()
                };

                const memberPwConfirm = $('#memberPwConfirm').val();

                // 비밀번호 일치 확인
                if (memberData.memberPw !== memberPwConfirm) {
                    showAlert('비밀번호가 일치하지 않습니다.', 'error');
                    return;
                }

                // 비밀번호 입력 확인
                if (!memberData.memberPw) {
                    showAlert('비밀번호를 입력해주세요.', 'error');
                    return;
                }

                // 이메일 형식 확인
                if (!isValidEmail(memberData.memberEmail)) {
                    showAlert('올바른 이메일 형식을 입력해주세요.', 'error');
                    return;
                }

                // 이메일이 변경된 경우 인증 확인
                if (memberData.memberEmail !== originalEmail && !isEmailVerified) {
                    showAlert('이메일이 변경되었습니다. 이메일 인증을 완료해주세요.', 'error');
                    return;
                }

                // reCAPTCHA 확인
                const recaptchaResponse = grecaptcha.getResponse();
                if (!recaptchaResponse) {
                    showAlert('캡챠를 완료해주세요.', 'error');
                    return;
                }

                // 서버로 전송할 데이터에 reCAPTCHA 응답과 이메일 인증 상태 추가
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
                        showAlert('수정 중 오류가 발생했습니다: ' + error, 'error');
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
            
            // 3초 후 자동으로 숨기기
            setTimeout(function() {
                alertDiv.fadeOut();
            }, 3000);
        }

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>

    <!-- Footer Include -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>