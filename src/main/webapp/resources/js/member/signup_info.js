document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("signupForm");
    const inputs = form.querySelectorAll("input");
    const nextBtn = document.getElementById("next-btn");
    const pwInput = document.getElementById("userPw");
    const pwCheckInput = document.getElementById("userPwCheck");
    const pwError = document.getElementById("pw-error");

    pwInput.addEventListener("input", checkPasswordMatch);
    pwCheckInput.addEventListener("input", checkPasswordMatch);

    function checkPasswordMatch() {
    const pw = pwInput.value;
    const pwCheck = pwCheckInput.value;

    if (pw && pwCheck && pw !== pwCheck) {
        pwError.style.display = "block";       // 알람 보이기
        pwCheckInput.classList.add("input-error"); // 빨간 테두리
    } else {
        pwError.style.display = "none";        // 알람 숨기기
        pwCheckInput.classList.remove("input-error");
    }
}
    function checkInputs() {
        const allFilled = Array.from(inputs).every(input => input.value.trim() !== "");
        nextBtn.disabled = !allFilled;
    }

    inputs.forEach(input => {
        input.addEventListener("input", checkInputs);
    });

    checkInputs(); // 초기 상태 설정
});

document.getElementById("signup-form").addEventListener("submit", function(e) {
    const response = grecaptcha.getResponse();
    if (response.length === 0) {
        e.preventDefault();
        alert("캡챠를 완료해주세요.");
    }
});