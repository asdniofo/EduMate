document.addEventListener("DOMContentLoaded", function() {
    const userIdInput = document.querySelector('input[name="userId"]');
    const userPwdInput = document.querySelector('input[name="userPwd"]');
    const loginBtn = document.querySelector('.btn-login');
    const errorMessage = document.getElementById('error-message');

    // 버튼 색상 상태 업데이트
    function updateButtonColor() {
        if (userIdInput.value.trim() !== "" && userPwdInput.value.trim() !== "") {
            loginBtn.style.background = "#216dff"; // 활성 색
        } else {
            loginBtn.style.background = "#ccc"; // 회색
        }
    }

    // 입력 이벤트
    userIdInput.addEventListener("input", function() {
        userIdInput.classList.remove("input-error");
        errorMessage.style.display = "none";
        updateButtonColor();
    });

    userPwdInput.addEventListener("input", function() {
        userPwdInput.classList.remove("input-error");
        errorMessage.style.display = "none";
        updateButtonColor();
    });

    // 로그인 버튼 클릭
    loginBtn.addEventListener("click", function(e) {
        e.preventDefault();
        const userId = userIdInput.value.trim();
        const userPwd = userPwdInput.value.trim();

        if (!userId) {
            userIdInput.classList.add("input-error");
            errorMessage.textContent = "아이디를 입력해주세요.";
            errorMessage.style.display = "block";
            return;
        }

        if (!userPwd) {
            userPwdInput.classList.add("input-error");
            errorMessage.textContent = "비밀번호를 입력해주세요.";
            errorMessage.style.display = "block";
            return;
        }

        // 둘 다 입력되어 있으면 경고 메시지 숨김
        errorMessage.style.display = "none";
        userIdInput.classList.remove("input-error");
        userPwdInput.classList.remove("input-error");

        document.getElementById('login-form').submit();
    });

    // 초기 버튼 색상
    updateButtonColor();
});
