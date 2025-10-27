document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("signupForm");
    const inputs = form.querySelectorAll("input");
    const nextBtn = document.getElementById("next-btn");
    const pwInput = document.getElementById("memberPw");
    const pwCheckInput = document.getElementById("memberPwCheck");
    const pwError = document.getElementById("pw-error");

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
        checkInputs(); // 버튼 활성화 상태 다시 체크
    }

    function checkInputs() {
        const allFilled = Array.from(inputs).every(input => input.value.trim() !== "");
        const pwMatched = pwInput.value === pwCheckInput.value && pwInput.value !== "";
        nextBtn.disabled = !(allFilled && pwMatched);

        // 버튼 색상 변경
        if (!nextBtn.disabled) {
            nextBtn.classList.add("active");
        } else {
            nextBtn.classList.remove("active");
        }
    }

    inputs.forEach(input => {
        input.addEventListener("input", checkInputs);
    });

    checkInputs(); // 초기 상태 설정
	
	form.addEventListener("submit", (e) => {
	       // 비밀번호 일치 여부 재확인
	       if (pwInput.value !== pwCheckInput.value) {
	           e.preventDefault();
	           alert("비밀번호가 일치하지 않습니다.");
	           return;
	       }

	       // 서버 응답을 기다리도록 form을 그대로 submit
	       // 서버에서 success/fail 페이지로 리다이렉트 처리됨
	   });
});
