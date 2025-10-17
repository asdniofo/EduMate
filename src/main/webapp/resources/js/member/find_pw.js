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
	       e.preventDefault(); // 실제 submit 막기

	       // 비밀번호 일치 여부 재확인
	       if (pwInput.value !== pwCheckInput.value) {
	           alert("비밀번호가 일치하지 않습니다.");
	           return;
	       }

	       // 서버에 비밀번호 변경 요청 (fetch 또는 form.submit())
	       form.submit(); // 실제 서버 POST 요청

	       // 완료 메시지
	       alert("비밀번호가 성공적으로 변경되었습니다.");
	       window.location.href = "/member/login"; // 로그인 페이지로 이동
	   });
});
