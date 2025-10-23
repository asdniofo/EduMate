document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("signupForm");
    const inputs = form.querySelectorAll("input");
    const nextBtn = document.getElementById("next-btn");
    const pwInput = document.getElementById("memberPw");
    const pwCheckInput = document.getElementById("memberPwCheck");
    const pwError = document.getElementById("pw-error");

    // 🔹 비밀번호 일치 검사
    pwInput.addEventListener("input", checkPasswordMatch);
    pwCheckInput.addEventListener("input", checkPasswordMatch);

    function checkPasswordMatch() {
        const pw = pwInput.value;
        const pwCheck = pwCheckInput.value;

        if (pw && pwCheck && pw !== pwCheck) {
            pwError.style.display = "block";       // 경고 보이기
            pwCheckInput.classList.add("input-error");
        } else {
            pwError.style.display = "none";        // 경고 숨기기
            pwCheckInput.classList.remove("input-error");
        }
    }

    // 🔹 모든 입력값이 채워져야 버튼 활성화
    function checkInputs() {
        const allFilled = Array.from(inputs).every(input => input.value.trim() !== "");
        nextBtn.disabled = !allFilled;
    }

    inputs.forEach(input => {
        input.addEventListener("input", checkInputs);
    });

    checkInputs(); // 초기 버튼 상태 설정
});


// 🔹 reCAPTCHA 검사
document.addEventListener("submit", function(e) {
    const form = e.target;
    if (form.id === "signupForm") {
        const response = grecaptcha.getResponse();
        if (response.length === 0) {
            e.preventDefault();
            alert("캡챠를 완료해주세요.");
        }
    }
});

// 이메일 인증
document.addEventListener('DOMContentLoaded', function() {
    const emailInput = document.getElementById('memberEmail');
    const sendAuthBtn = document.getElementById('sendAuthBtn');
    const authCodeArea = document.getElementById('authCodeArea');
    const authCodeInput = document.getElementById('authCodeInput');
    const verifyAuthBtn = document.getElementById('verifyAuthBtn');
    const authStatusMessage = document.getElementById('authStatusMessage');
    const emailAuthStatus = document.getElementById('emailAuthStatus'); // Hidden field
    const nextBtn = document.getElementById('next-btn');
    
    let isEmailVerified = false; // 이메일 인증 상태 플래그

    // 초기 제출 버튼 비활성화 (HTML에서 disabled="true" 처리됨)
    nextBtn.disabled = true;
	
	function updateAuthMessage(message, color) {
	    authStatusMessage.textContent = message;
	    authStatusMessage.style.color = color;
	    // 메시지가 비어있으면 display: none; 처리하여 공간을 차지하지 않게 함
	    authStatusMessage.style.display = message ? 'block' : 'none'; 
	}

    // 1. '인증 요청' 버튼 클릭 이벤트
    sendAuthBtn.addEventListener('click', function() {
        const email = emailInput.value.trim();
        if (!email) {
            alert('이메일을 입력해주세요.');
            return;
        }
        
        // 이메일 입력 필드와 버튼 비활성화 (재요청 방지)
        emailInput.disabled = true;
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
            authStatusMessage.textContent = data.message;
            if (data.success) {
                updateAuthMessage(data.message, '#5cb85c'); // 성공 시 초록색
                authCodeArea.style.display = 'flex'; // 인증 번호 입력창 표시
            } else {
                updateAuthMessage(data.message, 'red');
                // 실패 시 다시 활성화
                emailInput.disabled = false;
                sendAuthBtn.disabled = false;
            }
            sendAuthBtn.textContent = '인증 요청';
        })
        .catch(error => {
            authStatusMessage.textContent = '네트워크 오류로 발송에 실패했습니다.';
            authStatusMessage.style.color = 'red';
            emailInput.disabled = false;
            sendAuthBtn.disabled = false;
            sendAuthBtn.textContent = '인증 요청';
            console.error('Error:', error);
        });
    });

    // 2. '인증 확인' 버튼 클릭 이벤트
    verifyAuthBtn.addEventListener('click', function() {
        const email = emailInput.value.trim();
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
            authStatusMessage.textContent = data.message;
            
            if (data.success) {
                // 💡 인증 성공 시 처리
                updateAuthMessage(data.message, 'blue');
                emailAuthStatus.value = 'Y'; // Hidden 필드 값 변경
                isEmailVerified = true;
                authCodeInput.disabled = true;
                verifyAuthBtn.style.display = 'none'; // 인증 확인 버튼 숨기기
                nextBtn.disabled = false; // 다음 버튼 활성화

            } else {
                // 💡 인증 실패 시 처리
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

    // 3. 폼 제출 시 최종 확인
    document.getElementById('signupForm').addEventListener('submit', function(event) {
        // 비밀번호 일치 체크 로직은 signup_info.js에 있다고 가정

        // 이메일 인증 여부 최종 확인
		document.getElementById('memberEmail').disabled = false; 

	    // 이메일 인증 여부 최종 확인
	    if (!isEmailVerified) {
	        event.preventDefault(); // 폼 제출 중단

	        // 폼 제출을 막았다면, 다시 disabled 속성을 true로 설정해주어야 합니다.
	        document.getElementById('memberEmail').disabled = true; 
	        
	        alert('이메일 인증을 완료해야 회원가입을 진행할 수 있습니다.');
	        authStatusMessage.textContent = '이메일 인증을 완료해주세요.';
	        authStatusMessage.style.color = 'red';
	    }
    });
    
});
