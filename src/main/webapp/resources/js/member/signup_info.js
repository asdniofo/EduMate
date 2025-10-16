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
