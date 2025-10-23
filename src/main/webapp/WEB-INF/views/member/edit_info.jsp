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
                    <input type="email" id="memberEmail" value="${memberInfo.memberEmail}" required>
                </div>

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

            $('#editForm').on('submit', function(e) {
                e.preventDefault();
                
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

                // reCAPTCHA 확인
                const recaptchaResponse = grecaptcha.getResponse();
                if (!recaptchaResponse) {
                    showAlert('캡챠를 완료해주세요.', 'error');
                    return;
                }

                // 서버로 전송할 데이터에 reCAPTCHA 응답 추가
                memberData.recaptchaResponse = recaptchaResponse;

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